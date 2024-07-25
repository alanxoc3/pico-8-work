-- in picodex, the screen is always divided into 2 sections, the "preview" grid and the "text" grid.
-- p_ = preview, t_ = text. The "preview" grid is the area at the top of the screen. The "text" grid is the area at the bottom of the screen.

-- current: 4707 | 28810 | 10642

-- TODO: i could add another ui screen for confirming you want to select a pokemon. but its fine if i dont do this too.
-- TODO: stretch goal: add tiny descriptions for items

|[f_init_batresults]| function()
  f_setsel('g_grid_battle_results', p_action_other_active.spot-1) -- this needs to go in init, because it uses the DEFAULT memory location and there is a minor ui bug if it is called before init

  if p_action_other == p_battle_bot then
    g_p1_winfunc()
  end
end $$

---------------------------------------------------------------------- :OP
|[f_op_pickedit]| function(_ENV)
  local pkstr_arr = {}
  local pkstr_lens = split'2,2,2,2,1,1'
  for ii=0,5 do
    local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', ii)
    add(pkstr_arr, sub(c_pkmn_names[pkmn.num], 1, pkstr_lens[ii+1]))
  end

  f_print_info(preview_op, [[
     ;,"edit ",@
    ;;,@,"-",@,"-",@,"-",@,"-",@,@
  ]], c_team_names[f_getsel'g_grid_pickedit'], unpack(pkstr_arr))

  f_add_edit(op)
end $$

|[f_op_pickleagueenemy]| function(_ENV)
  for i=1, 58 do
    local disabled = @S_STORY+1<i
    add(op, {text=disabled and f_strtoq(c_trnr_names[i]) or c_trnr_names[i], disabled=disabled})
  end

  f_leagueinfo(preview_op)
end $$

|[f_op_pickleagueplayr]| function(_ENV)
  f_add_edit(op, true)
  f_leagueinfo(preview_op)
end $$

|[f_op_pickversus]| function(_ENV)
  f_info_toggle(preview_op, 'g_grid_pickplr1', c_team_names[f_getsel'g_grid_pickplr2'])
  f_add_edit(op, true)
end $$

-- This updates the lock variables, which determine if a pokemon/item/move is unlocked.
|[f_op_def]|        function(_ENV) add(op, {}) end $$
|[f_op_edititem]| function(_ENV)
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')

  f_print_info(preview_op, [[
     ;,"edit item"
    ;;,@,@," ",@
  ]], "#", pkmn.num_str, pkmn.name)

  f_op_template_edit(op, c_items, 'item')
end $$

|[f_op_statbrowse]| function(_ENV)
  f_add_browse_info(preview_op)
  f_add_stat(op, c_pokemon[f_getsel'g_grid_browse'])
end $$

|[f_op_browse]| function(_ENV)
  arg(preview_op)
  for i=0,251 do
    local disabled = not c_pokemon[i].lock
    add(op, {lrvalid=not disabled, disabled=disabled, draw=function(_, is_sel, gridobj)
      f_draw_pkmn(c_pokemon[i].lock and i or P_NONE, 1, 1, STYLE_SMALL, false, is_sel, gridobj.disabled)
    end})
  end
end $$

|[f_op_statbattle]| function(_ENV)
  f_dt_batstats(preview_op, f_getsel'g_grid_picktrnr', f_getsel'g_grid_battle_stats')

  local bothteams = {}
  for i=1,6 do add(bothteams, i == p_action_self_active.spot  and p_action_self_active  or p_action_self.team[i]) end
  for i=1,6 do add(bothteams, i == p_action_other_active.spot and p_action_other_active or p_action_other.team[i]) end
  f_add_stat(op, bothteams[f_getsel'g_grid_battle_stats'+1], true)
end $$

|[f_add_edit]| function(op, disable_empty)
  for partynum=0,3 do
    local valid = true
    local inds = {}
    for pkmnnum=0,5 do
      local pkmn = f_get_party_pkmn(partynum, pkmnnum)
      if pkmn.valid then
        valid = false
      end

      add(inds, pkmn.num)
    end
    add(op, {data=inds, disabled=disable_empty and valid, draw=function(i, is_sel, gridobj)
      for ii, ind in ipairs(gridobj.data) do
        f_draw_pkmn(ind, (ii-1)%3+1+(ii-1)%3*9, 1+(ii-1)\3*10, STYLE_SMALL, false, is_sel, gridobj.disabled)
      end
    end})
  end
