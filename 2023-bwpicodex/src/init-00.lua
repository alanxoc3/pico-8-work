-- INITIALIZATION FILE
-- Everything that is run before the first _update is here.
-- All in one file to make it easier to organize startup stuff.

-- BEGIN ZOBJ CORE IMPLEMENTATION: 160 tokens
function f_zobj_eval(val, table, parameters)
  if     ord(val) == 126 then return table[sub(val, 2)] -- 126 means "~"
  elseif val == '@'       then return deli(parameters, 1)
  elseif val == '#'       then return {} end -- TODO: consider saving some tokens by removing this and replacing usage with `;,` syntax
  return val ~= '' and val or nil
end

-- has an extra split call ~c_no matter key or val, but token & character count goes down from ztable-ord
function f_zobj_set(table, str, ...)
  local params, statements, dest = {...}, split(str, ";"), table
  foreach(statements, function(statement)
    local tokens = split(statement)
    if #tokens > 1 then
      if tokens[1] == '' then -- array (started with ',')
        foreach(tokens, function(val)
          add(dest, f_zobj_eval(val, table, params))
        end)
      else -- map
        for i=1,#tokens,2 do
          dest[tokens[i]] = f_zobj_eval(tokens[i+1], table, params)
        end
      end
      dest = table
    else
      if statement == '' then statement = #dest+1 end
      if type(dest[statement]) ~= "table" then
        dest[statement] = {}
      end
      dest = dest[statement]
    end
  end)
  return table
end
-- END ZOBJ CORE IMPLEMENTATION

-- first, set the basic constants/values used by global things below.
-- an initial pass is required because some globals could be set to f_zobj(...), which requires zobj to be set beforehand.
f_zobj_set(_ENV, [[
  c_yes,@, c_no,@, f_nop,@, f_zobj_setmeta,@, f_zobj,@, f_zcall,@,
  c_pokemon,#, c_moves,#, c_trainers,#, c_items,#, g_gridstack,#, -- needed for the grid
  g_palette,0, g_preview_timer,0, g_title_timer,0, g_shake_timer,0,
  g_title_l,253, g_title_r,254,
  g_msg_top," ", g_msg_bot," ", -- TODO: do I need these? try removing

  g_init_peek_loc,L_DATASTART
]], true, false, function() end, -- TODO: before this function looked like function(...) ... end : I should check nothing broke from removing that to make it empty.
  function(parent, ...) -- f_zobj_setmeta
    return f_zobj_set(setmetatable({}, {__index=parent}), ...)
  end,

  function(...) -- f_zobj
    return f_zobj_setmeta(_ENV, ...)
  end,

  function(text, ...) -- f_zcall
    foreach(f_zobj(text, ...), function(params)
      local func = deli(params, 1) -- TODO: any better way to do this? with select?
      func(unpack(params))
    end)
  end
)

-- BEGIN DEBUG UTILS BLOCK -- TODO: remove these when close to release. Will free up many tokens.
function debug_sort(t, compare_func) compare_func = compare_func or function(a, b) return tostr(a) < tostr(b) end if t then for n=2,#t do local i=n while i>1 and compare_func(t[i], t[i-1]) do t[i],t[i-1]=t[i-1],t[i] i=i-1 end end end end
function db(...) local str = "" for x in all{...} do str = str..debug_helper(x).." " end printh(str) end
function debug_helper(any) if type(any)~="table" then return tostr(any) end local str = "{" local keys = {} for i=1,#any do if str~="{" then str=str.."," end keys[i] = true str=str..debug_helper(any[i]) end local sortedkeys = {} for k,v in pairs(any) do if not keys[k] then add(sortedkeys, k) end end  debug_sort(sortedkeys) for k in all(sortedkeys) do if str~="{" then str=str.."," end str=str..debug_helper(k).."="..debug_helper(any[k]) end return str.."}" end
-- END DEBUG UTILS BLOCK

