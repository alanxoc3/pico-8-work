-- in picodex, the screen is always divided into 2 sections, the "preview" grid and the "text" grid.
-- p_ = preview, t_ = text. The "preview" grid is the area at the top of the screen. The "text" grid is the area at the bottom of the screen.

-----------------------------
-- OP FUNCTIONS - DATA FOR UI
-----------------------------

-- This updates the lock variables, which determine if a pokemon/item/move is unlocked.
|[f_op_def]| function()
  return {{}}
end $$

|[f_op_browse]| function()
  local op = {}

  for i=0,251 do
    add(op, {data=c_pokemon[i].lock and i or P_NONE, disabled=not c_pokemon[i].lock})
  end

  return op
end $$

|[f_op_edit]| function(sumdisable)
  local op = {}
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
    add(op, {data=inds, disabled=sumdisable and valid})
  end
  return op
end $$

|[f_op_editteam]| function()
  local op = {}
  for pkmnnum=0,5 do
    local pkmn = f_get_party_pkmn(@S_TEAM, pkmnnum)
    add(op, {data=pkmn.num})
  end
  return op
end $$

|[f_op_title]| function() return {{text="bROWSE"}, {text="eDIT"}, {text="lEAGUE"}, {text="vERSUS"}} end $$
|[f_op_teams]| function()
  local op = {}
  for i=1, 58 do
    add(op, {text=c_trnr_names[i], disabled=@S_STORY+1<i})
  end
  return op
end $$

|[f_op_editstat]| function()
  local op = {}
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)

  for i=1,4 do
    add(op, {text=c_move_names[pkmn.view_moves[i]], select=function()
      poke(S_EDITMOVE, pkmn.edit_moves[i])
      add(g_gridstack, g_grid_editmove)
    end})
  end

  add(op, {text=c_item_names[pkmn.item], select=function()
    poke(S_EDITITEM, pkmn.item)
    add(g_gridstack, g_grid_edititem)
  end})

  add(op, {text=c_gender_names[pkmn.gender], disabled=#pkmn.genders < 2, select=function()
    pkmn.gender_bit += 1
    pkmn:f_save_party_pkmn(@S_TEAM, @S_TEAME)
  end})

  add(op, {text="vIEW", select=function()
    -- TODO!
  end})

  add(op, {text="dELETE", select=function()
    memset(S_PARTY1+@S_TEAM*48+@S_TEAME*8, P_NONE, 8)
    deli(g_gridstack)
  end})
  return op
end $$

-- TODO: experiment with making item num/name/lock in same obj -- 4042
|[f_create_spot]| function(_ENV, op, disabled)
  add(op, {text=lock and name or f_strtoq(name), disabled=disabled or not lock})
end $$

|[f_get_edit_op_pkmn]| function() return {}, f_get_party_pkmn(@S_TEAM, @S_TEAME) end $$
|[f_op_editmove]| function()
  local op, pkmn = f_get_edit_op_pkmn()

  for i, num in ipairs(pkmn.possible_moves) do
    f_create_spot(c_moves[num], op, pkmn.seen_moves[i-1])
  end
  return op
end $$

|[f_op_template_edit]| function(list, key)
  local op, pkmn = f_get_edit_op_pkmn()
  for obj in all(list) do
    f_create_spot(obj, op, pkmn[key] == obj.num)
  end
  return op
end $$

|[f_op_edititem]| function() return f_op_template_edit(c_items,  'item')  end $$

