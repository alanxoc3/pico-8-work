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

  for i=1,252 do
    add(op, {data=g_lock_pokemon[i] and i or 0, disabled=not g_lock_pokemon[i]})
  end

  return op
end $$

|[f_op_edit]| function(sumdisable)
  local op = {}
  for partynum=0,3 do
    local sumind = 0
    local inds = {}
    for pkmnnum=0,5 do
      local pkmn = f_get_party_pkmn(partynum, pkmnnum)
      sumind += pkmn.num
      add(inds, pkmn.num)
    end
    add(op, {data=inds, disabled=sumdisable and sumind==0})
  end
  return op
end $$

|[f_op_editparty]| function()
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

  add(op, {text="lV "..pkmn.level, select=function()
    poke(S_EDITLEVEL, pkmn.level-1)
    add(g_gridstack, g_grid_editlevel)
  end})

  add(op, {text="dELETE", select=function()
    memset(S_PARTY1+@S_TEAM*48+@S_TEAME*8, 0, 8)
    deli(g_gridstack)
  end})
  return op
end $$

|[f_op_editmove]| function()
  local op = {}
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  for ind, m in ipairs(pkmn.possible_moves) do
    -- TODO: token crunching here!
    add(op, {text=g_lock_move[m.num] and c_move_names[m.num] or f_strtoq(c_move_names[m.num]), disabled=pkmn.seen_moves[ind-1] or not g_lock_move[m.num]})
  end

  -- for m in all(pkmn.teach) do add(op, {text=c_move_names[m+1]}) end
  -- for m in all(pkmn.event) do add(op, {text=c_move_names[m+1]}) end
  return op
end $$

|[f_op_edititem]| function()
  local op = {}
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)

  for i=0,I_LEN do
    add(op, {text=g_lock_item[i] and c_item_names[i] or f_strtoq(c_move_names[i]), disabled=pkmn.item == i or not g_lock_item[i]})
  end

  return op
end $$

|[f_op_editlevel]| function()
  local op = {}
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  for i=1,100 do
    add(op, {text="lV "..i, disabled=i==pkmn.level})
  end
  return op
end $$

|[f_op_pkstat]| function()
  local op = {}
  local pkmn = c_pokemon[@g_grid_browse[1].mem]

  local genders = ""
  -- if pkmn.gender_item & GP_MALE > 0 then genders ..= "m" end
  -- if pkmn.gender_item & GP_FEMA > 0 then
  --   if #genders > 0 then genders ..= "/" end
  --   genders ..= "f" end
  -- if #genders == 0 then genders ..= "n" end

  --add(op, {text="bASE sTATS", header=true})
  --add(op, {text=""})

  -- add(op, {text="hP:"..pkmn.hp})
  -- add(op, {text="sP:"..pkmn.spd})
  -- add(op, {text="aT:"..pkmn.att})
  -- add(op, {text="dF:"..pkmn.def})
  -- add(op, {text="sA:"..pkmn.sat})
  -- add(op, {text="sD:"..pkmn.sdf})
  -- add(op, {text="gD:"..genders})
  -- add(op, {text="lV:50"})
  return op

  --if #pkmn.learn > 0 then
  --  add(op, {text="lEARN mOVES", disabled=true, header=true})
  --  add(op, {text="", disabled=true, header=true})

  --  for m in all(pkmn.learn) do
  --    add(op, {text=c_move_names[m+1]})
  --  end

  --  if #op % 2 == 1 then add(op, {text="", disabled=true}) end
  --end

  --if #pkmn.teach > 0 then
  --  add(op, {text="tEACH mOVES", header=true, disabled=true})
  --  add(op, {text="", disabled=true})

  --  for m in all(pkmn.teach) do
  --    local movename = c_move_names[m+1]
  --    if not g_lock_move[m] then
  --      movename = f_strtoq(movename)
  --    end
  --    add(op, {text=movename})
  --  end

  --  if #op % 2 == 1 then add(op, {text="", disabled=true}) end
  --end

  --if #pkmn.event > 0 then
  --  add(op, {text="eVENT mOVES", header=true, disabled=true})
  --  add(op, {text="", disabled=true})

  --  for m in all(pkmn.event) do
  --    local movename = c_move_names[m+1]
  --    if not g_lock_move[m] then
  --      movename = f_strtoq(movename)
  --    end
  --    add(op, {text=movename})
  --  end

  --  if #op % 2 == 1 then add(op, {text="", disabled=true}) end
  --end
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

