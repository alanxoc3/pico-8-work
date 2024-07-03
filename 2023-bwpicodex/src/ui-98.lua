-- in picodex, the screen is always divided into 2 sections, the "preview" grid and the "text" grid.
-- p_ = preview, t_ = text. The "preview" grid is the area at the top of the screen. The "text" grid is the area at the bottom of the screen.

-- current: 4707 | 28810 | 10642

-- TODO: i could add another ui screen for confirming you want to select a pokemon. but its fine if i dont do this too.
-- TODO: stretch goal: add tiny descriptions for items


---------------------------------------------------------------------- :OP

-- This updates the lock variables, which determine if a pokemon/item/move is unlocked.
|[f_op_def]|        function(_ENV) add(op, {}) end $$
|[f_op_edititem]|   function(_ENV) f_op_template_edit(op, c_items, 'item')  end $$
|[f_op_statbrowse]| function(_ENV) f_add_stat(op, c_pokemon[f_getsel'g_grid_browse']) end $$

|[f_op_browse]| function(_ENV)
  for i=0,251 do
    local disabled = not c_pokemon[i].lock
    add(op, {lrvalid=not disabled, disabled=disabled, draw=function(_, is_sel, gridobj)
      f_draw_pkmn(c_pokemon[i].lock and i or P_NONE, 1, 1, 6, false, false, gridobj.disabled, not is_sel)
    end})
  end
end $$

|[f_op_statbattle]| function(_ENV)
  local bothteams = {}
  for i=1,6 do add(bothteams, p_self.team[i]) end
  for i=1,6 do add(bothteams, p_other.team[i]) end

  f_add_stat(op, bothteams[f_getsel'g_grid_battle_stats'+1], true)
end $$

|[f_op_edit]| function(_ENV, sumdisable)
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
    add(op, {data=inds, disabled=sumdisable and valid, draw=function(i, is_sel, gridobj)
      for ii, ind in ipairs(gridobj.data) do
        f_draw_pkmn(ind, (ii-1)%3+1+(ii-1)%3*9, 1+(ii-1)\3*10, 6, false, false, gridobj.disabled, not is_sel)
      end
    end})
  end
end $$

|[f_op_editteam]| function(_ENV)
  for pkmnnum=0,5 do
    local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', pkmnnum)
    add(op, {lrvalid=pkmn.valid, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, 16, false, false, false, not is_sel)
    end})
  end
end $$

|[f_op_title]| function(_ENV)
  foreach(split"view,edit,league,versus", function(text)
    f_addop_text(op, text)
  end)
end $$

|[f_op_prevpk]| function(_ENV)
  add(op, {draw=function()
    f_draw_pkmn(c_pokemon[f_getsel'g_grid_browse'].num, 30-18+1, 20-18+1, 32, g_title_sel, false, false, false)
  end})
end $$