|[f_op_pkstat]| function()
  local op = {}
  local pkmn = c_pokemon[@g_grid_browse[1].mem]

  local genders = ""
  if #pkmn.genders == 1 then
    genders = c_gender_names[pkmn.genders[1]].."/"
  else
    for g in all(pkmn.genders) do
      genders ..= sub(c_gender_names[g], 1, 2).."/"
    end
  end
  genders = sub(genders, 1, #genders-1)

  add(op, {text="#"..f_prefix_zero(pkmn.num, 3).." "..pkmn.name, disabled=true})
  add(op, {text="       tYPE:"})
  add(op, {text="        "..c_type_names[pkmn.type1+1]})
  if pkmn.type2 ~= T_BIRD then
    add(op, {text="        "..c_type_names[pkmn.type2+1]})
  else
    add(op, {text=""})
  end

  add(op, {text="pOKEMON dATA", disabled=true})
  add(op, {text="mAJOR: nONE"})
  add(op, {text="iTEM:  nONE"})
  add(op, {text="gENDR: "..genders})
  -- add(op, {text="eVOLV: "..c_pkmn_names[pkmn.prevolve]})

  add(op, {text="pOKEMON sTAT", disabled=true})
  add(op, {text="hEALT: " .. pkmn.hp .. "/" .. pkmn.hp})
  add(op, {text="aTACK: " .. f_prefix_zero(pkmn.attack,         3) .. " "  .. (pkmn.stages.attack         > 0 and "+"..pkmn.stages.attack         or (pkmn.stages.attack         < 0 and "-"..pkmn.stages.attack        ) or "")})
  add(op, {text="dEFNS: " .. f_prefix_zero(pkmn.defense,        3) .. " "  .. (pkmn.stages.defense        > 0 and "+"..pkmn.stages.defense        or (pkmn.stages.defense        < 0 and "-"..pkmn.stages.defense       ) or "")})
  add(op, {text="sPaTK: " .. f_prefix_zero(pkmn.specialattack,  3) .. " "  .. (pkmn.stages.specialattack  > 0 and "+"..pkmn.stages.specialattack  or (pkmn.stages.specialattack  < 0 and "-"..pkmn.stages.specialattack ) or "")})
  add(op, {text="sPdFN: " .. f_prefix_zero(pkmn.specialdefense, 3) .. " "  .. (pkmn.stages.specialdefense > 0 and "+"..pkmn.stages.specialdefense or (pkmn.stages.specialdefense < 0 and "-"..pkmn.stages.specialdefense) or "")})
  add(op, {text="sPEED: " .. f_prefix_zero(pkmn.speed,          3) .. " "  .. (pkmn.stages.speed          > 0 and "+"..pkmn.stages.speed          or (pkmn.stages.speed          < 0 and "-"..pkmn.stages.speed         ) or "")})
  add(op, {text="eVASN: " .. f_prefix_zero(pkmn.evasion*100\1,  3) .. "%"})
  add(op, {text="aCURY: " .. f_prefix_zero(pkmn.accuracy*100\1, 3) .. "%"})
  add(op, {text="cRITL: " .. f_prefix_zero(pkmn.crit/16*100\1,  3) .. "%"})

  add(op, {text="mOVE1: ___", disabled=true})
  add(op, {text="tYPE:  ___"})
  add(op, {text="pWpNT: __/__"})
  add(op, {text="pW/aC: ___/___"})

  add(op, {text="mOVE2: sLFdES", disabled=true})
  add(op, {text="tYPE:  wATER"})
  add(op, {text="pWpNT: 05/05"})
  add(op, {text="pW/aC: 040/100"})

  add(op, {text="mOVE3: sLFdES", disabled=true})
  add(op, {text="tYPE:  wATER"})
  add(op, {text="pWpNT: 05/05"})
  add(op, {text="pW/aC: 040/100"})

  add(op, {text="mOVE4: sLFdES", disabled=true})
  add(op, {text="tYPE:  wATER"})
  add(op, {text="pWpNT: 05/05"})
  add(op, {text="pW/aC: 040/100"})

  add(op, {text="bATTLE fLAGS", disabled=true})

  local prev = ""
  for i,x in ipairs(split"nONE") do -- split"aCTIVE,bENCHD,nONE,mVlOCK,bIDE,dFNcRL,dISABL,cONFUS,rOLOUT,dSTbND,lOCKoN,dIG,fLY,fRYcTR,rAGE,tOXIC,pERsNG,pDEcNT,sUBSTU,nGTMAR,tRFORM,lECHsD,cURSE,mIST,tRAPPD,mEANlK,aTRACT,fORsGT,fTRsGT,sAFgRD,lITsCR,rFLECT,sPIKES,sNDsTR,rAIdNC,sUNdAY") do
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

  return op
end $$

---------------------------------------------
-- dp and dt drawing for ui
---------------------------------------------

|[f_dp_browse]| function(i, is_sel, gridobj)
  f_draw_pkmn(gridobj.data, 1, 1, 6, false, is_sel, gridobj.disabled)
end $$

|[f_dp_edit]| function(i, is_sel, gridobj)
  for ii, ind in ipairs(gridobj.data) do
    f_draw_pkmn(ind, (ii-1)%3+1+(ii-1)%3*9, 1+(ii-1)\3*10, 6, false, is_sel, gridobj.disabled)
  end
end $$

|[f_dt_editteam]| function(i, is_sel)
  f_print_top("eDIT: sPOT ", @S_TEAME+1)
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  f_print_bot("#", pkmn.num_str, " ", pkmn.name)
end $$