-- yes this line is extremely important. see the perl preprocessor script for more info. this string is replaced with: f_zobj_set(_ENV, [[...]], ...)
-- nearly all functions in the game and large global datasets are created through this
_G_ZOBJ

f_zcall[[
  ----------------------------------------------------- UI INITIALIZATION
  --               w  vh x  y   cw  ch selw selh
   top_browse    ;,6 ,4 ,2 ,2  ,10 ,10 ,1   ,1
  ;top_edit      ;,2 ,2 ,2 ,2  ,30 ,20 ,1   ,1
  ;top_editteam  ;,3 ,2 ,2 ,2  ,20 ,20 ,1   ,1
  ;top_results   ;,3 ,2 ,2 ,2  ,20 ,20 ,1   ,1
  ;top_pkstat    ;,1 ,4 ,2 ,4  ,60 ,9  ,1   ,4
  ;top_pkstatbig ;,1 ,6 ,2 ,5  ,60 ,9  ,1   ,1
  ;top_text_grid ;,2 ,4 ,2 ,4  ,30 ,9  ,1   ,1
  ;top_title     ;,1 ,1 ,2 ,2  ,60 ,40 ,1   ,1
  ;top_battle    ;,1 ,1 ,2 ,2  ,60 ,40 ,1   ,1
  ;top_battle2   ;,1 ,2 ,2 ,2  ,60 ,20 ,1   ,1
  ;bot_4x4       ;,2 ,2 ,2 ,44 ,30 ,9  ,1   ,1
  ;bot_info      ;,1 ,1 ,2 ,45 ,60 ,16 ,1   ,1
  ;top_newstat   ;,1 ,6 ,2 ,4  ,60 ,9  ,1   ,1

  -- TODO: the lrbasegrid could be replaced with a mem reference. the grid can be figured out based on the previous item in the grid stack.
  -- TODO: f_setsel could go away. getsel might be able to go away too.
  --,func               ,name                      ,savespot      ,maingridspec   ,infogridspec   ,main opfunc           ,select func       ,leave func       ,lrbasegrid          ,static ,initfunc ,opfunc params
  ;;,~f_create_gridpair ,g_grid_title              ,S_TITLEACTION ,~bot_4x4       ,~top_title     ,~f_op_title           ,~f_s_title        ,~f_l_title       ,~c_no               ,~c_no  ,~f_nop

  ;;,~f_create_gridpair ,g_grid_browse             ,S_BROWSE      ,~top_browse    ,~bot_info      ,~f_op_browse          ,~f_s_browse       ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop   ,~f_add_browse_info
  ;;,~f_create_gridpair ,g_grid_editpkmn           ,S_BROWSE      ,~top_browse    ,~bot_info      ,~f_op_browse          ,~f_s_editpkmn     ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop   ,~f_add_editbrowse_info

  ;;,~f_create_gridpair ,g_grid_statbrowse         ,S_BROWSESTAT  ,~top_pkstat    ,~bot_info      ,~f_op_statbrowse      ,~f_s_pkstat       ,~f_l_browse      ,g_grid_browse       ,~c_no  ,~f_nop

  ;;,~f_create_gridpair ,g_grid_editstat           ,S_EDITACTION  ,~bot_4x4       ,~top_pkstat    ,~f_op_editstat        ,~f_s_editstat     ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,~f_create_gridpair ,g_grid_editmovebot        ,S_EDITMOVE    ,~bot_4x4       ,~top_pkstat    ,~f_op_editmovebot     ,~f_s_editmovebot  ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,~f_create_gridpair ,g_grid_editmove           ,S_DEFAULT     ,~top_text_grid ,~bot_info      ,~f_op_editmove        ,~f_s_editmove     ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,~f_create_gridpair ,g_grid_edititem           ,S_DEFAULT     ,~top_text_grid ,~bot_info      ,~f_op_edititem        ,~f_s_edititem     ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop

  ;;,~f_create_gridpair ,g_grid_pickedit           ,S_TEAM1       ,~top_edit      ,~bot_info      ,~f_op_pickedit        ,~f_s_edit         ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,~f_create_gridpair ,g_grid_pickleag           ,S_TEAM1       ,~top_edit      ,~bot_info      ,~f_op_pickleagueplayr ,~f_s_league       ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,~f_create_gridpair ,g_grid_pickplr1           ,S_TEAM1       ,~top_edit      ,~bot_info      ,~f_op_pickversus      ,~f_s_versus       ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,~f_create_gridpair ,g_grid_pickplr2           ,S_TEAM2       ,~top_edit      ,~bot_info      ,~f_op_pickversus      ,~f_s_versusbegin  ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,~f_create_gridpair ,g_grid_picktrnr           ,S_LEAGUE      ,~top_text_grid ,~bot_info      ,~f_op_pickleagueenemy ,~f_s_batbegin     ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,~f_create_gridpair ,g_grid_pickspot           ,S_EDITPKMN    ,~top_editteam  ,~bot_info      ,~f_op_editteam        ,~f_s_editteam     ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop

  -- Battle UI
  ;;,~f_create_gridpair ,g_grid_battle_select      ,S_DEFAULT     ,~bot_4x4       ,~top_battle2   ,~f_op_batsel          ,~f_s_battle       ,~f_l_battle      ,~c_no               ,~c_no  ,~f_nop
  ;;,~f_create_gridpair ,g_grid_statbattle         ,S_DEFAULT     ,~top_pkstat    ,~bot_info      ,~f_op_statbattle      ,~f_s_statbat      ,~f_l_browse      ,g_grid_battle_stats ,~c_no  ,~f_nop
  ;;,~f_create_gridpair ,g_grid_battle_movesel     ,S_DEFAULT     ,~bot_4x4       ,~top_pkstat    ,~f_op_movesel         ,~f_s_batmove      ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop -- normal move sel
  ;;,~f_create_gridpair ,g_grid_battle_dmovsel     ,S_DEFAULT     ,~bot_info      ,~top_pkstat    ,~f_op_dmovsel         ,~f_s_dmovsel      ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop -- struggle move sel
  ;;,~f_create_gridpair ,g_grid_battle_switch      ,S_DEFAULT     ,~top_editteam  ,~bot_info      ,~f_op_batswitch       ,~f_s_batswitch    ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,~f_create_gridpair ,g_grid_battle_stats       ,S_DEFAULT     ,~top_editteam  ,~bot_info      ,~f_op_batstats        ,~f_s_batstat      ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop

  ;;,~f_create_gridpair ,g_grid_battle_results     ,S_DEFAULT     ,~top_results   ,~bot_info      ,~f_op_batresults      ,~f_s_batresults   ,~f_l_browse      ,~c_no               ,~c_yes ,~f_init_batresults
  ;;,~f_create_gridpair ,g_grid_battle_actions     ,S_DEFAULT     ,~top_battle2   ,~bot_info      ,~f_op_bataction       ,~f_s_bataction    ,~f_l_battle      ,~c_no               ,~c_yes ,~f_s_bataction
  ;;,~f_create_gridpair ,g_grid_battle_firstaction ,S_DEFAULT     ,~top_battle2   ,~bot_info      ,~f_op_bataction       ,~f_s_bataction    ,~f_l_battle      ,~c_no               ,~c_yes ,~f_nop


  ----------------------------------------------------- GAME INITIALIZATION
  ;;,~poke ,0x5f2c  ,3  -- screen to 64x64
  ;;,~poke ,0x5f5c  ,8  -- set btn initial delay before repeating. 255 means never repeat.
  ;;,~poke ,0x5f5d  ,1  -- set btn repeating delay.

  ;;,~cls      -- this is just a visual blank screen when the game starts up

  ;;,~memset ,0x5e00 ,0   ,256 -- todo: remove me, factory reset
  ;;,~poke   ,S_STORY ,57      -- todo: remove me, story set for debugging
]]

