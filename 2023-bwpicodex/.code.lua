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
f_zobj_set(_g,"c_pokemon,#,c_moves,#,c_trainers,#,c_items,#,g_init_peek_loc,0x1fff,c_yes,@,c_no,@,c_empty,@,f_nop,@,g_palette,0,g_preview_timer,0,g_title_timer,0,g_title_l,253,g_title_r,254,g_msg_top, ,g_msg_bot, ,g_bat_func,,g_gridstack,#,g_title_an_timer,70",true,false,"",function(...)return...end)
f_zobj_set(_g,"f_zobj,@,f_zobj_set,@,f_zobj_eval,@,f_zcall,@,f_refresh_top,@,f_add_to_ui_stack,@,f_pop_ui_stack,@,f_getsel,@,f_setsel,@,f_create_gridpair,@,f_update_grid,@,f_draw_grid,@,f_addop_text,@,f_minisfx,@,f_flr_rnd,@,f_in_split,@,f_roundrect,@,f_draw_pkmn,@,f_strtoq,@,f_hurt_self,@,f_moveutil_hpchange,@,f_moveutil_dmgself,@,f_moveutil_dmgother,@,f_moveutil_movemod,@,f_moveutil_typeadv,@,f_moveutil_calc_move_damage,@,f_movehelp_effect_works,@,f_move_major_other,@,f_move_splash,@,f_move_recover,@,f_move_default,@,f_move_seismictoss,@,f_move_psywave,@,f_move_superfang,@,f_move_falseswipe,@,f_move_submission,@,f_move_struggle,@,f_move_multihit_set,@,f_move_barrage,@,f_move_doublekick,@,f_move_flail,@,f_move_return,@,f_move_frustration,@,f_move_present,@,f_move_magnitude,@,f_move_hiddenpower,@,f_move_stat,@,c_move_names,@,c_trnr_names,@,c_type_names,@,c_item_names,@,c_team_names,@,c_stages,@,c_pkmn_names,@,c_gender_names,@,c_major_names_long,@,c_major_names_short,@,c_movemethod_names,@,c_statmod_names,@,c_palettes,@,c_palette_names,@,c_types,@,f_init_peek_inc,@,f_unlock,@,f_update_locks,@,f_create_spot,@,f_get_edit_op_pkmn,@,f_op_template_edit,@,f_info_toggle,@,f_leagueinfo,@,f_add_stat_move,@,f_add_stat_preview,@,f_add_stat,@,f_print_info,@,f_print_top,@,f_print_bot,@,f_get_move_texts,@,f_prefix_space,@,f_prefix_zero,@,f_add_battle,@,f_create_active,@,f_create_player,@,f_get_other_pl,@,f_set_both_players,@,f_get_live_pkmn,@,f_get_next_active,@,f_end_battle,@,f_newaction,@,f_addaction,@,f_turn_addattack,@,f_pkmn_comes_out,@,f_pop_next_action,@,f_set_player_priority,@,f_movelogic,@,f_start_turn,@,f_start_battle,@,f_mkpkmn,@,f_team_party,@,f_fill_team,@,f_team_league,@",f_zobj,f_zobj_set,f_zobj_eval,function(func,text,...)
foreach(f_zobj(text,...),function(params)
func(unpack(params))
end)
end,function()
g_top_grid.op,g_top_grid.preview_op,g_top_grid.lrlist={},{},{}
g_top_grid:gridpofunc()
end,function(grid)
add(g_gridstack,{obj=grid})
g_grid_called_init=false
end,function()
deli(g_gridstack)
g_grid_called_init=false
end,function(gridname)
return@_g[gridname].g_cg_m.sel
end,function(gridname,val)
poke(_g[gridname].g_cg_m.sel,val)
end,function(name,memloc,main_grid_spec,info_grid_spec,main_op_func,main_sel_func,main_leave_func,lrbasegrid,static,init,arg)
_g[name]=f_zobj("init,@,g_cg_m,@,g_cg_s,@,gridpofunc,@,arg,@",
init,
f_zobj("sel,@,view,@,name,@,selfunc,@,leavefunc,@,lrbasegrid,@,static,@,w,@,vh,@,x,@,y,@,cw,@,ch,@,selw,@,selh,@",memloc,memloc+1,name,main_sel_func,main_leave_func,lrbasegrid,static,unpack(main_grid_spec)),
f_zobj("sel,@,view,@,static,~c_no,disabled,~c_yes,name,@,w,@,vh,@,x,@,y,@,cw,@,ch,@,selw,@,selh,@",0x5ec6,0x5ec6+1,name,unpack(info_grid_spec)),
main_op_func,
arg
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
end,function(num,x,y,style,flip,selected,disabled,func)
func=func or f_nop
local in_c=disabled and 2 or selected and 3 or 2
local out_c=disabled and 1 or 1
local row=num/8\1
local col=num%8
local width=style==0 and 6 or 16
if(style ~=2 or disabled)and num==252 then
rectfill(x+width/2-1,y+width/2-1,x+width/2,y+width/2,disabled and 2 or out_c)
return
end
if style==2 and selected and not disabled and stat"46">-1 and g_cur_pkmn_cry==num then
x+=sin(g_shake_timer/4)
end
local row=num/8\1
local col=num%8
local width=style==0 and 6 or 16
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
for yy=-1,1,1 do
for xx=-1,1,1 do
colordrawfunc(x+xx,y+yy,out_c)
end
end
colordrawfunc(x,y,in_c)
func(x+(flip and-38+1 or 19+1),y)
end,function(s)
local ns=""
for i=1,#s do ns..="?" end
return ns
end,function(hurtby,divide,activation)
if activation then
f_turn_addattack(p_turn_self,"hurt by "..hurtby)
f_moveutil_dmgself(ceil(p_turn_self_active.maxhp/divide))
end
end,function(player,amount,callback_function,issub)
local pkmn=player.active
local hp=issub and pkmn.substitute or pkmn.hp
callback_function=callback_function or f_nop
amount=mid(amount>0 and hp or-pkmn.maxhp+hp,amount,0)
local dmgtxt=(amount>0 and "-"or "+")..abs(amount).." hp change"
local hpchange=function()
p_action_self_active.base.hp-=amount
if p_action_self_active.base.hp<=0 then
p_action_self_active.base.major=1
end
end
if amount==0 then
return true
else
local amount_str=(amount>0 and "-"or "+")..abs(amount)
local text=issub and "substitute "..amount_str.." hp"or amount_str.." hp change"
f_turn_addattack(player,text,function()
if issub then
hpchange()
if pkmn.substitute<=0 then
f_turn_addattack(player,
"substitute broke",
function()
callback_function(amount)
end
)
else
callback_function(amount)
end
else
f_turn_addattack(p_action_self,text,function()
hpchange()
callback_function(amount)
end)
end
end)
end
end,function(dmg)
return f_moveutil_hpchange(p_turn_self,dmg)
end,function(dmg,callback_function)
callback_function=callback_function or f_nop
local advantage,crit=1
if type(dmg)=="table"then
dmg,advantage,crit=f_moveutil_calc_move_damage(dmg,p_turn_self_active,p_turn_other_active)
end
if advantage>0 then
f_zcall(f_turn_addattack,";,~p_action_self,@;;,~p_action_self,@",advantage>1 and "super effect"or advantage<1 and "little effect",crit and "critical hit")
return f_moveutil_hpchange(p_turn_other,dmg,function(dmg)
callback_function(dmg)
end,p_turn_other_active.substitute>0)
else
f_turn_addattack(p_turn_other,"resists attack")
end
end,function(active,move)
if f_in_split(move.num,"130,129 ")
or move.num==230 and not p_action_other.nextmove then
return 2
elseif move.num==88 then
return p_turn_self_active.numtimes
end
return 1
end,function(move,defender)
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
end,function(_ENV)
return f_moveutil_typeadv(_ENV,p_turn_other_active)>0 and pktype ~=p_turn_other_active.pktype1 and pktype ~=p_turn_other_active.pktype2
end,function(_ENV,majorind)
if p_turn_other_active.major==3 and majorind==2 then
f_turn_addattack(p_turn_other,"thawed out",function()
p_turn_other_active.base.major=0
end)
elseif p_turn_other_active.major==0 and(majorind==6 or f_movehelp_effect_works(_ENV))then
f_turn_addattack(p_turn_other,"now "..c_major_names_long[majorind],function()
p_turn_other_active.base.major=majorind
p_turn_other_active.sleeping=f_flr_rnd"7"+1
end)
else
return true
end
end,function()f_turn_addattack(p_action_self,"does nothing")end,function(_ENV)return f_moveutil_hpchange(p_action_self,-p_action_self_active.maxhp\2)end,function(_ENV,percent,func,...)
local params={_ENV,...}
f_moveutil_dmgother(_ENV,function()
if rnd"100"<(percent or 0)then
func(unpack(params))
end
end)
end,function(_ENV,spec)f_moveutil_dmgother(spec)end,function()f_moveutil_dmgother(f_flr_rnd"75"+1)end,function()f_moveutil_dmgother(ceil(p_action_other_active.hp/2))end,function(_ENV)
local dmg=f_moveutil_calc_move_damage(_ENV,p_turn_self_active,p_turn_other_active)
return f_moveutil_dmgother(min(p_turn_other_active.hp-1,dmg))
end,function(_ENV)
f_moveutil_dmgother(_ENV,function(dmg)
f_moveutil_dmgself(ceil(dmg/4))
end)
end,function(_ENV)
f_moveutil_dmgother(_ENV,function(dmg)
f_moveutil_dmgself(ceil(p_turn_self_active.maxhp/4))
end)
end,function(_ENV,hitcount,isresume)
if hitcount>0 then
f_turn_addattack(p_turn_self,isresume and "resumes "..name,function()
p_turn_self_active.numtimes+=1
f_moveutil_dmgother(_ENV,function()
f_move_multihit_set(_ENV,hitcount-1,true)
end)
end)
end
end,function(_ENV)
f_move_multihit_set(_ENV,2+f_flr_rnd"4")
end,function(_ENV,spec)
f_move_multihit_set(_ENV,spec)
end,function(_ENV)
local hplist=f_zobj";,.7,20;;,.4,40;;,.2,80;;,.1,100;;,.05,150"
local perc=p_turn_self_active.hp/p_turn_self_active.maxhp
local pow=200
for pair in all(hplist)do
if perc>pair[1]then
pow=pair[2]
break
end
end
f_moveutil_dmgother(f_zobj_setmeta(_ENV,"pow,@",pow))
end,function(_ENV)
local is_happy=p_turn_self_active.hp/p_turn_self_active.maxhp>=p_turn_other_active.hp/p_turn_other_active.maxhp
f_moveutil_dmgother(f_zobj_setmeta(_ENV,"pow,@",is_happy and 100 or 50))
end,function(_ENV)
local is_sad=p_turn_self_active.hp/p_turn_self_active.maxhp<=p_turn_other_active.hp/p_turn_other_active.maxhp
f_moveutil_dmgother(f_zobj_setmeta(_ENV,"pow,@",is_sad and 100 or 50))
end,function(_ENV)
local perc,pow=rnd()
for pair in all(f_zobj";,.2,120;;,.3,80;;,.6,40")do
if perc>pair[1]then
pow=pair[2]
end
end
if pow then
f_moveutil_dmgother(f_zobj_setmeta(_ENV,"pow,@",pow))
else
return f_moveutil_hpchange(p_turn_other,-p_turn_other_active.maxhp\4)
end
end,function(_ENV)
local perc,num,pow=rnd()
for i,pair in ipairs(f_zobj";,0,10;;,.05,30;;,.15,50;;,.35,70;;,.65,90;;,.85,110;;,.95,150")do
if perc>=pair[1]then
pow,num=pair[2],i+3
end
end
f_turn_addattack(p_turn_self,"magnitude "..num)
f_moveutil_dmgother(f_zobj_setmeta(_ENV,"pow,@",pow))
end,function(_ENV)
local possible_types={}
for i=1,18 do
local v=f_moveutil_typeadv(f_zobj_setmeta(_ENV,"pktype,@",i),p_turn_other_active)
if v>1 then
add(possible_types,i)
end
end
local newpktype=#possible_types>0 and possible_types[f_flr_rnd(#possible_types)+1]or 18
f_turn_addattack(p_turn_self,"type "..c_type_names[newpktype])
pktype=newpktype
f_moveutil_dmgother(f_zobj_setmeta(_ENV,"pow,@",60))
end,function(_ENV,isself,key,stage,func)
local pl=isself and p_turn_self or p_turn_other
local prev=pl.active.stages[key]
if not pl.active.misted or stage>0 then
pl.active.stages[key]=mid(-6,6,prev+stage)
end
if prev ~=pl.active.stages[key]then
f_turn_addattack(pl,(sgn(stage)>0 and "+"or "-")..abs(stage).." "..c_stages[key].." stat",func or f_nop)
else
return true
end
end,f_zobj"0,strugl;,acid,acidar,barage,bonclb,bind,clamp,moonlt,lechsd,extrsp,sncbom,twindl,thnshk,glare,gilotn,hypfng,jmpkck,kinsis,lockon,lovkis,macpnc,vicgrp,spican,spikes,spore,cotspr,presnt,vithrw,cmtpnc,drlpck,sndatk,agilty,fryatk,qikatk,falswp,growl,healbl,sing,pound,minmiz,tailwp,dblslp,meghrn,bonrng,convr1,convr2,spark,mlkdrk,morsun,ngtshd,octzok,pinmis,pwdsnw,supfng,firspn,psngas,barier,medtat,ftrsgt,hypnos,psybem,litscr,safgrd,petdnc,charm,synths,swtscn,razlef,psnpwd,slppwd,absorb,stnspr,flail,confsn,slam,constr,amnesa,bubble,splash,hydpmp,mindrd,mist,hrnatk,spiweb,dblkck,swtkis,mtlclw,trform,trikck,gust,twistr,crbham,dizpnc,sludge,painsp,dstbnd,haze,lick,persng,meanlk,cnfray,crschp,smog,karchp,ember,smkscr,beldrm,beatup,scrtch,slash,ancpwr,leer,bite,outrge,scryfc,thrash,stomp,roksld,magtud,rocthr,harden,bonrsh,hijkck,recovr,aerbls,hrndrl,drgrag,sfboil,drgbre,slfdes,explsn,eggbmb,slgbmb,gigdrn,megdrn,swrdnc,cut,fryctr,thief,dig,rolout,dfncrl,detect,solbem,raidnc,flash,psycic,psycup,drmeat,ngtmar,shdbal,zapcan,thundr,thnblt,irntal,streng,rocsms,hedbut,mudslp,sunday,protct,dbltem,slptlk,curse,hidpwr,swager,frustr,return,toxic,snore,rest,endure,atract,bide,mimic,substu,rage,dbledg,takdwn,sklbas,bodslm,wtrgun,bblbem,icebem,blizrd,icywnd,surf,wrlpol,wtrfal,swift,payday,triatk,rflect,thnwav,telprt,psywav,metrnm,countr,megpnc,seitos,submis,megkck,dynpnc,firpnc,thnpnc,icepnc,firbls,flmthr,fisure,eartqk,sndstr,hypbem,roar,stlwng,fly,razwnd,wrlwnd,skyatk,wngatk,peck,mirmov,fntatk,witdrw,rapspn,supsnc,aurbem,mircot,psnstg,spite,crunch,pursut,strsht,lechlf,btnpas,disabl,screch,tackle,flmwel,revrsl,fryswp,fcseng,forsgt,lowkck,rolkck,encore,wrap,growth,vinwip,sacfir,sharpn,sketch,tm05,______",split"youngs,sage,falknr,grunt,bugctr,bugsy,pkmfan,beauty,witney,kimono,medium,morty,police,karate,chuck,gentle,sailor,jasmin,rocket,skier,pryce,scient,twins,clair,nerd,camper,brock,school,swimer,misty,jugler,guitar,ltsurg,hiker,lass,erika,biker,picnik,janine,maniac,psycic,sabrin,fisher,breath,blaine,birdkp,cooltr,blue,legend,silver,will,koga,bruno,karen,lance,red,gold,horde",f_zobj"0,none;,normal,fire,fightng,water,poison,electrc,ground,grass,flying,ice,bug,psychic,rock,dragon,ghost,dark,steel,bird",f_zobj"0,none;,pnkbow,chrcol,blkblt,myswtr,psnbrb,magnet,sosand,mirasd,shbeak,nvrice,slvpwd,twspon,hrdstn,dragsc,speltg,blkgls,mtlcot,plkbow,bripwd,focbnd,kingrk,leftov,qikclw,scopln,amcoin,litbal,lukpnc,mtlpwd,stick,thkclb,bersrk,berry,gldbry,btrbry,mntbry,brnbry,icebry,parbry,psnbry,mirbry,mysbry",f_zobj"0,boy;,girl,cpu-boy,cpu-girl",f_zobj"attack,attack,defense,defens,specialattack,spcatk,specialdefense,spcdef,speed,speed,crit,crit,evasion,evason,accuracy,accury",f_zobj"0,misingno;,bulbsaur,ivysaur,venusaur,charmand,charmeln,charzard,squirtle,wartortl,blastois,caterpie,metapod,butrfree,weedle,kakuna,beedrill,pidgey,pidgeoto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sndshrew,sndslash,nidoranf,nidorina,nidoquen,nidoranm,nidorino,nidoking,clefairy,clefable,vulpix,ninetale,jiglypuf,wiglytuf,zubat,golbat,oddish,gloom,vileplum,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlith,arcanine,poliwag,polwhirl,polwrath,abra,kadabra,alakazam,machop,machoke,machamp,belsprot,weepnbel,victrbel,tntacool,tntcruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemit,magneton,fafetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrod,exegcute,exegutor,cubone,marowak,hitmnlee,hitmnchn,licktung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangakan,horsea,seadra,goldeen,seaking,staryu,starmie,mrmime,scyther,jynx,elecabuz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodact,snorlax,articuno,zapdos,moltres,dratini,dragnair,dragnite,mewtwo,mew,chikrita,bayleef,meganium,cyndquil,quilava,typhlosn,totodile,croconaw,fralgatr,sentret,furret,hoothoot,noctowl,ledyba,ledian,spinarak,ariados,crobat,chinchou,lanturn,pichu,cleffa,igglybuf,togepi,togetic,natu,xatu,mareep,flaaffy,ampharos,belossom,marill,azumaril,sudwoodo,politoed,hoppip,skiploom,jumpluff,aipom,sunkern,sunflora,yanma,wooper,quagsire,espeon,umbreon,murkrow,slowking,misdrvus,unown,wobbufet,girafrig,pineco,foretres,dunsparc,gligar,steelix,snubbull,granbull,qwilfish,scizor,shuckle,heracros,sneasel,tediursa,ursaring,slugma,magcargo,swinub,piloswin,corsola,remoraid,octilery,delibird,mantine,skarmory,houndour,houndoom,kingdra,phanpy,donphan,porygon2,stantler,smeargle,tyrogue,hitmntop,smoochum,elekid,magby,miltank,blissey,raikou,entei,suicune,larvitar,pupitar,tyrnitar,lugia,hooh,celebi,________,none,___,___",f_zobj"0,neuter;,male,female,mal/fem",f_zobj"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",f_zobj"0,___;,fnt,brn,fzn,par,psn,slp",split"learn,teach,cheat",f_zobj"attack,atack,defense,defns,specialattack,spatk,specialdefense,spdfn,speed,speed,evasion,evasn,accuracy,acury,crit,critl",f_zobj"0;,129,13,6;;,0,5,6;;,131,3,138;;,0,8,10;;,141,12,7;;,1,140,8;;,5,9,10",f_zobj"0,dual;,pong,gboy,hdog,cga,rebl,gosi",f_zobj"0;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,;;,",function()
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
f_save_party_pkmn(f_mkpkmn(ind,c_pokemon[ind],true,0,0,5,5,5,5),0,i-1)
end
end
if@0x5efe==0 then
poke(0x5efe,1)
memset(0x5e2a,252,126)
end
for i=start_trnr,min(58,@0x5eff)do
local team=f_team_league(i,i\58*251+1)
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
end,function(op,toggle_grid,enemyname)
local toggle=g_cg_m.name==toggle_grid
f_print_info(op,";,@,playr ,@;;,@,enemy ,@",toggle and "\f3"or "\f1",c_team_names[f_getsel(toggle_grid)],toggle and "\f1"or "\f3",enemyname)
end,function(op)
local name=c_trnr_names[f_getsel"g_grid_picktrnr"+1]
f_info_toggle(op,"g_grid_pickleag",(@0x5eff+1<f_getsel"g_grid_picktrnr"+1)and f_strtoq(name)or name)
end,function(op,pkmn,ind)
ind=ind+1
local move=pkmn[ind]
local movenum=move.num
local maxpp,pp,pow,accuracy,typ=f_get_move_texts(move)
local method=pkmn.possible_moves_method[movenum]or "empty"
add(op,{text="move"..ind.." "..move.name,disabled=true})
add(op,{text=""..method.." "..typ})
add(op,{text="   pp "..pp.."/"..maxpp})
add(op,{text="pw/ac "..pow.."/"..accuracy})
end,function(op,pkmn,player)
local draw_preview=function(off)
f_draw_pkmn(pkmn.num,21,off-12,2,p_battle_top and player==p_battle_top,true,false)
end
add(op,{text="#"..f_prefix_zero(pkmn.num,3).." "..pkmn.name,disabled=true})
add(op,{draw=function()draw_preview"17" end})
add(op,{draw=function()draw_preview"8" end})
add(op,{draw=function()draw_preview"-1" end})
end,function(op,pkmn,player)
f_add_stat_preview(op,pkmn,player)
add(op,{text="peek "..pkmn.name,disabled=true})
if player then
add(op,{text="major "..c_major_names_long[pkmn.major]})
else
add(op,{text="prevo "..c_pkmn_names[pkmn.prevolve]})
end
add(op,{text="   hp "..f_prefix_zero(pkmn.hp,3).."/"..f_prefix_zero(pkmn.maxhp,3)})
add(op,{text=" item "..c_item_names[pkmn.item]})
add(op,{text="info "..pkmn.name,disabled=true})
add(op,{text="gendr "..c_gender_names[pkmn.gender]})
add(op,{text="type1 "..c_type_names[pkmn.pktype1]})
add(op,{text="type2 "..c_type_names[pkmn.pktype2]})
add(op,{text="stat "..pkmn.name,disabled=true})
add(op,{text="at/df "..f_prefix_zero(f_stat_calc(pkmn,"attack"),3).."/"..f_prefix_zero(f_stat_calc(pkmn,"defense"),3)})
add(op,{text="sa/sd "..f_prefix_zero(f_stat_calc(pkmn,"specialattack"),3).."/"..f_prefix_zero(f_stat_calc(pkmn,"specialdefense"),3)})
add(op,{text="sp/lv "..f_prefix_zero(f_stat_calc(pkmn,"speed"),3).."/050"})
if is_battle then
f_add_stat_move(op,pkmn,0)
f_add_stat_move(op,pkmn,1)
f_add_stat_move(op,pkmn,2)
f_add_stat_move(op,pkmn,3)
end
end,function(op,...)
local params={...}
add(op,{draw=function()
local infoobj=f_zobj(unpack(params))
f_print_top(unpack(infoobj[1]))
f_print_bot(unpack(infoobj[2]))
end})
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
local maxpp,pp,pow,accuracy,typ=f_prefix_zero(move.maxpp,2),f_prefix_zero(move.pp_obj.pp,2),f_prefix_zero(move.pow,3),f_prefix_zero(move.accuracy,3),c_type_names[move.pktype]
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
end,function(op)
local b=function(player,px,py,flip)
add(op,{draw=function()
local invisible=player.active.invisible
local team=player.team
local active=player.active
f_draw_pkmn(invisible and player.num or active.num,px,py,2,flip,p_action_self==player,false,invisible and f_nop or function(x,y)
print(active.name,x+1,y,1,-1)
local hp=active.hp
local maxhp=active.maxhp
local spot=active.spot
local major=active.major
if hp>0 then
rectfill(x,y+6,x+mid(0,hp/maxhp*32,32),y+9,1)
pset(x,y+6,2)
pset(x,y+9,2)
pset(x+32,y+6,2)
pset(x+32,y+9,2)
end
local tx,ty=x+14,y+13
for i=0,5 do
if spot==i+1 or team[i+1].valid and team[i+1].major ~=1 then
pset(tx+i%3*2,ty+i\3*2-1,spot==i+1 and 3 or 1)
end
end
local majtext=c_major_names_short[major]
local hptext=f_prefix_zero(hp,3)
print(majtext.."  "..hptext,x+1,y+11,1,-1)
end)
end})
end
b(p_battle_top,39,1,true)
b(p_battle_bot,3,1)
end,function(_ENV,ind)
local bench_parent=team[ind]
local active=f_zobj_setmeta(team[ind],"isactive,~c_yes,lastmoverecv,0,moveturn,0,invisible,~c_yes,counterdmg,0,bidedmg,0,disabledtimer,0,confused,0,sleeping,@,substitute,0,toxiced,0,spot,@,base,@;stages;attack,0,defense,0,specialattack,0,specialdefense,0,speed,0,crit,0,evasion,0,accuracy,0;",f_flr_rnd"7"+1,ind,bench_parent)
for i=1,4 do
active[i]=f_zobj_setmeta(bench_parent[i],"")
end
return active
end,function(name,team,subname,num,iscpu)
local player=f_zobj("team,@,name,@,subname,@,num,@,iscpu,@,actions,#,greed,7",team,name,subname,num,iscpu)
for i=1,6 do
if team[i].valid then
player.active=f_create_active(player,i)
break
end
end
return player
end,function(player)
return player==p_battle_bot and p_battle_top or p_battle_bot
end,function(zobjtext,player)
f_zobj_set(_g,zobjtext,player,f_get_other_pl(player),player.active,f_get_other_pl(player).active)
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
f_set_both_players("p_action_self,@,p_action_other,@,p_action_self_active,@,p_action_other_active,@",player)
f_zcall(f_pop_ui_stack,";,;;,;;,")
f_add_to_ui_stack(g_grid_battle_results)
end,function(level,player,message,logic,isplayeraction)
return f_zobj("level,@,player,@,message,@,logic,@,isplayeraction,@",level,player,message or false,logic or f_nop,isplayeraction)
end,function(player,...)
add(player.actions,f_newaction(...))
end,function(...)
f_addaction(p_turn_self,3,...)
end,function(player,spot,level)
local pkmn=player.team[spot]
player.active=f_create_active(player,spot)
return f_newaction(level,player,"sends "..player.active.name,function()
player.active.invisible=false
return player.active.num
end,true)
end,function()
for player in all{p_first,p_last}do
if player.active.major==1 then
if player.active.invisible then
return player,f_pkmn_comes_out(player,f_get_next_active(player),3)
else
for np in all{p_first,p_last}do
for action in all(np.actions)do
if action.level<=4 and player==action.player then
del(np.actions,action)
end
end
end
return player,f_newaction(1,player,"backs "..player.active.name,function()
player.active.invisible=true
f_fill_team(player.team,player.active.spot)
end,true)
end
end
end
for level=1,12 do
for player in all{p_first,p_last}do
for action in all(player.actions)do
if action.level==level then
return player,del(player.actions,action)
end
end
end
end
end,function(player)
f_set_both_players("p_action_self,@,p_action_other,@,p_action_self_active,@,p_action_other_active,@",player)
local priority_class=3000
local movenum=p_action_self.nextmove and p_action_self.nextmove.num
if not movenum then priority_class=6000
elseif movenum==230 and not p_action_other.movenum then priority_class=7000
elseif f_in_split(movenum,"216,212,194 ")then priority_class=0000
elseif f_in_split(movenum,"33,20,9 ")then priority_class=4000
elseif f_in_split(movenum,"197,226 ")then priority_class=1000
elseif movenum==27 then priority_class=2000
end
p_action_self.priority=priority_class+f_stat_calc(p_action_self_active,"speed",true)
end,function(player)
local move=player.nextmove
f_addaction(player,4,player,(player.active.curmove and "resumes "or(move.func==f_move_multiturn and "begins "or "uses "))..c_move_names[move.num],function()
move.pp_obj.pp=max(0,move.pp_obj.pp-1)
if(function()
if move.accuracy<=0 then return false end
return rnd(f_stat_evac(p_action_other_active.stages["evasion"]))>move.accuracy/100*f_stat_evac(p_action_self_active.stages["accuracy"])or f_flr_rnd"256"==0 and f_flr_rnd"256"==0
end)()then
f_turn_addattack(player,"misses "..move.name)
if f_in_split(move.num,"M_HIGH_JUMP_KICK,M_JUMP_KICK")then
f_moveutil_dmgself"1"
end
else
if move:func(unpack(move.params))then
f_turn_addattack(player,"fails attack")
end
end
if f_in_split(move.num,"130,129 ")then
f_moveutil_dmgself(p_action_self_active.hp)
end
end)
f_addaction(player,4,player,false,function()
f_hurt_self("poison",8,p_turn_self_active.major==5)
f_hurt_self("burn",8,p_turn_self_active.major==2)
f_hurt_self("curse",4,p_turn_self_active.cursed)
f_hurt_self("dream",4,p_turn_self_active.nightmare)
end)
end,function()
local x=function()
if p_action_self.iscpu then
local possible_moves={}
for i=1,4 do
if p_action_self_active[i].num<252 and p_action_self_active[i].pp_obj.pp>0 then
add(possible_moves,i)
end
end
if #possible_moves>0 then
p_action_self.nextmove=p_action_self_active[possible_moves[f_flr_rnd(#possible_moves)+1]]
else
p_action_self.nextmove=c_moves[0]
end
f_movelogic(p_action_self)
else
f_addaction(p_action_self,1,p_action_self,"begins turn",function()
f_pop_ui_stack()
f_setsel("g_grid_battle_select",0)
if p_action_self==p_battle_bot then
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
f_set_both_players("p_first,@,p_last,@",p_battle_bot)
f_addaction(p_battle_bot,1,p_battle_bot,not p_battle_bot.iscpu and "begins turn",x,true)
f_addaction(p_battle_top,1,p_battle_top,not p_battle_top.iscpu and "begins turn",x,true)
f_addaction(p_battle_bot,2,p_battle_bot,false,function()
f_set_player_priority(p_battle_bot)
f_set_player_priority(p_battle_top)
if p_battle_bot.priority==p_battle_top.priority then p_battle_top.priority+=sgn(rnd"2"-1)end
f_set_both_players("p_first,@,p_last,@",p_battle_bot.priority>p_battle_top.priority and p_battle_bot or p_battle_top)
end)
end,function(p1winfunc,...)
p_battle_bot,p_battle_top=f_create_player("playr",f_team_party(@0x5eae),c_team_names[@0x5eae],253+@0x5eae%2,@0x5eae>1),f_create_player("enemy",...)
f_set_both_players("p_first,@,p_last,@",p_battle_bot)
g_p1_winfunc=p1winfunc
f_set_both_players("p_action_self,@,p_action_other,@,p_action_self_active,@,p_action_other_active,@",p_battle_bot)
memset(0x5eba,0,12)
f_addaction(p_battle_bot,1,p_battle_bot,"begins battle",f_nop,true)
add(p_battle_bot.actions,f_pkmn_comes_out(p_battle_bot,p_battle_bot.active.spot,1))
f_addaction(p_battle_top,1,p_battle_top,"begins battle",f_nop,true)
add(p_battle_top.actions,f_pkmn_comes_out(p_battle_top,p_battle_top.active.spot,1))
f_add_to_ui_stack(g_grid_battle_firstaction)
f_s_bataction()
end,function(ind,base,respect_locks,gender_bit,item,...)
local pkmn=f_zobj_setmeta(base,"num,@,base,@,gender_bit,@,item,@,valid,@,seen_moves,#,major,0,gender,0,substitute,0,evasion,100,accuracy,100,crit,1,numtimes,0;stages;attack,0,defense,0,specialattack,0,specialdefense,0,speed,0,crit,0,evasion,0,accuracy,0;",ind,base,gender_bit,item%42,ind<252)
pkmn.gender=pkmn.gender_mask
if gender_bit and pkmn.gender_mask==3 then
pkmn.gender=gender_bit%2+1
end
local moves={...}
for i=1,4 do
local move=mid(1,moves[i],#pkmn.possible_moves)
while pkmn.seen_moves[move]or respect_locks and not c_moves[pkmn.possible_moves[move]].lock do
move=move%#pkmn.possible_moves+1
end
pkmn.seen_moves[move]=true
local num=pkmn.possible_moves[move]
pkmn[i]=f_zobj_setmeta(c_moves[num],"num,@,pid,@",num,move)
pkmn[i].pp_obj={pp=pkmn[i].maxpp}
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
team[spot]=f_mkpkmn(pkmn_ind,c_pokemon[pkmn_ind],false,team.trainer.num==255 and pkmn_ind or team.trainer.num+1,c_pokemon[pkmn_ind].default_item,5,6,7,last_move)
team.fill_ind+=1
end
end,function(trainer_num,fill_ind)
local team={fill_ind=fill_ind,trainer=c_trainers[trainer_num]}
for i=1,6 do
f_fill_team(team,i)
end
return team
end)
f_zobj_set(_g,"f_get_party_pkmn,@,f_save_party_pkmn,@,f_stat_crit,@,f_stat_evac,@,f_stat_calc,@,f_init_batresults,@,f_op_pickedit,@,f_op_pickleagueenemy,@,f_op_pickleagueplayr,@,f_op_pickversus,@,f_op_def,@,f_op_edititem,@,f_op_statbrowse,@,f_op_browse,@,f_op_statbattle,@,f_add_edit,@,f_op_editteam,@,f_op_title,@,f_op_editmovebot,@,f_op_editstat,@,f_op_editmove,@,f_op_batsel,@,f_op_movesel,@,f_op_dmovsel,@,f_op_batswitch,@,f_op_batresults,@,f_op_batstats,@,f_add_browse_info_template,@,f_add_browse_info,@,f_add_editbrowse_info,@,f_dt_batstats,@,f_s_batresults,@,f_l_browse,@,f_s_browse,@,f_s_versus,@,f_s_league,@,f_s_batstat,@,f_s_edit,@,f_s_editteam,@,f_s_editstat,@,f_s_editmovebot,@,f_s_battle,@,f_s_title,@,f_s_pkstat,@,f_s_statedit,@,f_s_statbat,@,f_s_versusbegin,@,f_s_batbegin,@,f_s_editpkmn,@,f_s_editmove,@,f_s_edititem,@,f_l_title,@,f_l_battle,@,f_s_batmove,@,f_s_dmovsel,@,f_s_batswitch,@,f_op_bataction,@,f_s_bataction,@,_update,@,_draw,@",function(party_num,spot_num)
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
end,function()
f_setsel("g_grid_battle_results",p_action_other_active.spot-1)
if p_action_other==p_battle_bot then
g_p1_winfunc()
end
end,function(_ENV)
local pkstr_arr={}
local pkstr_lens=split"2,2,2,2,1,1"
for ii=0,5 do
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",ii)
add(pkstr_arr,sub(c_pkmn_names[pkmn.num],1,pkstr_lens[ii+1]))
end
f_print_info(preview_op,";,edit ,@;;,@,-,@,-,@,-,@,-,@,@",c_team_names[f_getsel"g_grid_pickedit"],unpack(pkstr_arr))
f_add_edit(op)
end,function(_ENV)
for i=1,58 do
local disabled=@0x5eff+1<i
add(op,{text=disabled and f_strtoq(c_trnr_names[i])or c_trnr_names[i],disabled=disabled})
end
f_leagueinfo(preview_op)
end,function(_ENV)
f_add_edit(op,true)
f_leagueinfo(preview_op)
end,function(_ENV)
f_info_toggle(preview_op,"g_grid_pickplr1",c_team_names[f_getsel"g_grid_pickplr2"])
f_add_edit(op,true)
end,function(_ENV)add(op,{})end,function(_ENV)
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_print_info(preview_op,";,edit item;;,@,@, ,@","#",pkmn.num_str,pkmn.name)
f_op_template_edit(op,c_items,"item")
end,function(_ENV)
f_add_browse_info(preview_op)
f_add_stat(op,c_pokemon[f_getsel"g_grid_browse"])
end,function(_ENV)
arg(preview_op)
for i=0,251 do
local disabled=not c_pokemon[i].lock
add(op,{lrvalid=not disabled,disabled=disabled,draw=function(_,is_sel,gridobj)
f_draw_pkmn(c_pokemon[i].lock and i or 252,1,1,0,false,is_sel,gridobj.disabled)
end})
end
end,function(_ENV)
f_dt_batstats(preview_op,f_getsel"g_grid_picktrnr",f_getsel"g_grid_battle_stats")
local bothteams={}
for i=1,6 do add(bothteams,i==p_action_self_active.spot and p_action_self_active or p_action_self.team[i])end
for i=1,6 do add(bothteams,i==p_action_other_active.spot and p_action_other_active or p_action_other.team[i])end
f_add_stat(op,bothteams[f_getsel"g_grid_battle_stats"+1],f_getsel"g_grid_battle_stats">=6 and p_action_other or p_action_self)
end,function(op,disable_empty)
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
add(op,{data=inds,disabled=disable_empty and valid,draw=function(i,is_sel,gridobj)
for ii,ind in ipairs(gridobj.data)do
f_draw_pkmn(ind,(ii-1)%3+1+(ii-1)%3*9,1+(ii-1)\3*10,0,false,is_sel,gridobj.disabled)
end
end})
end
end,function(_ENV)
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
f_print_info(preview_op,";,edit spot,@;;,@,@, ,@",f_getsel"g_grid_pickspot"+1,"#",pkmn.num_str,pkmn.name)
for pkmnnum=0,5 do
local pkmn=f_get_party_pkmn(f_getsel"g_grid_pickedit",pkmnnum)
add(op,{lrvalid=pkmn.valid,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,1,false,is_sel,false)
end})
end
end,function(_ENV)
add(preview_op,{draw=function()
local tcol=g_title_sel and 3 or 1
local bcol=g_title_sel and 1 or 3
local messages=f_zobj(",\^w\f1rom \n\f3hack\n\f1 plz,\^w\f1thx!\n\f3bulb\npdia,\^w\f1thx!\n\f3nint\nendo,\^w\f1easy\n\f3cmfy\n\f1shrt,\^w\f3upok\ncntr\n\f1thx!,\^w\f1disa\nsmbl\n\f3thx!,\^w\f1poke\nhist\n\f3thx!,\^w\f3smo \n gon\n\f1thx!,\^w\f1 by \n\f3alan\nxoc3,\^w\f332kb\n\f1pico\ncart,\^w\f3thx!\n\f1shri\nnko8,\^w\f1ctch\n\f3 em'\n\f1all!,\^w\f1awww\n\f3hmph\n\f1ohho,\^w\f3thx!\n\f1sere\n bii,\^w\f1nihi\n\f3only\n\f1grls,\^w\f3gen2\n\f1batl\n sim,@","\^w\f3pico\n dex\n\f1"..c_palette_names[g_palette])
f_draw_pkmn(g_title_l,7-4,14+1-1-3+10,2,false,g_title_sel,false,function(x,y)
print(messages[g_title_l%#messages+1],x+3,y-1)
end)
f_draw_pkmn(g_title_r,35+4,14+1-1-3-4+1-9+3-1,2,true,not g_title_sel,false,function(x,y)
print(messages[g_title_r%#messages+1],x,y)
end)
end})
foreach(split"view,edit,league,versus",function(text)
f_addop_text(op,text)
end)
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
add(op,{text=c_gender_names[pkmn.gender],disabled=pkmn.gender_mask<3,select=function()
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
local movenum=pkmn.possible_moves[f_getsel"g_grid_editmove"+1]
local move=c_moves[movenum]
local method=pkmn.possible_moves_method[movenum]
local maxpp,pp,pow,accuracy,typ=f_get_move_texts(move)
local ind=f_getsel"g_grid_editmovebot"+1
f_print_info(preview_op,";,edit move,@;;,@, ,@",ind,method,typ)
for i,num in ipairs(pkmn.possible_moves)do
f_create_spot(c_moves[num],op,pkmn.seen_moves[i])
end
end,function(_ENV)
add(op,{text="fight",select=function()
local should_struggle=true
for i=1,4 do
if p_action_self_active[i].pp_obj.pp>0 then
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
f_setsel("g_grid_battle_switch",p_action_self_active.spot-1)
f_add_to_ui_stack(g_grid_battle_switch)
end})
add(op,{text="view",select=function()
f_setsel("g_grid_battle_stats",p_action_self_active.spot-1)
f_add_to_ui_stack(g_grid_battle_stats)
end})
add(op,{text="run",select=function()f_end_battle(p_action_self)end})
f_add_battle(preview_op)
end,function(_ENV)
for i=1,4 do
add(op,{text=c_move_names[p_action_self_active[i].num],disabled=p_action_self_active[i].pp_obj.pp==0})
end
f_add_stat_move(preview_op,p_action_self_active,f_getsel"g_grid_battle_movesel")
end,function(_ENV)
f_print_info(op,";,no more moves;;,use struggle?")
f_add_stat_move(preview_op,p_action_self_active,-1)
end,function(_ENV)
local pkind=f_getsel"g_grid_battle_switch"
local trainer_ind=f_getsel"g_grid_picktrnr"
local name=c_trnr_names[trainer_ind+1]
local pkmn=p_action_self.team[pkind%6+1]
local player=pkind<6 and p_action_self or p_action_other
f_print_info(preview_op,";,swap ,@;;,@, spot,@",pkmn.name,player.name,pkind%6+1)
for i=1,6 do
local pkmn=p_action_self.team[i]
local disabled=not pkmn.valid or i==p_action_self_active.spot or pkmn.major==1
add(op,{disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,1,p_action_self==p_battle_top,is_sel,disabled)
end})
end
end,function(_ENV)
for i=1,6 do
local pkmn=p_action_other.team[i]
local disabled=not pkmn.valid or pkmn.major==1
add(op,{disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,2,p_action_other==p_battle_top,is_sel,disabled)
end})
end
f_print_info(preview_op,";,@, ,@;;,is the winner!",p_action_other.name,p_action_other.subname)
end,function(_ENV)
f_dt_batstats(preview_op,f_getsel"g_grid_picktrnr",f_getsel"g_grid_battle_stats")
for i=1,6 do
local pkmn=p_action_self.team[i]
local disabled=not pkmn.valid
add(op,{lrvalid=not disabled,disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,1,p_action_self==p_battle_top,is_sel,disabled)
end})
end
for i=1,6 do
local pkmn=p_action_other.team[i]
local disabled=not pkmn.valid
add(op,{lrvalid=not disabled,disabled=disabled,draw=function(i,is_sel)
f_draw_pkmn(pkmn.num,1,1,1,p_action_other==p_battle_top,is_sel,disabled)
end})
end
end,function(op,selname,topline)
local pkmn=c_pokemon[f_getsel(selname)]
local namestr=pkmn.name
if not pkmn.lock then
namestr=f_strtoq(namestr)
end
f_print_info(op,";,@;;,@,@, ,@",topline,"#",f_prefix_zero(pkmn.num,3),namestr)
end,function(op)f_add_browse_info_template(op,"g_grid_browse","view picodex")end,function(op)f_add_browse_info_template(op,"g_grid_editpkmn","edit spot"..(f_getsel"g_grid_pickspot"+1))end,function(op,trainer_ind,pkind)
local player=pkind<6 and p_action_self or p_action_other
local name=c_trnr_names[trainer_ind+1]
local pkmn=player.team[pkind%6+1]
f_print_info(op,";,@, spot,@;;,view ,@",player.name,pkind%6+1,pkmn.name)
end,function()
return p_action_other.team[f_getsel"g_grid_battle_results"+1].num
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
return f_getsel"g_grid_browse"
end,function()
g_preview_timer=20
return f_get_party_pkmn(f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot").num
end,function()
g_preview_timer=20
local bothteams={}
for i=1,6 do add(bothteams,p_action_self.team[i])end
for i=1,6 do add(bothteams,p_action_other.team[i])end
return bothteams[f_getsel"g_grid_battle_stats"+1].num
end,function()
f_start_battle(
f_nop,
f_team_party(f_getsel"g_grid_pickplr2"),
c_team_names[f_getsel"g_grid_pickplr2"],
253+f_getsel"g_grid_pickplr2"%2,
f_getsel"g_grid_pickplr2">1
)
end,function()
local loc=f_getsel"g_grid_picktrnr"
f_start_battle(function()
if loc==@0x5eff then
poke(0x5eff,max(loc+1,@0x5eff))
poke(0x5eb2,min(@0x5eff,57))
f_update_locks(loc)
end
end,f_team_league(loc+1,1),c_trnr_names[loc+1],c_trainers[loc+1].num,true)
end,function()
f_save_party_pkmn(f_mkpkmn(f_getsel"g_grid_editpkmn",c_pokemon[f_getsel"g_grid_editpkmn"],true,@0x5eae,0,5,6,7,8),f_getsel"g_grid_pickedit",f_getsel"g_grid_pickspot")
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
g_title_l=rnd"252"\1 return g_title_l
else
g_title_r=rnd"252"\1 return g_title_r
end
g_palette+=1
g_palette%=#c_palettes
end,function()
return p_action_self_active.invisible and 253 or p_action_self_active.num end,function()
p_action_self.nextmove=p_action_self_active[f_getsel"g_grid_battle_movesel"+1]
f_movelogic(p_action_self)
f_pop_ui_stack()
f_pop_ui_stack()
f_add_to_ui_stack(g_grid_battle_actions)
end,function()
p_action_self.nextmove=c_moves[0]
f_movelogic(p_action_self)
f_pop_ui_stack()
f_pop_ui_stack()
f_add_to_ui_stack(g_grid_battle_actions)
end,function()
p_action_self.nextmove=nil
local nextpkmn=f_getsel"g_grid_battle_switch"+1
f_addaction(p_action_self,4,p_action_self,"backs "..p_action_self_active.name,function()
p_action_self_active.invisible=true
add(p_action_self.actions,f_pkmn_comes_out(p_action_self,nextpkmn,4))
end,true)
f_pop_ui_stack()
f_pop_ui_stack()
f_add_to_ui_stack(g_grid_battle_actions)
end,function(_ENV)
if not g_msg_bot then end
f_print_info(preview_op,";,~g_msg_top;;,~g_msg_bot")
f_add_battle(op)
end,function()
while true do
for player in all{p_first,p_last}do
if not f_get_next_active(player)then
f_end_battle(player)
return
end
end
p_turn_self,p_curaction=f_pop_next_action()
if p_curaction then
f_set_both_players("p_action_self,@,p_action_other,@,p_action_self_active,@,p_action_other_active,@",p_curaction.player)
f_set_both_players("p_turn_self,@,p_turn_other,@,p_turn_self_active,@,p_turn_other_active,@",p_turn_self)
p_curaction.logic()
if p_curaction.message then
f_setsel("g_grid_battle_actions",p_action_self==p_battle_bot and 1 or 0)
g_msg_top=p_action_self.name.." "..p_action_self_active.name
if p_curaction.isplayeraction then
g_msg_top=p_action_self.name.." "..p_action_self.subname
end
g_msg_bot=p_curaction.message
return
end
else
f_set_both_players("p_action_self,@,p_action_other,@,p_action_self_active,@,p_action_other_active,@",p_battle_bot)
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
g_cg_m=g_top_grid.g_cg_m
g_cg_s=g_top_grid.g_cg_s
if not g_grid_called_init then
g_top_grid:init()
g_grid_called_init=true
g_top_grid.op,g_top_grid.preview_op,g_top_grid.lrlist={},{},{}
g_top_grid:gridpofunc()
end
gridpo=g_top_grid.op
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
if g_top_grid then
f_draw_grid(g_top_grid.g_cg_m,g_top_grid.op,@g_top_grid.g_cg_m.sel,@g_top_grid.g_cg_m.view,g_top_grid.g_cg_m.x,g_top_grid.g_cg_m.y+easing*24,true)
f_draw_grid(g_top_grid.g_cg_s,g_top_grid.preview_op,-1,0,g_top_grid.g_cg_s.x,g_top_grid.g_cg_s.y-easing*45)
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
c_move_funcs=f_zobj"0;,~f_move_struggle,0;;,~f_move_default,10,~f_move_stat,~c_no,defense,-1;;,~f_move_stat,~c_yes,defense,2;;,~f_move_barrage,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_default;;,~f_move_seismictoss,20;;,~f_move_splash,0;;,~f_move_default,10,~f_move_major_other,4;;,~f_move_major_other,4;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_stat,~c_no,accuracy,-1;;,~f_move_splash,0;;,~f_move_major_other,6;;,~f_move_default;;,~f_move_default;;,~f_move_barrage,0;;,~f_move_splash,0;;,~f_move_major_other,6;;,~f_move_stat,~c_no,speed,-2;;,~f_move_present,0;;,~f_move_splash,0;;,~f_move_barrage,0;;,~f_move_default;;,~f_move_stat,~c_no,accuracy,-1;;,~f_move_stat,~c_yes,speed,2;;,~f_move_barrage,0;;,~f_move_default;;,~f_move_falseswipe,0;;,~f_move_stat,~c_no,attack,-1;;,~f_move_splash,0;;,~f_move_major_other,6;;,~f_move_default;;,~f_move_stat,~c_yes,evasion,1;;,~f_move_stat,~c_no,defense,-1;;,~f_move_barrage,0;;,~f_move_default;;,~f_move_doublekick,2;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_default,30,~f_move_major_other,4;;,~f_move_recover,0;;,~f_move_splash,0;;,~f_move_seismictoss,50;;,~f_move_default,50,~f_move_stat,~c_no,accuracy,-1;;,~f_move_barrage,0;;,~f_move_default,10,~f_move_major_other,3;;,~f_move_superfang,0;;,~f_move_splash,0;;,~f_move_major_other,5;;,~f_move_stat,~c_yes,defense,2;;,~f_move_stat,~c_yes,attack,1;;,~f_move_splash,0;;,~f_move_major_other,6;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_stat,~c_no,attack,-2;;,~f_move_splash,0;;,~f_move_stat,~c_no,evasion,-1;;,~f_move_splash,0;;,~f_move_major_other,5;;,~f_move_major_other,6;;,~f_move_splash,0;;,~f_move_major_other,4;;,~f_move_flail,0;;,~f_move_splash,0;;,~f_move_default;;,~f_move_default,10,~f_move_stat,~c_no,speed,-1;;,~f_move_stat,~c_yes,specialdefense,2;;,~f_move_default,10,~f_move_stat,~c_no,speed,-1;;,~f_move_splash,0;;,~f_move_default;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_default;;,~f_move_splash,0;;,~f_move_doublekick,2;;,~f_move_splash,0;;,~f_move_default,10,~f_move_stat,~c_yes,attack,1;;,~f_move_splash,0;;,~f_move_doublekick,3;;,~f_move_default;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_default,30,~f_move_major_other,5;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_default,30,~f_move_major_other,4;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_default,40,~f_move_major_other,5;;,~f_move_splash,0;;,~f_move_default,10,~f_move_major_other,2;;,~f_move_stat,~c_no,accuracy,-1;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_default;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_stat,~c_no,defense,-1;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_stat,~c_no,speed,-2;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_magnitude,0;;,~f_move_default;;,~f_move_stat,~c_yes,defense,1;;,~f_move_barrage,0;;,~f_move_splash,0;;,~f_move_recover,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_seismictoss,40;;,~f_move_recover,0;;,~f_move_default,30,~f_move_major_other,4;;,~f_move_default;;,~f_move_default;;,~f_move_default;;,~f_move_default,30,~f_move_major_other,5;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_stat,~c_yes,attack,2;;,~f_move_default;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_stat,~c_no,accuracy,-1;;,~f_move_default,10,~f_move_stat,~c_no,specialdefense,-1;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_default,20,~f_move_stat,~c_no,specialdefense,-1;;,~f_move_default,100,~f_move_major_other,4;;,~f_move_default,30,~f_move_major_other,4;;,~f_move_default,10,~f_move_major_other,4;;,~f_move_default,30,~f_move_stat,~c_no,defense,-1;;,~f_move_default;;,~f_move_default,50,~f_move_stat,~c_no,defense,-1;;,~f_move_splash,0;;,~f_move_default,100,~f_move_stat,~c_no,accuracy,-1;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_stat,~c_yes,evasion,1;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_hiddenpower,0;;,~f_move_splash,0;;,~f_move_frustration,0;;,~f_move_return,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_submission,0;;,~f_move_submission,0;;,~f_move_splash,0;;,~f_move_default,30,~f_move_major_other,4;;,~f_move_default;;,~f_move_default,10,~f_move_stat,~c_no,speed,-1;;,~f_move_default,10,~f_move_major_other,3;;,~f_move_default,10,~f_move_major_other,3;;,~f_move_default,100,~f_move_stat,~c_no,speed,-1;;,~f_move_default;;,~f_move_splash,0;;,~f_move_default;;,~f_move_splash,0;;,~f_move_default;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_major_other,4;;,~f_move_splash,0;;,~f_move_psywave,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_default;;,~f_move_seismictoss,999;;,~f_move_submission,0;;,~f_move_default;;,~f_move_splash,0;;,~f_move_default,10,~f_move_major_other,2;;,~f_move_default,10,~f_move_major_other,4;;,~f_move_default,10,~f_move_major_other,3;;,~f_move_default,10,~f_move_major_other,2;;,~f_move_default,10,~f_move_major_other,2;;,~f_move_splash,0;;,~f_move_default;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_default,10,~f_move_stat,~c_yes,defense,1;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_default;;,~f_move_default;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_stat,~c_yes,defense,1;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_default,10,~f_move_stat,~c_no,attack,-1;;,~f_move_splash,0;;,~f_move_default,30,~f_move_major_other,5;;,~f_move_splash,0;;,~f_move_default,20,~f_move_stat,~c_no,specialdefense,-1;;,~f_move_default;;,~f_move_stat,~c_no,speed,-1;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_stat,~c_no,defense,-2;;,~f_move_default;;,~f_move_default,10,~f_move_major_other,2;;,~f_move_flail,0;;,~f_move_barrage,0;;,~f_move_stat,~c_yes,crit,1;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_splash,0;;,~f_move_stat,~c_yes,specialattack,1;;,~f_move_default;;,~f_move_default,50,~f_move_major_other,2;;,~f_move_stat,~c_yes,attack,1;;,~f_move_splash,0;;,~f_move_stat,~c_yes,evasion,2;;,~f_move_splash,0"
f_zcall(poke,";,0x5f2c,3;;,0x5f5c,8;;,0x5f5d,1;;,0x5eff,58")
cls()
for i=0,360 do
c_types[i\19][i%19]=f_init_peek_inc()/2
end
for i=0,41 do add(c_items,f_zobj("lock,~c_no,num,@,name,@",i,c_item_names[i]))end
for i=0,252 do
local pkmn=f_zobj("moves_progress;,#,#,#;moves_grouped;,#,#,#;lock,~c_no,pktype2,0,prevolve,253,name,@,num,@,num_str,@",c_pkmn_names[i],i,f_prefix_zero(i<252 and i or "???",3))
cur_list,c_moves[i],c_pokemon[i]=pkmn.moves_progress[1],f_zobj("lock,~c_no,num,@,name,@",i,c_move_names[i]),pkmn
foreach(split"pow,pktype,accuracy,maxpp",function(key)
c_moves[i][key]=f_init_peek_inc()
end)
c_moves[i].pp_obj={pp=c_moves[i].maxpp}
c_moves[i].func=deli(c_move_funcs[i],1)
c_moves[i].params=c_move_funcs[i]
foreach(split"pktype1,hp,attack,defense,speed,specialattack,specialdefense,default_item",function(key)
pkmn[key]=f_init_peek_inc()
end)
for i,key in ipairs{"pktype2","prevolve"}do
if pkmn.pktype1>>(4+i)& 1==1 then
pkmn[key]=f_init_peek_inc()
end
end
pkmn.pktype1 &=31
foreach(split"hp,attack,defense,speed,specialattack,specialdefense",function(key)
pkmn[key]+=52
end)
pkmn.hp+=55
pkmn.maxhp=pkmn.hp
pkmn.gender_mask=pkmn.default_item>>>6 & 3
pkmn.default_item &=63
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
if i==0 or not c_pokemon[i].possible_moves_method[v]then
add(c_pokemon[i].possible_moves,v)
c_pokemon[i].possible_moves_method[v]=c_movemethod_names[ii]
end
end)
end
c_pokemon[i]=f_mkpkmn(i,c_pokemon[i],false,false,0)
end
for i=1,57 do
local trainer={num=f_init_peek_inc()}
trainer.move=f_init_peek_inc()
for j=1,6 do add(trainer,f_init_peek_inc())end
add(c_trainers,trainer)
end
local horde={num=255,move=251}
for i=1,252 do add(horde,i%252)end
add(c_trainers,horde)
menuitem(1,"factory reset",function()
cls()flip()
memset(0x5e00,0,256)
run()
end)
f_update_locks"1"
for iloc=0x3200,0x4278,68 do
for loc=iloc,iloc+63,2 do
poke2(loc,%loc & 0x70df|0x0a00)
end
poke4(iloc+64,0x.07d7)
end
f_zcall(f_create_gridpair,"top_browse;,6,4,2,2,10,10,1,1;top_edit;,2,2,2,2,30,20,1,1;top_editteam;,3,2,2,2,20,20,1,1;top_results;,3,2,2,2,20,20,1,1;top_pkstat;,1,4,2,4,60,9,1,4;top_pkstatbig;,1,6,2,5,60,9,1,1;top_text_grid;,2,4,2,4,30,9,1,1;top_title;,1,1,2,2,60,40,1,1;top_battle;,1,1,2,2,60,40,1,1;top_battle2;,1,2,2,2,60,20,1,1;bot_4x4;,2,2,2,44,30,9,1,1;bot_info;,1,1,2,45,60,16,1,1;top_newstat;,1,6,2,4,60,9,1,1;;,g_grid_title,0x5ea8,~bot_4x4,~top_title,~f_op_title,~f_s_title,~f_l_title,~c_no,~c_no,~f_nop;;,g_grid_browse,0x5eaa,~top_browse,~bot_info,~f_op_browse,~f_s_browse,~f_l_browse,~c_no,~c_no,~f_nop,~f_add_browse_info;;,g_grid_editpkmn,0x5eaa,~top_browse,~bot_info,~f_op_browse,~f_s_editpkmn,~f_l_browse,~c_no,~c_no,~f_nop,~f_add_editbrowse_info;;,g_grid_statbrowse,0x5eac,~top_pkstat,~bot_info,~f_op_statbrowse,~f_s_pkstat,~f_l_browse,g_grid_browse,~c_no,~f_nop;;,g_grid_editstat,0x5eb6,~bot_4x4,~top_pkstat,~f_op_editstat,~f_s_editstat,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_editmovebot,0x5eb8,~bot_4x4,~top_pkstat,~f_op_editmovebot,~f_s_editmovebot,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_editmove,0x5ec6,~top_text_grid,~bot_info,~f_op_editmove,~f_s_editmove,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_edititem,0x5ec6,~top_text_grid,~bot_info,~f_op_edititem,~f_s_edititem,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_pickedit,0x5eae,~top_edit,~bot_info,~f_op_pickedit,~f_s_edit,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_pickleag,0x5eae,~top_edit,~bot_info,~f_op_pickleagueplayr,~f_s_league,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_pickplr1,0x5eae,~top_edit,~bot_info,~f_op_pickversus,~f_s_versus,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_pickplr2,0x5eb0,~top_edit,~bot_info,~f_op_pickversus,~f_s_versusbegin,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_picktrnr,0x5eb2,~top_text_grid,~bot_info,~f_op_pickleagueenemy,~f_s_batbegin,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_pickspot,0x5eb4,~top_editteam,~bot_info,~f_op_editteam,~f_s_editteam,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_battle_select,0x5ec6,~bot_4x4,~top_battle2,~f_op_batsel,~f_s_battle,~f_l_battle,~c_no,~c_no,~f_nop;;,g_grid_statbattle,0x5ec6,~top_pkstat,~bot_info,~f_op_statbattle,~f_s_statbat,~f_l_browse,g_grid_battle_stats,~c_no,~f_nop;;,g_grid_battle_movesel,0x5ec6,~bot_4x4,~top_pkstat,~f_op_movesel,~f_s_batmove,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_battle_dmovsel,0x5ec6,~bot_info,~top_pkstat,~f_op_dmovsel,~f_s_dmovsel,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_battle_switch,0x5ec6,~top_editteam,~bot_info,~f_op_batswitch,~f_s_batswitch,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_battle_stats,0x5ec6,~top_editteam,~bot_info,~f_op_batstats,~f_s_batstat,~f_l_browse,~c_no,~c_no,~f_nop;;,g_grid_battle_results,0x5ec6,~top_results,~bot_info,~f_op_batresults,~f_s_batresults,~f_l_browse,~c_no,~c_yes,~f_init_batresults;;,g_grid_battle_actions,0x5ec6,~top_battle2,~bot_info,~f_op_bataction,~f_s_bataction,~f_l_battle,~c_no,~c_yes,~f_s_bataction;;,g_grid_battle_firstaction,0x5ec6,~top_battle2,~bot_info,~f_op_bataction,~f_s_bataction,~f_l_battle,~c_no,~c_yes,~f_nop")
f_add_to_ui_stack(g_grid_title)
sfx"63"
g_shake_timer=0