|[f_dt_editstat]| function(i, is_sel)
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  if @S_EDITSTAT < 4 then f_print_top("eDIT: mOVE", @S_EDITSTAT+1)
  elseif @S_EDITSTAT == 4 then f_print_top"eDIT: iTEM"
  elseif @S_EDITSTAT == 5 then f_print_top"eDIT: gENDER"
  elseif @S_EDITSTAT == 6 then f_print_top"eDIT: pRVIEW"
  elseif @S_EDITSTAT == 7 then f_print_top"eDIT: dELETE"
  end

  -- f_print_top("eDIT: sPOT ", @S_TEAME+1)
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
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

|[f_dt_editmove_template]| function(pkmn, pkmnmoveind)
  local movenum = pkmn.possible_moves[pkmnmoveind+1]
  local move = c_moves[movenum]
  local pp = f_prefix_zero(move.pp, 2)
  local pow = f_prefix_zero(move.pow, 3)
  local acc = f_prefix_zero(move.acc, 3)
  local typ = c_type_names[move.type+1]

  if move.pow == 0 then pow = "___" end
  if move.pow == 1 then pow = "var" end
  if move.acc == 0 then acc = "___" end

  -- TODO: I'd rather store an empty move to save a few tokens. Empty and struggle.
  if movenum == M_NONE then
    typ, pp, pow, acc = "nONE", "__", "___", "___"
  end

  f_print_top(pkmn.possible_moves_method[movenum], ": ", typ)
  f_print_bot(pp, "PP ", pow, "P ", acc, "A")
end $$

|[f_dt_editmove]| function()
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  f_dt_editmove_template(pkmn, @S_EDITMOVE)
end $$

|[f_dt_edititem]| function(i, is_sel)
  print("\f4hello", 1, 1)
end $$

|[f_dp_editteam]| function(i, is_sel, gridobj)
  f_draw_pkmn(gridobj.data, 1, 1, 16, false, is_sel)
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

  f_print_top("#", f_prefix_zero(pkmn.num, 3), " \f4", namestr)
  f_print_bot(type1, " ", type2)
end $$

|[f_dt_browse]| function()
  f_dt_browse_template(@S_BROWSE)
end $$

|[f_dt_edit]| function()
  local pkstr_arr = {}
  local pkstr_lens = split'2,2,2,2,1,1'
  for ii=0,5 do
    local pkmn = f_get_party_pkmn(@S_TEAM, ii)
    add(pkstr_arr, sub(c_pkmn_names[pkmn.num], 1, pkstr_lens[ii+1]))
  end

  f_print_top("eDIT: tEAM ", (@g_cg_m.mem+1))
  f_print_bot(pkstr_arr[1], "-", pkstr_arr[2], "-", pkstr_arr[3], "-", pkstr_arr[4], "-", pkstr_arr[5], pkstr_arr[6])

  -- local pkstr = pkstr_arr[1].."-"..pkstr_arr[2].."-"..pkstr_arr[3]..pkstr_arr[4]..pkstr_arr[5].."-"..pkstr_arr[6]
  -- print("\^y7\f4#"..(@g_cg_m.mem+1).." \f4tEAM\n\f2"..pkstr, 1, 1, C_2)
end $$

|[f_dt_league]| function()
  -- TODO: save tokens / compression by extracting out this if.
  local toggle = g_cg_m.name == 'g_grid_pickleag'

  f_print_top((toggle and "\f4" or "\f2"), "pLR: tEAM ", (@S_TEAM+1))
  f_print_bot((toggle and "\f2" or "\f4"), "cPU: ", c_trnr_names[@S_TEAML+1])
end $$

|[f_dt_versus]| function()
  local toggle = g_cg_m.name == 'g_grid_pickplr1'

  f_print_top((toggle and "\f4" or "\f2"), "pLR1: tEAM ", (@S_TEAM+1))
  f_print_bot((toggle and "\f2" or "\f4"), "pLR2: tEAM ", (@S_TEAM2+1))
end $$

|[f_dp_title]| function()
  print("\^w\^tpicodex", 2, 1,  C_4)
  print("dUAL vERSION",  2, 12, C_2)

  -- todo: give title pokemon correct colors
  f_draw_pkmn(g_title_l, -8+15+(mid(-1, -.75, cos(0+g_title_an_timer/300))+.75)*4*26   + (g_title_an_timer > 190 and g_title_an_timer < 220 and (rnd(3)\1-1) or 0), 20, 16)
  f_draw_pkmn(g_title_r, 50-15-(mid(-1, -.75, cos(.5+g_title_an_timer/300))+.75)*4*26  + (g_title_an_timer > 40  and g_title_an_timer < 70  and (rnd(3)\1-1) or 0), 20, 16, true)
