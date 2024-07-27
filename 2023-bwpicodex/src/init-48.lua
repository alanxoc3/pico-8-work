f_zcall[[
   ;,~poke ,0x5f2c  ,3  -- screen to 64x64
  ;;,~poke ,0x5f5c  ,8  -- set btn initial delay before repeating. 255 means never repeat.
  ;;,~poke ,0x5f5d  ,1  -- set btn repeating delay.
  ;;,~cls               -- this is just a visual blank screen when the game starts up

  ;;,~memset ,0x5e00 ,0   ,256 -- todo: remove me, factory reset
  ;;,~poke   ,S_STORY ,57      -- todo: remove me, story set for debugging
]]

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