|[f_op_teams]| function(_ENV)
  for i=1, 58 do
    local disabled = @S_STORY+1<i
    add(op, {text=disabled and f_strtoq(c_trnr_names[i]) or c_trnr_names[i], disabled=disabled})
  end
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

  add(op, {text=c_gender_names[pkmn.gender], disabled=#pkmn.genders < 2, select=function()
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
  for i, num in ipairs(pkmn.possible_moves) do
    f_create_spot(c_moves[num], op, pkmn.seen_moves[i])
  end
end $$

-- TODO: there is currently a bug when swapping. the ui speeds through. Reproduce by playing versus and just swap.
-- first frame flips. nxt frame p2t2
|[f_op_batsel]| function(_ENV)
  -- TODO: this definitely could be crunched
  add(op, {text="fight", select=function() f_add_to_ui_stack(g_grid_battle_movesel) end})
  add(op, {text="swap",  select=function()
    f_setsel('g_grid_battle_switch', p_self.active.spot-1)
    f_add_to_ui_stack(g_grid_battle_switch)
  end})

  add(op, {text="view",  select=function()
    f_setsel('g_grid_battle_stats', p_self.active.spot-1)
    f_add_to_ui_stack(g_grid_battle_stats)
  end})

  add(op, {text="run",   select=function() f_end_battle(p_self)                     end})

  f_add_battle(preview_op)
end $$

|[f_op_movesel]| function(_ENV)
  for i=1,4 do
    add(op, {text=c_move_names[p_self.active[i].num], disabled=p_self.active[i].pp == 0})
  end

  f_add_stat_move(preview_op, p_self.active, f_getsel'g_grid_battle_movesel')
end $$

|[f_op_batswitch]| function(_ENV)
  for i=1,6 do
    local pkmn = p_self.team[i]
    local disabled = not pkmn.valid or i==p_self.active.spot or pkmn.major == C_MAJOR_FAINTED
    add(op, {disabled=disabled, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, 16, false, false, disabled, not disabled and not is_sel)
    end})
  end
end $$

|[f_op_batresults]| function(_ENV)
  for i=1,6 do
    local pkmn = p_other.team[i]
    local disabled = not pkmn.valid or pkmn.major == C_MAJOR_FAINTED
    add(op, {disabled=disabled, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, 16, false, false, disabled, not disabled and not is_sel)
    end})
  end

  add(preview_op, {draw=function()
    f_print_top(p_other.name.." "..p_other.subname)
    --f_print_bot("is victorious")
    --f_print_bot("wins the match!")
    f_print_bot("is the winner!")
  end})
end $$

|[f_op_batstats]| function(_ENV)
  for i=1,6 do
    local pkmn = p_self.team[i]
    local disabled = not pkmn.valid
    add(op, {lrvalid=not disabled, disabled=disabled, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, 16, false, false, disabled, not disabled and not is_sel)
    end})
  end

  for i=1,6 do
    local pkmn = p_other.team[i]
    local disabled = not pkmn.valid
    add(op, {lrvalid=not disabled, disabled=disabled, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, 16, false, false, disabled, not disabled and not is_sel)
    end})
  end
end $$

---------------------------------------------------------------------- :DT
|[f_dt_editteam]| function(i, is_sel)
  local spotstr = "spot"..(f_getsel'g_grid_pickspot'+1) -- ," spot",f_getsel'g_grid_pickspot'+1)

  f_print_top("edit ", spotstr)
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  f_print_bot("#", pkmn.num_str, " ", pkmn.name)
end $$

|[f_dt_editstat]| function(i, is_sel)
  local prefix = "edit" -- ..f_getsel'g_grid_pickspot'+1
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  local spotstr = "spot"..(f_getsel'g_grid_pickspot'+1)
  if f_getsel'g_grid_editstat' == 0 then f_print_top("view: "..spotstr)
  elseif f_getsel'g_grid_editstat' == 1 then f_print_top("edit item")
  elseif f_getsel'g_grid_editstat' == 6 then f_print_top(prefix, " item")
  elseif f_getsel'g_grid_editstat' == 7 then f_print_top(prefix, " gender")
  else f_print_top(prefix, " move", f_getsel'g_grid_editstat'-1)
  end

  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  f_print_bot("#", pkmn.num_str, " ", pkmn.name)
end $$

-- TODO: is this better being inside an "op" function?
|[f_dt_editmove_template]| function(move, method)
  local maxpp, pp, pow, accuracy, typ = f_get_move_texts(move)
  local ind = f_getsel'g_grid_editmovebot'+1

  f_print_top("edit move"..ind)
  f_print_bot(method.." "..typ)
end $$

|[f_dt_editmove]| function()
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  local movenum = pkmn.possible_moves[f_getsel'g_grid_editmove'+1]
  local move = c_moves[movenum]
  f_dt_editmove_template(move, pkmn.possible_moves_method[movenum])
end $$

|[f_dt_browse]| function()
  f_dt_browse_template(f_getsel'g_grid_browse')
end $$

-- TODO: dedup with below func
|[f_dt_editpkmn]| function()
  local pkmn = c_pokemon[f_getsel'g_grid_editpkmn']
  local namestr = pkmn.name

  if not pkmn.lock then
    namestr = f_strtoq(namestr)
  end

  local spotstr = "spot"..(f_getsel'g_grid_pickspot'+1)
  f_print_top("edit ",spotstr)
  f_print_bot("#", f_prefix_zero(pkmn.num, 3), " ", namestr)
