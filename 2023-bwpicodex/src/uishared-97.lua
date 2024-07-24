-- TODO: as of 2024-07-20 There is a tiny lag when pressing left/right on browse screen. The bottom info box updates right before the top box. It's annoying and I must fix it!

-- TODO: experiment with making item num/name/lock in same obj -- 4042
|[f_create_spot]| function(_ENV, op, disabled)
  add(op, {text=lock and name or f_strtoq(name), disabled=disabled or not lock})
end $$

|[f_get_edit_op_pkmn]| function() return f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot') end $$

|[f_op_template_edit]| function(op, list, key)
  local pkmn = f_get_edit_op_pkmn()
  for obj in all(list) do
    f_create_spot(obj, op, pkmn[key] == obj.num)
  end
end $$

|[f_info_toggle]| function(op, toggle_grid, enemyname)
  local toggle = g_cg_m.name == toggle_grid
  f_print_info(op, [[
     ;,@,"playr ",@
    ;;,@,"enemy ",@
  ]], toggle and "\f3" or "\f1", c_team_names[f_getsel(toggle_grid)], toggle and "\f1" or "\f3", enemyname)
end $$

|[f_leagueinfo]| function(op)
  local name = c_trnr_names[f_getsel'g_grid_picktrnr'+1]
  f_info_toggle(op, 'g_grid_pickleag', (@S_STORY+1<f_getsel'g_grid_picktrnr'+1) and f_strtoq(name) or name)
end $$

|[f_add_stat_move]| function(op, pkmn, ind)
  ind=ind+1
  local move = pkmn[ind]
  local movenum = move.num
  local maxpp, pp, pow, accuracy, typ = f_get_move_texts(move)
  local method = pkmn.possible_moves_method[movenum] or "empty"
  add(op, {text="move"..ind.." "..move.name, disabled=true})
  add(op, {text=""..method.." "..typ})
  add(op, {text="   pp "..pp.."/"..maxpp})
  add(op, {text="pw/ac "..pow.."/"..accuracy})
end $$

|[f_add_stat_preview]| function(op, pkmn)
  local draw_preview = function(off)
    f_draw_pkmn(pkmn.num, 21, off-12, STYLE_SHAKE, false, true, false)
  end

  add(op, {text="#"..f_prefix_zero(pkmn.num, 3).." "..pkmn.name, disabled=true})
  add(op, { draw=function() draw_preview'17' end})
  add(op, { draw=function() draw_preview'8' end})
  add(op, { draw=function() draw_preview'-1' end})
end $$

|[f_add_stat]| function(op, pkmn, is_battle)
  f_add_stat_preview(op, pkmn)

  add(op, {text="peek "..pkmn.name, disabled=true})
  if is_battle then
    add(op, {text="major "..c_major_names_long[pkmn.major]})
  else
    add(op, {text="prevo "..c_pkmn_names[pkmn.prevolve]})
  end

  add(op, {text="   hp "..f_prefix_zero(pkmn.hp, 3).."/"..f_prefix_zero(pkmn.maxhp, 3)})
  add(op, {text=" item "..c_item_names[pkmn.item]})

  add(op, {text="info "..pkmn.name, disabled=true})
  add(op, {text="gendr "..c_gender_names[pkmn.gender]})
  add(op, {text="type1 "..c_type_names[pkmn.pktype1]})
  add(op, {text="type2 "..c_type_names[pkmn.pktype2]})

  add(op, {text="stat "..pkmn.name, disabled=true})
  add(op, {text="at/df "..f_prefix_zero(f_stat_calc(pkmn, 'attack'), 3).."/"..f_prefix_zero(f_stat_calc(pkmn, 'defense'), 3)})
  add(op, {text="sa/sd "..f_prefix_zero(f_stat_calc(pkmn, 'specialattack'), 3).."/"..f_prefix_zero(f_stat_calc(pkmn, 'specialdefense'), 3)})
  add(op, {text="sp/lv "..f_prefix_zero(f_stat_calc(pkmn, 'speed'), 3).."/050"})

  -- TODO: token saving, add a zcall here
  if is_battle then
    f_add_stat_move(op, pkmn, 0)
    f_add_stat_move(op, pkmn, 1)
    f_add_stat_move(op, pkmn, 2)
    f_add_stat_move(op, pkmn, 3)
  end

  -- TODO: idk. should i include battle flags or no?
  -- for i,x in ipairs(split"active,benchd,none,mvlock,bide,dfncrl,disabl,confus,rolout,dstbnd,lockon,dig,fly,fryctr,rage,toxic,persng,pdecnt,substu,ngtmar,trform,lechsd,curse,mist,trappd,meanlk,atract,forsgt,ftrsgt,safgrd,litscr,rflect,spikes,sndstr,raidnc,sunday") do
