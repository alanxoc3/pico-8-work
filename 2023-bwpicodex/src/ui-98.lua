-- in picodex, the screen is always divided into 2 sections, the "preview" grid and the "text" grid.
-- p_ = preview, t_ = text. The "preview" grid is the area at the top of the screen. The "text" grid is the area at the bottom of the screen.

-- current: 4707 | 28810 | 10642
-----------------------------
-- OP FUNCTIONS - DATA FOR UI
-----------------------------

-- This updates the lock variables, which determine if a pokemon/item/move is unlocked.
|[f_op_def]| function(_ENV) add(op, {}) end $$

|[f_op_browse]| function(_ENV)
  for i=0,251 do
    local disabled = not c_pokemon[i].lock
    add(op, {lrvalid=not disabled, disabled=disabled, draw=function(_, is_sel, gridobj)
      f_draw_pkmn(c_pokemon[i].lock and i or P_NONE, 1, 1, 6, false, false, gridobj.disabled, not is_sel)
    end})
  end
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
  foreach(split"bROWSE,eDIT,lEAGUE,vERSUS", function(text)
    f_addop_text(op, text)
  end)
end $$

|[f_op_teams]| function(_ENV)
  for i=1, 58 do
    local disabled = @S_STORY+1<i
    add(op, {text=disabled and f_strtoq(c_trnr_names[i]) or c_trnr_names[i], disabled=disabled})
  end
end $$

|[f_op_editstat]| function(_ENV)
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')

  for i=1,4 do
    add(op, {text=c_move_names[pkmn[i].id], select=function()
      f_setsel('g_grid_editmove', pkmn[i].pid-1)
      f_add_to_ui_stack(g_grid_editmove)
    end})
  end

  add(op, {text=c_item_names[pkmn.item], select=function()
    f_setsel('g_grid_edititem', pkmn.item)
    f_add_to_ui_stack(g_grid_edititem)
  end})

  add(op, {text=c_gender_names[pkmn.gender], disabled=#pkmn.genders < 2, select=function()
    pkmn.gender_bit += 1
    pkmn:f_save_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
    f_refresh_top()
  end})

  add(op, {text="vIEW", select=function()
    f_add_to_ui_stack(g_grid_statedit)
  end})

  add(op, {text="dELETE", select=function()
    memset(S_PARTY1+f_getsel'g_grid_pickedit'*42+f_getsel'g_grid_pickspot'*7, P_NONE, 7)
    f_pop_ui_stack()
  end})
end $$

-- TODO: experiment with making item num/name/lock in same obj -- 4042
|[f_create_spot]| function(_ENV, op, disabled)
  add(op, {text=lock and name or f_strtoq(name), disabled=disabled or not lock})
end $$

|[f_get_edit_op_pkmn]| function() return f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot') end $$
|[f_op_editmove]| function(_ENV)
  local pkmn = f_get_edit_op_pkmn()
  for i, num in ipairs(pkmn.possible_moves) do
    f_create_spot(c_moves[num], op, pkmn.seen_moves[i])
  end
end $$

|[f_op_template_edit]| function(op, list, key)
  local pkmn = f_get_edit_op_pkmn()
  for obj in all(list) do
    f_create_spot(obj, op, pkmn[key] == obj.num)
  end
end $$

|[f_op_edititem]| function(_ENV) f_op_template_edit(op, c_items, 'item')  end $$

|[f_add_stat_move]| function(op, pkmn, ind)
  local m = pkmn[ind]
  local pp, pow, acc, typ = f_get_move_texts(c_moves[m.id])
  add(op, {text="mOVE"..ind..": "..c_move_names[m.id], header=true})
  add(op, {text="tYPE:  "..typ})
  add(op, {text="pWpNT: "..pp.."/"..pp})
  add(op, {text="pW/aC: "..pow.."/"..acc})
end $$