|[f_dt_edit2]| function(i, is_sel)
  local pkstr_arr = {}
  local pkstr_lens = split'3,3,3,2'

  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)

  for i=1,4 do -- in ipairs(pkmn.view_moves) do
    pkstr_arr[i] = sub(c_move_names[pkmn.view_moves[i] or 0], 1, pkstr_lens[i])
  end

  local pkstr = pkstr_arr[1].."-"..pkstr_arr[2].."-"..pkstr_arr[3].."-"..pkstr_arr[4]
  print("\^y7\f3#"..(@S_TEAME+1).." \f4"..(c_pkmn_names[pkmn.num]).."\n\f1"..pkstr, 1, 1, C_1)
end $$

|[f_dt_editstat]| function(i, is_sel)
  if @S_EDITSTAT < 4 then
    print("\f3#"..(@S_EDITSTAT+1).." \f4mOVE", 1, 1)
  end
end $$

|[f_dt_editmove]| function(i, is_sel)
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  if @S_EDITSTAT < 4 then
    print("\f3#"..(@S_EDITMOVE+1).." \f4"..pkmn.possible_moves[@S_EDITMOVE+1].method, 1, 1)
  end
end $$

|[f_dt_edititem]| function(i, is_sel)
  print("\f3hello", 1, 1)
  -- local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  -- if @S_EDITSTAT < 4 then
  --   print("\f3#"..(@S_EDITMOVE+1).." \f4"..pkmn.possible_moves[@S_EDITMOVE+1].method, 1, 1)
  -- end
end $$

|[f_dp_edit2]| function(i, is_sel, gridobj)
  f_draw_pkmn(gridobj.data, 1, 1, 16, false, is_sel)
end $$

|[f_dt_browse]| function(i, is_sel)
  local numstr = tostr((@S_BROWSE+1)%252)
  local pkmn = c_pokemon[@S_BROWSE+1]

  while #numstr < 3 do numstr = "0"..numstr end
  local namestr, type1, type2 = pkmn.name, c_type_names[pkmn.type1+1], ""

  if pkmn.type2 > T_NONE then
    type2 = c_type_names[pkmn.type2+1]
  end

  if not g_lock_pokemon[@S_BROWSE+1] then
    namestr, type1, type2 = f_strtoq(namestr), f_strtoq(type1), f_strtoq(type2)
  end

  local str = "\^y7\f3#"..numstr.." \f4"..namestr.."\n\f1"..type1.." "..type2

  print(str, 1, 1)
end $$

|[f_dt_edit]| function(i, is_sel)
  local pkstr_arr = {}
  local pkstr_lens = split'3,3,1,1,1,2'
  for ii=0,5 do
    local pkmn = f_get_party_pkmn(@S_TEAM, ii)
    add(pkstr_arr, sub(c_pkmn_names[pkmn.num], 1, pkstr_lens[ii+1]))
  end

  local pkstr = pkstr_arr[1].."-"..pkstr_arr[2].."-"..pkstr_arr[3]..pkstr_arr[4]..pkstr_arr[5].."-"..pkstr_arr[6]
  print("\^y7\f3#"..(@g_cg_m.mem+1).." \f4tEAM\n\f1"..pkstr, 1, 1, C_1)
end $$

|[f_dt_league]| function()
  -- TODO: save tokens / compression by extracting out this if.
  if g_cg_m.name == 'g_grid_league' then
    print("\^y7\f1pLR: \f4tEAM "..(@S_TEAM+1).."\f1\ncPU: \f3"..c_trnr_names[@S_TEAML+1], 1, 1)
  else
    print("\^y7\f1pLR: \f3tEAM "..(@S_TEAM+1).."\f1\ncPU: \f4"..c_trnr_names[@S_TEAML+1], 1, 1)
  end
end $$

|[f_dt_versus]| function()
  if g_cg_m.name == 'g_grid_versus' then
    print("\^y7\f1pLR1: \f4tEAM "..(@S_TEAM+1).."\f1\npLR2: \f3tEAM "..(@S_TEAM2+1), 1, 1)
  else
    print("\^y7\f1pLR1: \f3tEAM "..(@S_TEAM+1).."\f1\npLR2: \f4tEAM "..(@S_TEAM2+1), 1, 1)
  end
end $$

