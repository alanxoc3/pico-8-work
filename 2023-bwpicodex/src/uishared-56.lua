-- TODO: as of 2024-07-20 There is a tiny lag when pressing left/right on browse screen. The bottom info box updates right before the top box. It's annoying and I must fix it!

-- TODO: experiment with making item num/name/lock in same obj -- 4042
|[f_create_spot]| function(_ENV, op, disabled)
  add(op, {text=lock and name or f_strtoq(name), disabled=disabled or not lock})
end $$

|[f_get_edit_op_pkmn]| function()
  return f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
end $$

|[f_info_toggle]| function(op, toggle_grid, enemyname)
  f_print_info(op, [[
     ;,@,"playr ",@
    ;;,@,"enemy ",@
  ]], g_top_grid == toggle_grid and "\f3" or "\f1", c_team_names[f_getsel(toggle_grid.g_cg_m.name)], g_top_grid == toggle_grid and "\f1" or "\f3", enemyname)
end $$

|[f_leagueinfo]| function(op)
  local name = c_trnr_names[f_getsel'g_grid_picktrnr'+1]
  f_info_toggle(op, g_grid_pickleag, @S_STORY+1<f_getsel'g_grid_picktrnr'+1 and f_strtoq(name) or name)
end $$

|[f_add_stat_move]| function(op, pkmn, move)
  local _ENV = type(move) == "table" and move or pkmn[move+1]
  local maxpp, pp, pow, accuracy, typ = f_get_move_texts(_ENV)
  local method = pkmn.possible_moves_method[num] or "empty"

  f_zcall([[
    op,@
    ;;,~f_addop_text,~op,~c_yes,"move",@," ",@
    ;;,~f_addop_text,~op,~c_no ,@," ",@
    ;;,~f_addop_text,~op,~c_no ,"   pp ",@,"/",@
    ;;,~f_addop_text,~op,~c_no ,"pw/ac ",@,"/",@
  ]],op
    ,slot   ,name
    ,method ,typ
    ,pp     ,maxpp
    ,pow    ,accuracy
  )
end $$

|[f_add_stat_preview]| function(op, pkmn, player)
  local draw_preview = function(off)
    return function()
      f_draw_pkmn(pkmn.num, 21, off-12, STYLE_SHAKE, p_battle_top and player == p_battle_top, true, false)
    end
  end

  f_zcall([[
    op,@
    ;;,~f_addop_text,~op,~c_yes,@,@," ",@
    ;;,~f_addop_draw,~op,@
    ;;,~f_addop_draw,~op,@
    ;;,~f_addop_draw,~op,@
  ]],op
    -- TODO: if i remove the special # empty table logic from ztable, this can save 1 token
    ,"#" ,f_prefix_zero(pkmn.num, 3) ,pkmn.name
    ,draw_preview'17'
    ,draw_preview'8'
    ,draw_preview'-1'
  )
end $$