end $$

|[f_dt_edit]| function()
  local pkstr_arr = {}
  local pkstr_lens = split'2,2,2,2,1,1'
  for ii=0,5 do
    local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', ii)
    add(pkstr_arr, sub(c_pkmn_names[pkmn.num], 1, pkstr_lens[ii+1]))
  end

  f_print_top("edit team", f_getsel'g_grid_pickedit'+1) -- TODO: fixme
  f_print_bot(pkstr_arr[1], "-", pkstr_arr[2], "-", pkstr_arr[3], "-", pkstr_arr[4], "-", pkstr_arr[5], pkstr_arr[6])
end $$

|[f_dt_batstats]| function()
  local ind = f_getsel'g_grid_battle_stats'
  local player = ind < 6 and p_self or p_other
  local name = c_trnr_names[f_getsel'g_grid_picktrnr'+1]
  local pkmn = player.team[ind%6+1]
  f_print_bot(player.name, " spot", ind%6+1)
  f_print_top("view ", pkmn.name)
end $$

|[f_dt_switch]| function()
  local ind = f_getsel'g_grid_battle_switch'
  local name = c_trnr_names[f_getsel'g_grid_picktrnr'+1]
  local pkmn = p_self.team[ind%6+1]
  f_print_top("swap ", pkmn.name)
  --f_print_bot("#", f_prefix_zero(pkmn.num, 3), " ", pkmn.name)
  local player = ind < 6 and p_self or p_other
  f_print_bot(player.name, " spot", ind%6+1)
end $$

|[f_dt_league]| function()
  -- TODO: save tokens / compression by extracting out this if.
  local toggle = g_cg_m.name == 'g_grid_pickleag'
  local disabled = @S_STORY+1<f_getsel'g_grid_picktrnr'+1
  local name = c_trnr_names[f_getsel'g_grid_picktrnr'+1]
  name = disabled and f_strtoq(name) or name

  f_print_top(toggle and "\f3" or "\f1", "playr team", f_getsel'g_grid_pickleag'+1)
  f_print_bot(toggle and "\f1" or "\f3", "enemy ", name)
end $$

|[f_dt_versus]| function()
  local toggle = g_cg_m.name == 'g_grid_pickplr1'

  f_print_top(toggle and "\f3" or "\f1", "plyr1 team", f_getsel'g_grid_pickplr1'+1)
  f_print_bot(toggle and "\f1" or "\f3", "plyr2 team", f_getsel'g_grid_pickplr2'+1)
end $$

|[f_dt_title]| function()
  print("\^w\^tpicodex", 2, 1,  C_3)
  print(c_palette_names[g_palette], 2, 12, C_1)
  f_draw_pkmn(g_title_l, 7,  20, 16, false, false, false,     g_title_sel, true)
  f_draw_pkmn(g_title_r, 35, 20, 16, true , false, false, not g_title_sel, true)
end $$

-- do i want a stats menu? or do i want level + auto?
-- well, what is important that you can see in stat menu?
-- item, move info, major, ...

---------------------------------------------------------------------- :SELECT :LEAVE
|[f_s_batresults]| function()
  g_preview_timer = 20
  return p_other.team[f_getsel'g_grid_battle_results'+1].num
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
  g_title_sel = not g_title_sel
  return f_getsel'g_grid_browse'
end $$

|[f_s_statedit]| function()
  g_preview_timer = 20
  g_title_sel = not g_title_sel
  return f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot').num
end $$

|[f_s_statbat]| function()
  g_preview_timer = 20
  g_title_sel = not g_title_sel
  local bothteams = {}
  for i=1,6 do add(bothteams, p_self.team[i]) end
  for i=1,6 do add(bothteams, p_other.team[i]) end
  return bothteams[f_getsel'g_grid_battle_stats'+1].num
end $$

