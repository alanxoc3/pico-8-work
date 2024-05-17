-- in picodex, the screen is always divided into 2 sections, the "preview" grid and the "text" grid.
-- p_ = preview, t_ = text. The "preview" grid is the area at the top of the screen. The "text" grid is the area at the bottom of the screen.

-- current: 4707 | 28810 | 10642

-----------------------------
-- OP FUNCTIONS - DATA FOR UI
-----------------------------

-- This updates the lock variables, which determine if a pokemon/item/move is unlocked.
|[f_op_def]| function(op) add(op, {}) end $$

|[f_op_browse]| function(op)
  for i=0,251 do
    add(op, {disabled=not c_pokemon[i].lock, draw=function(_, is_sel, gridobj)
      f_draw_pkmn(c_pokemon[i].lock and i or P_NONE, 1, 1, 6, false, is_sel, gridobj.disabled)
    end})
  end
end $$

|[f_op_edit]| function(op, sumdisable)
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
        f_draw_pkmn(ind, (ii-1)%3+1+(ii-1)%3*9, 1+(ii-1)\3*10, 6, false, is_sel, gridobj.disabled)
      end
    end})
  end
end $$

|[f_op_editteam]| function(op)
  for pkmnnum=0,5 do
    local pkmn = f_get_party_pkmn(@S_TEAM, pkmnnum)
    add(op, {draw=function(i, is_sel)
      f_draw_pkmn(pkmn.num, 1, 1, 16, false, is_sel)
    end})
  end
end $$

|[f_op_title]| function(op)
  foreach(split"bROWSE,eDIT,lEAGUE,vERSUS", function(text)
    f_addop_text(op, text)
  end)
end $$

|[f_op_teams]| function(op)
  for i=1, 58 do
    add(op, {text=c_trnr_names[i], disabled=@S_STORY+1<i})
  end
end $$

|[f_op_editstat]| function(op)
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)

  for i=1,4 do
    add(op, {text=c_move_names[pkmn[i].id], select=function()
      poke(S_EDITMOVE, pkmn[i].pid)
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
    add(g_gridstack, g_grid_statedit)
  end})

  add(op, {text="dELETE", select=function()
    memset(S_PARTY1+@S_TEAM*42+@S_TEAME*7, P_NONE, 7)
    deli(g_gridstack)
  end})
end $$

-- TODO: experiment with making item num/name/lock in same obj -- 4042
|[f_create_spot]| function(_ENV, op, disabled)
  add(op, {text=lock and name or f_strtoq(name), disabled=disabled or not lock})
end $$

|[f_get_edit_op_pkmn]| function() return f_get_party_pkmn(@S_TEAM, @S_TEAME) end $$
|[f_op_editmove]| function(op)
  local pkmn = f_get_edit_op_pkmn()
  for i, num in ipairs(pkmn.possible_moves) do
    f_create_spot(c_moves[num], op, pkmn.seen_moves[i-1])
  end
end $$

|[f_op_template_edit]| function(op, list, key)
  local pkmn = f_get_edit_op_pkmn()
  for obj in all(list) do
    f_create_spot(obj, op, pkmn[key] == obj.num)
  end
end $$

|[f_op_edititem]| function(op) f_op_template_edit(op, c_items,  'item')  end $$

|[f_add_stat_move]| function(op, pkmn, ind)
  local m = pkmn[ind]
  local pp, pow, acc, typ = f_get_move_texts(c_moves[m.id])
  add(op, {text="mOVE"..ind..": "..c_move_names[m.id], disabled=true})
  add(op, {text="tYPE:  "..typ})
  add(op, {text="pWpNT: "..pp.."/"..pp})
  add(op, {text="pW/aC: "..pow.."/"..acc})
end $$