-- 0 = browse, 1 = edit, 2 = benched, 3 = active
|[f_add_stat]| function(op, pkmn, mode)
  local genders = ""
  if #pkmn.genders == 1 then -- TODO: gender logic can be simplified by adding another gender "m/f" in gender names
    genders = c_gender_names[pkmn.genders[1]].."/"
  else
    for g in all(pkmn.genders) do
      genders ..= sub(c_gender_names[g], 1, 2).."/"
    end
  end
  genders = sub(genders, 1, #genders-1)

  local draw_preview = function(off)
    f_draw_pkmn(pkmn.num, 2-8-20+30, -8+1-10-1-1+6+3-3-off, 16)
    rectfill(-9+4+30, -18-off-1, -9+4+30, 6-off+1, C_2)
  end

  add(op,  {text="#"..f_prefix_zero(pkmn.num, 3).." "..pkmn.name, header=true})
  add(op,  {text="       tYPE:", draw=function() draw_preview(-18) end})
  add(op,  {text="        "..c_type_names[pkmn.type1+1], draw=function() draw_preview(-9) end})
  local t2text = "        "
  if pkmn.type2 ~= T_BIRD then
    t2text ..= c_type_names[pkmn.type2+1]
  end


  add(op, {text=t2text, draw=function() draw_preview(0) end})

  add(op, {text="pOKEMON sTATS", header=true})

  if mode >= MODE_BENCH then -- todo: convert to > (gt), saves a character
    add(op, {text="mAJOR: nONE"})
  end

  if mode >= MODE_EDIT then -- todo: convert to > (gt), saves a character
    add(op, {text="iTEM:  nONE"})
  end

  add(op, {text="gEND: "..genders})
  add(op, {text="pREV: "..c_pkmn_names[pkmn.prevolve]})
  add(op, {text="hP:   " .. pkmn.hp .. "/" .. pkmn.hp})

  for stat in all(f_zobj[[
     ;name,aTCK, key,attack
    ;;name,dEFN, key,defense
    ;;name,sPaT, key,specialattack
    ;;name,sPdF, key,specialdefense
    ;;name,sPED, key,speed
  ]]) do
    local text = stat.name..": "..f_prefix_zero(pkmn[stat.key], 3).." + 1"
    if pkmn.stages then
      text ..= " "..(pkmn.stages[stat.key] > 0 and "+"..pkmn.stages[stat.key] or (pkmn.stages[stat.key] < 0 and "-"..pkmn.stages[stat.key]) or "")
    end
    add(op, {text=text})
  end

  if mode >= MODE_ACTIVE then -- todo: convert to > (gt), saves a character
    add(op, {text="eVASN: " .. f_prefix_zero(pkmn.evasion*100\1,  3) .. "%"})
    add(op, {text="aCURY: " .. f_prefix_zero(pkmn.accuracy*100\1, 3) .. "%"})
    add(op, {text="cRITL: " .. f_prefix_zero(pkmn.crit/16*100\1,  3) .. "%"})
  end

  if mode >= MODE_EDIT then
    f_add_stat_move(op, pkmn, 1)
    f_add_stat_move(op, pkmn, 2)
    f_add_stat_move(op, pkmn, 3)
    f_add_stat_move(op, pkmn, 4)
  end

  if mode >= MODE_ACTIVE then
    add(op, {text="bATTLE fLAGS", header=true})

    local prev = ""
    for i,x in ipairs(split"aCTIVE,bENCHD,nONE,mVlOCK,bIDE,dFNcRL,dISABL,cONFUS,rOLOUT,dSTbND,lOCKoN,dIG,fLY,fRYcTR,rAGE,tOXIC,pERsNG,pDEcNT,sUBSTU,nGTMAR,tRFORM,lECHsD,cURSE,mIST,tRAPPD,mEANlK,aTRACT,fORsGT,fTRsGT,sAFgRD,lITsCR,rFLECT,sPIKES,sNDsTR,rAIdNC,sUNdAY") do
      if i%2 == 1 do
        prev = x
        while #prev < 6 do
          prev = prev.." "
        end
      else
        add(op, {text=prev.." "..x})
        prev=""
      end
    end

    if prev ~= "" then
      add(op, {text=prev})
    end
  end
end $$

|[f_op_statbrowse]| function(_ENV) f_add_stat(op, c_pokemon[f_getsel'g_grid_browse'], MODE_BROWSE) end $$
|[f_op_statedit]|   function(_ENV) f_add_stat(op, f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot'),  MODE_EDIT)   end $$

---------------------------------------------
-- dp and dt drawing for ui
---------------------------------------------
|[f_dt_editteam]| function(i, is_sel)
  f_print_top("tEAM",f_getsel'g_grid_pickedit'+1,": sPOT",f_getsel'g_grid_pickspot'+1)
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  f_print_bot("#", pkmn.num_str, " ", pkmn.name)
end $$

|[f_dt_editstat]| function(i, is_sel)
  local prefix = "sPOT"..f_getsel'g_grid_pickspot'+1
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  if f_getsel'g_grid_editstat' < 4 then f_print_top(prefix, ": mOVE", f_getsel'g_grid_editstat'+1)
  elseif f_getsel'g_grid_editstat' == 4 then f_print_top(prefix, ": iTEM")
  elseif f_getsel'g_grid_editstat' == 5 then f_print_top(prefix, ": gENDER")
  elseif f_getsel'g_grid_editstat' == 6 then f_print_top(prefix, ": vIEW")
  elseif f_getsel'g_grid_editstat' == 7 then f_print_top(prefix, ": dELETE")
  end

  -- f_print_top("eDIT: sPOT ", f_getsel'g_grid_pickspot'+1)
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  f_print_bot("#", pkmn.num_str, " ", pkmn.name)
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
  local pp, pow, acc, typ = f_prefix_zero(move.pp, 2), f_prefix_zero(move.pow, 3), f_prefix_zero(move.acc, 3), c_type_names[move.type+1]

  if     move.pow == 0 then pow = "___"
  elseif move.pow == 1 then pow = "var" end
  if move.acc == 0 then acc = "___" end

  -- TODO: I'd rather store an empty move to save a few tokens. Empty and struggle.
  if move.num == M_NONE then
    typ, pp, pow, acc = "______", "__", "___", "___"
  elseif not move.lock then
    pp, pow, acc, typ = f_strtoq(pp), f_strtoq(pow), f_strtoq(acc), f_strtoq(typ)
  end
  return pp, pow, acc, typ
end $$

-- TODO: is this better being inside an "op" function?
|[f_dt_editmove_template]| function(move, method)
  local pp, pow, acc, typ = f_get_move_texts(move)
  f_print_top(method, ": ", typ)
  f_print_bot(pp, "PP ", pow, "P ", acc, "A")
end $$

|[f_dt_editmove]| function()
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  local movenum = pkmn.possible_moves[f_getsel'g_grid_editmove'+1]
  local move = c_moves[movenum]
  f_dt_editmove_template(move, pkmn.possible_moves_method[movenum])
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
  local namestr, type1, type2 = pkmn.name, c_type_names[pkmn.type1+1], ""

  if pkmn.type2 > T_NONE then
    type2 = c_type_names[pkmn.type2+1]
  end

  if not pkmn.lock then
    namestr, type1, type2 = f_strtoq(namestr), f_strtoq(type1), f_strtoq(type2)
  end

  f_print_top("#", f_prefix_zero(pkmn.num, 3), " ", namestr)
  f_print_bot(type1, " ", type2)
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

  f_print_top("tEAM",f_getsel'g_grid_pickedit'+1,": sPOT",f_getsel'g_grid_pickspot'+1)
  f_print_bot("#", f_prefix_zero(pkmn.num, 3), " ", namestr)
end $$

|[f_dt_edit]| function()
  local pkstr_arr = {}
  local pkstr_lens = split'2,2,2,2,1,1'
  for ii=0,5 do
    local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', ii)
    add(pkstr_arr, sub(c_pkmn_names[pkmn.num], 1, pkstr_lens[ii+1]))
  end

  f_print_top("eDIT: tEAM", f_getsel'g_grid_pickedit'+1) -- TODO: fixme
  f_print_bot(pkstr_arr[1], "-", pkstr_arr[2], "-", pkstr_arr[3], "-", pkstr_arr[4], "-", pkstr_arr[5], pkstr_arr[6])
end $$

|[f_dt_league]| function()
  -- TODO: save tokens / compression by extracting out this if.
  local toggle = g_cg_m.name == 'g_grid_pickleag'
  local disabled = @S_STORY+1<f_getsel'g_grid_picktrnr'+1
  local name = c_trnr_names[f_getsel'g_grid_picktrnr'+1]
  name = disabled and f_strtoq(name) or name

  f_print_top(toggle and "\f4" or "\f2", "pLR: tEAM", f_getsel'g_grid_pickedit'+1)
  f_print_bot(toggle and "\f2" or "\f4", "cPU: ", name)
end $$

|[f_dt_versus]| function()
  local toggle = g_cg_m.name == 'g_grid_pickplr1'

  f_print_top(toggle and "\f4" or "\f2", "pLR1: tEAM", f_getsel'g_grid_pickedit'+1)
  f_print_bot(toggle and "\f2" or "\f4", "pLR2: tEAM", f_getsel'g_grid_pickplr2'+1)
end $$

|[f_dp_title]| function()
  print("\^w\^tpicodex", 2, 1,  C_4)
  print(c_palette_names[g_palette].." vERSION",  2, 12, C_2)
  f_draw_pkmn(g_title_l, 7 , 20, 16, false, false, false, g_title_sel)
  f_draw_pkmn(g_title_r, 35, 20, 16, true , false, false, not g_title_sel)
end $$

function roundrect_r(x1, y1, x2, y2, c)
  rectfill(x1, y1+1, x2, y2-1, c)
  if x2-x1 > 2 then -- if check is for the hp bar, so it looks good when small.
    rectfill(x1+1, y1, x2-1, y2, c)
  end
end

|[f_op_batsel]| function(_ENV)
  add(op, {text="fIGHT", select=function()
    f_add_to_ui_stack(g_grid_battle_movesel)
  end})

  add(op, {text="sTATS", select=function()
    f_add_to_ui_stack(g_grid_battle_stats)
  end})

  add(op, {text="sWITCH", select=function()
    f_add_to_ui_stack(g_grid_battle_switch)
  end})

  add(op, {text="gIVEuP", select=function()
    f_pop_ui_stack() f_pop_ui_stack() f_pop_ui_stack()
    f_add_to_ui_stack(g_grid_battle_results)
  end})

  local b = function(_ENV, team, x, y, px, py, flip)
    roundrect_r(x-1+1, y+1-6+1, x+35-1, y+6+6+1, C_3)
    if hp > 0 then
      rectfill(x+1, y+3, x+1+mid(0, hp/hp*32, 32), y+6, C_2)
      pset(x+1, y+3, C_3)
      pset(x+1, y+6, C_3)
      pset(x+33, y+3, C_3)
      pset(x+33, y+6, C_3)
    end

    local tx, ty = x+15, y+9
    for i=0,5 do
      if team[i+1].valid and team[i+1].major ~= C_MAJOR_FAINTED then
        pset(tx+i%3*2, ty+i\3*2-1+1, spot == i+1 and C_4 or C_2 )
      end

      if i ~= 1 then
      end
    end

    print(name,   x+2,   y-5+1+1, C_2, -1)
    print("fZN".."  "..f_prefix_zero(hp, 3), x+1+1, y+8-1+1,   C_2, -1)
    f_draw_pkmn(num, px, py,  16, flip,  false, false, p0.active ~= _ENV)
  end

  add(preview_op, {draw=function() b(p2.active, p2.team,  0, 4, 39, 1, true)  end})
  add(preview_op, {draw=function() b(p1.active, p1.team, 23, 4,  3, 1)        end})
end $$

|[f_op_movesel]| function(_ENV)
  for i=1,4 do
    add(op, {text=c_move_names[p0.active[i].id]})
  end

  f_add_stat_move(preview_op, p0.active, f_getsel'g_grid_battle_movesel'+1)
end $$

|[f_op_batswitch]| function(_ENV)
  for i=1,6 do
    local pkmn = p0.team[i]
    local disabled = not pkmn.valid or i==p0.active.spot or pkmn.major == C_MAJOR_FAINTED
    add(op, {disabled=disabled, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, 16, p0 == p2, false, disabled, not disabled and not is_sel)
    end})
  end
end $$

|[f_s_batresults]| function()
  g_preview_timer = 20
  local otherteam = p1 == p0 and p2 or p1
  return otherteam.team[f_getsel'g_grid_battle_results'+1].num
end $$

|[f_op_batresults]| function(_ENV)
  local otherteam = p1 == p0 and p2 or p1
  for i=1,6 do
    local pkmn = otherteam.team[i]
    local disabled = not pkmn.valid or pkmn.major == C_MAJOR_FAINTED
    add(op, {disabled=disabled, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, 16, otherteam == p2, false, disabled, not disabled and not is_sel)
    end})
  end

  add(preview_op, {draw=function()
    f_print_top"cHAMP: yOUNGS"
    f_print_bot"lOSER: tEAM1"
  end})