end $$

|[f_print_info]| function(op, ...)
  local params = {...}
  add(op, {draw=function()
    local infoobj = f_zobj(unpack(params))
    f_print_top(unpack(infoobj[1]))
    f_print_bot(unpack(infoobj[2]))
  end})
end $$

|[f_print_top]| function(...)
  local text = ""
  for x in all{...} do
    text ..= x
  end
  print("\f3"..text, 1, 1)
end $$

-- TODO: dedup with _top
|[f_print_bot]| function(...)
  local text = ""
  for x in all{...} do
    text ..= x
  end
  print("\f1"..text, 1, 8)
end $$

|[f_get_move_texts]| function(move)
  -- TODO: token crunching with zobj
  local maxpp, pp, pow, accuracy, typ = f_prefix_zero(move.maxpp, 2), f_prefix_zero(move.pp_obj.pp, 2), f_prefix_zero(move.pow, 3), f_prefix_zero(move.accuracy, 3), c_type_names[move.pktype]

  if     move.pow == 0 then pow = "___"
  elseif move.pow == 1 then pow = "var" end
  if move.accuracy == 0 then accuracy = "___" end

  -- TODO: I'd rather store an empty move to save a few tokens. Empty and struggle.
  if move.num == M_NONE then
    typ, maxpp, pp, pow, accuracy = "______", "__", "__", "___", "___"
  elseif not move.lock then
    maxpp, pp, pow, accuracy, typ = f_strtoq(maxpp), f_strtoq(pp), f_strtoq(pow), f_strtoq(accuracy), f_strtoq(typ)
  end
  return maxpp, pp, pow, accuracy, typ
end $$

|[f_prefix_space]| function(num, len)
  local numstr = tostr(num)
  while #numstr < len do numstr = " "..numstr end
  return numstr
end $$

-- TODO: DEDUP ABOVE
|[f_prefix_zero]| function(num, len)
  local numstr = tostr(num)
  while #numstr < len do numstr = "0"..numstr end
  return numstr
end $$

|[f_add_battle]| function(op)
  local b = function(player, x, y, px, py, flip)
    add(op, {draw=function()
      local invisible = player.active.invisible
      local team  = player.team
      local active = player.active

      -- TODO: shouldn't be 254. Should be the player's sprites. I can probably fit a few player sprites: plrboy, plrgirl, cpu, horde
      f_draw_pkmn(invisible and player.num or active.num, px, py, STYLE_SHAKE, flip,  p_action_self == player, false)
      if invisible then return end
      print(active.name, x+2, y-4, C_1, -1)
      local hp = active.hp
      local maxhp = active.maxhp
      local spot = active.spot
      local major = active.major

      --f_roundrect(x+1, y+1-6+1, x+34-1, y+6+6+1, C_2)
      if hp > 0 then
        rectfill(x+1, y+2, x+1+mid(0, hp/maxhp*32, 32), y+5, C_1)
        pset(x+1,  y+2, C_2)
        pset(x+1,  y+5, C_2)
        pset(x+33, y+2, C_2)
        pset(x+33, y+5, C_2)
      end

      local tx, ty = x+15, y+9
      for i=0,5 do
        if spot == i+1 or team[i+1].valid and team[i+1].major ~= C_MAJOR_FAINTED then
          pset(tx+i%3*2, ty+i\3*2-1, spot == i+1 and C_3 or C_1)
        end
      end

      local majtext = c_major_names_short[major]
      local hptext = f_prefix_zero(hp, 3)
      print(majtext.."  "..hptext, x+1+1, y+8-1, C_1, -1)
    end})
  end

  b(p_battle_top,  1, 5, 39, 1, true) -- top pl
  b(p_battle_bot, 22, 5,  3, 1)       -- bot pl
end $$