-- 0 = browse, 1 = edit, 2 = benched, 3 = active
|[f_add_stat]| function(op, pkmn, mode)
  local genders = ""
  if #pkmn.genders == 1 then
    genders = c_gender_names[pkmn.genders[1]].."/"
  else
    for g in all(pkmn.genders) do
      genders ..= sub(c_gender_names[g], 1, 2).."/"
    end
  end
  genders = sub(genders, 1, #genders-1)

  add(op,  {text="#"..f_prefix_zero(pkmn.num, 3).." "..pkmn.name, disabled=true})
  add(op,  {text="       tYPE:"})
  add(op,  {text="        "..c_type_names[pkmn.type1+1]})
  local t2text = "        "
  if pkmn.type2 ~= T_BIRD then
    t2text ..= c_type_names[pkmn.type2+1]
  end

  add(op, {text=t2text, draw=function()
    f_draw_pkmn(pkmn.num, 2-8-20+(g_preview_timer > 0 and (rnd(3)\1-1) or 0)+30, -8+1-10-1-1+6+3-3, 16)
    rectfill(-9+4+30, -18, -9+4+30, 6, C_2)
  end})

  add(op, {text="pOKEMON sTATS", disabled=true})

  if mode >= MODE_BENCH then -- todo: convert to > (gt), saves a character
    add(op, {text="mAJOR: nONE"})
  end

  if mode >= MODE_EDIT then -- todo: convert to > (gt), saves a character
    add(op, {text="iTEM:  nONE"})
  end

  add(op, {text="gENDR: "..genders})
  add(op, {text="pREVO: "..c_pkmn_names[pkmn.prevolve]})
  add(op, {text="hEALT: " .. pkmn.hp .. "/" .. pkmn.hp})
  add(op, {text="aTACK: " .. f_prefix_zero(pkmn.attack,         3) .. " "  .. (pkmn.stages.attack         > 0 and "+"..pkmn.stages.attack         or (pkmn.stages.attack         < 0 and "-"..pkmn.stages.attack        ) or "")})
  add(op, {text="dEFNS: " .. f_prefix_zero(pkmn.defense,        3) .. " "  .. (pkmn.stages.defense        > 0 and "+"..pkmn.stages.defense        or (pkmn.stages.defense        < 0 and "-"..pkmn.stages.defense       ) or "")})
  add(op, {text="sPaTK: " .. f_prefix_zero(pkmn.specialattack,  3) .. " "  .. (pkmn.stages.specialattack  > 0 and "+"..pkmn.stages.specialattack  or (pkmn.stages.specialattack  < 0 and "-"..pkmn.stages.specialattack ) or "")})
  add(op, {text="sPdFN: " .. f_prefix_zero(pkmn.specialdefense, 3) .. " "  .. (pkmn.stages.specialdefense > 0 and "+"..pkmn.stages.specialdefense or (pkmn.stages.specialdefense < 0 and "-"..pkmn.stages.specialdefense) or "")})
  add(op, {text="sPEED: " .. f_prefix_zero(pkmn.speed,          3) .. " "  .. (pkmn.stages.speed          > 0 and "+"..pkmn.stages.speed          or (pkmn.stages.speed          < 0 and "-"..pkmn.stages.speed         ) or "")})

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
    add(op, {text="bATTLE fLAGS", disabled=true})

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

|[f_op_statbrowse]| function(op) f_add_stat(op, c_pokemon[@S_BROWSE], MODE_BROWSE) end $$
|[f_op_statedit]|   function(op) f_add_stat(op, f_get_party_pkmn(@S_TEAM, @S_TEAME),  MODE_EDIT)   end $$

---------------------------------------------
-- dp and dt drawing for ui
---------------------------------------------
|[f_dt_editteam]| function(i, is_sel)
  f_print_top("tEAM",@S_TEAM+1,": sPOT",@S_TEAME+1)
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  f_print_bot("#", pkmn.num_str, " ", pkmn.name)
end $$

|[f_dt_editstat]| function(i, is_sel)
  local prefix = "sPOT"..@S_TEAME+1
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  if @S_EDITSTAT < 4 then f_print_top(prefix, ": mOVE", @S_EDITSTAT+1)
  elseif @S_EDITSTAT == 4 then f_print_top(prefix, ": iTEM")
  elseif @S_EDITSTAT == 5 then f_print_top(prefix, ": gENDER")
  elseif @S_EDITSTAT == 6 then f_print_top(prefix, ": vIEW")
  elseif @S_EDITSTAT == 7 then f_print_top(prefix, ": dELETE")
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
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  local movenum = pkmn.possible_moves[@S_EDITMOVE+1]
  local move = c_moves[movenum]
  f_dt_editmove_template(move, pkmn.possible_moves_method[movenum])
end $$

|[f_dt_edititem]| function(i, is_sel)
  print("\f4hello", 1, 1)
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
  f_dt_browse_template(@S_BROWSE)
end $$

-- TODO: dedup with below func
|[f_dt_editpkmn]| function()
  local pkmn = c_pokemon[@S_BROWSE]
  local namestr = pkmn.name

  if not pkmn.lock then
    namestr = f_strtoq(namestr)
  end

  f_print_top("tEAM",@S_TEAM+1,": sPOT",@S_TEAME+1)
  f_print_bot("#", f_prefix_zero(pkmn.num, 3), " ", namestr)
end $$

|[f_dt_edit]| function()
  local pkstr_arr = {}
  local pkstr_lens = split'2,2,2,2,1,1'
  for ii=0,5 do
    local pkmn = f_get_party_pkmn(@S_TEAM, ii)
    add(pkstr_arr, sub(c_pkmn_names[pkmn.num], 1, pkstr_lens[ii+1]))
  end

  f_print_top("eDIT: tEAM", (@g_cg_m.mem+1))
  f_print_bot(pkstr_arr[1], "-", pkstr_arr[2], "-", pkstr_arr[3], "-", pkstr_arr[4], "-", pkstr_arr[5], pkstr_arr[6])

  -- local pkstr = pkstr_arr[1].."-"..pkstr_arr[2].."-"..pkstr_arr[3]..pkstr_arr[4]..pkstr_arr[5].."-"..pkstr_arr[6]
  -- print("\^y7\f4#"..(@g_cg_m.mem+1).." \f4tEAM\n\f2"..pkstr, 1, 1, C_2)
end $$

|[f_dt_league]| function()
  -- TODO: save tokens / compression by extracting out this if.
  local toggle = g_cg_m.name == 'g_grid_pickleag'

  f_print_top(toggle and "\f4" or "\f2", "pLR: tEAM", @S_TEAM+1)
  f_print_bot(toggle and "\f2" or "\f4", "cPU: ", c_trnr_names[@S_TEAML+1])
end $$

|[f_dt_versus]| function()
  local toggle = g_cg_m.name == 'g_grid_pickplr1'

  f_print_top(toggle and "\f4" or "\f2", "pLR1: tEAM", @S_TEAM+1)
  f_print_bot(toggle and "\f2" or "\f4", "pLR2: tEAM", @S_TEAM2+1)
end $$

|[f_dp_title]| function()
  print("\^w\^tpicodex", 2, 1,  C_4)
  print("dUAL vERSION",  2, 12, C_2)

  -- todo: give title pokemon correct colors
  f_draw_pkmn(g_title_l, -8+15+(mid(-1, -.75, cos(0+g_title_an_timer/300))+.75)*4*26   + (g_title_an_timer > 190 and g_title_an_timer < 220 and (rnd(3)\1-1) or 0), 20, 16)
  f_draw_pkmn(g_title_r, 50-15-(mid(-1, -.75, cos(.5+g_title_an_timer/300))+.75)*4*26  + (g_title_an_timer > 40  and g_title_an_timer < 70  and (rnd(3)\1-1) or 0), 20, 16, true)
end $$

function roundrect_r(x1, y1, x2, y2, c)
  rectfill(x1, y1+1, x2, y2-1, c)
  if x2-x1 > 2 then -- if check is for the hp bar, so it looks good when small.
    rectfill(x1+1, y1, x2-1, y2, c)
  end
end

|[f_dp_battle]| function()
  local b = function(name, status, x, y, bx, by, hp, hpmax, sel)
    local col = sel and C_2 or C_2
    local boxcol = sel and C_3 or C_3
    roundrect_r(bx-1+1, by+1-6+1, bx+35-1, by+6+6+1, boxcol)
    if hp > 0 then
      rectfill(bx+1, by+3, bx+1+mid(0, hp/hpmax*32, 32), by+6, col)
      pset(bx+1, by+3, boxcol)
      pset(bx+1, by+6, boxcol)
      pset(bx+33, by+3, boxcol)
      pset(bx+33, by+6, boxcol)
    end

    local tx, ty = x+15, y+9
    -- for i=0,5 do
    --   if i ~= 1 then
    --     pset(tx+i%3*2, ty+i%2*2-1+1, col)
    --   end
    -- end

    print(name,   x+2,   y-5+1+1, col, -1)
    print(status.."  "..f_prefix_zero(hp, 3), x+1+1, y+8-1+1,   col, -1)
    -- print(f_prefix_zero(hp, 3),   x+37-4*3-1-1-1, y+8-1+1, col, 1)
  end

  b("vENUSAUR", "bRN",0, 4, 0, 4,  1,100, false)  f_draw_pkmn(3, 39, 1,  16, true,  false, false, true)
  b("cHARMAND","fZN", 23,24,23,24, 60+cos(t())*50\1,80, true)  f_draw_pkmn(9, 3,  21, 16, false, false, false, false)
end $$

|[f_op_batsel]| function(op)
  add(op, {text="fIGHT"})
  add(op, {text="sTATS"})
  add(op, {text="sWITCH"})
  add(op, {text="gIVEuP"})
end $$

----------------------------------------------------
-- sels and leaves - forward and back through stack
----------------------------------------------------
|[f_l_browse]| function()
  deli(g_gridstack)
end $$

|[f_s_browse]| function()
  add(g_gridstack, g_grid_statbrowse)
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

|[f_s_pkstat]| function()
  g_preview_timer = 20
  return @S_BROWSE
end $$

|[f_s_statedit]| function()
  g_preview_timer = 20
  return f_get_party_pkmn(@S_TEAM, @S_TEAME).num
end $$

|[f_s_versus]| function()
  add(g_gridstack, g_grid_pickplr2)
end $$

|[f_s_league]| function()
  add(g_gridstack, g_grid_picktrnr)
end $$

|[f_s_batbegin]| function()
  add(g_gridstack, g_grid_battle_select)
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
  pkmn[@S_EDITSTAT+1].pid = @S_EDITMOVE
  f_save_party_pkmn(pkmn, @S_TEAM, @S_TEAME)
  deli(g_gridstack)
end $$

|[f_s_edititem]| function()
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  pkmn.item = @S_EDITITEM
  f_save_party_pkmn(pkmn, @S_TEAM, @S_TEAME)
  deli(g_gridstack)
end $$

|[f_l_title]| function() -- TODO: maybe we can call sfx in here and l_browse. might save a token instead of handling that in grid.
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
    for i=prev-1,0,-1 do
      if c_pokemon[i].lock then
        next = i+1
        break
      end
    end
  end

  poke(S_BROWSE, next-1)
  if prev ~= @S_BROWSE then
    f_minisfx(SFX_MOVE)
    -- f_populate_stats() f_op_statbrowse related
  elseif dir ~= 0 then
    f_minisfx(SFX_ERROR)
  end
end $$

|[f_lr_statedit]| function(dir) -- TODO: can this be simplified & combined with above?
  local prev = @S_TEAME
  local next = prev+1
  if dir > 0 then
    for i=next+1,6,1 do
      local pkmn = f_get_party_pkmn(@S_TEAM, i-1)
      if pkmn.num ~= P_NONE then
        next = i
        break
      end
    end
  elseif dir < 0 then
    for i=prev-1,0,-1 do
      local pkmn = f_get_party_pkmn(@S_TEAM, i)
      if pkmn.num ~= P_NONE then
        next = i+1
        break
      end
    end
  end

  poke(S_TEAME, next-1)
  if prev ~= @S_TEAME then
    f_minisfx(SFX_MOVE)
  elseif dir ~= 0 then
    f_minisfx(SFX_ERROR)
  end
end $$

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
  ;bot_4x4       ;,2 ,2 ,2 ,44 ,30 ,9
  ;bot_info      ;,1 ,1 ,2 ,45 ,60 ,16

  -- name                  active mem       maingridspec     infogridspec  infogriddraw    main opfunc        select func    leave func      lrfunc        opfunc params
  ;;,g_grid_title          ,S_TITLE         ,~bot_4x4        ,~top_title   ,~f_dp_title    ,~f_op_title       ,~f_s_title    ,~f_l_title     ,~c_no

  ;;,g_grid_browse         ,S_BROWSE        ,~top_browse     ,~bot_info    ,~f_dt_browse   ,~f_op_browse      ,~f_s_browse   ,~f_l_browse    ,~c_no
  ;;,g_grid_editpkmn       ,S_BROWSE        ,~top_browse     ,~bot_info    ,~f_dt_editpkmn ,~f_op_browse      ,~f_s_editpkmn ,~f_l_browse    ,~c_no

  ;;,g_grid_statbrowse     ,S_STATBROWSE    ,~top_pkstat     ,~bot_info    ,~f_dt_browse   ,~f_op_statbrowse  ,~f_s_pkstat   ,~f_l_browse    ,~f_browselr
  ;;,g_grid_statedit       ,S_STATEDIT      ,~top_pkstat     ,~bot_info    ,~f_dt_editstat ,~f_op_statedit    ,~f_s_statedit ,~f_l_browse    ,~f_lr_statedit
  ;;,g_grid_statbattle     ,S_STATBATTLE    ,~top_pkstat     ,~bot_info    ,~f_dt_browse   ,~f_op_statbrowse  ,~f_s_pkstat   ,~f_l_browse    ,~f_browselr

  ;;,g_grid_editstat       ,S_EDITSTAT      ,~top_text_grid  ,~bot_info    ,~f_dt_editstat ,~f_op_editstat    ,~f_s_editstat ,~f_l_browse    ,~c_no
  ;;,g_grid_editmove       ,S_EDITMOVE      ,~top_text_grid  ,~bot_info    ,~f_dt_editmove ,~f_op_editmove    ,~f_s_editmove ,~f_l_browse    ,~c_no
  ;;,g_grid_edititem       ,S_EDITITEM      ,~top_text_grid  ,~bot_info    ,~f_dt_editstat ,~f_op_edititem    ,~f_s_edititem ,~f_l_browse    ,~c_no

  ;;,g_grid_pickedit       ,S_TEAM          ,~top_edit       ,~bot_info    ,~f_dt_edit     ,~f_op_edit        ,~f_s_edit     ,~f_l_browse    ,~c_no
  ;;,g_grid_pickleag       ,S_TEAM          ,~top_edit       ,~bot_info    ,~f_dt_league   ,~f_op_edit        ,~f_s_league   ,~f_l_browse    ,~c_no        ,~c_yes
  ;;,g_grid_pickplr1       ,S_TEAM          ,~top_edit       ,~bot_info    ,~f_dt_versus   ,~f_op_edit        ,~f_s_versus   ,~f_l_browse    ,~c_no        ,~c_yes
  ;;,g_grid_pickplr2       ,S_TEAM2         ,~top_edit       ,~bot_info    ,~f_dt_versus   ,~f_op_edit        ,~f_nf         ,~f_l_browse    ,~c_no        ,~c_yes

  ;;,g_grid_pickspot       ,S_TEAME         ,~top_editteam   ,~bot_info    ,~f_dt_editteam ,~f_op_editteam    ,~f_s_editteam ,~f_l_browse    ,~c_no
  ;;,g_grid_picktrnr       ,S_TEAML         ,~top_text_grid  ,~bot_info    ,~f_dt_league   ,~f_op_teams       ,~f_s_batbegin ,~f_l_browse    ,~c_no

  ;;,g_grid_battle_select, ,S_BATSELECT     ,~bot_4x4        ,~top_battle  ,~f_dp_battle   ,~f_op_batsel      ,~f_nf         ,~f_nf          ,~c_no
  -- ;;,g_grid_battle_move,   ,S_BATMOVE
  -- ;;,g_grid_battle_switch, ,S_BATSWITCH
  -- ;;,g_grid_battle_stat,   ,S_BATSTAT
  -- ;;,g_grid_battle_turn,   ,S_BATTURN
  -- ;;,g_grid_battle_result, ,S_BATRESULT
]])

g_gridstack = {g_grid_title} -- gotta run after the above.