-- This needs to go after the above zcall and can't go inside, because g_grid_title wouldn't exist when the initial zobj is parsed.
f_add_to_ui_stack(g_grid_title) -- Add the title to the grid stack, meaning the title grid is the first screen/grid in the game.

-- STEP 2: UNPACK TYPE CHART
for i=0,360 do -- 19*19-1 = 324 (19 types, including BIRD and NONE)
  c_types[i\19][i%19] = f_init_peek_inc()/2 -- want division, not integer division. need .5 for less effective moves
end

for i=0,I_END do c_items[i] = f_zobj([[lock,~c_no, num,@, name,@]], i, c_item_names[i]) end

-- 136 to 118. Storing data all together saves like 18 code tokens.
for i=0,252 do -- There are 252+1 pkmn and 252+1 moves. The +1s are for empties. So zipped when unpacking to save some tokens.
  local pkmn = f_zobj([[moves_progress;,#,#,#; moves_grouped;,#,#,#; lock,~c_no, pktype2,T_NONE, prevolve,P_EMPTY, name,@, num,@, num_str,@]], c_pkmn_names[i], i, f_prefix_zero(i < P_NONE and i or "???", 3))

  -- cur_list is not local just so I can save 1 token
  cur_list, c_moves[i], c_pokemon[i] = pkmn.moves_progress[1], f_zobj([[lock,~c_no, num,@, name,@]], i, c_move_names[i]), pkmn -- todo: get rid of i-1

  foreach(split'pow,pktype,accuracy,maxpp', function(key)
    c_moves[i][key] = f_init_peek_inc()
  end)

  -- TODO: if these can fit in data section, that would be very sweetscent.
  c_moves[i].pp_obj = {pp=c_moves[i].maxpp}
  c_moves[i].func = deli(c_move_funcs[i], 1) -- TODO: if c_move_funcs order is reversed (move is last), a token could be saved. This would definitely make it more confusing to look at though
  c_moves[i].params = c_move_funcs[i]

  -- TODO: idea, i could use the last bit of type1 to specify an extra gender byte. uses more space but saves 13 tokens
  -- default_item actually has gender and item information, but keeping the name item saves a possible token
  foreach(split'pktype1,hp,attack,defense,speed,specialattack,specialdefense,default_item', function(key)
    pkmn[key] = f_init_peek_inc()
  end)
  for i, key in ipairs{'pktype2','prevolve'} do
    if pkmn.pktype1 >> (4+i) & 1 == 1 then
      pkmn[key] = f_init_peek_inc()
    end
  end

  pkmn.pktype1 &= 31 -- 0b 0001 1111

  foreach(split'hp,attack,defense,speed,specialattack,specialdefense', function(key)
    -- This calculates the max stat possible at level 50. Simplified a ton from the original formula.
    -- HP is different and needs to add an extra 55 to the value (+ level + 10).
    -- Original formula came from here:
    -- https://bulbapedia.bulbagarden.net/wiki/Individual_values#Usage

    -- Stat calculator helped verify: https://pycosites.com/pkmn/stat_gen2.php
    -- MAX EV: 65535 | MAX IV: 15
    pkmn[key] += 52
  end)
  pkmn.hp += 55
  pkmn.maxhp = pkmn.hp -- TODO: save a token by combining with below eqals statement. actually all these sets could use zobj possibly
  pkmn.gender_mask = pkmn.default_item >>> 6 & G_BOTH
  pkmn.default_item &= 63 -- all bits except first two (0x3f or 0b00111111)

  while f_init_peek_inc() < C_NEXT do
    if     @g_init_peek_loc == C_TEACH then cur_list = pkmn.moves_progress[2]
    elseif @g_init_peek_loc == C_EVENT then cur_list = pkmn.moves_progress[3]
    elseif @g_init_peek_loc == C_DASH  then
      for j=cur_list[#cur_list-1]+1,cur_list[#cur_list]-1 do
        add(cur_list, j)
      end
    else
      add(cur_list, @g_init_peek_loc)
    end
  end
end

for i=0,252 do
  local sub = c_pokemon[i]

  while sub do
    for ii=1,3 do
      foreach(sub.moves_progress[ii], function(v)
        add(c_pokemon[i].moves_grouped[ii], v)
      end)
    end

    sub = c_pokemon[sub.prevolve]
  end
end

for i=0,252 do -- todo: token crunching - can move up
  local _ENV = c_pokemon[i]
  -- having metatables here causes me to run out of lua memory, lets keep good ol' number arrays
  possible_moves, possible_moves_method = f_zobj[[,M_NONE,M_NONE,M_NONE,M_NONE]], f_zobj[[M_NONE,"empty"]]

  for ii=1,3 do
    foreach(moves_grouped[ii], function(v)
      -- this if statement is required for pokemon learn a move naturally and their prevolve learns the move through teaching.
      -- Specifically Jigglypuff/Igglybuff have this scenario with rest & rollout. There may be others too.
      -- Missingno is the only exception here because it is the only pokemon that can learn multiple of one move (watergun)
      if i == P_MISSINGNO or not possible_moves_method[v] then
        add(possible_moves, v)
        possible_moves_method[v] = c_movemethod_names[ii]
      end
    end)
  end

  -- TODO: These 2 lines obviously take up a few tokens, but it frees up 272 mb of lua memory.
  -- c_pokemon[i].moves_progress = nil
  -- c_pokemon[i].moves_grouped = nil

  -- And finally, set stats/etc on the base pokemon.
  c_pokemon[i] = f_mkpkmn(i, _ENV, false, false, I_NONE)
end

for i=1,LEAGUE_END do
  add(c_trainers, {})
  foreach(f_zobj[[,num,move,1,2,3,4,5,6]], function(k)
    c_trainers[i][k] = f_init_peek_inc()
  end)
end

-- Logic to add the horde.
-- TODO: dedup with above
-- TODO: figure out how trainer len/party goes to battle
--       only trainers are saved as continuous things.

add(c_trainers, f_zobj[[num,P_GHOST, move,M_TM05]])
for i=1,252 do add(c_trainers[LEAGUE_HORDE], i%252) end

f_update_locks'1' -- unlock everything from the first trainer to the current trainer

-- after we have read all the bytes, we can now apply filters to the sfx for the cool sounding pkmn cries.
-- sfx starts at 0x3200. each sfx are 68 bytes. 64 for notes then 4 for effects.
-- 0x4278 = 0x3200+63*68 (0 to 62, only modify 63/64 sfx, because 63*4 = 252, which is how many pkmn there are)
for iloc=0x3200, 0x4278, 68 do
  for loc=iloc, iloc+63, 2 do
    -- breaking apart the bits:
    -- & 0b0111000011011111 (0x70df)
    --   0: disable custom waves
    --   111: keep the note effects
    --   000: dont keeep the volume
    --   011: only allow triangle, tilted saw, saw, and square waves. tilted saw usually gives the "meat" of the cry.
    --   011111: note pitch, but remove the top bit so we don't have tons of super high pitched noises (lots of 255 and 254)
    -- | 0b0000100000000000 (0x0c00): set the volume to 6 for everything (0=0, 2=1, 4=2, 6=3, 8=4, a=5, c=6, e=7)

    poke2(loc, %loc & 0x70df | 0x0a00)
  end

  -- breaking apart the bits:
  -- 0x00: zero out the beg loop
  -- 0x00: zero out the end loop
  -- 0x07: set speed to 7
  -- 0xd7: somehow sets noiz, buzz, detune, reverb, dampen all to max
  poke4(iloc+64, 0x.07d7)
end

sfx'63' -- play the starting sound effect after everything has been initialized, this guarantees the into sfx matches the initial animation.
