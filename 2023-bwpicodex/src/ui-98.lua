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

  add(op, {text=c_levels[pkmn.level].name, select=function()
    poke(S_EDITLEVL, pkmn.level-1)
    add(g_gridstack, g_grid_editlevl)
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
|[f_op_editlevl]| function() return f_op_template_edit(c_levels, 'level') end $$

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

  -- add(op, {text="lV.050 sTATS", disabled=true}) add(op, {text="", disabled=true})
  -- same shows for 
  add(op, {text="pICODEX eNTRY", disabled=true}) add(op, {text="", disabled=true})
  -- add(op, {text="      m:fROZEN"}) add(op, {text=""})
  -- 3 most important things to see in stat screen...
  -- add(op, {text="     p:"..c_pkmn_names[pkmn.prevolve]})     add(op, {text=""})
  -- add(op, {text="     i:"..c_item_names[pkmn.default_item]}) add(op, {text=""})
  -- add(op, {text="     g:"..genders})  add(op, {text=""})

  -- add(op, {text="     mAJ: nON"}) add(op, {text=""})
  add(op, {text="       "..pkmn.name})  add(op, {text=""})
  add(op, {text="        "..c_type_names[pkmn.type1+1]})                      add(op, {text=""})
  if pkmn.type2 ~= T_BIRD then
    add(op, {text="        "..c_type_names[pkmn.type2+1]})  add(op, {text=""})
  else
    add(op, {text=""})  add(op, {text=""})
  end

  -- add(op, {text="     gN:"..genders})                      add(op, {text=""})

  add(op, {text="pOKEMON dATA", disabled=true})          add(op, {text="", disabled=true})
  --add(op, {text="tYPE1: "..c_type_names[pkmn.type1+1]})   add(op, {text=""})
  --add(op, {text="tYPE2: "..c_type_names[pkmn.type2+1]})   add(op, {text=""})
  add(op, {text="iNDEX: #"..f_prefix_zero(pkmn.num, 3)})                         add(op, {text=""})
  add(op, {text="eVOLV: "..c_pkmn_names[pkmn.prevolve]})  add(op, {text=""})
  add(op, {text="gENDR: "..genders})                      add(op, {text=""})
  add(op, {text="lEVEL: lV.50"})                         add(op, {text=""})

  -- add(op, {text="hP:    019/123"}) add(op, {text=""})
  -- add(op, {text="iTEM:  bONcLB"}) add(op, {text=""})

  add(op, {text="pOKEMON sTAT", disabled=true})          add(op, {text="", disabled=true})
  add(op, {text="hEALT: "..pkmn.hp.."/"..pkmn.hp}) add(op, {text=""})
  add(op, {text="aTACK: 003 +4"}) add(op, {text=""})
  add(op, {text="dEFNS: 132 +1"}) add(op, {text=""})
  add(op, {text="sPaTK: 132 -3"}) add(op, {text=""})
  add(op, {text="sPdFN: 090 -6"}) add(op, {text=""})
  add(op, {text="sPEED: 132"}) add(op, {text=""})
  add(op, {text="eVASN: 120% +3"}) add(op, {text=""})
  add(op, {text="aCURY: 090% -1"}) add(op, {text=""})
  add(op, {text="cRITL: 006% +2"}) add(op, {text=""})

--   add(op, {text="pOKEMON mOVE 1", disabled=true}) add(op, {text="", disabled=true})
--   add(op, {text="sLFdES | 30PP"}) add(op, {text=""})
--   add(op, {text="lEARN | dRAGON"}) add(op, {text=""})
--   add(op, {text="40PP 030P 100A"}) add(op, {text=""})
--   add(op, {text="pOKEMON mOVE 2", disabled=true}) add(op, {text="", disabled=true})
--   add(op, {text="\f4sLFdES"}) add(op, {text=""})
--   add(op, {text="lEARN | dRAGON"}) add(op, {text=""})
--   add(op, {text="40PP 030P 100A"}) add(op, {text=""})
--   -- add(op, {text="tYPE:  wATER"}) add(op, {text=""})
--   -- add(op, {text="pP:    05/05"}) add(op, {text=""})
--   -- add(op, {text="pW/aC: 040/100"}) add(op, {text=""})
-- 
  -- add(op, {text="pOKEMON mOVES", disabled=true}) add(op, {text="", disabled=true})
  -- add(op, {text="sLFdES: 05/05"}) add(op, {text=""})
  -- add(op, {text="bODsLM: 05/05"}) add(op, {text=""})
  -- add(op, {text="sKETCH: 05/05"}) add(op, {text=""})
  -- add(op, {text="sCRTCH: 05/05"}) add(op, {text=""})

  add(op, {text="mOVE1: sLFdES", disabled=true}) add(op, {text="", disabled=true})
  add(op, {text="lEARN: wATER"}) add(op, {text=""})
  add(op, {text="pWpNT: 05/05"}) add(op, {text=""})
  add(op, {text="pW/aC: 040/100"}) add(op, {text=""})

  add(op, {text="mOVE2: sLFdES", disabled=true}) add(op, {text="", disabled=true})
  add(op, {text="lEARN: wATER"}) add(op, {text=""})
  add(op, {text="pWpNT: 05/05"}) add(op, {text=""})
  add(op, {text="pW/aC: 040/100"}) add(op, {text=""})

  add(op, {text="mOVE3: sLFdES", disabled=true}) add(op, {text="", disabled=true})
  add(op, {text="lEARN: wATER"}) add(op, {text=""})
  add(op, {text="pWpNT: 05/05"}) add(op, {text=""})
  add(op, {text="pW/aC: 040/100"}) add(op, {text=""})

  add(op, {text="mOVE4: sLFdES", disabled=true}) add(op, {text="", disabled=true})
  add(op, {text="lEARN: wATER"}) add(op, {text=""})
  add(op, {text="pWpNT: 05/05"}) add(op, {text=""})
  add(op, {text="pW/aC: 040/100"}) add(op, {text=""})

  add(op, {text="bATTLE fLAGS", disabled=true}) add(op, {text="", disabled=true})
  add(op, {text="aCTIVE"}) -- set to move index (1-4) for moves that lock itself for multiple turns (outrage, petal dance, thrash, sky attack, razor wind, skull bash, solarbeam, bide, hyper beam) (need to ensure that pp isnt zero when on a move lock)
  add(op, {text="bENCHD"}) -- set to move index (1-4) for moves that lock itself for multiple turns (outrage, petal dance, thrash, sky attack, razor wind, skull bash, solarbeam, bide, hyper beam) (need to ensure that pp isnt zero when on a move lock)
  add(op, {text="mVlOCK"}) -- set to move index (1-4) for moves that lock itself for multiple turns (outrage, petal dance, thrash, sky attack, razor wind, skull bash, solarbeam, bide, hyper beam) (need to ensure that pp isnt zero when on a move lock)
  add(op, {text="bIDE"})   -- damage counter for bide
  add(op, {text="dFNcRL"}) -- flag if dFNcRL was used (makes rollout stronger)
  add(op, {text="dISABL"}) -- turn timer for disable, encore
  add(op, {text="cONFUS"}) -- turn timer for confusion minor status
  add(op, {text="rOLOUT"}) -- turn timer for rollout
  add(op, {text="dSTbND"}) -- turn timer for destiny bond (only 1 turn)
  add(op, {text="lOCKoN"}) -- turn timer for lockon/mindreader. set on target. turn timer is 1.
  add(op, {text="dIG"})    -- turn timer for dig set to 1
  add(op, {text="fLY"})    -- turn timer for fly set to 1
  add(op, {text="fRYcTR"}) -- turn counter for fury cutter
  add(op, {text="rAGE"})   -- turn counter for rage
  add(op, {text="tOXIC"})  -- turn counter for turns poisoned
  add(op, {text="pERsNG"}) -- turn counter for perish song. set on both target and user -- counter needs to happen at the end of both turns. -- pkmn can survive with endure/focus band
  add(op, {text="pDEcNT"}) -- turn counter for protect/detect/endure (determines success rate)
  add(op, {text="sUBSTU"}) -- hp substitute hp
  add(op, {text="nGTMAR"}) -- boolean whether or not sleeping
  add(op, {text="tRFORM"}) -- boolean whether or not transformed. can't transform twice to prevent inifinite battles.
  add(op, {text="lECHsD"}) -- boolean whether or not seeded
  add(op, {text="cURSE"})  -- boolean whether or not cursed
  add(op, {text="mIST"})   -- boolean whether on not protected by negative stat mods
  add(op, {text="tRAPPD"}) -- set to the other pkmn? but also a turn counter... so i'm unsure. this is bind/whirlpool/firespin/clamp/wrap
  add(op, {text="mEANlK"}) -- set to the other pkmn? mean look or spider web prevents switching (baton pass works)
  add(op, {text="aTRACT"}) -- set to the other pkmn? that way it doesn't work when they are switched out (and resets).
  add(op, {text="fORsGT"}) -- set to the other pkmn? boolean whether or not foresighted (set on target)

  -- add(op, {text="tEAM fLAGS", disabled=true}) add(op, {text="", disabled=true})
  add(op, {text="fTRsGT"}) -- turn timer for future sight
  add(op, {text="sAFgRD"}) -- turn timer for safeguard
  add(op, {text="lITsCR"}) -- turn timer for light screen
  add(op, {text="rFLECT"}) -- turn timer for reflect
  add(op, {text="sPIKES"}) -- boolean whether or not spikes exist

  -- battle flags
  add(op, {text="sNDsTR"}) -- turn timer for sandstorm
  add(op, {text="rAIdNC"}) -- turn timer for raining
  add(op, {text="sUNdAY"}) -- turn timer for harsh sunlight

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
  if @S_EDITSTAT < 4 then f_print_top("eDIT: mOVE ", @S_EDITSTAT+1)
  elseif @S_EDITSTAT == 4 then f_print_top"eDIT: iTEM"
  elseif @S_EDITSTAT == 5 then f_print_top"eDIT: gENDER"
  elseif @S_EDITSTAT == 6 then f_print_top"eDIT: lEVEL"
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

|[f_dp_pkpreview]| function() -- TODO: DELETE ME
  local pkmn_ind = @S_BROWSE
  f_draw_pkmn(pkmn_ind, 13+(g_preview_timer > 0 and (rnd(3)\1-1) or 0), 1+2, 16)
end $$

|[f_dp_pkstat]| function(i)
  if i == 7 then
    local y = 6
    -- rectfill(-30-1,    -9-9-2-1-1+y-1,    27+1,    -3+4-1-1+y,     C_3)
    -- rectfill(-30-1+1,  -9-9-2-1-1-1+y-1,  27+1-1,  -3+4-1-1+1+y,   C_3)
    -- rectfill(-30-1,  -9-9-2-1-1-1+y-1-1,  27+1,  -3+4-1-1+1+y+1,   C_3)
    local pkmn_ind = @S_BROWSE
    local pkmn = c_pokemon[@S_BROWSE]
    f_draw_pkmn(pkmn_ind, 2-8-20+(g_preview_timer > 0 and (rnd(3)\1-1) or 0), -8+1-10-1-1+y+3-3, 16)
    -- rectfill(-9-20, -22+6+y+8+7, 10+16-20-15-3, -22+6+y+8+7, C_2)
    rectfill(-9+4, -18, -9+4, 6, C_2)
    -- print(pkmn.name,  4-9,  -22+y-1, C_2)
    -- print("-"..c_type_names[pkmn.type1+1], 4 -9, -22+8+y, C_2)
    -- print("-"..c_type_names[pkmn.type2+1], 4 -9, -22+8+8+1+y, C_2)

    -- print("h: 3.2M",  4-9,  -22+y-1, C_2)
    -- print("w: 123KG", 4 -9, -22+8+y, C_2)
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

|[f_l_pkpreview]| function()
  deli(g_gridstack)
end $$

|[f_s_pkpreview]| function()
  g_preview_timer = 20
  return @S_BROWSE
end $$

|[f_l_pkstat]| function()
  deli(g_gridstack)
end $$

|[f_s_pkstat]| function()
  g_preview_timer = 20
  return @S_BROWSE
  -- add(g_gridstack, g_grid_pkpreview)
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

|[f_s_editlevl]| function()
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  pkmn.level = @S_EDITLEVL+1
  f_save_party_pkmn(pkmn, @S_TEAM, @S_TEAME)
  deli(g_gridstack)
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
  ;p_pkpreview; ,1 ,1 ,2 ,2  ,60 ,40 ,~f_dp_pkpreview   ,~f_nf
  ;p_pkstat;    ,2 ,4 ,2 ,4  ,30 ,9  ,~f_dp_pkstat      ,~f_nf

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
  ;;,g_grid_pkpreview ,S_PKPREVIEW ,~p_pkpreview ,~t_browse    ,~f_op_def,       ~f_s_pkpreview  ,~f_l_pkpreview ,~f_browselr

  ;;,g_grid_pkstat    ,S_PKSTAT    ,~p_pkstat    ,~t_browse    ,~f_op_pkstat,    ~f_s_pkstat     ,~f_l_pkstat,   ,~f_browselr

  ;;,g_grid_editstat  ,S_EDITSTAT  ,~p_editstat  ,~t_editstat  ,~f_op_editstat,  ~f_s_editstat   ,~f_l_browse,   ,~c_no
  ;;,g_grid_editmove  ,S_EDITMOVE  ,~p_edit4     ,~t_edit4     ,~f_op_editmove,  ~f_s_editmove   ,~f_l_browse,   ,~c_no
  ;;,g_grid_edititem  ,S_EDITITEM  ,~p_edititem  ,~t_edititem  ,~f_op_edititem,  ~f_s_edititem   ,~f_l_browse,   ,~c_no
  ;;,g_grid_editlevl  ,S_EDITLEVL  ,~p_edititem  ,~t_edititem  ,~f_op_editlevl,  ~f_s_editlevl   ,~f_l_browse,   ,~c_no
  ;;,g_grid_editpkmn  ,S_BROWSE    ,~p_browse    ,~t_browse    ,~f_op_browse,    ~f_s_editpkmn   ,~f_l_browse,   ,~c_no

  ;;,g_grid_pickedit  ,S_TEAM      ,~p_edit      ,~t_edit      ,~f_op_edit,      ~f_s_edit       ,~f_l_browse,   ,~c_no
  ;;,g_grid_pickleag  ,S_TEAM      ,~p_edit      ,~t_league    ,~f_op_edit,      ~f_s_league     ,~f_l_browse,   ,~c_no,      ~c_yes
  ;;,g_grid_pickplr1  ,S_TEAM      ,~p_edit      ,~t_versus    ,~f_op_edit,      ~f_s_versus     ,~f_l_browse,   ,~c_no,      ~c_yes

  ;;,g_grid_pickspot  ,S_TEAME     ,~p_editteam  ,~t_editteam  ,~f_op_editteam,  ~f_s_editteam   ,~f_l_browse,   ,~c_no
  ;;,g_grid_picktrnr  ,S_TEAML     ,~p_teamed    ,~t_league    ,~f_op_teams,     ~f_nf           ,~f_l_browse,   ,~c_no
  ;;,g_grid_pickplr2  ,S_TEAM2     ,~p_edit      ,~t_versus    ,~f_op_edit,      ~f_nf           ,~f_l_browse,   ,~c_no,      ~c_yes
]])