end $$

|[f_op_batstats]| function(_ENV)
  for i=1,6 do
    local pkmn = p0.team[i]
    local disabled = not pkmn.valid
    add(op, {lrvalid=not disabled, disabled=disabled, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, 16, false, false, disabled, not disabled and not is_sel)
    end})
  end

  local otherteam = p1 == p0 and p2 or p1
  for i=1,6 do
    local pkmn = otherteam.team[i]
    local disabled = not pkmn.valid
    add(op, {lrvalid=not disabled, disabled=disabled, draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, 16, false, false, disabled, not disabled and not is_sel)
    end})
  end
end $$

-- do i want a stats menu? or do i want level + auto?
-- well, what is important that you can see in stat menu?
-- item, move info, major, 

----------------------------------------------------
-- sels and leaves - forward and back through stack
----------------------------------------------------
|[f_l_browse]| function()
  f_pop_ui_stack()
end $$

|[f_s_browse]| function()
  f_add_to_ui_stack(g_grid_statbrowse)
end $$

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

|[f_s_versus]| function()
  f_add_to_ui_stack(g_grid_pickplr2)
end $$

|[f_s_league]| function()
  f_add_to_ui_stack(g_grid_picktrnr)
end $$

|[f_op_statbattle]| function(_ENV)
  local otherpl = p1 == p0 and p2 or p1
  local bothteams = {}
  for i=1,6 do add(bothteams, p0.team[i]) end
  for i=1,6 do add(bothteams, otherpl.team[i]) end

  f_add_stat(op, bothteams[f_getsel'g_grid_battle_stats'+1], MODE_EDIT)