end $$

|[f_dp_title_update]| function()
  g_title_an_timer = (g_title_an_timer+1)%300

  if g_title_an_timer == 0 then
    g_title_r = rnd"252"\1
  elseif g_title_an_timer == 150 then
    g_title_l = rnd"252"\1

  elseif g_title_an_timer == 50-10  then f_minisfx(g_title_r-1)
  elseif g_title_an_timer == 200-10 then f_minisfx(g_title_l-1)
  end
end $$

|[f_dp_pkstat]| function(i)
  if i == 3 then
    local y = 6
    local pkmn_ind = @S_BROWSE
    local pkmn = c_pokemon[@S_BROWSE]
    f_draw_pkmn(pkmn_ind, 2-8-20+(g_preview_timer > 0 and (rnd(3)\1-1) or 0)+30, -8+1-10-1-1+y+3-3, 16)
    rectfill(-9+4+30, -18, -9+4+30, 6, C_2)
  end
end $$

----------------------------------------------------
-- sels and leaves - forward and back through stack
----------------------------------------------------
|[f_l_browse]| function()
  deli(g_gridstack)
end $$

|[f_s_browse]| function()
  add(g_gridstack, g_grid_pkstat)
end $$

|[f_s_title]| function()
  if @g_cg_m.mem == 0 then
    add(g_gridstack, g_grid_browse)
  elseif @g_cg_m.mem == 1 then
    add(g_gridstack, g_grid_pickedit)
  elseif @g_cg_m.mem == 2 then
    add(g_gridstack, g_grid_pickleag)
  elseif @g_cg_m.mem == 3 then
    add(g_gridstack, g_grid_pickplr1)
  end
end $$

|[f_l_pkstat]| function()
  deli(g_gridstack)
end $$

|[f_s_pkstat]| function()
  g_preview_timer = 20
  return @S_BROWSE
end $$

|[f_s_versus]| function()
  add(g_gridstack, g_grid_pickplr2)
end $$

|[f_s_league]| function()
  add(g_gridstack, g_grid_picktrnr)
end $$

|[f_s_edit]| function()
  add(g_gridstack, g_grid_pickspot)
end $$

|[f_s_editteam]| function()
  --local party_loc = S_PARTY1+(@S_TEAM)*42
  --local pkmn_loc = party_loc+@S_TEAME*7
  add(g_gridstack, f_get_party_pkmn(@S_TEAM, @S_TEAME).valid and g_grid_editstat or g_grid_editpkmn)
end $$

|[f_s_editpkmn]| function()
  f_save_party_pkmn(f_get_default_pkmn(@S_BROWSE), @S_TEAM, @S_TEAME)
  deli(g_gridstack)
end $$

|[f_s_editstat]| function()
  gridpo[@S_EDITSTAT+1].select()
end $$

|[f_s_editmove]| function()
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  pkmn.edit_moves[@S_EDITSTAT+1] = @S_EDITMOVE
  f_save_party_pkmn(pkmn, @S_TEAM, @S_TEAME)
  deli(g_gridstack)
end $$

|[f_s_edititem]| function()
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  pkmn.item = @S_EDITITEM
  f_save_party_pkmn(pkmn, @S_TEAM, @S_TEAME)
  deli(g_gridstack)
end $$

|[f_l_title]| function()
  return SFX_ERROR
end $$

|[f_browselr]| function(dir) -- TODO: can this be simplified?
  local prev = @S_BROWSE
  local next = prev+1
  if dir > 0 then
    for i=next+1,252,1 do
      if c_pokemon[i-1].lock then
        next = i
        break
      end
    end
  elseif dir < 0 then
    for i=prev-1,1,-1 do
      if c_pokemon[i].lock then
        next = i+1
        break
      end
    end
  end

  poke(S_BROWSE, next-1)
  if prev ~= @S_BROWSE then
    f_minisfx(SFX_MOVE)
    -- f_populate_stats() f_op_pkstat related
  elseif dir ~= 0 then
    f_minisfx(SFX_ERROR)
  end
end $$

---------------------------------------------
-- connections
---------------------------------------------