end $$

|[f_op_editteam]| function(_ENV)
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')

  f_print_info(preview_op, [[
     ;,"edit spot",@
    ;;,@,@," ",@
  ]], f_getsel'g_grid_pickspot'+1, "#", pkmn.num_str, pkmn.name)

  for pkmnnum=0,5 do
    local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', pkmnnum)
    add(op, {lrvalid=pkmn.valid, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, STYLE_NORMAL, false, is_sel, false)
    end})
  end
end $$

|[f_op_title]| function(_ENV)
  add(preview_op, {draw=function()
    print("\^w\^tpicodex", 2, 1,  C_3)
    print(c_palette_names[g_palette], 2, 32, C_1)
    f_draw_pkmn(g_title_l, 7,  14, STYLE_SHAKE, false, not g_title_sel, false)
    f_draw_pkmn(g_title_r, 35, 14, STYLE_SHAKE, true,  g_title_sel,     false)
  end})

  foreach(split"view,edit,league,versus", function(text)
    f_addop_text(op, text)
  end)
end $$

|[f_op_editmovebot]| function(_ENV)
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  for i=1,4 do
    add(op, {text=c_move_names[pkmn[i].num], select=function()
      f_setsel('g_grid_editmove', pkmn[i].pid-1)
      f_add_to_ui_stack(g_grid_editmove)
    end})
  end

  f_add_stat_move(preview_op, pkmn, f_getsel'g_grid_editmovebot')
end $$

|[f_op_editstat]| function(_ENV)
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  f_add_stat_preview(preview_op, pkmn)

  add(op, {text="moves", select=function()
    f_add_to_ui_stack(g_grid_editmovebot)
  end})

  add(op, {text=c_item_names[pkmn.item], select=function()
    f_setsel('g_grid_edititem', pkmn.item)
    f_add_to_ui_stack(g_grid_edititem)
  end})

  add(op, {text=c_gender_names[pkmn.gender], disabled=pkmn.gender_mask < G_BOTH, select=function()
    pkmn.gender_bit += 1
    pkmn:f_save_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
    f_refresh_top()
  end})

  add(op, {text="delete", select=function()
    memset(S_PARTY1+f_getsel'g_grid_pickedit'*42+f_getsel'g_grid_pickspot'*7, P_NONE, 7)
    f_pop_ui_stack()
  end})
end $$

|[f_op_editmove]| function(_ENV)
  local pkmn = f_get_edit_op_pkmn()

  local movenum = pkmn.possible_moves[f_getsel'g_grid_editmove'+1]
  local move = c_moves[movenum]
  local method = pkmn.possible_moves_method[movenum]

  local maxpp, pp, pow, accuracy, typ = f_get_move_texts(move)
  local ind = f_getsel'g_grid_editmovebot'+1

  f_print_info(preview_op, [[
     ;,"edit move",@
    ;;,@," ",@
  ]], ind, method, typ)

  for i, num in ipairs(pkmn.possible_moves) do
    f_create_spot(c_moves[num], op, pkmn.seen_moves[i])
  end
end $$

-- TODO: there is currently a bug when swapping. the ui speeds through. Reproduce by playing versus and just swap.
-- first frame flips. nxt frame p2t2
|[f_op_batsel]| function(_ENV)
  -- TODO: this definitely could be crunched
  add(op, {text="fight", select=function()
    local should_struggle = true
    for i=1,4 do
      if p_action_self_active[i].pp_obj.pp > 0 then
        should_struggle = false
      end
    end

    if should_struggle then
      f_add_to_ui_stack(g_grid_battle_dmovsel)
    else
      f_add_to_ui_stack(g_grid_battle_movesel)
    end
  end})

  add(op, {text="swap",  select=function()
    f_setsel('g_grid_battle_switch', p_action_self_active.spot-1)
    f_add_to_ui_stack(g_grid_battle_switch)
  end})

  add(op, {text="view",  select=function()
    f_setsel('g_grid_battle_stats', p_action_self_active.spot-1)
    f_add_to_ui_stack(g_grid_battle_stats)
  end})

  add(op, {text="run",   select=function() f_end_battle(p_action_self)                     end})

  f_add_battle(preview_op)
end $$

|[f_op_movesel]| function(_ENV)
  for i=1,4 do
    add(op, {text=c_move_names[p_action_self_active[i].num], disabled=p_action_self_active[i].pp_obj.pp == 0})
  end

  f_add_stat_move(preview_op, p_action_self_active, f_getsel'g_grid_battle_movesel')