|[f_dp_title]| function(i, is_sel)
  print("\^w\^tpicodex", 2, 1,  4)
  print("dUAL vERSION",  2, 12, 1)

  -- todo: give title pokemon correct colors
  f_draw_pkmn(g_title_l, -8+15+(mid(-1, -.75, cos(0+g_title_an_timer/300))+.75)*4*26   + (g_title_an_timer > 190 and g_title_an_timer < 220 and (rnd(3)\1-1) or 0), 20, 16)
  f_draw_pkmn(g_title_r, 50-15-(mid(-1, -.75, cos(.5+g_title_an_timer/300))+.75)*4*26  + (g_title_an_timer > 40  and g_title_an_timer < 70  and (rnd(3)\1-1) or 0), 20, 16, true)
end $$

|[f_dp_title_update]| function()
  g_title_an_timer = (g_title_an_timer+1)%300

  if g_title_an_timer == 0 then
    g_title_r = rnd"252"\1+1
  elseif g_title_an_timer == 150 then
    g_title_l = rnd"252"\1+1

  elseif g_title_an_timer == 50-10  then f_minisfx(g_title_r-1)
  elseif g_title_an_timer == 200-10 then f_minisfx(g_title_l-1)
  end
end $$

|[f_dp_pkpreview]| function(i, is_sel)
  local pkmn_ind = @S_BROWSE+1
  f_draw_pkmn(pkmn_ind, 13+(g_preview_timer > 0 and (rnd(3)\1-1) or 0), 1+2, 32)
end $$

|[f_dp_pkstat]| function(i, is_sel, obj)
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
    add(g_gridstack, g_grid_edit)
  elseif @g_cg_m.mem == 2 then
    add(g_gridstack, g_grid_league)
  elseif @g_cg_m.mem == 3 then
    add(g_gridstack, g_grid_versus)
  end
end $$

|[f_l_pkpreview]| function()
  deli(g_gridstack)
end $$

|[f_s_pkpreview]| function()
  g_preview_timer = 20
  return @g_grid_browse[1].mem
end $$

|[f_l_pkstat]| function()
  deli(g_gridstack)
end $$

|[f_s_pkstat]| function()
  add(g_gridstack, g_grid_pkpreview)
end $$

|[f_s_versus]| function()
  add(g_gridstack, g_grid_versus2)
end $$

|[f_s_league]| function()
  add(g_gridstack, g_grid_league2)
end $$

|[f_s_edit]| function()
  add(g_gridstack, g_grid_edit2)
end $$

|[f_s_edit2]| function()
  --local party_loc = S_PARTY1+(@S_TEAM)*42
  --local pkmn_loc = party_loc+@S_TEAME*7
  local pkmn = f_get_party_pkmn(@S_TEAM, @S_TEAME)
  if pkmn.num > 0 then -- includes missingno at 252
    add(g_gridstack, g_grid_edit3)
  else
    add(g_gridstack, g_grid_editpkmn)
  end
end $$

|[f_s_editstat]| function()
  gridpo[@S_EDITSTAT+1].select()
end $$

