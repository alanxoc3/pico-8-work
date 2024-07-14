_g=setmetatable({},{__index=_ENV})
_ENV=_g
function f_zobj_eval(val,table,parameters)
if ord(val)==126 then return table[sub(val,2)]
elseif val=="@" then return deli(parameters,1)
elseif val=="#" then return{}end
return val ~="" and val or nil
end
function f_zobj_set(table,str,...)
local params,statements,dest={...},split(str,";"),table
foreach(statements,function(statement)
local tokens=split(statement)
if #tokens>1 then
if tokens[1]=="" then
foreach(tokens,function(val)
add(dest,f_zobj_eval(val,table,params))
end)
else
for i=1,#tokens,2 do
dest[tokens[i]]=f_zobj_eval(tokens[i+1],table,params)
end
end
dest=table
else
if statement=="" then statement=#dest+1 end
if type(dest[statement])~="table"then
dest[statement]={}
end
dest=dest[statement]
end
end)
return table
end
function f_zobj_setmeta(parent,...)
return f_zobj_set(setmetatable({},{__index=parent}),...)
end
function f_zobj(...)
return f_zobj_setmeta(_g,...)
end
f_zobj_set(_g,"c_pokemon,#,c_moves,#,c_trainers,#,c_items,#,g_init_peek_loc,0x1fff,c_yes,@,c_no,@,c_empty,@,f_nop,@,g_palette,0,g_preview_timer,0,g_title_timer,0,g_title_l,254,g_title_r,254,g_msg_top, ,g_msg_bot, ,g_bat_func,,g_gridstack,#,g_title_an_timer,70",true,false,"",function(...)return...end)
f_zobj_set(_g,"f_zobj,@,f_zobj_set,@,f_zobj_eval,@,f_zcall,@,f_refresh_top,@,f_add_to_ui_stack,@,f_pop_ui_stack,@,f_getsel,@,f_setsel,@,f_create_gridpair,@,f_update_grid,@,f_draw_grid,@,f_addop_text,@,f_minisfx,@,f_flr_rnd,@,f_in_split,@,f_roundrect,@,f_draw_pkmn,@,f_strtoq,@,f_moveutil_hpchange,@,f_moveutil_dmgself,@,f_moveutil_dmgother,@,f_moveutil_movemod,@,f_moveutil_typeadv,@,f_moveutil_calc_move_damage,@,f_move_splash,@,f_move_recover,@,f_move_tackle,@,f_move_seismictoss,@,f_move_psywave,@,f_move_superfang,@,f_move_falseswipe,@,f_move_submission,@,f_move_struggle,@,f_move_multihit_set,@,f_move_barrage,@,f_move_doublekick,@,f_move_flail,@,f_move_return,@,f_move_frustration,@,f_move_present,@,f_move_magnitude,@,f_move_hiddenpower,@,c_move_funcs,@,c_move_names,@,c_trnr_names,@,c_type_names,@,c_item_names,@,c_team_names,@,c_pkmn_names,@,c_gender_names,@,c_major_names_long,@,c_major_names_short,@,c_movemethod_names,@,c_statmod_names,@,c_palettes,@,c_palette_names,@,c_types,@,f_init_peek_inc,@,f_unlock,@,f_update_locks,@,f_create_spot,@,f_get_edit_op_pkmn,@,f_op_template_edit,@,f_add_stat_move,@,f_add_stat_info,@,f_add_stat_preview,@,f_add_stat,@,f_print_top,@,f_print_bot,@,f_get_move_texts,@,f_prefix_space,@,f_prefix_zero,@,f_dt_browse_template,@,f_add_battle,@,f_create_active,@,f_create_player,@,f_get_other_pl,@,f_set_pself,@,f_get_live_pkmn,@,f_get_next_active,@,f_end_battle,@,f_newaction,@,f_addaction,@,f_pkmn_comes_out,@,f_pop_next_action,@,f_set_player_priority,@,f_movelogic,@,f_start_turn,@,f_start_battle,@,f_mkpkmn,@,f_team_party,@,f_fill_team,@,f_team_league,@,f_get_party_pkmn,@,f_save_party_pkmn,@,f_stat_crit,@,f_stat_evac,@,f_stat_calc,@,f_op_def,@",f_zobj,f_zobj_set,f_zobj_eval,function(func,text,...)
foreach(f_zobj(text,...),function(params)
func(unpack(params))
end)
end,function()
g_top_grid.op,g_top_grid.preview_op,g_top_grid.lrlist={},{},{}
g_top_grid.gridpofunc(g_top_grid,unpack(g_top_grid.params))
end,function(_ENV,init_func)
add(g_gridstack,{obj=_ENV,init_func=init_func or f_nop})
end,function(init_func)
deli(g_gridstack)
g_gridstack[#g_gridstack].init_func=init_func or f_nop
end,function(gridname)
return@_g[gridname].g_cg_m.sel
end,function(gridname,val)
poke(_g[gridname].g_cg_m.sel,val)
end,function(name,memloc,main_grid_spec,info_grid_spec,info_grid_draw,main_op_func,main_sel_func,main_leave_func,lrbasegrid,static,...)
_g[name]=f_zobj("g_cg_m,@,g_cg_s,@,gridpofunc,@,params,@",
f_zobj("sel,@,view,@,name,@,selfunc,@,leavefunc,@,lrbasegrid,@,static,@,w,@,vh,@,x,@,y,@,cw,@,ch,@,selw,@,selh,@",memloc,memloc+1,name,main_sel_func,main_leave_func,lrbasegrid,static,unpack(main_grid_spec)),
f_zobj("sel,@,view,@,static,~c_no,disabled,~c_yes,name,@,df,@,w,@,vh,@,x,@,y,@,cw,@,ch,@,selw,@,selh,@",0x5ec6,0x5ec6+1,name,info_grid_draw,unpack(info_grid_spec)),
main_op_func,
{...}
)
end,function(_ENV,gridobj)
local evalfunc=function(num,mmin,mmax,b0,b1,l)
local off=(b1 and l or 0)-(b0 and l or 0)
local newnum=mid(mmin,min(#gridobj-1,mmin+mmax),num+(static and 0 or off))
if newnum==num and off ~=0 then
f_minisfx(253)
elseif newnum ~=num then
f_minisfx(255)
end
return newnum
end
local prevsel=@sel
if lrbasegrid then
local dir=(btnp"1" and 1 or 0)-(btnp"0" and 1 or 0)
local lst=_g[lrbasegrid].op
local cur=f_getsel(lrbasegrid)
local nxt=cur
if dir>0 then
for i=cur+2,#lst,1 do
if lst[i].lrvalid then
nxt=i-1
break
end
end
elseif dir<0 then
for i=cur-1,0,-1 do
if lst[i+1].lrvalid then
nxt=i
break
end
end
end
if nxt ~=cur then
f_minisfx(255)
f_setsel(lrbasegrid,nxt)
f_refresh_top()
elseif dir ~=0 then
f_minisfx(253)
end
else
poke(sel,evalfunc(@sel,@sel\w*w,w-selw,btnp"0",btnp"1",selw))
end
poke(sel,evalfunc(@sel,@sel%w,(#gridobj-1)\w*w\(selh*selw)*selh*selw,btnp"2",btnp"3",w*selh))
if@sel ~=prevsel then
f_refresh_top()
end
if@sel\w-vh+1>@view then poke(view,(@sel\w-vh+1)\selh*selh+(selh-1))end
if@sel\w<@view+selh-1 then poke(view,@sel\w\selh*selh)end
poke(view,mid(0,@view,(#gridobj-1)\w-vh+1))
if btnp"4" then
f_minisfx(leavefunc()or 254)
elseif btnp"5" then
if(selw*selh>1 or disabled or lrfunc or not gridobj[@sel+1].disabled)then
f_minisfx(selfunc()or 252)
else
f_minisfx(253)
end
end
end,function(_ENV,gridobj,num,view,x,y,active)
printh("static _")
db(_ENV)
local draw_cell_bg=function(j,offx,offy,force)
local i=j+view*w
local obj=gridobj[i+1]
if i>=#gridobj then return true end
local xloc,yloc=x+i%w*cw,y+j\w*ch
camera(-xloc-1,-yloc-1)
local l,r,u,d=0,0,0,0
if force or i==0 then l,u=1,1 end
if i==w-1 then r,u=1,1 end
if force or i==#gridobj-1 then r,d=1,1 end
if i==(#gridobj-1)\w*w then l,d=1,1 end
local c=2
if obj.disabled then
c=1
end
rectfill(offx-1+l,offy-1,offx+cw-2-r,offy+ch-2,c)
rectfill(offx-1,offy-1+u,offx+cw-2,offy+ch-2-d,c)
end
local draw_cell_fg=function(j)
local i=j+view*w
local obj=gridobj[i+1]
if i>=#gridobj then return true end
local xloc,yloc=x+i%w*cw,y+j\w*ch
clip(xloc,yloc,cw,ch)
camera(-xloc-1,-yloc-1)
local c=1
if obj.disabled then
c=2
end
print(obj.text or "",1,1,c)
if obj.draw then
obj.draw(i,i==num,obj)
end
clip()
end
for j=0,vh*w-1 do if draw_cell_bg(j,0,0)then break end end
for j=0,vh*w-1 do if draw_cell_fg(j)then break end end
if not disabled then
pal{3,3,3}
for ss=0,selh-1 do
for sw=0,selw-1 do
for i=-1,1 do
for j=-1,1 do
draw_cell_bg(num-view*w+ss*selw+sw,i,j,static)
end
end
end
end
pal()
for ss=0,selh-1 do
for sw=0,selw-1 do
draw_cell_bg(num-view*w+ss*selw+sw,0,0,static)
end
end
for ss=0,selh-1 do
for sw=0,selw-1 do
draw_cell_fg(num-view*w+ss*selw+sw)
end
end
end
camera()
end,function(op,text)
add(op,{draw=function()print(text,1,1,1)end})
end,function(num)
if num<252 then
g_cur_pkmn_cry=num
end
sfx(num\4,num<252 and 0 or 1,num%4*8,8)
end,function(n)return flr(rnd(n))end,function(val,str)
for m in all(split(str))do
if m==val then
return true
end
end
end,function(x1,y1,x2,y2,c)
rectfill(x1,y1+1,x2,y2-1,c)
if x2-x1>2 then
rectfill(x1+1,y1,x2-1,y2,c)
end
end,function(num,x,y,width,flip,sel,disabled,isoutline,platform)
local og_x=x
if not disabled and not isoutline and stat"46">-1 and g_cur_pkmn_cry==num then
x+=sin(g_shake_timer/4)
end
local in_c=isoutline and 2 or sel and 3 or disabled and 1 or 3
local out_c=disabled and(sel and 1 or 2)or sel and 2 or 1
if num==252 then
rectfill(x+width/2-1,y+width/2-1,x+width/2,y+width/2,out_c)
return
end
local row=num/8\1
local col=num%8
local scale=max(width\16,1)
local masks={8,4,2,1}
local colordrawfunc=function(ix,iy,c)
local mask=masks[num\64+1]
for i=1,15 do
if i & mask==0 then
palt(i,true)
else
pal(i,c)
end
end
palt(mask,false)
pal(mask,c)
sspr(col*16,row%8*16,16,16,ix,iy,width,width,flip,false)
palt()
pal()
end
if platform then
end
for yy=-scale,scale,scale do
for xx=-scale,scale,scale do
if not(xx==0 and yy==0)then
colordrawfunc(x+xx,y+yy,out_c)
end
end
end
colordrawfunc(x,y,in_c)
end,function(s)
local ns=""
for i=1,#s do ns..="?" end
return ns
end,function(player,amount,callback_function,issub)
local pkmn=player.active
local hp=issub and pkmn.substitute or pkmn.hp
callback_function=callback_function or f_nop
amount=mid(amount>0 and hp or-pkmn.maxhp+hp,amount,0)
local dmgtxt=(amount>0 and "-"or "+")..abs(amount).." hp change"
local hpchange=function()
a_self_active.hp-=amount
if a_self_active.hp<=0 then
a_self_active.base.major=1
end
end
if amount==0 then
return true
else
local amount_str=(amount>0 and "-"or "+")..abs(amount)
local text=issub and "substitute "..amount_str.." hp"or amount_str.." hp change"
a_addaction(player,text,function()
if issub then
hpchange()
if pkmn.substitute<=0 then
a_addaction(player,
"substitute broke",
function()
callback_function(amount)
end
)
else
callback_function(amount)
end
else
a_addaction(p_selfaction,text,function()
hpchange()
callback_function(amount)
end)
end
end)
end
end,function(dmg)
return f_moveutil_hpchange(p_selfturn,dmg)
end,function(dmg,callback_function)
callback_function=callback_function or f_nop
local advantage,crit=1
if type(dmg)=="table"then
dmg,advantage,crit=f_moveutil_calc_move_damage(dmg,a_self_active,p_otherturn.active)
end
if advantage>0 then
if advantage>1 then a_addaction(p_selfaction,"very effective")
elseif advantage<1 then a_addaction(p_selfaction,"not effective")end
if crit then a_addaction(p_selfaction,"critical hit")end
return f_moveutil_hpchange(p_otherturn,dmg,function(dmg)
callback_function(dmg)
end,p_otherturn.active.substitute>0)
else
a_addaction(p_otherturn,"resists attack")
end
end,function(active,move)
if f_in_split(move.num,"130,129 ")
or move.num==230 and not p_otheraction.nextmove then
return 2
elseif move.num==88 then
return p_selfturn.active.numtimes
end
return 1
end,function(move,defender)
db(c_types[move.pktype])
return(c_types[move.pktype][defender.pktype1]or 1)*(c_types[move.pktype][defender.pktype2]or 1)
end,function(move,attacker,defender)
local attack,defense=attacker:f_stat_calc("specialattack",true),defender:f_stat_calc("specialdefense",true)
if move.pktype%2==1 then
attack,defense=attacker:f_stat_calc("attack",true),defender:f_stat_calc("defense",true)
end
local crit=rnd"1"<f_stat_crit(0)
local stab=(move.pktype==attacker.pktype1 or move.pktype==attacker.pktype2)and 1.5 or 1
local itemdmg=1
local base_damage=mid(
1,999,
.44*move.pow
*mid(10,.2,attack/defense)
*itemdmg
*(crit and 2 or 1)+2
)
local advantage=f_moveutil_typeadv(move,defender)
base_damage=mid(1,999,base_damage*stab*advantage)
base_damage=mid(1,999,base_damage*f_moveutil_movemod(attacker,move)*(rnd".15"+.85))
return base_damage\1,advantage,crit
end,function()a_addaction(p_selfaction,"does nothing")end,function(_ENV)return f_moveutil_hpchange(p_selfaction,-a_self_active.maxhp\2)end,function(_ENV)
f_moveutil_dmgother(_ENV)
end,function(_ENV)f_moveutil_dmgother(spec)end,function()f_moveutil_dmgother(f_flr_rnd"75"+1)end,function()f_moveutil_dmgother(ceil(a_other_active.hp/2))end,function(_ENV)
end,function(_ENV)
f_moveutil_dmgother(_ENV,function(dmg)
f_moveutil_dmgself(ceil(dmg/4))
end)
end,function(_ENV)
f_moveutil_dmgother(_ENV,function(dmg)
f_moveutil_dmgself(ceil(p_selfturn.active.maxhp/4))
end)
end,function(_ENV,hitcount,isresume)
end,function(_ENV)
end,function(_ENV)
end,function(_ENV)
local hplist=f_zobj";,.7,20;;,.4,40;;,.2,80;;,.1,100;;,.05,150"
local perc=p_selfturn.active.hp/p_selfturn.active.maxhp
local pow=200
for pair in all(hplist)do
if perc>pair[1]then
pow=pair[2]
break
end
end
f_moveutil_dmgother(f_zobj_setmeta(_ENV,"pow,@",pow))
end,function(_ENV)
local is_happy=p_selfturn.active.hp/p_selfturn.active.maxhp>=p_otherturn.active.hp/p_otherturn.active.maxhp
f_moveutil_dmgother(f_zobj_setmeta(_ENV,"pow,@",is_happy and 100 or 50))
end,function(_ENV)
local is_sad=p_selfturn.active.hp/p_selfturn.active.maxhp<=p_otherturn.active.hp/p_otherturn.active.maxhp
f_moveutil_dmgother(f_zobj_setmeta(_ENV,"pow,@",is_sad and 100 or 50))
end,function(_ENV)
end,function(_ENV)
local perc,num,pow=rnd()
for i,pair in ipairs(f_zobj";,0,10;;,.05,30;;,.15,50;;,.35,70;;,.65,90;;,.85,110;;,.95,150")do
if perc>=pair[1]then
pow,num=pair[2],i+3
end
end
a_addaction(p_selfturn,"magnitude "..num)
f_moveutil_dmgother(f_zobj_setmeta(_ENV,"pow,@",pow))
end,function(_ENV)
local possible_types={}
for i=1,18 do
local v=f_moveutil_typeadv(f_zobj_setmeta(_ENV,"pktype,@",i),p_otherturn.active)
printh("TYP "..v)
if v>1 then
add(possible_types,i)
end
end
local newpktype=#possible_types>0 and possible_types[f_flr_rnd(#possible_types)+1]or 18
a_addaction(p_selfturn,"type "..c_type_names[newpktype])
pktype=newpktype
f_moveutil_dmgother(f_zobj_setmeta(_ENV,"pow,@",60))
end,f_zobj"0;,f_move_struggle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_barrage,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_seismictoss,20;;,f_move_twineedle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_tackle,0;;,f_move_barrage,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_present,0;;,f_move_splash,0;;,f_move_barrage,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_barrage,0;;,f_move_tackle,0;;,f_move_falseswipe,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_barrage,0;;,f_move_tackle,0;;,f_move_doublekick,2;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_recover,0;;,f_move_splash,0;;,f_move_seismictoss,50;;,f_move_splash,0;;,f_move_barrage,0;;,f_move_splash,0;;,f_move_superfang,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_flail,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_doublekick,2;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_doublekick,3;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_magnitude,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_barrage,0;;,f_move_splash,0;;,f_move_recover,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_seismictoss,40;;,f_move_recover,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_tackle,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_hiddenpower,0;;,f_move_splash,0;;,f_move_frustration,0;;,f_move_return,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_submission,0;;,f_move_submission,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_psywave,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_seismictoss,999;;,f_move_submission,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_flail,0;;,f_move_barrage,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_tackle,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0;;,f_move_splash,0",f_zobj"0,strugl;,acid,acidar,barage,bonclb,bind,clamp,moonlt,lechsd,extrsp,sncbom,twindl,thnshk,glare,gilotn,hypfng,jmpkck,kinsis,lockon,lovkis,macpnc,vicgrp,spican,spikes,spore,cotspr,presnt,vithrw,cmtpnc,drlpck,sndatk,agilty,fryatk,qikatk,falswp,growl,healbl,sing,pound,minmiz,tailwp,dblslp,meghrn,bonrng,convr1,convr2,spark,mlkdrk,morsun,ngtshd,octzok,pinmis,pwdsnw,supfng,firspn,psngas,barier,medtat,ftrsgt,hypnos,psybem,litscr,safgrd,petdnc,charm,synths,swtscn,razlef,psnpwd,slppwd,absorb,stnspr,flail,confsn,slam,constr,amnesa,bubble,splash,hydpmp,mindrd,mist,hrnatk,spiweb,dblkck,swtkis,mtlclw,trform,trikck,gust,twistr,crbham,dizpnc,sludge,painsp,dstbnd,haze,lick,persng,meanlk,cnfray,crschp,smog,karchp,ember,smkscr,beldrm,beatup,scrtch,slash,ancpwr,leer,bite,outrge,scryfc,thrash,stomp,roksld,magtud,rocthr,harden,bonrsh,hijkck,recovr,aerbls,hrndrl,drgrag,sfboil,drgbre,slfdes,explsn,eggbmb,slgbmb,gigdrn,megdrn,swrdnc,cut,fryctr,thief,dig,rolout,dfncrl,detect,solbem,raidnc,flash,psycic,psycup,drmeat,ngtmar,shdbal,zapcan,thundr,thnblt,irntal,streng,rocsms,hedbut,mudslp,sunday,protct,dbltem,slptlk,curse,hidpwr,swager,frustr,return,toxic,snore,rest,endure,atract,bide,mimic,substu,rage,dbledg,takdwn,sklbas,bodslm,wtrgun,bblbem,icebem,blizrd,icywnd,surf,wrlpol,wtrfal,swift,payday,triatk,rflect,thnwav,telprt,psywav,metrnm,countr,megpnc,seitos,submis,megkck,dynpnc,firpnc,thnpnc,icepnc,firbls,flmthr,fisure,eartqk,sndstr,hypbem,roar,stlwng,fly,razwnd,wrlwnd,skyatk,wngatk,peck,mirmov,fntatk,witdrw,rapspn,supsnc,aurbem,mircot,psnstg,spite,crunch,pursut,strsht,lechlf,btnpas,disabl,screch,tackle,flmwel,revrsl,fryswp,fcseng,forsgt,lowkck,rolkck,encore,wrap,growth,vinwip,sacfir,sharpn,sketch,tm05,______",split"youngs,sage,falknr,grunt,bugctr,bugsy,pkmfan,beauty,witney,kimono,medium,morty,police,karate,chuck,gentle,sailor,jasmin,rocket,skier,pryce,scient,twins,clair,nerd,camper,brock,school,swimer,misty,jugler,guitar,ltsurg,hiker,lass,erika,biker,picnik,janine,maniac,psycic,sabrin,fisher,breath,blaine,birdkp,cooltr,blue,legend,silver,will,koga,bruno,karen,lance,red,gold,horde",f_zobj"0,none;,normal,fire,fightng,water,poison,electrc,ground,grass,flying,ice,bug,psychic,rock,dragon,ghost,dark,steel,bird",f_zobj"0,______;,pnkbow,chrcol,blkblt,myswtr,psnbrb,magnet,sosand,mirasd,shbeak,nvrice,slvpwd,twspon,hrdstn,dragsc,speltg,blkgls,mtlcot,plkbow,bripwd,focbnd,kingrk,leftov,qikclw,scopln,amcoin,litbal,lukpnc,mtlpwd,stick,thkclb,bersrk,berry,gldbry,btrbry,mntbry,brnbry,icebry,parbry,psnbry,mirbry,mysbry",f_zobj"0,team1;,team2,comp1,comp2",f_zobj"0,misingno;,bulbsaur,ivysaur,venusaur,charmand,charmeln,charzard,squirtle,wartortl,blastois,caterpie,metapod,butrfree,weedle,kakuna,beedrill,pidgey,pidgeoto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sndshrew,sndslash,nidoranf,nidorina,nidoquen,nidoranm,nidorino,nidoking,clefairy,clefable,vulpix,ninetale,jiglypuf,wiglytuf,zubat,golbat,oddish,gloom,vileplum,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlith,arcanine,poliwag,polwhirl,polwrath,abra,kadabra,alakazam,machop,machoke,machamp,belsprot,weepnbel,victrbel,tntacool,tntcruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemit,magneton,fafetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrod,exegcute,exegutor,cubone,marowak,hitmnlee,hitmnchn,licktung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangakan,horsea,seadra,goldeen,seaking,staryu,starmie,mrmime,scyther,jynx,elecabuz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodact,snorlax,articuno,zapdos,moltres,dratini,dragnair,dragnite,mewtwo,mew,chikrita,bayleef,meganium,cyndquil,quilava,typhlosn,totodile,croconaw,fralgatr,sentret,furret,hoothoot,noctowl,ledyba,ledian,spinarak,ariados,crobat,chinchou,lanturn,pichu,cleffa,igglybuf,togepi,togetic,natu,xatu,mareep,flaaffy,ampharos,belossom,marill,azumaril,sudwoodo,politoed,hoppip,skiploom,jumpluff,aipom,sunkern,sunflora,yanma,wooper,quagsire,espeon,umbreon,murkrow,slowking,misdrvus,unown,wobbufet,girafrig,pineco,foretres,dunsparc,gligar,steelix,snubbull,granbull,qwilfish,scizor,shuckle,heracros,sneasel,tediursa,ursaring,slugma,magcargo,swinub,piloswin,corsola,remoraid,octilery,delibird,mantine,skarmory,houndour,houndoom,kingdra,phanpy,donphan,porygon2,stantler,smeargle,tyrogue,hitmntop,smoochum,elekid,magby,miltank,blissey,raikou,entei,suicune,larvitar,pupitar,tyrnitar,lugia,hooh,celebi,________,none,___,___",f_zobj"0,neuter;,male,female",f_zobj"0,______;,faint,burn,freeze,parlyz,poisnd,sleep",f_zobj"0,___;,fnt,brn,fzn,par,psn,slp",split"learn,teach,cheat",f_zobj"attack,atack,defense,defns,specialattack,spatk,specialdefense,spdfn,speed,speed,evasion,evasn,accuracy,acury,crit,critl",f_zobj"0;,129,13,6;;,1,140,12;;,130,136,8;;,131,3,138;;,0,8,10;;,5,134,6;;,4,9,10",f_zobj"0,dual version;,blue version,red version,green version,hotdog flavor,silvr version,gold version",f_zobj"0;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,",function()
g_init_peek_loc+=1
return@g_init_peek_loc
end,function(list,ind)
list[ind].lock=true
end,function(start_trnr)
f_unlock(c_items,0+1)
f_unlock(c_items,32+1)
for ind in all(split"0,252,8,104,181,247,236,112,40,111,105,61,235 ")do
f_unlock(c_moves,ind)
end
for i,ind in ipairs(split"1,4,7,152,155,158,252 ")do
f_unlock(c_pokemon,ind)
if@0x5efe==0 then
f_save_party_pkmn(f_mkpkmn(ind,c_pokemon[ind],true,rnd(2)\1,0,5,5,5,5),0,i-1)
end
end
if@0x5efe==0 then
poke(0x5efe,1)
memset(0x5e2a,252,126)
end
for i=start_trnr,min(58,@0x5eff)do
local team=f_team_league(i)
for pkmn in all(team)do
f_unlock(c_pokemon,pkmn.num)
f_unlock(c_items,pkmn.item+1)
for i=1,4 do
f_unlock(c_moves,pkmn[i].num)
end
end
end
end,function(_ENV,op,disabled)
add(op,{text=lock and name or f_strtoq(name),disabled=disabled or not lock})
end,function()return f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")end,function(op,list,key)
local pkmn=f_get_edit_op_pkmn()
for obj in all(list)do
f_create_spot(obj,op,pkmn[key]==obj.num)
end
end,function(op,pkmn,ind)
ind=ind+1
local move=pkmn[ind]
local movenum=move.num
local maxpp,pp,pow,accuracy,typ=f_get_move_texts(move)
local method=pkmn.possible_moves_method[movenum]or "empty"
add(op,{text="move"..ind..": "..move.name,disabled=true})
add(op,{text=""..method..": "..typ})
add(op,{text="   pp: "..pp.."/"..maxpp})
add(op,{text="pw/ac: "..pow.."/"..accuracy})
end,function(op,pkmn)
add(op,{text="info: "..pkmn.name,disabled=true})
add(op,{text="gendr: "..c_gender_names[pkmn.gender]})
add(op,{text="type1: "..c_type_names[pkmn.pktype1]})
add(op,{text="type2: "..c_type_names[pkmn.pktype2]})
end,function(op,pkmn)
local draw_preview=function(off)
f_draw_pkmn(pkmn.num,21,off-12,16,false,false,false,false,true)
end
add(op,{text="#"..f_prefix_zero(pkmn.num,3)..": "..pkmn.name,disabled=true})
add(op,{draw=function()draw_preview"17" end})
add(op,{draw=function()draw_preview"8" end})
add(op,{draw=function()draw_preview"-1" end})
end,function(op,pkmn,is_battle)
f_add_stat_preview(op,pkmn)
f_add_stat_info(op,pkmn)
add(op,{text="stat: "..pkmn.name,disabled=true})
add(op,{text="at/df: "..f_prefix_zero(f_stat_calc(pkmn,"attack"),3).."/"..f_prefix_zero(f_stat_calc(pkmn,"defense"),3)})
add(op,{text="sa/sd: "..f_prefix_zero(f_stat_calc(pkmn,"specialattack"),3).."/"..f_prefix_zero(f_stat_calc(pkmn,"specialdefense"),3)})
add(op,{text="sp/lv: "..f_prefix_zero(f_stat_calc(pkmn,"speed"),3).."/050"})
add(op,{text="batl: "..pkmn.name,disabled=true})
add(op,{text="major: "..c_major_names_long[pkmn.major]})
add(op,{text="   hp: "..pkmn.hp.."/"..pkmn.maxhp})
add(op,{text=" item: "..c_item_names[pkmn.item]})
if is_battle then
f_add_stat_move(op,pkmn,0)
f_add_stat_move(op,pkmn,1)
f_add_stat_move(op,pkmn,2)
f_add_stat_move(op,pkmn,3)
end
end,function(...)
local text=""
for x in all{...}do
text..=x
end
print("\f3"..text,1,1)
end,function(...)
local text=""
for x in all{...}do
text..=x
end
print("\f1"..text,1,8)
end,function(move)
local maxpp,pp,pow,accuracy,typ=f_prefix_zero(move.maxpp,2),f_prefix_zero(move.pp,2),f_prefix_zero(move.pow,3),f_prefix_zero(move.accuracy,3),c_type_names[move.pktype]
if move.pow==0 then pow="___"
elseif move.pow==1 then pow="var" end
if move.accuracy==0 then accuracy="___" end
if move.num==252 then
typ,maxpp,pp,pow,accuracy="______","__","__","___","___"
elseif not move.lock then
maxpp,pp,pow,accuracy,typ=f_strtoq(maxpp),f_strtoq(pp),f_strtoq(pow),f_strtoq(accuracy),f_strtoq(typ)
end
return maxpp,pp,pow,accuracy,typ
end,function(num,len)
local numstr=tostr(num)
while #numstr<len do numstr=" "..numstr end
return numstr
end,function(num,len)
local numstr=tostr(num)
while #numstr<len do numstr="0"..numstr end
return numstr
end,function(pkmn_ind)
local pkmn=c_pokemon[pkmn_ind]
local namestr=pkmn.name
if not pkmn.lock then
namestr=f_strtoq(namestr)
end
f_print_top("view ",namestr)
f_print_bot("picodex #",f_prefix_zero(pkmn.num,3))
end,function(op)
local b=function(_ENV,team,x,y,px,py,flip)
add(op,{draw=function()
local is_notactive=p_selfaction.active ~=_ENV
f_draw_pkmn(invisible and 254 or num,px,py,16,flip,false,false,is_notactive,not is_notactive)
if invisible then return end
if hp>0 then
rectfill(x+1,y+2,x+1+mid(0,hp/maxhp*32,32),y+5,1)
pset(x+1,y+2,2)
pset(x+1,y+5,2)
pset(x+33,y+2,2)
pset(x+33,y+5,2)
end
local tx,ty=x+15,y+9
for i=0,5 do
if spot==i+1 or team[i+1].valid and team[i+1].major ~=1 then
pset(tx+i%3*2,ty+i\6-1,spot==i+1 and 3 or 1)
end
if i ~=1 then
end
end
print(name,x+2,y-4,1,-1)
print(c_major_names_short[major].."  "..f_prefix_zero(hp,3),x+1+1,y+8-1,1,-1)
end})
end
b(p_2.active,p_2.team,1,5,39,1,true)
b(p_1.active,p_1.team,22,5,3,1)
end,function(team,ind)
return f_zobj_setmeta(team[ind],"isactive,~c_yes,lastmoverecv,0,moveturn,0,invisible,~c_yes,counterdmg,0,bidedmg,0,disabledtimer,0,confused,0,sleeping,@,substitute,0,toxiced,0,spot,@,base,@;stages;attack,0,defense,0,specialattack,0,specialdefense,0,speed,0,crit,0,evasion,0,accuracy,0;",f_flr_rnd"7"+1,ind,team[ind])
end,function(team,name,subname,iscpu)
local active=nil
for i=1,6 do
if team[i].valid then
active=f_create_active(team,i)
break
end
end
return f_zobj("active,@,team,@,name,@,subname,@,iscpu,@,actions,#,greed,7",active,team,name,subname,iscpu)
end,function(player)
return player==p_1 and p_2 or p_1
end,function(player)
p_selfaction,p_otheraction=player,f_get_other_pl(player)
end,function(player)
local newteam={}
for i=1,6 do
local ind=(player.active.spot+i-1)%6+1
local pkmn=player.team[ind]
if pkmn.valid and pkmn.major ~=1 then
add(newteam,ind)
end
end
return newteam
end,function(player)
return f_get_live_pkmn(player)[1]
end,function(player)
f_set_pself(player)
f_zcall(f_pop_ui_stack,";,;;,;;,")
f_add_to_ui_stack(g_grid_battle_results,function()
g_win_spot=p_otheraction.active.spot
if p_otheraction==p_1 then
g_p1_winfunc()
end
end)
f_setsel("g_grid_battle_results",p_otheraction.active.spot-1)
end,function(level,player,message,logic,isplayeraction)
return f_zobj("level,@,player,@,message,@,logic,@,isplayeraction,@",level,player,message or false,logic or f_nop,isplayeraction)
end,function(player,...)
add(player.actions,f_newaction(...))
end,function(player,spot)
local pkmn=player.team[spot]
player.active=f_create_active(player.team,spot)
for i=1,4 do
player.active[i]=pkmn[i]
end
return f_newaction(2,player,"sends "..player.active.name,function()
player.active.invisible=false
return player.active.num
end,true)
end,function()
for player in all{p_first,p_last}do
if player.active.major==1 and not player.active.invisible then
for np in all{p_first,p_last}do
for action in all(np.actions)do
if action.level==2 and del({p_first,p_last},action.player)then
del(np.actions,action)
end
end
end
return player,f_newaction(1,player,"backs "..player.active.name,function()
player.active.invisible=true
f_fill_team(player.team,player.active.spot)
end,true)
elseif player.active.invisible then
return player,f_pkmn_comes_out(player,f_get_next_active(player))
end
end
for level=1,10 do
for player in all{p_first,p_last}do
for action in all(player.actions)do
if action.level==level then
return player,del(player.actions,action)
end
end
end
end
end,function(player)
local priority_class=3000
local movenum=player.nextmove and player.nextmove.num
local other=f_get_other_pl(player)
if not movenum then priority_class=6000
elseif movenum==230 and not other.movenum then priority_class=7000
elseif f_in_split(movenum,"216,212,194 ")then priority_class=0000
elseif f_in_split(movenum,"33,20,9 ")then priority_class=4000
elseif f_in_split(movenum,"197,226 ")then priority_class=1000
elseif movenum==27 then priority_class=2000
end
player.priority=priority_class+f_stat_calc(player.active,"speed",true)
printh("prior: "..player.name)
end,function(player)
local move=player.nextmove
f_addaction(player,2,player,(player.active.curmove and "resumes "or(move.func==f_move_multiturn and "begins "or "uses "))..c_move_names[move.num],function()
move.pp-=1
if(function()
if move.accuracy<=0 then return false end
return rnd(f_stat_evac(a_other_active.stages["evasion"]))>move.accuracy/100*f_stat_evac(a_self_active.stages["accuracy"])or f_flr_rnd"256"==0 and f_flr_rnd"256"==0
end)()then
a_addaction(player,"misses "..move.name)
if f_in_split(move.num,"M_HIGH_JUMP_KICK,M_JUMP_KICK")then
f_moveutil_dmgself"1"
end
else
if move:func()then
a_addaction(player,"fails attack")
end
end
if f_in_split(move.num,"130,129 ")then
f_moveutil_dmgself(a_self_active.hp)
end
end)
end,function()
local x=function()
if p_selfaction.iscpu then
local possible_moves={}
for i=1,4 do
if p_selfaction.active[i].num<252 and p_selfaction.active[i].pp>0 then
add(possible_moves,i)
end
end
if #possible_moves>0 then
p_selfaction.nextmove=p_selfaction.active[f_flr_rnd(#possible_moves)+1]
else
p_selfaction.nextmove=c_moves[0]
end
f_movelogic(p_selfaction)
else
f_addaction(p_selfaction,1,p_selfaction,"begins turn",function()
printh("IDEK")
f_pop_ui_stack()
f_setsel("g_grid_battle_select",0)
if p_selfaction==p_1 then
g_grid_battle_select.g_cg_m.sel=0x5eba
g_grid_statbattle.g_cg_m.sel=0x5ebe
g_grid_battle_movesel.g_cg_m.sel=0x5ebc
g_grid_battle_select.g_cg_m.view=0x5eba+1
g_grid_statbattle.g_cg_m.view=0x5ebe+1
g_grid_battle_movesel.g_cg_m.view=0x5ebc+1
else
g_grid_battle_select.g_cg_m.sel=0x5ec0
g_grid_statbattle.g_cg_m.sel=0x5ec4
g_grid_battle_movesel.g_cg_m.sel=0x5ec2
g_grid_battle_select.g_cg_m.view=0x5ec0+1
g_grid_statbattle.g_cg_m.view=0x5ec4+1
g_grid_battle_movesel.g_cg_m.view=0x5ec2+1
end
f_add_to_ui_stack(g_grid_battle_select)
end,true)
end
end
p_first=p_1
p_last=p_2
f_addaction(p_1,1,p_1,not p_1.iscpu and "begins turn",x,true)
f_addaction(p_2,1,p_2,not p_2.iscpu and "begins turn",x,true)
f_addaction(p_1,1,p_1,false,function()
f_set_player_priority(p_1)
f_set_player_priority(p_2)
if p_1.priority==p_2.priority then p_2.priority+=sgn(rnd"2"-1)end
p_first=p_1.priority>p_2.priority and p_1 or p_2
printh("first is: "..p_first.name)
p_last=f_get_other_pl(p_first)
end)
end,function(p1name,p1winfunc,...)
p_1,p_2=f_create_player(f_team_party(@0x5eae),p1name,c_team_names[@0x5eae]),f_create_player(...)
p_first,p_last=p_1,p_2
g_p1_winfunc=p1winfunc
p_curaction=nil
g_action_level=1
db(p_1.actions)
db(p_2.actions)
f_set_pself(p_1)
poke2(0x5eba,0)
poke2(0x5ebc,0)
poke2(0x5ebe,0)
poke2(0x5ec0,0)
poke2(0x5ec2,0)
poke2(0x5ec4,0)
f_add_to_ui_stack(g_grid_battle_actions)
f_s_bataction()
end,function(ind,base,respect_locks,gender_bit,item,...)
local pkmn=f_zobj_setmeta(base,"num,@,base,@,gender_bit,@,item,@,valid,@,seen_moves,#,major,0,gender,0,substitute,0,evasion,100,accuracy,100,crit,1,numtimes,0;stages;attack,0,defense,0,specialattack,0,specialdefense,0,speed,0,crit,0,evasion,0,accuracy,0;",ind,base,gender_bit,item%42,ind<252)
pkmn.gender=pkmn.genders[pkmn.gender_bit%#pkmn.genders+1]
local moves={...}
for i=1,4 do
local move=mid(1,moves[i],#pkmn.possible_moves)
while pkmn.seen_moves[move]or respect_locks and not c_moves[pkmn.possible_moves[move]].lock do
move=move%#pkmn.possible_moves+1
end
pkmn.seen_moves[move]=true
local num=pkmn.possible_moves[move]
pkmn[i]=f_zobj_setmeta(c_moves[num],"num,@,pid,@",num,move)
end
pkmn[0]=f_zobj_setmeta(c_moves[0],"num,0,pid,1")
return pkmn
end,function(party_num)
local team={fill_ind=7,trainer={}}
for spot_num=0,5 do
add(team,f_get_party_pkmn(party_num,spot_num))
end
return team
end,function(team,spot)
local pkmn_ind=team.trainer[team.fill_ind]
if pkmn_ind then
local last_move=8
local possible_moves=c_pokemon[pkmn_ind].possible_moves
for i=9,#possible_moves do
if possible_moves[i]==team.trainer.move then
last_move=i
break
end
end
team[spot]=f_mkpkmn(pkmn_ind,c_pokemon[pkmn_ind],false,1,c_pokemon[pkmn_ind].default_item,5,6,7,last_move)
team.fill_ind+=1
end
end,function(trainer_num)
local team={fill_ind=1,trainer=c_trainers[trainer_num]}
db(c_trainers[trainer_num])
for i=1,6 do
f_fill_team(team,i)
end
return team
end,function(party_num,spot_num)
local num_loc=0x5e00+party_num*42+spot_num*7
local pkmn_num=min(252,@num_loc)
if pkmn_num<252 and not c_pokemon[pkmn_num].lock then pkmn_num=252 end
local pkmn=f_mkpkmn(pkmn_num,c_pokemon[pkmn_num],true,@(num_loc+1),@(num_loc+2),@(num_loc+3),@(num_loc+4),@(num_loc+5),@(num_loc+6))
f_save_party_pkmn(pkmn,party_num,spot_num)
return pkmn
end,function(_ENV,party_num,spot_num)
local num_loc=0x5e00+party_num*42+spot_num*7
poke(num_loc,num)
poke(num_loc+1,gender_bit)
poke(num_loc+2,item)
poke(num_loc+3,_ENV[1].pid)
poke(num_loc+4,_ENV[2].pid)
poke(num_loc+5,_ENV[3].pid)
poke(num_loc+6,_ENV[4].pid)
end,function(crit)
return mid(0,1,.0095*crit^4-.0746*crit^3+.1883*crit^2-.0607*crit+.0625)
end,function(stat)
return mid(1,1+stat/3,3)/mid(1,1-stat/3,3)
end,function(active,stat,special)
local stage=active.stages[stat]or 0
local base=active[stat]*mid(2,2+stage,8)/mid(2,2-stage,8)
if special then
if stat=="attack" and major==2 then base*=.5 end
if stat=="defense" and active.reflected then base*=2 end
if stat=="specialdefense" and active.screened then base*=2 end
if stat=="speed" then
if major==4 then
base*=.25
end
if active.item==23 and rnd()<.23 then
base=999
end
end
end
return mid(1,999,base)
end,function(_ENV)add(op,{})end)
f_zobj_set(_g,"f_op_edititem,@,f_op_statbrowse,@,f_op_browse,@,f_op_statbattle,@,f_op_edit,@,f_op_editteam,@,f_op_title,@,f_op_prevpk,@,f_op_teams,@,f_op_editmovebot,@,f_op_editstat,@,f_op_editmove,@,f_op_batsel,@,f_op_movesel,@,f_op_dmovsel,@,f_op_batswitch,@,f_op_batresults,@,f_op_batstats,@,f_dt_editteam,@,f_dt_editstat,@,f_dt_editmove_template,@,f_dt_editmove,@,f_dt_browse,@,f_dt_editpkmn,@,f_dt_edit,@,f_dt_batstats,@,f_dt_switch,@,f_dt_league,@,f_dt_versus,@,f_dt_title,@,f_s_batresults,@,f_l_browse,@,f_s_browse,@,f_s_versus,@,f_s_league,@,f_s_batstat,@,f_s_edit,@,f_s_editteam,@,f_s_editstat,@,f_s_editmovebot,@,f_s_battle,@,f_s_title,@,f_s_pkstat,@,f_s_statedit,@,f_s_statbat,@,f_s_versusbegin,@,f_s_batbegin,@,f_s_editpkmn,@,f_s_editmove,@,f_s_edititem,@,f_l_title,@,f_l_battle,@,f_s_batmove,@,f_s_dmovsel,@,f_s_batswitch,@,f_op_bataction,@,f_s_bataction,@,_update,@,_draw,@",function(_ENV)f_op_template_edit(op,c_items,"item")end,function(_ENV)f_add_stat(op,c_pokemon[f_getsel"g_grid_browse"])end,function(_ENV)
for i=0,251 do
local disabled=not c_pokemon[i].lock
add(op,{lrvalid=not disabled,disabled=disabled,draw=function(_,is_sel,gridobj)
f_draw_pkmn(c_pokemon[i].lock and i or 252,1,1,6,false,false,gridobj.disabled,not is_sel)
end})
end
end,function(_ENV)
local bothteams={}
for i=1,6 do add(bothteams,p_selfaction.team[i])end
for i=1,6 do add(bothteams,p_otheraction.team[i])end
f_add_stat(op,bothteams[f_getsel"g_grid_battle_stats"+1],true)
end,function(_ENV,sumdisable)
for partynum=0,3 do
local valid=true
local inds={}
for pkmnnum=0,5 do
local pkmn=f_get_party_pkmn(partynum,pkmnnum)
if pkmn.valid then
valid=false
end
add(inds,pkmn.num)
end
add(op,{data=inds,disabled=sumdisable and valid,draw=function(i,is_sel,gridobj)
for ii,ind in ipairs(gridobj.data)do
f_draw_pkmn(ind,(ii-1)%3+1+(ii-1)%3*9,1+(ii-1)\3*10,6,false,false,gridobj.disabled,not is_sel)
end
end})
end
end,function(_ENV)
for pkmnnum=0,5 do
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",pkmnnum)
add(op,{lrvalid=pkmn.valid,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,16,false,false,false,not is_sel)
end})
end
end,function(_ENV)
foreach(split"view,edit,league,versus",function(text)
f_addop_text(op,text)
end)
end,function(_ENV)
add(op,{draw=function()
f_draw_pkmn(c_pokemon[f_getsel"g_grid_browse"].num,30-18+1,20-18+1,32,g_title_sel,false,false,false)
end})
end,function(_ENV)
for i=1,58 do
local disabled=@0x5eff+1<i
add(op,{text=disabled and f_strtoq(c_trnr_names[i])or c_trnr_names[i],disabled=disabled})
end
end,function(_ENV)
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
for i=1,4 do
add(op,{text=c_move_names[pkmn[i].num],select=function()
f_setsel("g_grid_editmove",pkmn[i].pid-1)
f_add_to_ui_stack(g_grid_editmove)
end})
end
f_add_stat_move(preview_op,pkmn,f_getsel"g_grid_editmovebot")
end,function(_ENV)
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_add_stat_preview(preview_op,pkmn)
add(op,{text="moves",select=function()
f_add_to_ui_stack(g_grid_editmovebot)
end})
add(op,{text=c_item_names[pkmn.item],select=function()
f_setsel("g_grid_edititem",pkmn.item)
f_add_to_ui_stack(g_grid_edititem)
end})
add(op,{text=c_gender_names[pkmn.gender],disabled=#pkmn.genders<2,select=function()
pkmn.gender_bit+=1
pkmn:f_save_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_refresh_top()
end})
add(op,{text="delete",select=function()
memset(0x5e00+f_getsel"g_grid_pickedit"*42+f_getsel"g_grid_pickspot"*7,252,7)
f_pop_ui_stack()
end})
end,function(_ENV)
local pkmn=f_get_edit_op_pkmn()
for i,num in ipairs(pkmn.possible_moves)do
f_create_spot(c_moves[num],op,pkmn.seen_moves[i])
end
end,function(_ENV)
add(op,{text="fight",select=function()
local should_struggle=true
for i=1,4 do
if p_selfaction.active[i].pp>0 then
should_struggle=false
end
end
if should_struggle then
f_add_to_ui_stack(g_grid_battle_dmovsel)
else
f_add_to_ui_stack(g_grid_battle_movesel)
end
end})
add(op,{text="swap",select=function()
f_setsel("g_grid_battle_switch",p_selfaction.active.spot-1)
f_add_to_ui_stack(g_grid_battle_switch)
end})
add(op,{text="view",select=function()
f_setsel("g_grid_battle_stats",p_selfaction.active.spot-1)
f_add_to_ui_stack(g_grid_battle_stats)
end})
add(op,{text="run",select=function()f_end_battle(p_selfaction)end})
f_add_battle(preview_op)
end,function(_ENV)
for i=1,4 do
add(op,{text=c_move_names[p_selfaction.active[i].num],disabled=p_selfaction.active[i].pp==0})
end
f_add_stat_move(preview_op,p_selfaction.active,f_getsel"g_grid_battle_movesel")
end,function(_ENV)
add(op,{draw=function()
f_print_top"no more moves"
f_print_bot"use struggle?"
end})
f_add_stat_move(preview_op,p_selfaction.active,-1)
end,function(_ENV)
for i=1,6 do
local pkmn=p_selfaction.team[i]
local disabled=not pkmn.valid or i==p_selfaction.active.spot or pkmn.major==1
add(op,{disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,16,false,false,disabled,not disabled and not is_sel)
end})
end
end,function(_ENV)
for i=1,6 do
local pkmn=p_otheraction.team[i]
local disabled=not pkmn.valid or pkmn.major==1
add(op,{disabled=disabled,draw=function(i)
f_draw_pkmn(pkmn.num,1,1,16,false,false,disabled,not disabled and g_win_spot ~=i+1)
end})
end
add(preview_op,{draw=function()
f_print_top(p_otheraction.name.." "..p_otheraction.subname)
f_print_bot("is the winner!")
end})
end,function(_ENV)
for i=1,6 do
local pkmn=p_selfaction.team[i]
local disabled=not pkmn.valid
add(op,{lrvalid=not disabled,disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,16,false,false,disabled,not disabled and not is_sel)
end})
end
for i=1,6 do
local pkmn=p_otheraction.team[i]
local disabled=not pkmn.valid
add(op,{lrvalid=not disabled,disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,16,false,false,disabled,not disabled and not is_sel)
end})
end
end,function(i,is_sel)
local spotstr="spot"..(f_getsel"g_grid_pickspot"+1)
f_print_top("edit ",spotstr)
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_print_bot("#",pkmn.num_str," ",pkmn.name)
end,function(i,is_sel)
local prefix="edit"
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
local spotstr="spot"..(f_getsel"g_grid_pickspot"+1)
if f_getsel"g_grid_editstat"==0 then f_print_top("view: "..spotstr)
elseif f_getsel"g_grid_editstat"==1 then f_print_top("edit item")
elseif f_getsel"g_grid_editstat"==6 then f_print_top(prefix," item")
elseif f_getsel"g_grid_editstat"==7 then f_print_top(prefix," gender")
else f_print_top(prefix," move",f_getsel"g_grid_editstat"-1)
end
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_print_bot("#",pkmn.num_str," ",pkmn.name)
end,function(move,method)
local maxpp,pp,pow,accuracy,typ=f_get_move_texts(move)
local ind=f_getsel"g_grid_editmovebot"+1
f_print_top("edit move"..ind)
f_print_bot(method.." "..typ)
end,function()
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
local movenum=pkmn.possible_moves[f_getsel"g_grid_editmove"+1]
local move=c_moves[movenum]
f_dt_editmove_template(move,pkmn.possible_moves_method[movenum])
end,function()
f_dt_browse_template(f_getsel"g_grid_browse")
end,function()
local pkmn=c_pokemon[f_getsel"g_grid_editpkmn"]
local namestr=pkmn.name
if not pkmn.lock then
namestr=f_strtoq(namestr)
end
local spotstr="spot"..(f_getsel"g_grid_pickspot"+1)
f_print_top("edit ",spotstr)
f_print_bot("#",f_prefix_zero(pkmn.num,3)," ",namestr)
end,function()
local pkstr_arr={}
local pkstr_lens=split"2,2,2,2,1,1"
for ii=0,5 do
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",ii)
add(pkstr_arr,sub(c_pkmn_names[pkmn.num],1,pkstr_lens[ii+1]))
end
f_print_top("edit ",c_team_names[f_getsel"g_grid_pickedit"])
f_print_bot(pkstr_arr[1],"-",pkstr_arr[2],"-",pkstr_arr[3],"-",pkstr_arr[4],"-",pkstr_arr[5],pkstr_arr[6])
end,function()
local ind=f_getsel"g_grid_battle_stats"
local player=ind<6 and p_selfaction or p_otheraction
local name=c_trnr_names[f_getsel"g_grid_picktrnr"+1]
local pkmn=player.team[ind%6+1]
f_print_bot(player.name," spot",ind%6+1)
f_print_top("view ",pkmn.name)
end,function()
local ind=f_getsel"g_grid_battle_switch"
local name=c_trnr_names[f_getsel"g_grid_picktrnr"+1]
local pkmn=p_selfaction.team[ind%6+1]
f_print_top("swap ",pkmn.name)
local player=ind<6 and p_selfaction or p_otheraction
f_print_bot(player.name," spot",ind%6+1)
end,function()
local toggle=g_cg_m.name=="g_grid_pickleag"
local disabled=@0x5eff+1<f_getsel"g_grid_picktrnr"+1
local name=c_trnr_names[f_getsel"g_grid_picktrnr"+1]
name=disabled and f_strtoq(name)or name
f_print_top(toggle and "\f3"or "\f1","playr ",c_team_names[f_getsel"g_grid_pickleag"])
f_print_bot(toggle and "\f1"or "\f3","enemy ",name)
end,function()
local toggle=g_cg_m.name=="g_grid_pickplr1"
f_print_top(toggle and "\f3"or "\f1","playr ",c_team_names[f_getsel"g_grid_pickplr1"])
f_print_bot(toggle and "\f1"or "\f3","enemy ",c_team_names[f_getsel"g_grid_pickplr2"])
end,function()
print("\^w\^tpicodex",2,1,3)
print(c_palette_names[g_palette],2,12,1)
f_draw_pkmn(g_title_l,7,20,16,false,false,false,g_title_sel,true)
f_draw_pkmn(g_title_r,35,20,16,true,false,false,not g_title_sel,true)
end,function()
local possible_spots={}
for i=1,6 do
local pkmn=p_otheraction.team[i]
local disabled=not pkmn.valid or pkmn.major==1
if not disabled and i ~=g_win_spot then
add(possible_spots,i)
end
end
if #possible_spots>0 then
g_win_spot=possible_spots[f_flr_rnd(#possible_spots)+1]
end
g_preview_timer=20
return p_otheraction.team[g_win_spot].num
end,function()f_pop_ui_stack()end,function()f_add_to_ui_stack(g_grid_statbrowse)end,function()f_add_to_ui_stack(g_grid_pickplr2)end,function()f_add_to_ui_stack(g_grid_picktrnr)end,function()f_add_to_ui_stack(g_grid_statbattle)end,function()f_add_to_ui_stack(g_grid_pickspot)end,function()f_add_to_ui_stack(f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot").valid and g_grid_editstat or g_grid_editpkmn)end,function()gridpo[f_getsel"g_grid_editstat"+1].select()end,function()gridpo[f_getsel"g_grid_editmovebot"+1].select()end,function()gridpo[f_getsel"g_grid_battle_select"+1].select()end,function()
if f_getsel"g_grid_title"==0 then
f_add_to_ui_stack(g_grid_browse)
elseif f_getsel"g_grid_title"==1 then
f_add_to_ui_stack(g_grid_pickedit)
elseif f_getsel"g_grid_title"==2 then
f_add_to_ui_stack(g_grid_pickleag)
elseif f_getsel"g_grid_title"==3 then
f_add_to_ui_stack(g_grid_pickplr1)
end
end,function()
g_preview_timer=20
g_title_sel=not g_title_sel
return f_getsel"g_grid_browse"
end,function()
g_preview_timer=20
g_title_sel=not g_title_sel
return f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot").num
end,function()
g_preview_timer=20
g_title_sel=not g_title_sel
local bothteams={}
for i=1,6 do add(bothteams,p_selfaction.team[i])end
for i=1,6 do add(bothteams,p_otheraction.team[i])end
return bothteams[f_getsel"g_grid_battle_stats"+1].num
end,function()
f_start_battle("plyr1",f_nop,f_team_party(f_getsel"g_grid_pickplr2"),"enemy",c_team_names[f_getsel"g_grid_pickplr2"])
end,function()
local loc=f_getsel"g_grid_picktrnr"
f_start_battle("playr",function()
if loc==@0x5eff then
poke(0x5eff,max(loc+1,@0x5eff))
poke(0x5eb2,min(@0x5eff,57))
f_update_locks(loc)
end
end,f_team_league(loc+1),"enemy",c_trnr_names[loc+1],true)
end,function()
f_save_party_pkmn(f_mkpkmn(f_getsel"g_grid_editpkmn",c_pokemon[f_getsel"g_grid_editpkmn"],true,rnd(2)\1,0,5,6,7,8),f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_pop_ui_stack()
end,function()
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
pkmn[f_getsel"g_grid_editmovebot"+1].pid=f_getsel"g_grid_editmove"+1
f_save_party_pkmn(pkmn,f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_pop_ui_stack()
end,function()
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
pkmn.item=f_getsel("g_grid_edititem")
f_save_party_pkmn(pkmn,f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_pop_ui_stack()
end,function()
g_title_sel=not g_title_sel
if g_title_sel then
g_title_r=rnd"252"\1 return g_title_r
else
g_title_l=rnd"252"\1 return g_title_l
end
g_palette+=1
g_palette%=#c_palettes
end,function()return p_selfaction.active.num end,function()
p_selfaction.nextmove=p_selfaction.active[f_getsel"g_grid_battle_movesel"+1]
f_movelogic(p_selfaction)
f_pop_ui_stack()
f_pop_ui_stack()
f_add_to_ui_stack(g_grid_battle_actions,f_s_bataction)
end,function()
p_selfaction.nextmove=c_moves[0]
f_movelogic(p_selfaction)
f_pop_ui_stack()
f_pop_ui_stack()
f_add_to_ui_stack(g_grid_battle_actions,f_s_bataction)
end,function()
p_selfaction.nextmove=nil
local nextpkmn=f_getsel"g_grid_battle_switch"+1
f_addaction(p_selfaction,2,p_selfaction,"backs "..p_selfaction.active.name,function()
p_selfaction.active.invisible=true
add(p_selfaction.actions,f_pkmn_comes_out(p_selfaction,nextpkmn))
end,true)
f_pop_ui_stack()
f_pop_ui_stack()
f_add_to_ui_stack(g_grid_battle_actions,f_s_bataction)
end,function(_ENV)
if not g_msg_bot then end
add(preview_op,{draw=function()
f_print_top(g_msg_top)
f_print_bot(g_msg_bot)
end})
f_add_battle(op)
end,function()
while true do
for player in all{p_first,p_last}do
if not f_get_next_active(player)then
f_end_battle(player)
return
end
end
p_selfturn,p_curaction=f_pop_next_action()
if p_curaction then
f_set_pself(p_curaction.player)
a_self_active,a_other_active=p_selfaction.active,p_otheraction.active
a_addaction=function(...)f_addaction(p_selfturn,2,...)end
p_otherturn=f_get_other_pl(p_selfturn)
p_curaction.logic()
printh("Running some logic")
if p_curaction.message then
f_setsel("g_grid_battle_actions",p_selfaction==p_1 and 1 or 0)
g_msg_top=p_selfaction.name.." "..p_selfaction.active.name
if p_curaction.isplayeraction then
g_msg_top=p_selfaction.name.." "..p_selfaction.subname
end
g_msg_bot=p_curaction.message
return
end
else
f_set_pself(p_1)
f_start_turn()
end
end
end,function()
if t()>=1.5 then
if g_title_timer==0 then
f_minisfx(254)
end
g_title_timer=min(6,(g_title_timer+1))
end
g_preview_timer=max(0,g_preview_timer-1)
g_top_grid_cont=g_gridstack[#g_gridstack]
g_top_grid=g_top_grid_cont.obj
gridpofunc=g_top_grid.gridpofunc
params=g_top_grid.params
if g_top_grid_cont.init_func then
g_top_grid_cont.init_func()
g_top_grid_cont.init_func=nil
g_top_grid.op,g_top_grid.preview_op,g_top_grid.lrlist={},{},{}
gridpofunc(g_top_grid,unpack(g_top_grid.params))
end
gridpo=g_top_grid.op
g_cg_m=g_top_grid.g_cg_m
g_cg_s=g_top_grid.g_cg_s
grid_previewop=g_top_grid.preview_op
if g_title_timer==6 then
f_update_grid(g_cg_m,gridpo)
end
end,function()
cls"1 "
if g_title_timer<6 then
print"\^j47\|e\f3alanxoc3\n\^j4a\|9\f2presents"
for i=1,6 do
if.5<<i & btn()>0 then
g_palette=i
end
end
end
local var=1-min(6,g_title_timer)/6
local easing=var*var
if g_cg_m then
f_draw_grid(g_cg_m,gridpo,@g_cg_m.sel,@g_cg_m.view,g_cg_m.x,g_cg_m.y+easing*24,true)
f_draw_grid(g_cg_s,#grid_previewop>0 and grid_previewop or{{draw=g_cg_s.df}},-1,0,g_cg_s.x,g_cg_s.y-easing*45)
end
pal(c_palettes[g_palette],1)
g_shake_timer=(g_shake_timer+1)%4
end)
function debug_sort(t,compare_func)
compare_func=compare_func or function(a,b)return tostr(a)<tostr(b)end
if t then
for n=2,#t do
local i=n
while i>1 and compare_func(t[i],t[i-1])do
t[i],t[i-1]=t[i-1],t[i]
i=i-1
end
end
end
end
function db(...)
local str=""
for x in all{...}do
str=str..debug_helper(x).." "
end
printh(str)
end
function debug_helper(any)
if type(any)~="table"then return tostr(any)end
local str="{"
local keys={}
for i=1,#any do
if str~="{"then str=str.."," end
keys[i]=true
str=str..debug_helper(any[i])
end
local sortedkeys={}
for k,v in pairs(any)do
if not keys[k]then
add(sortedkeys,k)
end
end
debug_sort(sortedkeys)
for k in all(sortedkeys)do
if str~="{"then str=str.."," end
str=str..debug_helper(k).."="..debug_helper(any[k])
end
return str.."}"
end
g_cur_pkmn_cry=nil
f_zcall(poke,";,0x5f2c,3;;,0x5f5c,8;;,0x5f5d,1;;,0x5eff,56")
cls()
for i=0,360 do
c_types[i\19][i%19]=f_init_peek_inc()\2
end
for i=0,41 do add(c_items,f_zobj("lock,~c_no,num,@,name,@",i,c_item_names[i]))end
for i=0,252 do
local pkmn=f_zobj("moves_progress;,#,#,#;moves_grouped;,#,#,#;lock,~c_no,name,@,num,@,num_str,@",c_pkmn_names[i],i,f_prefix_zero(i<252 and i or "???",3))
cur_list,c_moves[i],c_pokemon[i]=pkmn.moves_progress[1],f_zobj("lock,~c_no,num,@,name,@",i,c_move_names[i]),pkmn
foreach(split"pow,pktype,accuracy,maxpp",function(key)
c_moves[i][key]=f_init_peek_inc()
end)
c_moves[i].pp=c_moves[i].maxpp
c_moves[i].func=_g[c_move_funcs[i][1]]
c_moves[i].spec=c_move_funcs[i][2]
foreach(split"prevolve,pktype1,pktype2,hp,attack,defense,speed,specialattack,specialdefense,default_item",function(key)
pkmn[key]=f_init_peek_inc()
end)
foreach(split"hp,attack,defense,speed,specialattack,specialdefense",function(key)
pkmn[key]+=52
end)
pkmn.hp+=55
pkmn.maxhp=pkmn.hp
for k,v in pairs(f_zobj"192;,1,2;0;,0;64;,1;128;,2")do
if pkmn.default_item & 192==k then
pkmn.genders=v
pkmn.default_item &=0x3f
end
end
while f_init_peek_inc()<255 do
if@g_init_peek_loc==252 then cur_list=pkmn.moves_progress[2]
elseif@g_init_peek_loc==253 then cur_list=pkmn.moves_progress[3]
elseif@g_init_peek_loc==254 then
for j=cur_list[#cur_list-1]+1,cur_list[#cur_list]-1 do
add(cur_list,j)
end
else
add(cur_list,@g_init_peek_loc)
end
end
end
for i=0,252 do
local sub=c_pokemon[i]
while sub do
for ii=1,3 do
foreach(sub.moves_progress[ii],function(v)
add(c_pokemon[i].moves_grouped[ii],v)
end)
end
sub=c_pokemon[sub.prevolve]
end
end
for i=0,252 do
c_pokemon[i].possible_moves=f_zobj",252,252,252,252"
c_pokemon[i].possible_moves_method=f_zobj"252,empty"
for ii=1,3 do
foreach(c_pokemon[i].moves_grouped[ii],function(v)
add(c_pokemon[i].possible_moves,v)
c_pokemon[i].possible_moves_method[v]=c_movemethod_names[ii]
end)
end
c_pokemon[i]=f_mkpkmn(i,c_pokemon[i],false,0,0)
end
for i=1,57 do
local trainer={move=f_init_peek_inc()}
for j=1,6 do add(trainer,f_init_peek_inc())end
add(c_trainers,trainer)
end
local horde={move=251}
for i=1,252 do add(horde,i%252)end
add(c_trainers,horde)
menuitem(1,"factory reset",function()
cls()flip()
memset(0x5e00,0,256)
run()
end)
f_update_locks(1)
for iloc=0x3200,0x4278,68 do
for loc=iloc,iloc+63,2 do
poke2(loc,%loc & 0x70df|0x0a00)
end
poke4(iloc+64,0x.07d7)
end
f_zcall(f_create_gridpair,"top_browse;,6,4,2,2,10,10,1,1;top_edit;,2,2,2,2,30,20,1,1;top_editteam;,3,2,2,2,20,20,1,1;top_results;,3,2,2,2,20,20,3,2;top_pkstat;,1,4,2,4,60,9,1,4;top_pkstatbig;,1,6,2,5,60,9,1,1;top_text_grid;,2,4,2,4,30,9,1,1;top_title;,1,1,2,2,60,40,1,1;top_battle;,1,1,2,2,60,40,1,1;top_battle2;,1,2,2,2,60,20,1,1;bot_4x4;,2,2,2,44,30,9,1,1;bot_info;,1,1,2,45,60,16,1,1;top_newstat;,1,6,2,4,60,9,1,1;;,g_grid_title,0x5ea8,~bot_4x4,~top_title,~f_dt_title,~f_op_title,~f_s_title,~f_l_title,~c_no,~c_no;;,g_grid_browse,0x5eaa,~top_browse,~bot_info,~f_dt_browse,~f_op_browse,~f_s_browse,~f_l_browse,~c_no,~c_no,~c_no;;,g_grid_editpkmn,0x5eaa,~top_browse,~bot_info,~f_dt_editpkmn,~f_op_browse,~f_s_editpkmn,~f_l_browse,~c_no,~c_no,~c_no;;,g_grid_statbrowse,0x5eac,~top_pkstat,~bot_info,~f_dt_browse,~f_op_statbrowse,~f_s_pkstat,~f_l_browse,g_grid_browse,~c_no;;,g_grid_editstat,0x5eb6,~bot_4x4,~top_pkstat,~f_nop,~f_op_editstat,~f_s_editstat,~f_l_browse,~c_no,~c_no;;,g_grid_editmovebot,0x5eb8,~bot_4x4,~top_pkstat,~f_nop,~f_op_editmovebot,~f_s_editmovebot,~f_l_browse,~c_no,~c_no;;,g_grid_editmove,0x5ec6,~top_text_grid,~bot_info,~f_dt_editmove,~f_op_editmove,~f_s_editmove,~f_l_browse,~c_no,~c_no;;,g_grid_edititem,0x5ec6,~top_text_grid,~bot_info,~f_dt_editstat,~f_op_edititem,~f_s_edititem,~f_l_browse,~c_no,~c_no;;,g_grid_pickedit,0x5eae,~top_edit,~bot_info,~f_dt_edit,~f_op_edit,~f_s_edit,~f_l_browse,~c_no,~c_no;;,g_grid_pickleag,0x5eae,~top_edit,~bot_info,~f_dt_league,~f_op_edit,~f_s_league,~f_l_browse,~c_no,~c_no,~c_yes;;,g_grid_pickplr1,0x5eae,~top_edit,~bot_info,~f_dt_versus,~f_op_edit,~f_s_versus,~f_l_browse,~c_no,~c_no,~c_yes;;,g_grid_pickplr2,0x5eb0,~top_edit,~bot_info,~f_dt_versus,~f_op_edit,~f_s_versusbegin,~f_l_browse,~c_no,~c_no,~c_yes;;,g_grid_pickspot,0x5eb4,~top_editteam,~bot_info,~f_dt_editteam,~f_op_editteam,~f_s_editteam,~f_l_browse,~c_no,~c_no;;,g_grid_picktrnr,0x5eb2,~top_text_grid,~bot_info,~f_dt_league,~f_op_teams,~f_s_batbegin,~f_l_browse,~c_no,~c_no;;,g_grid_battle_select,0x5ec6,~bot_4x4,~top_battle2,~f_nop,~f_op_batsel,~f_s_battle,~f_l_battle,~c_no,~c_no;;,g_grid_statbattle,0x5ec6,~top_pkstat,~bot_info,~f_dt_batstats,~f_op_statbattle,~f_s_statbat,~f_l_browse,g_grid_battle_stats,~c_no;;,g_grid_battle_movesel,0x5ec6,~bot_4x4,~top_pkstat,~f_nop,~f_op_movesel,~f_s_batmove,~f_l_browse,~c_no,~c_no;;,g_grid_battle_dmovsel,0x5ec6,~bot_info,~top_pkstat,~f_nop,~f_op_dmovsel,~f_s_dmovsel,~f_l_browse,~c_no,~c_no;;,g_grid_battle_switch,0x5ec6,~top_editteam,~bot_info,~f_dt_switch,~f_op_batswitch,~f_s_batswitch,~f_l_browse,~c_no,~c_no;;,g_grid_battle_stats,0x5ec6,~top_editteam,~bot_info,~f_dt_batstats,~f_op_batstats,~f_s_batstat,~f_l_browse,~c_no,~c_no;;,g_grid_battle_results,0x5ec6,~top_results,~bot_info,~f_nop,~f_op_batresults,~f_s_batresults,~f_l_browse,~c_no,~c_no;;,g_grid_battle_actions,0x5ec6,~top_battle2,~bot_info,~f_nop,~f_op_bataction,~f_s_bataction,~f_l_battle,~c_no,~c_yes")
f_add_to_ui_stack(g_grid_title)
sfx"63"
g_shake_timer=0