end $$

|[f_s_batstat]| function()
  f_add_to_ui_stack(g_grid_statbattle)
end $$

|[f_s_statbat]| function()
  g_preview_timer = 20
  local otherpl = p1 == p0 and p2 or p1
  local bothteams = {}
  for i=1,6 do add(bothteams, p0.team[i]) end
  for i=1,6 do add(bothteams, otherpl.team[i]) end
  return bothteams[f_getsel'g_grid_battle_stats'+1].num
end $$

|[f_s_batbegin]| function()
  f_start_battle(f_team_party(f_getsel'g_grid_pickleag'), f_team_league(f_getsel'g_grid_picktrnr'+1))
  f_add_to_ui_stack(g_grid_battle_select)
end $$

|[f_s_edit]| function()
  f_add_to_ui_stack(g_grid_pickspot)
end $$

|[f_s_editteam]| function()
  f_add_to_ui_stack(f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot').valid and g_grid_editstat or g_grid_editpkmn)
end $$

|[f_s_editpkmn]| function()
  f_save_party_pkmn(f_mkpkmn(f_getsel'g_grid_editpkmn', true, rnd(2)\1, 0, 5, 6, 7, 8), f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  f_pop_ui_stack()
end $$

|[f_s_editstat]| function() gridpo[f_getsel'g_grid_editstat'+1].select() end $$
|[f_s_battle]|   function()
  gridpo[f_getsel'g_grid_battle_select'+1].select()
end $$

|[f_s_editmove]| function()
  local pkmn = f_get_party_pkmn(f_getsel'g_grid_pickedit', f_getsel'g_grid_pickspot')
  pkmn[f_getsel'g_grid_editstat'+1].pid = f_getsel'g_grid_editmove'+1
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

|[f_l_battle]| function() return p0.active.num end $$

---------------------------------------------
-- connections
---------------------------------------------

-- This needs to be called early on because there is a draw
f_zcall(f_create_gridpair, [[
   top_browse    ;,6 ,4 ,2 ,2  ,10 ,10
  ;top_edit      ;,2 ,2 ,2 ,2  ,30 ,20
  ;top_editteam  ;,3 ,2 ,2 ,2  ,20 ,20
  ;top_pkstat    ;,1 ,4 ,2 ,4  ,60 ,9
  ;top_text_grid ;,2 ,4 ,2 ,4  ,30 ,9
  ;top_title     ;,1 ,1 ,2 ,2  ,60 ,40
  ;top_battle    ;,1 ,1 ,2 ,2  ,60 ,40
  ;top_battle2   ;,1 ,2 ,2 ,2  ,60 ,20
  ;bot_4x4       ;,2 ,2 ,2 ,44 ,30 ,9
  ;bot_info      ;,1 ,1 ,2 ,45 ,60 ,16

  -- name                  maingridspec     infogridspec    infogriddraw    main opfunc        select func      leave func      lrfunc        opfunc params
  ;;,g_grid_title          ,~bot_4x4        ,~top_title     ,~f_dp_title    ,~f_op_title       ,~f_s_title      ,~f_l_title     ,~c_no

  ;;,g_grid_browse         ,~top_browse     ,~bot_info      ,~f_dt_browse   ,~f_op_browse      ,~f_s_browse     ,~f_l_browse    ,~c_no
  ;;,g_grid_editpkmn       ,~top_browse     ,~bot_info      ,~f_dt_editpkmn ,~f_op_browse      ,~f_s_editpkmn   ,~f_l_browse    ,~c_no

  ;;,g_grid_statbrowse     ,~top_pkstat     ,~bot_info      ,~f_dt_browse   ,~f_op_statbrowse  ,~f_s_pkstat     ,~f_l_browse    ,g_grid_browse
  ;;,g_grid_statedit       ,~top_pkstat     ,~bot_info      ,~f_dt_editstat ,~f_op_statedit    ,~f_s_statedit   ,~f_l_browse    ,g_grid_pickspot
  ;;,g_grid_statbattle     ,~top_pkstat     ,~bot_info      ,~f_dt_browse   ,~f_op_statbattle  ,~f_s_statbat    ,~f_l_browse    ,g_grid_battle_stats

  ;;,g_grid_editstat       ,~top_text_grid  ,~bot_info      ,~f_dt_editstat ,~f_op_editstat    ,~f_s_editstat   ,~f_l_browse    ,~c_no
  ;;,g_grid_editmove       ,~top_text_grid  ,~bot_info      ,~f_dt_editmove ,~f_op_editmove    ,~f_s_editmove   ,~f_l_browse    ,~c_no
  ;;,g_grid_edititem       ,~top_text_grid  ,~bot_info      ,~f_dt_editstat ,~f_op_edititem    ,~f_s_edititem   ,~f_l_browse    ,~c_no

  ;;,g_grid_pickedit       ,~top_edit       ,~bot_info      ,~f_dt_edit     ,~f_op_edit        ,~f_s_edit       ,~f_l_browse    ,~c_no
  ;;,g_grid_pickleag       ,~top_edit       ,~bot_info      ,~f_dt_league   ,~f_op_edit        ,~f_s_league     ,~f_l_browse    ,~c_no        ,~c_yes
  ;;,g_grid_pickplr1       ,~top_edit       ,~bot_info      ,~f_dt_versus   ,~f_op_edit        ,~f_s_versus     ,~f_l_browse    ,~c_no        ,~c_yes
  ;;,g_grid_pickplr2       ,~top_edit       ,~bot_info      ,~f_dt_versus   ,~f_op_edit        ,~f_nf           ,~f_l_browse    ,~c_no        ,~c_yes

  ;;,g_grid_pickspot       ,~top_editteam   ,~bot_info      ,~f_dt_editteam ,~f_op_editteam    ,~f_s_editteam   ,~f_l_browse    ,~c_no
  ;;,g_grid_picktrnr       ,~top_text_grid  ,~bot_info      ,~f_dt_league   ,~f_op_teams       ,~f_s_batbegin   ,~f_l_browse    ,~c_no
  ;;,g_grid_battle_select  ,~bot_4x4        ,~top_battle2   ,~f_nf          ,~f_op_batsel      ,~f_s_battle     ,~f_l_battle    ,~c_no
  ;;,g_grid_battle_movesel ,~bot_4x4        ,~top_pkstat    ,~f_nf          ,~f_op_movesel     ,~f_s_battle     ,~f_l_browse    ,~c_no

  ;;,g_grid_battle_switch  ,~top_editteam,  ,~bot_info      ,~f_nf          ,~f_op_batswitch   ,~f_nf           ,~f_l_browse    ,~c_no
  ;;,g_grid_battle_stats   ,~top_editteam,  ,~bot_info      ,~f_nf          ,~f_op_batstats    ,~f_s_batstat    ,~f_l_browse    ,~c_no
  ;;,g_grid_battle_results ,~top_editteam   ,~bot_info      ,~f_nf          ,~f_op_batresults  ,~f_s_batresults ,~f_l_browse    ,~c_no
]])

g_gridstack = {} -- gotta run after the above.
f_add_to_ui_stack(g_grid_title)