|[f_s_editmove]| function()
  -- poke(@S_TEAM+@S_TEAME*42+1+@S_EDITSTAT
  -- f_l_browse()
end $$

|[f_s_edititem]| function()
  -- poke(@S_TEAM+@S_TEAME*42+1+@S_EDITSTAT
  -- f_l_browse()
end $$

|[f_l_title]| function()
  return SFX_ERROR
end $$

|[f_browselr]| function(dir)
  local prev = @S_BROWSE
  local next = prev+1
  if dir > 0 then
    for i=next+1,252,1 do
      if g_lock_pokemon[i] then
        next = i
        break
      end
    end
  elseif dir < 0 then
    for i=prev,0,-1 do
      if g_lock_pokemon[i] then
        next = i
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
  --            w  vh x  y   cw   ch draw func        update func
   p_browse;    ,6 ,4 ,2 ,2  ,10 ,10 ,~f_dp_browse    ,~f_nf
  ;t_browse;    ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_browse    ,~f_nf
  ;p_title;     ,1 ,1 ,2 ,2  ,60 ,40 ,~f_dp_title     ,~f_dp_title_update
  ;t_title;     ,2 ,2 ,2 ,44 ,30 ,9  ,~f_nf           ,~f_nf
  ;p_pkpreview; ,1 ,1 ,2 ,2  ,60 ,40 ,~f_dp_pkpreview ,~f_nf
  ;p_pkstat;    ,2 ,4 ,2 ,4  ,30 ,9  ,~f_dp_pkstat    ,~f_nf

  ;t_edit;      ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_edit      ,~f_nf
  ;p_edit;      ,2 ,2 ,2 ,2  ,30 ,20 ,~f_dp_edit      ,~f_nf

  ;t_edit2;     ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_edit2     ,~f_nf
  ;p_edit2;     ,3 ,2 ,2 ,2  ,20 ,20 ,~f_dp_edit2     ,~f_nf

  ;t_edit3;     ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_editstat  ,~f_nf
  ;p_edit3;     ,2 ,4 ,2 ,4  ,30 ,9  ,~f_nf           ,~f_nf

  ;t_edit4;     ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_editmove  ,~f_nf
  ;p_edit4;     ,2 ,4 ,2 ,4  ,30 ,9  ,~f_nf           ,~f_nf

  ;t_edititem;  ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_edititem  ,~f_nf
  ;p_edititem;  ,2 ,4 ,2 ,4  ,30 ,9  ,~f_nf           ,~f_nf

  ;t_versus;    ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_versus    ,~f_nf
  ;t_league;    ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_league    ,~f_nf

  ;p_teamed;    ,2 ,4 ,2 ,4  ,30 ,9  ,~f_nf           ,~f_nf
  ;t_teamed;    ,1 ,1 ,2 ,45 ,60 ,16 ,~f_dt_edit      ,~f_nf

  -- name              active mem  main grid     info grid  mg op mkfunc      select func     leave func
  ;;,g_grid_browse    ,S_BROWSE    ,~p_browse    ,~t_browse    ,~f_op_browse,    ~f_s_pkstat     ,~f_l_browse,   ,~c_no
  ;;,g_grid_title     ,S_TITLE     ,~t_title     ,~p_title     ,~f_op_title,     ~f_s_title      ,~f_l_title,    ,~c_no
  ;;,g_grid_pkpreview ,S_PKPREVIEW ,~p_pkpreview ,~t_browse    ,~f_op_def,       ~f_s_pkpreview  ,~f_l_pkpreview ,~f_browselr
  ;;,g_grid_pkstat    ,S_PKSTAT    ,~p_pkstat    ,~t_browse    ,~f_op_pkstat,    ~f_s_pkstat     ,~f_l_pkstat,   ,~c_no
  ;;,g_grid_edit      ,S_TEAM      ,~p_edit      ,~t_edit      ,~f_op_edit,      ~f_s_edit       ,~f_l_browse,   ,~c_no
  ;;,g_grid_edit2     ,S_TEAME     ,~p_edit2     ,~t_edit2     ,~f_op_editparty, ~f_s_edit2      ,~f_l_browse,   ,~c_no
  ;;,g_grid_edit3     ,S_EDITSTAT  ,~p_edit3     ,~t_edit3     ,~f_op_editstat,  ~f_s_editstat   ,~f_l_browse,   ,~c_no
  ;;,g_grid_editmove  ,S_EDITMOVE  ,~p_edit4     ,~t_edit4     ,~f_op_editmove,  ~f_s_editmove   ,~f_l_browse,   ,~c_no
  ;;,g_grid_edititem  ,S_EDITITEM  ,~p_edititem  ,~t_edititem  ,~f_op_edititem,  ~f_s_edititem   ,~f_l_browse,   ,~c_no
  ;;,g_grid_editlevel ,S_EDITLEVEL ,~p_edititem  ,~t_edititem  ,~f_op_editlevel, ~f_s_edititem   ,~f_l_browse,   ,~c_no
  ;;,g_grid_editpkmn  ,S_BROWSE    ,~p_browse    ,~t_browse    ,~f_op_browse,    ~f_nf           ,~f_l_browse,   ,~c_no

  ;;,g_grid_league    ,S_TEAM      ,~p_edit      ,~t_league    ,~f_op_edit,      ~f_s_league     ,~f_l_browse,   ,~c_no, ~c_yes
  ;;,g_grid_league2   ,S_TEAML     ,~p_teamed    ,~t_league    ,~f_op_teams,     ~f_nf           ,~f_l_browse,   ,~c_no
  ;;,g_grid_versus    ,S_TEAM      ,~p_edit      ,~t_versus    ,~f_op_edit,      ~f_s_versus     ,~f_l_browse,   ,~c_no, ~c_yes
  ;;,g_grid_versus2   ,S_TEAM2     ,~p_edit      ,~t_versus    ,~f_op_edit,      ~f_nf           ,~f_l_browse,   ,~c_no, ~c_yes
]])