end $$

|[f_op_dmovsel]| function(_ENV)
  f_print_info(op, [[;,"no more moves";;,"use struggle?"]])
  f_add_stat_move(preview_op, p_action_self_active, -1) -- -1+1=0 is struggle, every pokemon has a default move of 0 which is always struggle.
end $$

|[f_op_batswitch]| function(_ENV)
  -- TODO: this could likely be combined with f_dt_batstats. would saves tokenies :)
  local pkind = f_getsel'g_grid_battle_switch'
  local trainer_ind = f_getsel'g_grid_picktrnr'

  local name = c_trnr_names[trainer_ind+1]
  local pkmn = p_action_self.team[pkind%6+1]
  local player = pkind < 6 and p_action_self or p_action_other

  f_print_info(preview_op, [[
     ;,"swap ",@
    ;;,@," spot",@
  ]], pkmn.name, player.name, pkind%6+1)

  for i=1,6 do
    local pkmn = p_action_self.team[i]
    local disabled = not pkmn.valid or i==p_action_self_active.spot or pkmn.major == C_MAJOR_FAINTED
    add(op, {disabled=disabled, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, STYLE_NORMAL, false, is_sel, disabled)
    end})
  end
end $$

|[f_op_batresults]| function(_ENV)
  for i=1,6 do
    local pkmn = p_action_other.team[i]
    local disabled = not pkmn.valid or pkmn.major == C_MAJOR_FAINTED
    add(op, {disabled=disabled, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, STYLE_SHAKE, p_action_other == p_battle_top, is_sel, disabled)
    end})
  end

  f_print_info(preview_op, [[
     ;,@," ",@
    ;;,"is the winner!" -- ;;,"is victorious!" -- that's another good win phrase.
  ]], p_action_other.name, p_action_other.subname)
end $$

-- TODO: make pkmn face opposite way if player 2, for switch screen as well. Maybe...
|[f_op_batstats]| function(_ENV)
  f_dt_batstats(preview_op, f_getsel'g_grid_picktrnr', f_getsel'g_grid_battle_stats')

  for i=1,6 do
    local pkmn = p_action_self.team[i]
    local disabled = not pkmn.valid
    add(op, {lrvalid=not disabled, disabled=disabled, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, STYLE_NORMAL, false, is_sel, disabled)
    end})
  end

  for i=1,6 do
    local pkmn = p_action_other.team[i]
    local disabled = not pkmn.valid
    add(op, {lrvalid=not disabled, disabled=disabled, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, STYLE_NORMAL, true, is_sel, disabled)
    end})
  end
end $$

---------------------------------------------------------------------- :DT
|[f_add_browse_info_template]| function(op, selname, topline)
  local pkmn = c_pokemon[f_getsel(selname)]
  local namestr = pkmn.name

  if not pkmn.lock then
    namestr = f_strtoq(namestr)
  end

  f_print_info(op, [[
     ;,@
    ;;,@,@," ",@
  ]], topline, "#", f_prefix_zero(pkmn.num, 3), namestr)
end $$

|[f_add_browse_info]|     function(op) f_add_browse_info_template(op, 'g_grid_browse',   "view picodex") end $$
|[f_add_editbrowse_info]| function(op) f_add_browse_info_template(op, 'g_grid_editpkmn', "edit spot"..(f_getsel'g_grid_pickspot'+1)) end $$ -- TODO: check if the parens are needed here. could save a token if not