|[f_add_stat]| function(op, pkmn, player)
  f_add_stat_preview(op, pkmn, player)

  f_zcall([[
    op,@
    ;;,~f_addop_text,~op,~c_yes,"peek ",@
    ;;,~f_addop_text,~op,~c_no ,@
    ;;,~f_addop_text,~op,~c_no ,"   hp ",@,"/",@
    ;;,~f_addop_text,~op,~c_no ," item ",@
    ;;,~f_addop_text,~op,~c_yes,"info ",@
    ;;,~f_addop_text,~op,~c_no ,"gendr ",@
    ;;,~f_addop_text,~op,~c_no ,"type1 ",@
    ;;,~f_addop_text,~op,~c_no ,"type2 ",@
    ;;,~f_addop_text,~op,~c_yes,"stat ",@
    ;;,~f_addop_text,~op,~c_no ,"at/df ",@,"/",@
    ;;,~f_addop_text,~op,~c_no ,"sa/sd ",@,"/",@
    ;;,~f_addop_text,~op,~c_no ,"sp/lv ",@,"/050"
  ]],op
    ,pkmn.name
    ,"major "..c_major_names_long[pkmn.major] or "prevo "..c_pkmn_names[pkmn.prevolve]
    ,f_prefix_zero(pkmn.hp, 3) ,f_prefix_zero(pkmn.maxhp, 3) -- hp

    ,c_item_names[pkmn.item]     -- item
    ,pkmn.name                   -- info
    ,c_gender_names[pkmn.gender] -- gendr
    ,c_type_names[pkmn.pktype1]  -- type1
    ,c_type_names[pkmn.pktype2]  -- type2
    ,pkmn.name                   -- stat

    ,f_prefix_zero(f_stat_calc(pkmn, 'attack'), 3)        ,f_prefix_zero(f_stat_calc(pkmn, 'defense'), 3)
    ,f_prefix_zero(f_stat_calc(pkmn, 'specialattack'), 3) ,f_prefix_zero(f_stat_calc(pkmn, 'specialdefense'), 3)
    ,f_prefix_zero(f_stat_calc(pkmn, 'speed'), 3)
  )

  if player then -- if the player was passed in, then we are in a battle and should show moves
    f_zcall([[
      op,@, pkmn,@
      ;;,~f_add_stat_move,~op,~pkmn,0
      ;;,~f_add_stat_move,~op,~pkmn,1
      ;;,~f_add_stat_move,~op,~pkmn,2
      ;;,~f_add_stat_move,~op,~pkmn,3
    ]], op, pkmn)
  end

  -- TODO: idk. should i include battle flags or no?
  -- for i,x in ipairs(split"active,benchd,none,mvlock,bide,dfncrl,disabl,confus,rolout,dstbnd,lockon,dig,fly,fryctr,rage,toxic,persng,pdecnt,substu,ngtmar,trform,lechsd,curse,mist,trappd,meanlk,atract,forsgt,ftrsgt,safgrd,litscr,rflect,spikes,sndstr,raidnc,sunday") do
end $$

|[f_print_info]| function(op, ...)
  local params = {...}
  f_addop_draw(op, function()
    local infoobj = f_zobj(unpack(params))
    print(f_join(unpack(infoobj[1])), 1, 1, C_3)
    print(f_join(unpack(infoobj[2])), 1, 8, C_1)
  end)
end $$

|[f_addop_draw]| function(op, draw, disabled)
  add(op, {draw=draw, disabled=disabled}) -- todo use zobj?
end $$

|[f_addop_text]| function(op, disabled, ...)
  add(op, {text=f_join(...), disabled=disabled})
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
  local b = function(_ENV, px, py, flip)
    add(op, {draw=function()
      -- TODO: shouldn't be 254. Should be the player's sprites. I can probably fit a few player sprites: plrboy, plrgirl, cpu, horde
      f_draw_pkmn(active.invisible and num or active.num, px, py, STYLE_SHAKE, flip, p_action_self == _ENV, false, active.invisible and f_nop or function()
        print(active.name, 1, 0, C_1, -1)

        if active.hp > 0 then
          f_zcall([[
             ;,~rectfill,0,6,@,9,C_1
            ;;,~pset,0,6,C_2
            ;;,~pset,0,9,C_2
            ;;,~pset,32,6,C_2
            ;;,~pset,32,9,C_2
          ]], mid(0, active.hp/active.maxhp*32, 32))
        end

        local tx, ty = 14, 13
        for i=0,5 do
          if active.spot == i+1 or team[i+1].valid and team[i+1].major ~= C_MAJOR_FAINTED then
            pset(tx+i%3*2, ty+i\3*2-1, active.spot == i+1 and C_3 or C_1)
          end
        end

        print(c_major_names_short[active.major].."  "..f_prefix_zero(active.hp, 3), 1, 11, C_1, -1)
      end, active.digging or active.flying)
    end})
  end

  f_zcall([[
    b,@
    ;;,~b,~p_battle_top,39,1,~c_yes
    ;;,~b,~p_battle_bot,3,1
  ]], b)
end $$