f_zcall(f_create_gridpair, [[
  -- TODO: test if duplicating this saves compression space ( getting rid of the p_browse and putting it in the g_grids...)
  --            w  vh x  y   cw   ch draw func          update func
   p_browse;    ,6 ,4 ,2 ,2  ,10 ,10 ,~f_dp_browse      ,~f_nf
  ;t_browse;    ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_browse      ,~f_nf
  ;p_title;     ,1 ,1 ,2 ,2  ,60 ,40 ,~f_dp_title       ,~f_dp_title_update
  ;t_title;     ,2 ,2 ,2 ,44 ,30 ,9  ,~f_nf             ,~f_nf

  ;p_pkstat;    ,1 ,4 ,2 ,4  ,60 ,9  ,~f_dp_pkstat      ,~f_nf

  ;t_edit;      ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_edit        ,~f_nf
  ;p_edit;      ,2 ,2 ,2 ,2  ,30 ,20 ,~f_dp_edit        ,~f_nf

  ;t_editteam;     ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_editteam ,~f_nf
  ;p_editteam;     ,3 ,2 ,2 ,2  ,20 ,20 ,~f_dp_editteam ,~f_nf

  ;t_editstat;     ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_editstat ,~f_nf
  ;p_editstat;     ,2 ,4 ,2 ,4  ,30 ,9  ,~f_nf          ,~f_nf

  ;t_edit4;     ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_editmove    ,~f_nf
  ;p_edit4;     ,2 ,4 ,2 ,4  ,30 ,9  ,~f_nf             ,~f_nf

  ;t_edititem;  ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_editstat    ,~f_nf
  ;p_edititem;  ,2 ,4 ,2 ,4  ,30 ,9  ,~f_nf             ,~f_nf

  ;t_versus;    ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_versus      ,~f_nf
  ;t_league;    ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_league      ,~f_nf

  ;p_teamed;    ,2 ,4 ,2 ,4  ,30 ,9  ,~f_nf             ,~f_nf
  ;t_teamed;    ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_edit        ,~f_nf

  -- name              active mem  main grid     info grid     mk op mkfunc      select func     leave func
  ;;,g_grid_browse    ,S_BROWSE    ,~p_browse    ,~t_browse    ,~f_op_browse,    ~f_s_browse     ,~f_l_browse,   ,~c_no
  ;;,g_grid_title     ,S_TITLE     ,~t_title     ,~p_title     ,~f_op_title,     ~f_s_title      ,~f_l_title,    ,~c_no

  ;;,g_grid_pkstat    ,S_PKSTAT    ,~p_pkstat    ,~t_browse    ,~f_op_pkstat,    ~f_s_pkstat     ,~f_l_pkstat,   ,~f_browselr

  ;;,g_grid_editstat  ,S_EDITSTAT  ,~p_editstat  ,~t_editstat  ,~f_op_editstat,  ~f_s_editstat   ,~f_l_browse,   ,~c_no
  ;;,g_grid_editmove  ,S_EDITMOVE  ,~p_edit4     ,~t_edit4     ,~f_op_editmove,  ~f_s_editmove   ,~f_l_browse,   ,~c_no
  ;;,g_grid_edititem  ,S_EDITITEM  ,~p_edititem  ,~t_edititem  ,~f_op_edititem,  ~f_s_edititem   ,~f_l_browse,   ,~c_no
  ;;,g_grid_editpkmn  ,S_BROWSE    ,~p_browse    ,~t_browse    ,~f_op_browse,    ~f_s_editpkmn   ,~f_l_browse,   ,~c_no

  ;;,g_grid_pickedit  ,S_TEAM      ,~p_edit      ,~t_edit      ,~f_op_edit,      ~f_s_edit       ,~f_l_browse,   ,~c_no
  ;;,g_grid_pickleag  ,S_TEAM      ,~p_edit      ,~t_league    ,~f_op_edit,      ~f_s_league     ,~f_l_browse,   ,~c_no,      ~c_yes
  ;;,g_grid_pickplr1  ,S_TEAM      ,~p_edit      ,~t_versus    ,~f_op_edit,      ~f_s_versus     ,~f_l_browse,   ,~c_no,      ~c_yes

  ;;,g_grid_pickspot  ,S_TEAME     ,~p_editteam  ,~t_editteam  ,~f_op_editteam,  ~f_s_editteam   ,~f_l_browse,   ,~c_no
  ;;,g_grid_picktrnr  ,S_TEAML     ,~p_teamed    ,~t_league    ,~f_op_teams,     ~f_nf           ,~f_l_browse,   ,~c_no
  ;;,g_grid_pickplr2  ,S_TEAM2     ,~p_edit      ,~t_versus    ,~f_op_edit,      ~f_nf           ,~f_l_browse,   ,~c_no,      ~c_yes
]])