|[f_dt_batstats]| function(op, trainer_ind, pkind)
  local player = pkind < 6 and p_action_self or p_action_other
  local name = c_trnr_names[trainer_ind+1]
  local pkmn = player.team[pkind%6+1]
  -- TODO: try changing this to match the editbrowse and viewbrowse info boxes (#xxx pkmname)
  f_print_info(op, [[
     ;,@," spot",@
    ;;,"view ",@
  ]], player.name, pkind%6+1,pkmn.name)
end $$

-- do i want a stats menu? or do i want level + auto?
-- well, what is important that you can see in stat menu?
-- item, move info, major, ...

---------------------------------------------------------------------- :SELECT :LEAVE
|[f_s_batresults]| function()
  -- TODO: dedup with other loops through alive pokemon
  return p_action_other.team[f_getsel'g_grid_battle_results'+1].num
end $$

|[f_l_browse]|   function()  f_pop_ui_stack()                                                                                                                      end $$
|[f_s_browse]|   function()  f_add_to_ui_stack(g_grid_statbrowse)                                                                                                  end $$
|[f_s_versus]|   function()  f_add_to_ui_stack(g_grid_pickplr2)                                                                                                    end $$
|[f_s_league]|   function()  f_add_to_ui_stack(g_grid_picktrnr)                                                                                                    end $$
|[f_s_batstat]|  function() f_add_to_ui_stack(g_grid_statbattle)                                                                                                   end $$
|[f_s_edit]|     function() f_add_to_ui_stack(g_grid_pickspot)                                                                                                     end $$
|[f_s_editteam]| function() f_add_to_ui_stack(f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot').valid and g_grid_editstat or g_grid_editpkmn) end $$

|[f_s_editstat]|    function() gridpo[f_getsel'g_grid_editstat'+1].select()      end $$
|[f_s_editmovebot]| function() gridpo[f_getsel'g_grid_editmovebot'+1].select()   end $$
|[f_s_battle]|      function() gridpo[f_getsel'g_grid_battle_select'+1].select() end $$

|[f_s_title]| function()
  if f_getsel'g_grid_title' == 0 then
    f_add_to_ui_stack(g_grid_browse)
  elseif f_getsel'g_grid_title' == 1 then
    f_add_to_ui_stack(g_grid_pickedit)
  elseif f_getsel'g_grid_title' == 2 then
    f_add_to_ui_stack(g_grid_pickleag)
  elseif f_getsel'g_grid_title' == 3 then
    f_add_to_ui_stack(g_grid_pickplr1)
  end
end $$

|[f_s_pkstat]| function()
  g_preview_timer = 20
  return f_getsel'g_grid_browse'
end $$

|[f_s_statedit]| function()
  g_preview_timer = 20
  return f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot').num
end $$

|[f_s_statbat]| function()
  g_preview_timer = 20
  local bothteams = {}
  for i=1,6 do add(bothteams, p_action_self.team[i]) end
  for i=1,6 do add(bothteams, p_action_other.team[i]) end
  return bothteams[f_getsel'g_grid_battle_stats'+1].num
end $$

|[f_s_versusbegin]| function()
  f_start_battle(
    f_nop,
    f_team_party(f_getsel'g_grid_pickplr2'),
    c_team_names[f_getsel'g_grid_pickplr2'],
    P_MALETRNR + f_getsel'g_grid_pickplr2' % 2,
    f_getsel'g_grid_pickplr2' > 1
  )
end $$

|[f_s_batbegin]|    function()
  local loc = f_getsel'g_grid_picktrnr' -- I THINK THIS NEEDS TO BE SET BEFORE THE FUNCTION. TODO: I should check that's correct and comment it for sure, which means cant save tokens.
  f_start_battle(function()
    if loc == @S_STORY then
      poke(S_STORY,  max(loc+1, @S_STORY))
      poke(S_LEAGUE, min(@S_STORY, 57))
      f_update_locks(loc)
    end
  end, f_team_league(loc+1, 1), c_trnr_names[loc+1], c_trainers[loc+1].num, true)
end $$

|[f_s_editpkmn]| function()
  f_save_party_pkmn(f_mkpkmn(f_getsel'g_grid_editpkmn', c_pokemon[f_getsel'g_grid_editpkmn'], true, @S_TEAM1, I_NONE, 5, 6, 7, 8), f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  f_pop_ui_stack()
end $$

|[f_s_editmove]| function()
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  pkmn[f_getsel'g_grid_editmovebot'+1].pid = f_getsel'g_grid_editmove'+1
  f_save_party_pkmn(pkmn, f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  f_pop_ui_stack()
end $$

|[f_s_edititem]| function()
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  pkmn.item = f_getsel('g_grid_edititem')
  f_save_party_pkmn(pkmn, f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  f_pop_ui_stack()
end $$

|[f_l_title]| function() -- TODO: maybe we can call sfx in here and l_browse. might save a token instead of handling that in grid.
  g_title_sel = not g_title_sel

  if g_title_sel then
    g_title_r = rnd"252"\1 return g_title_r
  else
    g_title_l = rnd"252"\1 return g_title_l
  end

  g_palette += 1
  g_palette %= #c_palettes
end $$

|[f_l_battle]| function()
  return p_action_self_active.invisible and SFX_ERROR or p_action_self_active.num end $$

|[f_s_batmove]| function()
  p_action_self.nextmove = p_action_self_active[f_getsel'g_grid_battle_movesel'+1]
  f_movelogic(p_action_self)

  -- TODO: Dedup with below.
  f_pop_ui_stack()
  f_pop_ui_stack()

  f_add_to_ui_stack(g_grid_battle_actions) -- TODO: add init select func?
end $$

|[f_s_dmovsel]| function()
  -- TODO: dedup
  p_action_self.nextmove = c_moves[M_STRUGGLE]
  f_movelogic(p_action_self)
  f_pop_ui_stack()
  f_pop_ui_stack()

  f_add_to_ui_stack(g_grid_battle_actions)
end $$

-- TODO: fix ui bug where state changes a frame early. Probably by putting a callback in pop ui stack?
-- it immediately applies thing, but doesn't switch the drawn thing for another frame...
-- fixed the draw thing, but now the selection doesn't get applied immediately. TODO: figure this out!
|[f_s_batswitch]| function()
  p_action_self.nextmove = nil -- nextmove as nil means the pokemon will switch out

  local nextpkmn = f_getsel'g_grid_battle_switch'+1 -- needs to be defined out of callback, because it can change!
  f_addaction(p_action_self, L_TRIGGER, p_action_self, "backs "..p_action_self_active.name, function()
    p_action_self_active.invisible = true
    add(p_action_self.actions, f_pkmn_comes_out(p_action_self, nextpkmn, L_TRIGGER)) -- technically, this could be L_ATTACK too, doesn't really matter since poison/nightmare dmg isnt done on switches.
  end, true)

  f_pop_ui_stack()
  f_pop_ui_stack()

  f_add_to_ui_stack(g_grid_battle_actions) -- todo: add init? select func
end $$

|[f_op_bataction]| function(_ENV)
  if not g_msg_bot then end -- TODO: is this needed? I'm guessing not... experiment removing it!
  f_print_info(preview_op, [[;,~g_msg_top;;,~g_msg_bot]])
  f_add_battle(op)
end $$

|[f_s_bataction]| function()
  while true do -- a "return" is the only way out of here. we could execute multiple actions in a frame if some actions simply trigger other actions. TODO: is there any checks i can have here instead of returns?
    -- check for win condition before selecting every action
    for player in all{p_first, p_last} do
      if not f_get_next_active(player) then
        f_end_battle(player)
        return
      end
    end

    -- uncomment this for a decent log that prints the contents of the action stack.
    -- local actionstr = "p1 actions" for x in all(p_battle_bot.actions) do actionstr ..= " | "..(x.message or "empty") end actionstr ..= " |:| p2 actions" for x in all(p_battle_top.actions) do actionstr ..= " | "..(x.message or "empty") end printh(actionstr)

    p_turn_self, p_curaction = f_pop_next_action()
    if p_curaction then -- if there is a next action
      f_set_both_players([[p_action_self,@, p_action_other,@, p_action_self_active,@, p_action_other_active,@]], p_curaction.player)
      f_set_both_players([[p_turn_self,@,   p_turn_other,@,   p_turn_self_active,@,   p_turn_other_active,@]], p_turn_self)

      p_curaction.logic()

      -- an empty message means we execute the logic, but look for another p_curaction
      if p_curaction.message then
        f_setsel('g_grid_battle_actions', p_action_self == p_battle_bot and 1 or 0) -- TODO: dedup
        g_msg_top = p_action_self.name.." "..p_action_self_active.name
        if p_curaction.isplayeraction then -- TODO: token crunch
          g_msg_top = p_action_self.name.." "..p_action_self.subname
        end
        g_msg_bot = p_curaction.message
        return
      end
    else -- if there is no next action, that means we are at the end of the turn.
      f_set_both_players([[p_action_self,@, p_action_other,@, p_action_self_active,@, p_action_other_active,@]], p_battle_bot)
      f_start_turn()
    end
  end
end $$

---------------------------------------------------------------------- :CONNECT
-- This needs to be called early on because there is a draw
f_zcall(f_create_gridpair, [[
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
  --,name                      ,savespot      ,maingridspec   ,infogridspec   ,main opfunc           ,select func       ,leave func       ,lrbasegrid          ,static ,initfunc ,opfunc params
  ;;,g_grid_title              ,S_TITLEACTION ,~bot_4x4       ,~top_title     ,~f_op_title           ,~f_s_title        ,~f_l_title       ,~c_no               ,~c_no  ,~f_nop

  ;;,g_grid_browse             ,S_BROWSE      ,~top_browse    ,~bot_info      ,~f_op_browse          ,~f_s_browse       ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop   ,~f_add_browse_info
  ;;,g_grid_editpkmn           ,S_BROWSE      ,~top_browse    ,~bot_info      ,~f_op_browse          ,~f_s_editpkmn     ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop   ,~f_add_editbrowse_info

  ;;,g_grid_statbrowse         ,S_BROWSESTAT  ,~top_pkstat    ,~bot_info      ,~f_op_statbrowse      ,~f_s_pkstat       ,~f_l_browse      ,g_grid_browse       ,~c_no  ,~f_nop

  ;;,g_grid_editstat           ,S_EDITACTION  ,~bot_4x4       ,~top_pkstat    ,~f_op_editstat        ,~f_s_editstat     ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,g_grid_editmovebot        ,S_EDITMOVE    ,~bot_4x4       ,~top_pkstat    ,~f_op_editmovebot     ,~f_s_editmovebot  ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,g_grid_editmove           ,S_DEFAULT     ,~top_text_grid ,~bot_info      ,~f_op_editmove        ,~f_s_editmove     ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,g_grid_edititem           ,S_DEFAULT     ,~top_text_grid ,~bot_info      ,~f_op_edititem        ,~f_s_edititem     ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop

  ;;,g_grid_pickedit           ,S_TEAM1       ,~top_edit      ,~bot_info      ,~f_op_pickedit        ,~f_s_edit         ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,g_grid_pickleag           ,S_TEAM1       ,~top_edit      ,~bot_info      ,~f_op_pickleagueplayr ,~f_s_league       ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,g_grid_pickplr1           ,S_TEAM1       ,~top_edit      ,~bot_info      ,~f_op_pickversus      ,~f_s_versus       ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,g_grid_pickplr2           ,S_TEAM2       ,~top_edit      ,~bot_info      ,~f_op_pickversus      ,~f_s_versusbegin  ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,g_grid_picktrnr           ,S_LEAGUE      ,~top_text_grid ,~bot_info      ,~f_op_pickleagueenemy ,~f_s_batbegin     ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,g_grid_pickspot           ,S_EDITPKMN    ,~top_editteam  ,~bot_info      ,~f_op_editteam        ,~f_s_editteam     ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop

  -- Battle UI
  ;;,g_grid_battle_select      ,S_DEFAULT     ,~bot_4x4       ,~top_battle2   ,~f_op_batsel          ,~f_s_battle       ,~f_l_battle      ,~c_no               ,~c_no  ,~f_nop
  ;;,g_grid_statbattle         ,S_DEFAULT     ,~top_pkstat    ,~bot_info      ,~f_op_statbattle      ,~f_s_statbat      ,~f_l_browse      ,g_grid_battle_stats ,~c_no  ,~f_nop
  ;;,g_grid_battle_movesel     ,S_DEFAULT     ,~bot_4x4       ,~top_pkstat    ,~f_op_movesel         ,~f_s_batmove      ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop -- normal move sel
  ;;,g_grid_battle_dmovsel     ,S_DEFAULT     ,~bot_info      ,~top_pkstat    ,~f_op_dmovsel         ,~f_s_dmovsel      ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop -- struggle move sel
  ;;,g_grid_battle_switch      ,S_DEFAULT     ,~top_editteam  ,~bot_info      ,~f_op_batswitch       ,~f_s_batswitch    ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop
  ;;,g_grid_battle_stats       ,S_DEFAULT     ,~top_editteam  ,~bot_info      ,~f_op_batstats        ,~f_s_batstat      ,~f_l_browse      ,~c_no               ,~c_no  ,~f_nop

  ;;,g_grid_battle_results     ,S_DEFAULT     ,~top_results   ,~bot_info      ,~f_op_batresults      ,~f_s_batresults   ,~f_l_browse      ,~c_no               ,~c_yes ,~f_init_batresults
  ;;,g_grid_battle_actions     ,S_DEFAULT     ,~top_battle2   ,~bot_info      ,~f_op_bataction       ,~f_s_bataction    ,~f_l_battle      ,~c_no               ,~c_yes ,~f_s_bataction
  ;;,g_grid_battle_firstaction ,S_DEFAULT     ,~top_battle2   ,~bot_info      ,~f_op_bataction       ,~f_s_bataction    ,~f_l_battle      ,~c_no               ,~c_yes ,~f_nop
]])

f_add_to_ui_stack(g_grid_title)
