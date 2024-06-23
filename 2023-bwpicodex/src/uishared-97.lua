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

|[f_add_stat_move]| function(op, pkmn, ind)
  ind=ind+1
  local move = pkmn[ind]
  local movenum = move.num
  local maxpp, pp, pow, accuracy, typ = f_get_move_texts(move)
  local method = pkmn.possible_moves_method[movenum]
  add(op, {text="mov"..ind..": "..move.name, header=true})
  add(op, {text=""..method..": "..typ})
  add(op, {text="pwpnt: "..pp.."/"..maxpp})
  add(op, {text="pw/ac: "..pow.."/"..accuracy})
end $$

|[f_add_stat_info]| function(op, pkmn)
  --add(op, {text="pokemon basics", header=true})
  add(op, {text="info: "..pkmn.name, header=true})
  add(op, {text="gendr: "..c_gender_names[pkmn.gender]})
  add(op, {text="type1: "..c_type_names[pkmn.pktype1]})
  add(op, {text="type2: "..c_type_names[pkmn.pktype2]})
end $$

|[f_add_stat]| function(op, pkmn, is_battle)
  local draw_preview = function(off)
    f_draw_pkmn(pkmn.num, 21, off-12, 16, false, false, false, false, true)
  end

  add(op, {text="#"..f_prefix_zero(pkmn.num, 3)..": "..pkmn.name, header=true})
  add(op, { draw=function() draw_preview'17' end})
  add(op, { draw=function() draw_preview'8' end})
  add(op, { draw=function() draw_preview'-1' end})

  -- add(op, {text="pokemon evol", header=true})
  -- add(op, {text="name: "..pkmn.name})
  -- add(op, {text="prev: "..c_pkmn_names[pkmn.prevolve]})
  -- add(op, {text="next: "..c_pkmn_names[pkmn.prevolve]})

  f_add_stat_info(op, pkmn)

  add(op, {text="stat: "..pkmn.name, header=true})
  add(op, {text="at/df: 123/096"})
  add(op, {text="sa/sd: 311/916"})
  add(op, {text="sp/lv: 223/050"})

  --if is_battle then
    add(op, {text="batl: "..pkmn.name, header=true})
    add(op, {text="htpnt: 123/321"})
    add(op, {text="condi: "..c_major_names_long[pkmn.major]})
    add(op, {text="holdi: "..c_item_names[pkmn.item]})
  --end

  --add(op, {text="pkmn stats", header=true})
  -- add(op, {text="htpnt " .. pkmn.hp .. "/" .. pkmn.maxhp})
  -- add(op, {text="htpnt " .. pkmn.maxhp})

  -- for key in all(f_zobj[[,attack,defense,specialattack,specialdefense,speed]]) do
  --   local txt = c_statmod_names[key].." "..f_prefix_zero(pkmn[key], 3)
  --   -- local stage = pkmn.stages[key]
  --   -- txt ..= (stage < 0 and "-" or "+")..abs(stage)
  --   add(op, {text=txt})
  -- end

  -- for key in all(f_zobj[[,crit,evasion,accuracy]]) do
  --   local stage = pkmn.stages[key]
  --   add(op, {text=c_statmod_names[key].." "..stage.."%"})
  -- end

  -- add(op, {text="ev/ac 100/100"})

  if is_battle then
    f_add_stat_move(op, pkmn, 0)
    f_add_stat_move(op, pkmn, 1)
    f_add_stat_move(op, pkmn, 2)
    f_add_stat_move(op, pkmn, 3)

    -- add(op, {text=f_prefix_space(c_move_names[pkmn[1].num], 6)..": 20/20"})
    -- add(op, {text=f_prefix_space(c_move_names[pkmn[2].num], 6)..": 20/20"})
    -- add(op, {text=f_prefix_space(c_move_names[pkmn[3].num], 6)..": 20/20"})
    -- add(op, {text=f_prefix_space(c_move_names[pkmn[4].num], 6)..": 20/20"})
  end

  -- TODO: idk. should i include battle flags or no?
  -- for i,x in ipairs(split"active,benchd,none,mvlock,bide,dfncrl,disabl,confus,rolout,dstbnd,lockon,dig,fly,fryctr,rage,toxic,persng,pdecnt,substu,ngtmar,trform,lechsd,curse,mist,trappd,meanlk,atract,forsgt,ftrsgt,safgrd,litscr,rflect,spikes,sndstr,raidnc,sunday") do
end $$

|[f_print_top]| function(...)
  local text = ""
  for x in all{...} do
    text ..= x
  end
  print("\f4"..text, 1, 1)
end $$

-- TODO: dedup with _top
|[f_print_bot]| function(...)
  local text = ""
  for x in all{...} do
    text ..= x
  end
  print("\f2"..text, 1, 8)
end $$

|[f_get_move_texts]| function(move)
  -- TODO: token crunching with zobj
  local maxpp, pp, pow, accuracy, typ = f_prefix_zero(move.maxpp, 2), f_prefix_zero(move.pp, 2), f_prefix_zero(move.pow, 3), f_prefix_zero(move.accuracy, 3), c_type_names[move.pktype]

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

|[f_dt_browse_template]| function(pkmn_ind)
  local pkmn = c_pokemon[pkmn_ind]
  local namestr = pkmn.name

  if not pkmn.lock then
    namestr = f_strtoq(namestr)
  end

  f_print_top("view ", namestr)
  f_print_bot("picodex #", f_prefix_zero(pkmn.num, 3))
end $$

|[f_add_battle]| function(op)
  local b = function(_ENV, team, x, y, px, py, flip)
    local is_notactive = p_self.active ~= _ENV
    if invisible then return end
    --f_roundrect(x+1, y+1-6+1, x+34-1, y+6+6+1, C_3)
    if hp > 0 then
      rectfill(x+1, y+2, x+1+mid(0, hp/maxhp*32, 32), y+5, C_2)
      pset(x+1,  y+2, C_3)
      pset(x+1,  y+5, C_3)
      pset(x+33, y+2, C_3)
      pset(x+33, y+5, C_3)
    end

    local tx, ty = x+15, y+9
    for i=0,5 do
      if spot == i+1 or team[i+1].valid and team[i+1].major ~= C_MAJOR_FAINTED then
        pset(tx+i%3*2, ty+i\3*2-1+1-1-1+1, spot == i+1 and C_4 or C_2 )
      end

      if i ~= 1 then
      end
    end

    print(name,   x+2,   y-5+1+1+1-2, C_2, -1)
    print(c_major_names_short[major].."  "..f_prefix_zero(hp, 3), x+1+1, y+8-1+1-1-1+1,   C_2, -1)
    f_draw_pkmn(num, px, py,  16, flip,  false, false, is_notactive, true)
  end

  add(op, {draw=function()
    b(p_2.active, p_2.team,  -1+1,   4-1+2,       39-4+2+1,  1, true) -- top pl
    b(p_1.active, p_1.team, 23+1-1, 4+20+2+1-1-1,  3+4-2-1, 1-4+20+1+1+1) -- bot pl
  end})
end $$