|[f_s_versusbegin]| function()
  f_start_battle("plyr1", f_nop, f_team_party(f_getsel'g_grid_pickplr2'),    "plyr2", "team"..(f_getsel'g_grid_pickplr2'+1))
end $$

|[f_s_batbegin]|    function()
  local loc = f_getsel'g_grid_picktrnr'

  f_start_battle("playr", function()
    if loc == @S_STORY then
      poke(S_STORY,  max(loc+1, @S_STORY))
      poke(S_LEAGUE, min(@S_STORY, 57))
      f_update_locks(loc)
    end
  end, f_team_league(loc+1), "enemy", c_trnr_names[loc+1], true)
end $$

|[f_s_editpkmn]| function()
  f_save_party_pkmn(f_mkpkmn(f_getsel'g_grid_editpkmn', c_pokemon[f_getsel'g_grid_editpkmn'], true, rnd(2)\1, I_NONE, 5, 6, 7, 8), f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
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

|[f_l_battle]| function() return p_self.active.num end $$

|[f_s_batmove]| function()
  p_self.nextmove = p_self.active[f_getsel'g_grid_battle_movesel'+1]
  f_movelogic(p_self)

  -- TODO: Dedup with below.
  f_pop_ui_stack()
  f_pop_ui_stack()

  f_add_to_ui_stack((p_self == p_2 or p_2.iscpu) and g_grid_battle_actions or g_grid_battle_turnbeg, function()
    if p_self == p_1 then
      f_turn_end_p1()
    else
      f_turn_end_p2()
    end
  end)
end $$

-- TODO: fix ui bug where state changes a frame early. Probably by putting a callback in pop ui stack?
-- it immediately applies thing, but doesn't switch the drawn thing for another frame...
-- fixed the draw thing, but now the selection doesn't get applied immediately. TODO: figure this out!
|[f_s_batswitch]| function()
  p_self.nextmove = nil -- nextmove as nil means the pokemon will switch out

  local nextpkmn = f_getsel'g_grid_battle_switch'+1 -- needs to be defined out of callback, because it can change!
  f_addaction(p_self, p_self, "backs "..p_self.active.name, function()
    p_self.active.invisible = true
    add(p_self.actions, f_pkmn_comes_out(p_self, nextpkmn))
  end, true)

  f_pop_ui_stack()
  f_pop_ui_stack()

  f_add_to_ui_stack((p_self == p_2 or p_2.iscpu) and g_grid_battle_actions or g_grid_battle_turnbeg, function()
    if p_self == p_1 then
      f_turn_end_p1()
    else
      f_turn_end_p2()
    end
  end)
end $$

|[f_op_startturn]| function(obj)
  g_msg_top = p_self.name.." "..p_self.subname -- TODO: can this be extracted/combined with other g_msg stuff?
  g_msg_bot = "begins turn"
  f_op_bataction(obj)
end $$

|[f_s_startturn]| function()
  f_pop_ui_stack()

  -- this is a quality of life thing. when switching and spamming x, i never wanted to switch 2 times in a row. most commonly you just want to fight right after.
  f_setsel('g_grid_battle_select', 0)

  if p_self == p_1 then
    g_grid_battle_select.g_cg_m.sel  = S_P1_BATACTION
    g_grid_statbattle.g_cg_m.sel     = S_P1_STAT
    g_grid_battle_movesel.g_cg_m.sel = S_P1_MOVE
    g_grid_battle_select.g_cg_m.view  = S_P1_BATACTION+1
    g_grid_statbattle.g_cg_m.view     = S_P1_STAT+1
    g_grid_battle_movesel.g_cg_m.view = S_P1_MOVE+1
  else
    g_grid_battle_select.g_cg_m.sel  = S_P2_BATACTION
    g_grid_statbattle.g_cg_m.sel     = S_P2_STAT
    g_grid_battle_movesel.g_cg_m.sel = S_P2_MOVE
    g_grid_battle_select.g_cg_m.view  = S_P2_BATACTION+1
    g_grid_statbattle.g_cg_m.view     = S_P2_STAT+1
    g_grid_battle_movesel.g_cg_m.view = S_P2_MOVE+1
  end

  f_add_to_ui_stack(g_grid_battle_select)
end $$

|[f_op_bataction]| function(_ENV)
  if not g_msg_bot then end -- TODO: is this needed?
  add(op, {draw=function()
    f_print_top(g_msg_top)
    f_print_bot(g_msg_bot)
  end})

  f_add_battle(preview_op)
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

    local action = f_pop_next_action()
    if action then
      f_set_pself(action.player)
      a_self_active, a_other_active, a_turnself = p_self.active, p_other.active, action.onplayer

      -- TODO: this should probably add to the current turn actions. Not the current actions player.
      a_addaction = function(...) f_addaction(action.onplayer, ...) end
      action.logic(envparams)

      -- an empty message means we execute the logic, but look for another action
      if action.message then
        g_msg_top = p_self.name.." "..p_self.active.name
        if action.isplayeraction then -- TODO: token crunch
          g_msg_top = p_self.name.." "..p_self.subname
        end
        g_msg_bot = action.message
        return
      end
    else
      f_set_pself(p_1)
      p_1.turnover = false
      p_2.turnover = false
      f_pop_ui_stack()
      f_add_to_ui_stack(g_grid_battle_turnbeg)
      return -- important! need to return out otherwise we have an infinite loop
    end
  end
end $$

|[f_l_bataction]| function()
  return p_self.active.num
end $$

---------------------------------------------------------------------- :CONNECT
-- This needs to be called early on because there is a draw
f_zcall(f_create_gridpair, [[
  --               w  vh x  y   cw  ch selh
   top_browse    ;,6 ,4 ,2 ,2  ,10 ,10 ,1
  ;top_edit      ;,2 ,2 ,2 ,2  ,30 ,20 ,1
  ;top_editteam  ;,3 ,2 ,2 ,2  ,20 ,20 ,1
  ;top_pkstat    ;,1 ,4 ,2 ,4  ,60 ,9 ,4
  ;top_pkstatbig ;,1 ,6 ,2 ,5  ,60 ,9  ,1
  ;top_text_grid ;,2 ,4 ,2 ,4  ,30 ,9  ,1
  ;top_title     ;,1 ,1 ,2 ,2  ,60 ,40 ,1
  ;top_battle    ;,1 ,1 ,2 ,2  ,60 ,40 ,1
  ;top_battle2   ;,1 ,1 ,2 ,2  ,60 ,40 ,1
  ;bot_4x4       ;,2 ,2 ,2 ,44 ,30 ,9  ,1
  ;bot_info      ;,1 ,1 ,2 ,45 ,60 ,16 ,1
  ;top_newstat   ;,1 ,6 ,2 ,4  ,60 ,9  ,1

  --,name                  ,savespot       ,maingridspec   ,infogridspec   ,infogriddraw     ,main opfunc       ,select func       ,leave func       ,lrbasegrid        ,opfunc params
  ;;,g_grid_title          ,S_TITLE        ,~bot_4x4       ,~top_title     ,~f_dt_title      ,~f_op_title       ,~f_s_title        ,~f_l_title       ,~c_no

  ;;,g_grid_browse         ,S_BROWSE       ,~top_browse    ,~bot_info      ,~f_dt_browse     ,~f_op_browse      ,~f_s_browse       ,~f_l_browse      ,~c_no             ,~c_no
  ;;,g_grid_editpkmn       ,S_BROWSE       ,~top_browse    ,~bot_info      ,~f_dt_editpkmn   ,~f_op_browse      ,~f_s_editpkmn     ,~f_l_browse      ,~c_no             ,~c_no

  ;;,g_grid_statbrowse     ,S_STAT         ,~top_pkstat    ,~bot_info      ,~f_dt_browse     ,~f_op_statbrowse  ,~f_s_pkstat       ,~f_l_browse      ,g_grid_browse

  ;;,g_grid_editstat       ,S_EDITSEL      ,~bot_4x4       ,~top_pkstat    ,~f_nop           ,~f_op_editstat    ,~f_s_editstat     ,~f_l_browse      ,~c_no
  ;;,g_grid_editmovebot    ,S_EDITMOVE     ,~bot_4x4       ,~top_pkstat    ,~f_nop           ,~f_op_editmovebot ,~f_s_editmovebot  ,~f_l_browse      ,~c_no
  ;;,g_grid_editmove       ,S_DEFAULT      ,~top_text_grid ,~bot_info      ,~f_dt_editmove   ,~f_op_editmove    ,~f_s_editmove     ,~f_l_browse      ,~c_no
  ;;,g_grid_edititem       ,S_DEFAULT      ,~top_text_grid ,~bot_info      ,~f_dt_editstat   ,~f_op_edititem    ,~f_s_edititem     ,~f_l_browse      ,~c_no

  ;;,g_grid_pickedit       ,S_TEAM1        ,~top_edit      ,~bot_info      ,~f_dt_edit       ,~f_op_edit        ,~f_s_edit         ,~f_l_browse      ,~c_no
  ;;,g_grid_pickleag       ,S_TEAM1        ,~top_edit      ,~bot_info      ,~f_dt_league     ,~f_op_edit        ,~f_s_league       ,~f_l_browse      ,~c_no             ,~c_yes
  ;;,g_grid_pickplr1       ,S_TEAM1        ,~top_edit      ,~bot_info      ,~f_dt_versus     ,~f_op_edit        ,~f_s_versus       ,~f_l_browse      ,~c_no             ,~c_yes
  ;;,g_grid_pickplr2       ,S_TEAM2        ,~top_edit      ,~bot_info      ,~f_dt_versus     ,~f_op_edit        ,~f_s_versusbegin  ,~f_l_browse      ,~c_no             ,~c_yes
  ;;,g_grid_pickspot       ,S_EDITPKMN     ,~top_editteam  ,~bot_info      ,~f_dt_editteam   ,~f_op_editteam    ,~f_s_editteam     ,~f_l_browse      ,~c_no
  ;;,g_grid_picktrnr       ,S_LEAGUE       ,~top_text_grid ,~bot_info      ,~f_dt_league     ,~f_op_teams       ,~f_s_batbegin     ,~f_l_browse      ,~c_no

  -- Battle UI
  ;;,g_grid_battle_select  ,S_DEFAULT      ,~bot_4x4       ,~top_battle2   ,~f_nop           ,~f_op_batsel      ,~f_s_battle       ,~f_l_battle      ,~c_no
  ;;,g_grid_statbattle     ,S_DEFAULT      ,~top_pkstat    ,~bot_info      ,~f_dt_batstats   ,~f_op_statbattle  ,~f_s_statbat      ,~f_l_browse      ,g_grid_battle_stats
  ;;,g_grid_battle_movesel ,S_DEFAULT      ,~bot_4x4       ,~top_pkstat    ,~f_nop           ,~f_op_movesel     ,~f_s_batmove      ,~f_l_browse      ,~c_no
  ;;,g_grid_battle_switch  ,S_DEFAULT      ,~top_editteam  ,~bot_info      ,~f_dt_switch     ,~f_op_batswitch   ,~f_s_batswitch    ,~f_l_browse      ,~c_no
  ;;,g_grid_battle_stats   ,S_DEFAULT      ,~top_editteam  ,~bot_info      ,~f_dt_batstats   ,~f_op_batstats    ,~f_s_batstat      ,~f_l_browse      ,~c_no
  ;;,g_grid_battle_turnbeg ,S_DEFAULT      ,~bot_info      ,~top_battle2   ,~f_nop           ,~f_op_startturn   ,~f_s_startturn    ,~f_l_bataction   ,~c_no

  ;;,g_grid_battle_results ,S_DEFAULT      ,~top_editteam  ,~bot_info      ,~f_nop           ,~f_op_batresults  ,~f_s_batresults   ,~f_l_browse      ,~c_no
  ;;,g_grid_battle_actions ,S_DEFAULT      ,~bot_info      ,~top_battle2   ,~f_nop           ,~f_op_bataction   ,~f_s_bataction    ,~f_l_bataction   ,~c_no
]])

f_add_to_ui_stack(g_grid_title)
