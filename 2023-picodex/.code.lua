function f_zobj_eval(val,table,parameters)
if _ord(val)==37 then return _g[_sub(val,2)]
elseif val=="~"then return table
elseif _ord(val)==126 then return table[_sub(val,2)]
elseif val=="@"then return _deli(parameters,1)
elseif val=="#"then return{}end
return val ~=""and val or nil
end
function f_zobj_set(table,str,...)
local params,statements,dest={...},_split(str,";"),table
_foreach(statements,function(statement)
local tokens=_split(statement)
if #tokens>1 then
if tokens[1]==""then
_foreach(tokens,function(val)
_add(dest,f_zobj_eval(val,table,params))
end)
else
for i=1,#tokens,2 do
dest[tokens[i]]=f_zobj_eval(tokens[i+1],table,params)
end
end
dest=table
else
if statement==""then statement=#dest+1 end
if _type(dest[statement])~="table"then
dest[statement]={}
end
dest=dest[statement]
end
end)
return table
end
function f_zobj(...)
return f_zobj_set(_setmetatable({},{__index=_g}),...)
end
f_zobj_set(_g,[[c_yes,@,c_no,@,c_empty,@,f_nop,@]],true,false,"",function(...)return...end)
f_zobj_set(_g,[[f_zclass,@,f_actor_get_elapsed_percent,@,f_actor_load,@,f_actor_loadlogic,@,f_actor_state,@,f_modes_popuntil,@,f_modes_pop,@,f_modes_push,@,f_zobj,@,f_zobj_set,@,f_zobj_eval,@,f_zspr,@,f_beep,@,f_flr_rnd,@,f_zcall,@,f_zcamera,@,f_btn_helper,@,f_print_draw2_message,@,f_print_draw3_message,@,c_pokemon,@,c_pokemon_names,@,c_major_names,@,c_major_names_short,@,c_types,@,c_flags,@,c_stages,@,c_bg_styles,@,c_zmovetype,@,c_moves,@,c_trainers,@,f_menu_state_callback,@,f_create_menu_view,@,f_create_menu,@,f_menu_refresh,@,f_menu_cancel,@,f_menu_set,@,f_menu_view_update,@,f_menu_update,@,f_menu_draw1,@,f_menu_drawentry,@,f_browse_drawentry,@,f_movehelp_switch,@,f_movehelp_incstat,@,f_movehelp_getstat,@,f_move_disable,@,f_movehelp_movecopy,@,f_move_mimic,@,f_move_transform,@,f_move_conversion,@,f_move_haze,@,f_move_heal,@,f_move_recover,@,f_move_metronome,@,f_move_mirror_move,@,f_move_roar,@,f_move_teleport,@,f_format_num_sign,@,f_move_self,@,f_move_other,@,f_move_stat,@,f_move_toxic,@,f_move_splash,@,f_move_major_other,@,f_movehelp_minor,@,f_movehelp_flinch,@,f_movehelp_confuse,@,f_move_substitute,@,f_move_rest,@,f_move_counter,@,f_move_multihit_set,@,f_move_multihit_var,@,f_move_multihit_twin,@,f_move_rage,@,f_move_bide,@,f_move_thrash,@,f_move_trapping,@,f_move_flydig,@,f_move_hyperbeam,@,f_move_prepare,@,f_move_recoil,@,f_move_default,@,f_move_dreameater,@,f_move_drain,@,f_move_ohko,@,f_move_psywave,@,f_move_superfang,@,f_movehelp_setdmg,@,f_move_setdmg,@,f_move_setdmg_self,@,f_calc_max_stat,@,f_get_default_pokemon,@,f_populate_c_pokemon,@,f_create_team_pkmn,@,f_team_pkmn_to_active,@,f_unlock_pkmn,@,f_get_team_dead,@,f_get_team_live,@,f_get_next_active,@,f_teamdel,@,f_set_default_team_pkmn,@]],function(template)
return f_zobj_set(f_zobj[[load,%f_actor_load,loadlogic,%f_actor_loadlogic,state,%f_actor_state,get_elapsed_percent,%f_actor_get_elapsed_percent,timer,0,stacksize,0,isnew,%c_yes,curr,start,init,%f_nop,update,%f_nop;stack;,;]],template)
end,function(_ENV,key)
if key==curr then
return duration and timer/duration or 0
end
if _ENV[key]and _ENV[key].done then
return 1
end
return 0
end,function(_ENV,stateName)
next_state=stateName or next
end,function(_ENV,stateName)
timer,next_state,isnew,next,duration=0
_ENV[curr].done=true
for k,v in _pairs(defaults)do _ENV[k]=v end
for k,v in _pairs(_ENV[stateName])do _ENV[k]=v end
curr=stateName
_ENV:init()
stacksize=#stack
end,function(_ENV)
timer+=1/60
if isnew then _ENV:loadlogic(curr)end
if duration and timer>=duration then
_ENV:load()
end
while next_state do
_ENV:loadlogic(next_state)
end
_ENV:update()
end,function(_ENV,untilstate)
while next_state ~=untilstate and #stack>0 do
_ENV:pop()
end
end,function(_ENV)
_deli(stack)
_ENV:load(stack[#stack]or "main")
end,function(_ENV,newstate)
_add(stack,newstate)
_ENV:f_actor_load(newstate)
end,f_zobj,f_zobj_set,f_zobj_eval,function(sind,x,y,sw,sh,...)
sw,sh=sw or 1,sh or 1
_spr(sind,x-sw*4,y-sh*4,sw,sh,...)
end,function()
f_minisfx"153"
end,function(x)
return _flr(_rnd(x))
end,function(func,text,...)
_foreach(f_zobj(text,...),function(params)
func(_unpack(params))
end)
end,function(nx,ny,func)
local ox,oy=%0x5f28,%0x5f2a
_camera(ox-nx,oy-ny)
func()
_camera(ox,oy)
end,function(f,a,b)
return f(a)and f(b)and 0 or f(a)and-1 or f(b)and 1 or 0
end,function(txt)
f_zprint(txt or "",23,4,1,0)
end,function(str)
f_zcall(_rectfill,[[;,0,0,45,6,1]])
f_zcall(f_zprint,[[;,@,23,1,13,0;;,@,23,8,1,0;;,@,23,15,1,0]],_unpack(_split(str,"|",false)))
end,f_zobj[[]],_split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",f_zobj"0,none;,fainted,burned,frozen,paralyzed,poisoned,sleeping",f_zobj"0,NON;,FNT,BRN,FZN,PAR,PSN,SLP",f_zobj[[0;bg,0,name,%c_empty;1;bg,0,name,normal,15,0,13,.5;2;bg,5,name,fire,8,2,10,2,11,2,2,.5,4,.5,13,.5,14,.5;3;bg,2,name,fighting,10,2,1,2,13,2,15,0,11,.5,9,.5,5,.5,12,.5;4;bg,4,name,water,2,2,7,2,13,2,14,.5,8,.5,4,.5;5;bg,1,name,poison,11,2,8,2,15,.5,7,.5,5,.5,13,.5;6;bg,6,name,electric,9,2,4,2,7,0,14,.5,6,.5,8,.5;7;bg,2,name,ground,6,2,2,2,5,2,13,2,9,0,11,.5,8,.5;8;bg,3,name,grass,7,2,13,2,4,2,11,.5,14,.5,2,.5,9,.5,8,.5,5,.5;9;bg,0,name,flying,11,2,3,2,8,2,6,.5,13,.5;10;bg,4,name,ice,14,2,9,2,8,2,2,.5,10,.5,4,.5;11;bg,3,name,bug,8,2,12,2,3,.5,2,.5,9,.5,15,.5,5,.5;12;bg,1,name,psychic,3,2,5,2,12,.5;13;bg,0,name,rock,11,2,2,2,9,2,10,2,3,.5,7,.5;14;bg,0,name,dragon,14,2;15;bg,1,name,ghost,15,2,1,0,12,0;17;bg,0,name,bird;]],f_zobj[[confused,confused,disabled,disable,digging,digging,flying,flying,preparing,prepare,recharging,recharge,flinching,flinch,thrashed,thrashing,trapping,trapping,trapped,trapped,raged,enraged,decoyed,decoyed,focused,focus,misted,mist,reflected,reflect,screened,screened,seeded,seeded,toxiced,toxiced,transform,tranform]],f_zobj[[special,spc,attack,att,defense,def,speed,spd,accuracy,acc,evasion,eva]],f_zobj[[0;bg,6,aa,13;;bg,14,aa,4;;bg,9,aa,4;;bg,11,aa,3;;bg,12,aa,5;;bg,8,aa,2;;bg,10,aa,4]],f_zobj[[0;name,status;;name,physical;;name,special;]],f_zobj[[]],_split"youngstr,bugcatch,junior,brock,lass,hiker,swimmer,misty,gentlman,sailor,rocker,ltsurge,channelr,gambler,beauty,erika,biker,birdkeep,juggler,koga,blckbelt,rocket,psychic,sabrina,scientst,pkmaniac,suprnerd,blaine,cooltrnr,fishrman,tamer,giovanni,lorelei,bruno,agatha,lance,blue,green,red,legendry",function(game,entry)
if entry.state then
game:push(entry.state)
else
game:pop()
end
end,function(edraw,viewmin)
return f_zobj([[edraw,@,viewmin,@,v,~viewmin,r,1,update,%f_menu_view_update,draw1,%f_menu_draw1,cancel,%f_menu_cancel,refresh,%f_menu_refresh]],edraw,viewmin or 0)
end,function(edraw,r)
return f_zobj_set(f_create_menu_view(edraw),[[c,0,r,@,update,%f_menu_update,set,%f_menu_set]],r or 1)
end,function(menu,data,mapfunc)
while _deli(menu)do end
for i=1,#data do
_add(menu,(mapfunc or f_nop)(data[i],i))
end
end,function(game)
game:pop()
f_minisfx"154"
end,function(menu,delta,is_ud)
if is_ud then
local newval=menu.c+delta*menu.r
if newval==_mid(0,newval,#menu-1)then
menu.c=newval
if 0+delta ~=0 then f_minisfx"154" end
else
f_beep()
end
else
local newval=menu.c+delta
local left=menu.c-menu.c%menu.r
if newval==_mid(left,newval,left+menu.r-1)then
menu.c=newval
if 0+delta ~=0 then f_minisfx"154" end
else
f_beep()
end
end
menu.c=_mid(0,menu.c,#menu-1)
if menu.c\menu.r<menu.v then menu.v=menu.c\menu.r end
if menu.c\menu.r>menu.v+2 then menu.v=menu.c\menu.r-2 end
menu.v=_mid(0,menu.v,(#menu-1)\menu.r)
end,function(game)
local menu=game.menu
if g_bpo then menu.cancel(game)end
if g_bpx then game:xfunc()end
menu.v+=g_bpv
if g_bph ~=0 then game:lrfunc(g_bph)end
local oldview=menu.v
menu.v=_mid(menu.viewmin,menu.v,#menu-3)
if menu.v ~=oldview then
f_beep()
elseif g_bpv ~=0 then
f_minisfx"154"
end
end,function(game)
local menu=game.menu
menu:set"0"
menu:set(g_bpv,true)
menu:set(g_bph)
if g_bpx then
local entry=menu[menu.c+1]
if entry.disabled then
f_beep()
elseif entry.select then
f_minisfx"155"
entry.select(game,entry)
end
end
if g_bpo then menu.cancel(game)end
end,function(game)
local menu=game.menu
local cellw=menu.r>1 and 10 or 40
local xoff=20-(menu.r*cellw)/2
f_zcall(_rectfill,[[;,0,0,39,39,1;;,0,@,39,@,13]],5-menu.v*10,4+(_max(_ceil(#menu/menu.r),3)-menu.v)*10)
for i=-1,menu.r*5-1 do
local index=(menu.v-1)*menu.r+i+1
local entry=menu[index]
if entry then
local style_ind,x,y=entry.style or 1,xoff+i%menu.r*10,i\menu.r*10
if entry.disabled then style_ind=3 end
if index-1==menu.c then style_ind+=1 end
if not entry.hidden then
_rectfill(x,y-5,x+cellw-1,y+4,c_menustyles[style_ind].bg)
f_zcamera(i%menu.r*cellw+xoff+cellw/2,i\menu.r*10-3,function()
menu.edraw(entry,c_menustyles[style_ind])
end)
end
end
end
end,function(entry,style)
if entry.pkmn then
local style=c_bg_styles[c_types[entry.pkmn.type1].bg]
f_zcall(_rectfill,[[;,-20,-2,19,17,@;;,-20,14,19,17,@]],style.bg,style.aa)
entry.pkmn:draw(0,8,style.aa,1,1)
else
f_wobble_text(entry.name,0,0,style.fg)
end
end,function(entry,style)
entry.pkmn:draw(0,3,style.out,.375,.375)
end,function(pl)
local team=f_get_team_live(pl.team)
_del(team,pl.active.shared)
if #team>0 then
return team[f_flr_rnd(#team)+1]
end
end,function(a,stat,inc)
local prev=a.stages[stat]
if not a.misted or inc>0 then
a.stages[stat]=_mid(-6,6,prev+inc)
end
return prev ~=a.stages[stat]
end,function(a,stat)
local stage=a.stages[stat]
return _ceil(_mid(1,999,
a[stat]*(
(stat=="evasion"or stat=="accuracy")
and _mid(1,1+stage/3,3)/_mid(1,1-stage/3,3)
or _mid(2,2+stage,8)/_mid(2,2-stage,8)
)
))
end,function(_ENV)
if otheractive.disabledtimer>0 then return true end
local moves=f_get_moves(otheractive)
if #moves==0 then return true end
otheractive.disabledtimer=f_flr_rnd"6"+2
otheractive.disabledslot=moves[f_flr_rnd(#moves)+1].slot
addaction(other,"|"..otheractive.mynewmoves[otheractive.disabledslot].name.."|disabled")
if otheractive.curmove and otheractive.curmove.slot==otheractive.disabledslot then
otheractive.moveturn=0
end
end,function(_ENV,num,slot)
local newmove=f_create_move(num,slot)
newmove.pp,newmove.maxpp=5,5
mynewmoves[slot]=newmove
return newmove
end,function(_ENV)
local othermoves=f_get_moves(otheractive,true)
addaction(self,"|copied|"..f_movehelp_movecopy(selfactive,othermoves[f_flr_rnd(#othermoves)+1].num,move.slot).name)
end,function(_ENV)
if selfactive.transform then
return true
else
addaction(self,"|copied|"..otheractive.name,function()
selfactive.transform=true
_foreach(_split"num,attack,defense,speed,special,type1,type2",function(key)
selfactive[key]=otheractive[key]
end)
selfactive.mynewmoves={}
_foreach(otheractive.mynewmoves,function(m)
f_movehelp_movecopy(selfactive,m.num,m.slot)
end)
end)
end
end,function(_ENV)
f_zobj_set(selfactive,[[type1,@,type2,@,conversion,%c_yes]],otheractive.type1,otheractive.type2)
addaction(self,"|copied|types")
end,function(_ENV)
_foreach({other,self},function(pl)
f_zobj_set(pl.active.stages,[[special,0,attack,0,defense,0,speed,0,accuracy,0,evasion,0]])
addaction(pl,"|reset|modifiers")
end)
end,function(_ENV,pl,amount)
amount=_min(amount,pl.active.maxhp-pl.active.hp)
if amount>0 then
addaction(pl,f_format_num_sign(amount,"|hitpoints"),function()
pl.active.shared.hp+=amount
end)
else
return true
end
end,function(_ENV)
return f_move_heal(_ENV,self,selfactive.maxhp\2)
end,function(_ENV)
f_movelogic(self,f_create_move(f_flr_rnd(164)+1,move.slot))
end,function(_ENV)
if selfactive.lastmoverecv>0 then
f_movelogic(self,f_create_move(selfactive.lastmoverecv,move.slot))
else
return true
end
end,function(_ENV)
local pkmn=f_movehelp_switch(other)
if pkmn then
f_select_switch(other,pkmn)
else
return true
end
end,function(_ENV)
local pkmn=f_movehelp_switch(self)
if pkmn then
f_select_switch(self,pkmn)
else
return true
end
end,function(num,remainder)
return(_sgn(num)>0 and "|+"or "|-").._abs(num)..remainder
end,function(_ENV,func,...)return func(_ENV,self,...)end,function(_ENV,func,...)return func(_ENV,other,...)end,function(_ENV,pl,key,stage)
if f_movehelp_incstat(pl.active,key,stage)then
addaction(pl,f_format_num_sign(stage,"/6|"..c_stages[key]))
else
return true
end
end,function(_ENV)
if f_move_major_other(_ENV,5)and otheractive.major ~=5 then
return true
end
return f_move_other(_ENV,f_movehelp_minor,"|badly|poisoned","toxiced",1)
end,function(_ENV)
addaction(self,"|does|nothing")
end,function(_ENV,majorind)
if f_get_type_advantage(move,otheractive)>0 and otheractive.shared.major==0 then
addaction(other,"|is|"..c_major_names[majorind],function()
otheractive.shared.major=majorind
end)
else
return true
end
end,function(_ENV,pl,message,minor,val)
if(pl.active[minor]or 0)==0 then
pl.active[minor]=val or 1
addaction(pl,message)
else
return true
end
end,function(_ENV,pl)
pl.active.flinching=true
end,function(_ENV,pl)
return f_movehelp_minor(_ENV,pl,"|becomes|confused","confused",f_flr_rnd"4"+1)
end,function(_ENV)
local subhp=selfactive.maxhp\4
if subhp>=selfactive.hp or selfactive.substitute>0 then
return true
end
f_move_setdmg_self(_ENV,subhp)
addaction(self,"|created|substitute",function()
selfactive.substitute=subhp
end)
end,function(_ENV)
selfactive.shared.major=6
addaction(self,"|is|sleeping")
f_move_heal(_ENV,self,selfactive.maxhp)
selfactive.toxiced=0
end,function(_ENV)
if selfactive.counterdmg>0 then
f_move_setdmg(_ENV,selfactive.counterdmg*2)
else
return true
end
end,function(_ENV,hitcount,endfunc)
if hitcount>0 then
addaction(self,"|begin|hit #"..hitcount,function()
_ENV.otheractive=other.active
if f_move_default(_ENV)then
addaction(self,"|failed|hit #"..hitcount)
end
f_move_multihit_set(_ENV,hitcount-1,endfunc)
end)
else
endfunc()
end
end,function(_ENV,hitcount)
f_move_multihit_set(_ENV,2+f_flr_rnd"4",f_nop)
end,function(_ENV)
f_move_multihit_set(_ENV,2,function()
if _rnd"100"<20 then
f_move_major_other(_ENV,5)
end
end)
end,function(_ENV)
f_set_moveturn(selfactive,-1,f_create_move(move.num,move.slot))
f_move_default(_ENV)
end,function(_ENV)
if not selfactive.curmove then
f_set_moveturn(selfactive,f_flr_rnd"2"+1,f_create_move(move.num,move.slot))
addaction(self,"|"..move.name.."|begins")
selfactive.bidedmg=0
end
if selfactive.moveturn==0 then
f_move_setdmg(_ENV,selfactive.bidedmg*2)
end
end,function(_ENV)
f_set_moveturn(selfactive,f_flr_rnd"2"+1,f_create_move(move.num,move.slot))
f_move_default(_ENV)
if selfactive.moveturn==0 then
f_move_self(_ENV,f_movehelp_confuse,"confused")
end
end,function(_ENV)
if not selfactive.curmove then
f_set_moveturn(selfactive,f_flr_rnd"4"+1,f_create_move(move.num,move.slot))
addaction(self,"|"..move.name.."|begins")
selfactive.trappedother=otheractive
end
if selfactive.trappedother==otheractive then
f_move_default(_ENV)
end
if selfactive.moveturn==0 or selfactive.trappedother ~=otheractive then
selfactive.moveturn,selfactive.trappedother=0
addaction(self,"|"..move.name.."|ended")
end
end,function(_ENV,desc)
if selfactive.curmove then
f_move_default(_ENV)
else
addaction(self,"|started|"..desc,function()
f_set_moveturn(selfactive,1,f_create_move(move.num,move.slot))
end)
end
end,function(_ENV)
if selfactive.curmove then
addaction(self,"|recharging|energy")
else
f_move_default(_ENV)
local m=f_create_move(move.num,move.slot)
m.accuracy=0
f_set_moveturn(selfactive,1,m)
end
end,function(_ENV)
if selfactive.curmove then
f_move_default(_ENV)
else
f_set_moveturn(selfactive,1,move)
addaction(self,"|preparing|attack")
move.pp+=1
end
end,function(_ENV)
local dmg=f_calc_move_damage(selfactive,otheractive,move)
if f_move_setdmg(_ENV,dmg)then
return true
else
f_move_setdmg_self(_ENV,_max(1,dmg\4))
end
end,function(_ENV,percent,func,...)
if f_move_setdmg(_ENV,f_calc_move_damage(selfactive,otheractive,move))then
return true
else
if _rnd"100"<(percent or 0)then
func(_ENV,...)
end
end
end,function(_ENV)
if selfactive.major==6 then
f_move_drain(_ENV)
else
return true
end
end,function(_ENV)
local dmg=f_calc_move_damage(selfactive,otheractive,move)
if f_move_setdmg(_ENV,dmg)then
return true
else
f_move_heal(_ENV,self,_max(dmg\2,1))
end
end,function(_ENV)
if selfactive.speed>=otheractive.speed then
return f_move_setdmg(_ENV,otheractive.hp)
else
return true
end
end,function(_ENV)
return f_move_setdmg(_ENV,1+f_flr_rnd"75")
end,function(_ENV)
return f_move_setdmg(_ENV,_max(otheractive.hp\2,1))
end,function(_ENV,pl,dmg,isself)
local active=pl.active
local issub=not isself and active.substitute>0
addaction(pl,f_format_num_sign(-dmg,"|hitpoints"),function()
active.bidedmg+=dmg
if active.curmove and active.curmove.num==20 then
f_move_stat(_ENV,pl,"attack",1)
end
if issub then
active.substitute=_max(active.substitute-dmg,0)
else
active.shared.hp=_max(active.shared.hp-dmg,0)
end
end,issub and "substitute")
end,function(_ENV,dmg)
if dmg>0 and f_get_type_advantage(move,otheractive)>0 then
if move.type%2==1 then
otheractive.counterdmg+=dmg
end
f_movehelp_setdmg(_ENV,other,dmg)
else
return true
end
end,function(_ENV,dmg)
f_movehelp_setdmg(_ENV,self,dmg,true)
end,function(base)
return _ceil(base+.5*93)+5
end,function()
return f_zobj([[browse,%c_yes,level,50,attack,0,defense,0,special,0,speed,0,maxhp,0,hp,0,total,0,accuracy,100,evasion,100,base_maxhp,0,base_attack,0,base_defense,0,base_speed,0,base_special,0,num,-1,evolvesfrom,-1,name, ,type1,0,type2,0,moves_natural,#,moves_teach,#,moves_event,#,draw,%f_draw_pkmn_out,mynewmoves,@]],f_create_empty_moveset())
end,function()
local movemem=_peek2"0xa"
c_pokemon[-1]=f_get_default_pokemon()
for num=0,151 do
local pkmndata,is_range={},false
while@movemem ~=255 do
if@movemem==254 then
is_range=true
elseif is_range then
for i=pkmndata[#pkmndata]+1,@movemem do
_add(pkmndata,i)
end
is_range=false
else
_add(pkmndata,@movemem)
end
movemem+=1
end
movemem+=1
local evolvesfrom=num-_deli(pkmndata,1)
local pkmn=f_get_default_pokemon()
f_zobj_set(pkmn,[[num,@,evolvesfrom,@,name,@,type1,@,type2,@,base_maxhp,@,base_attack,@,base_defense,@,base_speed,@,base_special,@]],num,
evolvesfrom,
c_pokemon_names[num+1],
_unpack(pkmndata)
)
local move_bucket=pkmn.moves_natural
for i=8,#pkmndata do
local val=pkmndata[i]
if val==253 then
move_bucket=pkmn.moves_teach
elseif val==252 then
move_bucket=pkmn.moves_event
else
_add(move_bucket,val)
end
end
if evolvesfrom<num then
_foreach(c_pokemon[evolvesfrom].moves_natural,function(move)_add(pkmn.moves_natural,move)end)
_foreach(c_pokemon[evolvesfrom].moves_teach,function(move)_add(pkmn.moves_teach,move)end)
_foreach(c_pokemon[evolvesfrom].moves_event,function(move)_add(pkmn.moves_event,move)end)
end
local teach_map,teachs={},{}
_foreach(pkmn.moves_teach,function(move)teach_map[move]=true end)
for i=1,54 do
if teach_map[i]then _add(teachs,i)end
end
pkmn.moves_teach=teachs
do local _ENV=pkmn
f_zobj_set(_ENV,[[attack,@,defense,@,special,@,speed,@,maxhp,@,hp,~maxhp,level,50]],f_calc_max_stat(base_attack),
f_calc_max_stat(base_defense),
f_calc_max_stat(base_special),
f_calc_max_stat(base_speed),
f_calc_max_stat(base_maxhp)+5+50
)
total=attack+defense+special+speed+maxhp
end
c_pokemon[num]=pkmn
end
end,function(num,mynewmoves)
return _setmetatable(f_zobj([[mynewmoves,@,major,0,browse,%c_no]],mynewmoves),{__index=c_pokemon[num]})
end,function(teampkmn)
local moves={}
_foreach(teampkmn.mynewmoves,function(m)
_add(moves,m)
end)
return _setmetatable(f_zobj([[isactive,%c_yes,lastmoverecv,0,accuracy,1,evasion,1,moveturn,0,counterdmg,0,bidedmg,0,disabledtimer,0,confused,0,substitute,0,toxiced,0,shared,@,mynewmoves,@;stages;special,0,attack,0,defense,0,speed,0,accuracy,0,evasion,0]],teampkmn,moves),{__index=teampkmn})
end,function(trainer)
_foreach(f_get_team_dead(trainer.team),function(pkmn)
_poke(0x5e5a+pkmn.num,1)
end)
end,function(team)
local newteam={}
_foreach(team,function(pkmn)
if pkmn.num>-1 and pkmn.major==1 then
_add(newteam,pkmn)
end
end)
return newteam
end,function(team,exclude_missingno)
local newteam={}
_foreach(team,function(pkmn)
if pkmn.num>(exclude_missingno and 0 or-1)and pkmn.major ~=1 then
_add(newteam,pkmn)
end
end)
return newteam
end,function(team)
return f_get_team_live(team)[1]
end,function(game)
local team=game:f_get_team_cursor"team1"
team[game:cursor"editteam"+1]=f_create_team_pkmn(-1,f_create_empty_moveset())
f_save_team(game:cursor"team1",team)
game:pop()
end,function(team,ind,num)
team[ind]=f_create_team_pkmn(num,f_get_natural_moveset(num))
return team
end)
f_zobj_set(_g,[[f_get_team,@,f_save_team,@,f_populate_c_moves,@,f_get_natural_moveset,@,f_create_move,@,f_create_empty_moveset,@,f_editteam_draw1,@,f_turn_draw1,@,f_browse_draw2,@,f_editteam_draw2,@,f_teammoves_draw2,@,f_team_draw2,@,f_fightover_draw2,@,f_pselactions_draw2,@,f_teammovesel_draw2,@,f_main_draw2,@,f_turn_draw2,@,f_editteam_draw3,@,f_move_draw3,@,f_browse_draw3,@,f_main_draw3,@,f_fight_draw3_helper,@,f_pselswitch_draw3,@,f_pselactions_draw3,@,f_team_draw3,@,f_fightover_draw3,@,f_turn_draw3,@,f_fightover_init,@,f_main_init,@,f_browse_init_shared,@,f_browse_init,@,f_teampkmn_init,@,f_browsestat_init,@,f_credits_init,@,f_fightsel_init,@,f_teamaction_init,@,f_moveaction_init,@,f_movedel,@,f_moves_init_helper,@,f_teammoves_init,@,f_switchmoves_init,@,f_teammovesel_init,@,f_pselmove_init,@,f_pselactions_init,@,f_team_init,@,f_get_team_num,@,f_editteam_init,@,f_switchteam_init,@,f_pselswitch_init,@,f_turn_init,@,f_browsestat_lrfunc,@,f_browsestat_xfunc,@,f_credits_xfunc,@,f_fightover_xfunc,@,f_game_init,@,f_game_update,@,f_game_draw1,@,f_game_draw2,@,f_game_draw3,@,f_modes_default_update,@,f_modes_default_draw1,@,f_modes_cursor,@,f_modes_entry,@,f_moveup_init,@,f_closed_init,@,f_any_btn,@,f_closed_update,@,g_cur_light,@,f_minisfx,@,f_draw_picodex,@,f_picodex_map,@,f_wobble_text,@,f_zprint,@,f_draw_screen,@,f_pkmn_available,@,f_draw2_pokeinfo,@,f_draw3_pokeinfo,@,f_draw_pkmn,@,f_draw_pkmn_out,@,f_update_stat_menu,@,f_story_select,@,f_match_select,@,f_match_start,@,f_horde_select,@,f_team_select,@,f_get_team_cursor,@,f_get_pkmn_team_edit,@,f_pkmn_comes_out,@,f_select_switch,@,f_movelogic,@,f_set_moveturn,@,f_premovelogic,@,f_decrement_timer,@,f_postmove_logic,@,f_select_move,@,f_get_other_pl,@,f_newaction,@,f_addaction,@,f_turn_update,@,f_pop_next_action,@]],function(team_index)
local mem=c_team_memlocs[team_index]
local team=f_zobj[[]]
for i=1,6 do
local memstart,mynewmoves,has_moves=mem+(i-1)*5,{},false
for i=1,4 do
mynewmoves[i]=f_create_move(_peek(memstart+i),i)
if mynewmoves[i].num>0 then
has_moves=true
else
mynewmoves[i]=f_create_move(-1)
end
end
team[i]=f_create_team_pkmn(has_moves and@memstart or-1,mynewmoves)
end
return team
end,function(team_index,team)
local mem=c_team_memlocs[team_index]
_memset(mem,0,30)
for i=1,6 do
local memstart,pkmn=mem+(i-1)*5,team[i]
_poke(memstart,_max(0,pkmn.num))
for i=1,4 do
_poke(memstart+i,pkmn.mynewmoves[i].num>0 and pkmn.mynewmoves[i].num or 0)
end
end
end,function()
local memloc=_peek2"0x8"
for i=-1,164 do
local typ=_peek(memloc+0)
local pp=_peek(memloc+1)*5-5
local dmg=_peek(memloc+2)*5-5
local acc=_peek(memloc+3)*5-5
local name=_deli(c_moves_raw[i],1)
local ofunc=_deli(c_moves_raw[i],1)
c_moves[i]=f_zobj([[func,@,num,@,name,@,type,@,pp,@,maxpp,~pp,damage,@,accuracy,@,ofunc,@]],function(envparams)
return ofunc(envparams,_unpack(c_moves_raw[i]))
end,i,name,typ,pp,dmg,acc,ofunc)
memloc+=4
end
end,function(num)
local pkmn,moveset=c_pokemon[num],f_create_empty_moveset()
for i=1,_min(4,#pkmn.moves_natural)do
moveset[i]=f_create_move(pkmn.moves_natural[i],i)
end
return moveset
end,function(id,slot)
return _setmetatable(f_zobj([[slot,@]],slot or 0),{__index=c_moves[id]})
end,function()
local moveset={}
for i=1,4 do _add(moveset,f_create_move(-1))end
return moveset
end,function(game)
f_modes_default_draw1(game)
f_wobble_text("team #"..game:cursor"team1"+1,20,27,1)
end,function(_ENV)
local cra,p1a,p2a=cur_action.active,p1.active,p2.active
local p1on,p2on=p1a==cra,p2a==cra
local p1c,p2c=p1on and 6 or 1,p2on and 6 or 1
f_zcall(_rectfill,[[;,0,0,39,6,5;;,0,33,39,39,5]])
f_zcall(_rectfill,[[;,-1,33,@,41,@;;,40,-2,@,6,@]],-1+_max(_ceil(p1a.hp/p1a.maxhp*40),0),p1c,
40-_max(_ceil(p2a.hp/p2a.maxhp*40),0),p2c)
f_zcall(_rectfill,[[;,0,6,24,6,13;;,0,5,23,5,13;;,15,33,39,33,13;;,16,34,39,34,13]])
f_zcall(f_zprint,[[;,@,2,34,13,-1;;,@,41,29,@,1;;,@,40,1,13,1;;,@,1,5,@,-1]],p1a.hp,c_major_names_short[p1a.major],p1c,p2a.hp,c_major_names_short[p2a.major],p2c)
p1a:draw(10,23,5,1)
p2a:draw(30,17,5,-1)
end,function(game)f_draw2_pokeinfo(c_pokemon[game:cursor"browse"])end,function(game)f_print_draw2_message("spot #"..(game:cursor"editteam"+1))end,function(game)f_print_draw2_message("move #"..(game:cursor"teammoves"+1))end,function(game)f_print_draw2_message(game.ui_pl)end,function(game)f_print_draw2_message"match over" end,function(_)end,function(game)
local move=game:entry"teammovesel"
f_print_draw2_message(move and move.ref)
end,function()
_rectfill(0,0,46,13,13)
_pal(7,1)
local xx=0
for i,v in _ipairs(_split"6,5,5,6,6,5,6")do
_sspr(6*8+xx,6*8,v,8,xx+3,3.5+_cos((_t()+i)/4))
xx+=v
end
_pal()
end,function(game)f_print_draw2_message(game.cur_action.pl.name)end,function(game)
f_draw3_pokeinfo(game:f_get_pkmn_team_edit())
end,function(game)
local move=game:entry(game.movemode).move
if move.num>=0 then
f_print_draw3_message(c_types[move.type].name.."|"..move.pp.."/"..move.maxpp.."|"..(move.damage>=0 and move.damage or "??").."P "..(move.accuracy>=0 and move.accuracy or "??").."A")
else
f_print_draw3_message"????|?/?|?P ?A"
end
end,function(game)
f_draw3_pokeinfo(game:entry"browse".pkmn)
end,function(game)f_print_draw3_message(game:entry"main".desc)end,function(_ENV)
if num>-1 then
f_print_draw3_message(name.."|"..hp.."/"..maxhp.."|"..c_major_names[major])
else
f_print_draw3_message"?????????|???/???|"
end
end,function(_ENV)f_fight_draw3_helper(_ENV:entry"pselswitch".pkmn)end,function(_ENV)f_fight_draw3_helper(p0.active)end,function(game)
local count,power=0,0
for i=1,6 do
local num=game:entry().team[i]
if num then
count+=1
power+=c_pokemon[num].total
end
end
f_print_draw3_message(game:entry().name.."|pkmn "..count.."/6|pow "..power)
end,function(game)
f_print_draw3_message(game.p0.name.."|is the|winner")
end,function(game)
f_print_draw3_message(game.cur_action.name..game.cur_action.message)
end,function(_ENV)
local winner,loser=p0,f_get_other_pl(_ENV,p0)
winner:winlogic(loser)
menu:refresh{}
menu.cancel=function(game)
game:popuntil"team2story"
end
for pl in _all{winner,loser}do
f_zobj_set(menu,[[v,0;;pkmn,@;;hidden,%c_yes;;name,@,style,5;;name,@;;name,@]],pl.active.shared,pl.name,(#f_get_team_live(pl.team,true)).." live",(#f_get_team_dead(pl.team)).." dead")
end
end,function(_ENV)
local count=0
for i=0,151 do count+=c_pokemon[i]:f_pkmn_available()and 1 or 0 end
menu:refresh(
f_zobj([[;name,browse,state,browse,select,%f_menu_state_callback,desc,@;;name,edit,state,team1,select,%f_menu_state_callback,desc,edit|stored|teams;;name,league,state,team1story,select,%f_menu_state_callback,desc,@;;name,player,state,team1match,select,%f_menu_state_callback,desc,player|custom|battles;;name,?????,state,team1horde,select,%f_menu_state_callback,desc,?????|beat|league,disabled,%c_yes;;name,credits,state,credits,select,%f_menu_state_callback,desc,credits|amorg|games]],"browse|"..count.."/151|pokemon","league|"..(@0x5efd).."/40|trainers")
)
if@0x5efd>=40 then
f_zobj_set(menu[5],[[disabled,%c_no,name,horde,desc,@]],"horde|"..(@0x5efe).."/151|hi-score")
end
end,function(_ENV,selectfunc)
local tbl={}
for i=0,151 do
_add(tbl,i)
end
menu:refresh(
tbl,
function(num)
local pkmn=c_pokemon[num]
return{
select=selectfunc,
disabled=not pkmn:f_pkmn_available(),
pkmn=pkmn
}
end
)
end,function(_ENV)
f_browse_init_shared(_ENV,function(_ENV)
_ENV:push"browsestat"
end)
end,function(_ENV)
f_browse_init_shared(_ENV,function(_ENV)
f_save_team(_ENV:cursor"team1",f_set_default_team_pkmn(_ENV:f_get_team_cursor"team1",_ENV:cursor"editteam"+1,_ENV:cursor"browse"))
_ENV:pop()
end)
end,function(_ENV)
f_update_stat_menu(menu,_ENV:entry"browse".pkmn)
end,function(_ENV)
menu:refresh(
_split"106,,!alanxoc3,code+sfx,design,6,,!gr8cadet,graphics,playtest,129,,!wadlo,magikarp,playtest,145,,!zep,pico-8,px9 func,137,,!pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
function(txt)
if _type(txt)=="number"then
return{pkmn=f_create_team_pkmn(txt,f_create_empty_moveset())}
end
local style=1
if _sub(txt,1,1)=="!"then
txt,style=_sub(txt,2),5
end
return{name=txt,style=style,hidden=txt==""}
end
)
menu.v=0
end,function(_ENV)
menu:refresh(c_trainers,function(trainer,num)
return{
name=trainer.name,
team=trainer,
disabled=num-1>@0x5efd,
select=function(game,entry)
f_begin_fight_cpu(game,entry.team,entry.name,function(pl,other)
_poke(0x5efd,_mid(@0x5efd,num,40))
f_unlock_pkmn(other)
end)
end
}
end)
end,function(_ENV)
menu:refresh(f_zobj[[;name,moves,state,teammoves,select,%f_menu_state_callback;;name,switch,state,switchteam,select,%f_menu_state_callback;;name,delete,select,%f_teamdel]])
end,function(_ENV)
local teampkmn=_ENV:f_get_pkmn_team_edit()
local count=0
for j=1,4 do
if teampkmn.mynewmoves[j].num>0 then count+=1 end
end
menu:refresh(f_zobj([[;name,change,state,teammovesel,select,%f_menu_state_callback;;name,switch,state,switchmoves,select,%f_menu_state_callback;;name,delete,disabled,@,select,%f_movedel]],count==1))
end,function(_ENV)
local teampkmn,team=_ENV:f_get_pkmn_team_edit()
teampkmn.mynewmoves[_ENV:cursor"teammoves"+1]=f_create_move(-1)
f_save_team(_ENV:cursor"team1",team)
_ENV:pop()
end,function(_ENV,disabled_ind,select_func)
local teampkmn,team=_ENV:f_get_pkmn_team_edit()
menu:refresh(f_zobj[[,1,2,3,4]],function(i)
local move=teampkmn.mynewmoves[i]
return{
move=move,
name=move.name,
select=function(_ENV)select_func(_ENV,i,teampkmn,team)end,
disabled=i==disabled_ind
}
end)
end,function(_ENV)
f_moves_init_helper(_ENV,0,function(_ENV,i,teampkmn)
_ENV:push(teampkmn.mynewmoves[i].num>0 and "moveaction"or "teammovesel")
end)
end,function(_ENV)
local disabled_ind=_ENV:cursor"teammoves"+1
f_moves_init_helper(_ENV,disabled_ind,function(_ENV,i,teampkmn,team)
teampkmn.mynewmoves[i],teampkmn.mynewmoves[disabled_ind]=teampkmn.mynewmoves[disabled_ind],teampkmn.mynewmoves[i]
f_save_team(_ENV:cursor"team1",team)
_ENV:popuntil"teammoves"
end)
menu.c=teammoves.menu.c
end,function(_ENV)
local teampkmn=_ENV:f_get_pkmn_team_edit()
local pkmn=c_pokemon[teampkmn.num]
local movemetadata={}
f_zcall(function(movelist,prefix)
for i=1,#movelist do
local moveind=movelist[i]
_add(movemetadata,{name=c_moves[moveind].name,disabled=teampkmn:f_pkmn_has_move(moveind),num=moveind,desc=prefix..i})
end
end,[[;,@,learn #;;,@,teach #;;,@,event #]],pkmn.moves_natural,pkmn.moves_teach,pkmn.moves_event)
menu:refresh(movemetadata,function(m)
return{
name=m.name,
disabled=m.disabled,
move=c_moves[m.num],
ref=m.desc,
select=function()
local team=_ENV:f_get_team_cursor"team1"
team[_ENV:cursor"editteam"+1].mynewmoves[_ENV:cursor"teammoves"+1]=f_create_move(m.num)
f_save_team(_ENV:cursor"team1",team)
_ENV:popuntil"teammoves"
end
}
end)
end,function(_ENV)
local possible_moves=f_get_possible_moves(p0.active)
if p0.active.curmove then
f_select_move(p0,p0.active.curmove)
_ENV:pop()_ENV:pop()
elseif #possible_moves==0 then
f_select_move(p0,f_create_move(0))
_ENV:pop()_ENV:pop()
end
menu:refresh(p0.active.mynewmoves,function(move)
return f_zobj([[disabled,@,name,@,move,@,select,@]],
not possible_moves[move],
move.name,
move,
function()
_ENV:pop()_ENV:pop()
f_select_move(p0,move)
end
)
end)
end,function(_ENV)
menu:refresh(f_zobj[[;name,fight,desc,fight|select|move,select,%f_menu_state_callback,state,pselmove;;name,switch,desc,switch|active|pokemon,select,%f_menu_state_callback,state,pselswitch;;name,forfeit,desc,forfeit|pokemon|battle,select,%f_psel_forfeit]])
end,function(_ENV)
menu:refresh(f_zobj[[,1,2,3]],function(i)
local team=f_get_team(i-1)
local newteam={}
local is_disabled=true
for i=1,6 do
newteam[i]=team[i].num
if not team[i]:f_pkmn_isempty()then
is_disabled=false
end
end
return{
name="team #"..i,
team=newteam,
select=function()_ENV:select_func()end,
disabled=disable_empty_team and is_disabled
}
end)
end,function(team,i)
return team[i]and team[i].num or-1
end,function(_ENV)
local team=_ENV:f_get_team_cursor"team1"
menu:refresh(f_zobj[[,1,2,3,4,5,6]],function(i)
return{
pkmn=team[i],
select=function(_ENV)
if team[_ENV:cursor"editteam"+1]:f_pkmn_available()then
_ENV:push"teamaction"
else
_ENV:push"teampkmn"
end
end
}
end)
end,function(_ENV)
local team=_ENV:f_get_team_cursor"team1"
menu:refresh(f_zobj[[,1,2,3,4,5,6]],function(i)
return{
disabled=i==_ENV:cursor"editteam"+1,
select=function(_ENV)
local ind_one,ind_two=_ENV:cursor"editteam"+1,_ENV:cursor"switchteam"+1
team[ind_one],team[ind_two]=team[ind_two],team[ind_one]
f_save_team(_ENV:cursor"team1",team)
_ENV:popuntil"editteam"
end,
pkmn=team[i]
}
end)
menu.c=editteam.menu.c
end,function(_ENV)
local team=_ENV:f_get_team_cursor"team1"
menu:refresh(f_zobj[[,1,2,3,4,5,6]],function(i)
local disabled=p0.team[i]:f_pkmn_isempty()or p0.active.shared==p0.team[i]or p0.team[i].major==1
return{
disabled=disabled,
select=function()
_ENV:pop()_ENV:pop()
f_select_switch(p0,p0.team[i])
end,
pkmn=p0.team[i]
}
end)
end,function(_ENV)
local p1,p2=p1,p2
if p1.priority==p2.priority then p2.priority+=_sgn(_rnd"2"-1)end
p0=p1.priority>p2.priority and p1 or p2
end,function(_ENV,lr)
local stayed=true
for i=browse.menu.c+lr,75.5+75.5*lr,lr do
if c_pokemon[i]:f_pkmn_available()then
browse.menu.c=i
stayed=false
f_minisfx"154"
break
end
end
if stayed then f_beep()end
f_browsestat_init(_ENV)
end,function(game)f_minisfx(game:cursor"browse")end,function()f_minisfx(f_flr_rnd"152")end,function(_ENV)f_minisfx(p0.active.num)end,function(_ENV)
local team={}
for ind,num in _pairs(_split"133,7,35,1,25,4")do
f_set_default_team_pkmn(team,ind,num)
_poke(0x5e5a+num,1)
end
if@0x5efc==0 then
_poke(0x5efc,1)
f_save_team(0,team)
end
modes=f_zclass[[cursor,%f_modes_cursor,entry,%f_modes_entry,push,%f_modes_push,pop,%f_modes_pop,popuntil,%f_modes_popuntil,pkmn,%f_nop,update,%f_nop,draw1,%f_nop,draw2,%f_nop,draw3,%f_nop,curr,main;defaults;menu,%c_no,ui_pl,error,finit,%f_nop,init,%f_nop,lrfunc,%f_beep,xfunc,%f_nop,update,%f_modes_default_update,movemode,%c_no,draw1,%f_modes_default_draw1,draw2,%f_nop,draw3,%f_nop;main;init,~f_main_init,draw2,~f_main_draw2,draw3,~f_main_draw3;browse;init,%f_browse_init,draw2,%f_browse_draw2,draw3,%f_browse_draw3;browsestat;init,%f_browsestat_init,draw2,%f_browse_draw2,draw3,%f_browse_draw3,lrfunc,%f_browsestat_lrfunc,xfunc,%f_browsestat_xfunc;editteam;init,%f_editteam_init,draw2,%f_editteam_draw2,draw3,%f_editteam_draw3,draw1,%f_editteam_draw1;switchteam;init,%f_switchteam_init,draw2,%f_editteam_draw2,draw3,%f_editteam_draw3,draw1,%f_editteam_draw1;teampkmn;init,%f_teampkmn_init,draw2,%f_browse_draw2,draw3,%f_browse_draw3;teamaction;init,%f_teamaction_init,draw2,%f_editteam_draw2,draw3,%f_editteam_draw3;moveaction;init,%f_moveaction_init,draw2,%f_teammoves_draw2,draw3,%f_move_draw3,movemode,teammoves;teammovesel;init,%f_teammovesel_init,draw2,%f_teammovesel_draw2,draw3,%f_move_draw3;teammoves;init,%f_teammoves_init,draw2,%f_teammoves_draw2,draw3,%f_move_draw3;switchmoves;init,%f_switchmoves_init,draw2,%f_teammoves_draw2,draw3,%f_move_draw3;team1;ui_pl,player,init,%f_team_init,draw2,%f_team_draw2,draw3,%f_team_draw3,disable_empty_team,%c_no,select_func,%f_team_select;team1story;ui_pl,player,init,%f_team_init,draw2,%f_team_draw2,draw3,%f_team_draw3,disable_empty_team,%c_yes,select_func,%f_story_select;team1match;ui_pl,player 1,init,%f_team_init,draw2,%f_team_draw2,draw3,%f_team_draw3,disable_empty_team,%c_yes,select_func,%f_match_select;team1horde;ui_pl,player,init,%f_team_init,draw2,%f_team_draw2,draw3,%f_team_draw3,disable_empty_team,%c_yes,select_func,%f_horde_select;team2match;ui_pl,player 2,init,%f_team_init,draw2,%f_team_draw2,draw3,%f_team_draw3,disable_empty_team,%c_yes,select_func,%f_match_start;team2story;ui_pl,trainer,init,%f_fightsel_init,draw2,%f_team_draw2,draw3,%f_team_draw3;fightover;init,%f_fightover_init,draw2,%f_fightover_draw2,draw3,%f_fightover_draw3,xfunc,%f_fightover_xfunc;pselactions;init,%f_pselactions_init,draw2,%f_turn_draw2,draw3,%f_pselactions_draw3;pselmove;init,%f_pselmove_init,draw2,%f_turn_draw2,draw3,%f_move_draw3;pselswitch;init,%f_pselswitch_init,draw2,%f_turn_draw2,draw3,%f_pselswitch_draw3,draw1,%f_editteam_draw1;p1sel;next,p2sel,init,%f_psel_init,update,%f_nop,draw1,%f_nop,p0key,p1;p2sel;next,turn,init,%f_psel_init,update,%f_nop,draw1,%f_nop,p0key,p2;turn;next,p1sel,init,%f_turn_init,update,%f_turn_update,draw1,%f_turn_draw1,draw2,%f_turn_draw2,draw3,%f_turn_draw3,cur_action,%c_no;credits;init,%f_credits_init,draw2,%f_main_draw2,draw3,%f_main_draw3,xfunc,%f_credits_xfunc;]]
f_zcall(function(menu_name,create_func,...)
modes[menu_name].menu=create_func(...)
end,[[;,browse,~f_create_menu,~f_browse_drawentry,4;;,browsestat,~f_create_menu_view,~f_menu_drawentry;;,credits,~f_create_menu_view,~f_menu_drawentry;;,fightover,~f_create_menu_view,~f_menu_drawentry;;,editteam,~f_create_menu,~f_browse_drawentry,3;;,switchteam,~f_create_menu,~f_browse_drawentry,3;;,main,~f_create_menu,~f_menu_drawentry;;,teamaction,~f_create_menu,~f_menu_drawentry;;,moveaction,~f_create_menu,~f_menu_drawentry;;,teammovesel,~f_create_menu,~f_menu_drawentry;;,teammoves,~f_create_menu,~f_menu_drawentry;;,switchmoves,~f_create_menu,~f_menu_drawentry;;,team1,~f_create_menu,~f_menu_drawentry;;,team2story,~f_create_menu,~f_menu_drawentry;;,team2match,~f_create_menu,~f_menu_drawentry]])
f_zobj_set(modes,[[team1menu,@,browsemenu,@;main;menu;cancel,%f_beep;pselactions;menu;cancel,%f_beep;team1horde;menu,~team1menu;team1match;menu,~team1menu;team1story;menu,~team1menu;teampkmn;menu,~browsemenu;]],modes.team1.menu,modes.browse.menu)
f_minisfx"152"
_menuitem(1,"close picodex",function()
_menuitem(1)
_menuitem(2)
_ENV:load"closing"
end)
_menuitem(2,"swap 🅾️/❎",function()
_poke(0x5eff,@0x5eff==0 and 1 or 0)
end)
end,function(program)
program.modes:state()
end,function()g_picodex.modes:draw1()end,function()g_picodex.modes:draw2()end,function()g_picodex.modes:draw3()end,function(_ENV)menu.update(_ENV)end,function(_ENV)menu.draw1(_ENV)end,function(_ENV,menu_name)
return _ENV[menu_name].menu.c
end,function(_ENV,menu_name)
local menu=menu_name and _ENV[menu_name].menu or menu
return menu[menu.c+1]
end,function()
_sfx(-2,1)
end,function(_ENV)
_menuitem(1,"factory reset",function()
_memset(0x5e00,0,0x100)
_ENV:load"shaking"
end)
end,function()
return _btn()& 0x3f ~=0
end,function(_ENV)
if not f_any_btn()and backbuttonheld then
backbuttonheld=false
_ENV:load()
_menuitem(1)
elseif f_any_btn()then
backbuttonheld=true
_menuitem(1)
end
end,0,function(num)
_g.g_cur_light=_max(0,0+num-152)
_sfx(54+num\16,0,num%16*2,2)
end,function(_ENV)
_cls"0"
f_zcamera(0,128+_sin(_ENV:get_elapsed_percent"moveup"/4)*128,function()
f_zcall(f_zprint,[[;,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pICO-8 pOKEDEX sIM,64,15,7,0]])
f_zcall(f_zspr,[[;,102,64,11,5,1]])
local top_row_buttons,
bot_row_buttons,
rotation=
modes and modes.main.menu.c,
modes and modes.stacksize-1,
foldstate=="open"and 1
or foldstate=="closed"and-1
or(foldstate=="opening"and-1 or 1)*_cos(_ENV:get_elapsed_percent(foldstate)/2)
f_zcamera(30-(rotation+1)*15+(curr=="shaking"and f_flr_rnd"3"-1 or 0),27,function()
f_zcall(_rectfill,[[;,14,18,@,87,5]],63+_max(0,rotation*54))
if light==0 then
f_zcall(_rectfill,[[;,14,18,117,87,13]])
f_zcall(f_draw_screen,[[;,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@]],draw1,draw2,draw3)
end
f_zcall(_map,[[;,24,0,2,1,8,3;;,8,0,2,9,8,11]])
f_zcall(function(l,off,on,flash,x,y)
return _spr((light<=l)and(g_cur_light==l and _stat"46">=0 and flash or on)or off,x,y)
end,[[;,0,135,133,134,6,3;;,1,132,128,131,12,3;;,2,132,129,131,17,3;;,3,132,130,131,22,3]])
f_zcall(function(b,s1,s2,x,y)
_spr(_btn(b)and s1 or s2,x,y)
end,[[;,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77]])
if rotation<=0 then
f_picodex_map(0,2+64*(1-_abs(rotation)),_abs(rotation))
if rotation==-1 and backbuttonheld then _spr(123,6,49)end
else
f_picodex_map(16,62,rotation)
if rotation==1 then
if top_row_buttons then _spr(153,70+top_row_buttons*8,41)end
if bot_row_buttons and bot_row_buttons>=0 then _spr(153,70+bot_row_buttons*8,49)end
end
end
end)
end)
end,function(cx,sx,sw)
sw*=64
for y=9,96 do
_tline(sx,y,sx+sw-1,y,cx,y/8-1.125,8/sw,0)
end
end,function(text,x,y,color)
local t1,t2="",""
for i=1,#text do
local letter,switch=_sub(text,i,i),i%2==0
t1..=switch and " "or letter
t2..=switch and letter or " "
end
f_zprint(t1,x,y,color,0)
f_zprint(t2,x,y+1,color,0)
end,function(text,x,y,color,align)
text=""..text
if align==0 then x-=#text*2
elseif align>0 then x-=#text*4+1 end
_print(text,x,y,color)
end,function(xoff,yoff,w,h,screen_func)
_clip(-%0x5f28+xoff,-%0x5f2a+yoff,w,h)
f_zcamera(xoff,yoff,screen_func)
_clip()
end,function(_ENV)
if num>=0 then
return not browse or@(0x5e5a+num)>0
end
end,function(pkmn)
f_print_draw2_message("pkmn #"..pkmn.num)
end,function(pkmn)
if pkmn:f_pkmn_available()then
f_print_draw3_message(pkmn.name.."|"..c_types[pkmn.type1].name.."|"..c_types[pkmn.type2].name)
else
f_print_draw3_message"?????????|????|??????"
end
end,function(num,x,y,sw,sh)
local row,col=num/8\1,num%8
if row ~=g_loaded_row then
g_loaded_row=row
_memcpy(0x0000,0x8000+0x400*row,0x400)
end
local w,h=16*sw,16*sh
_sspr(col*16,0,16,16,x-w/2,y-h/2,w,h)
end,function(_ENV,x,y,col,xscale,yscale)
local num=_ENV:f_pkmn_available()and num or-1
if num==25 and _ENV:f_pkmn_has_move(53)then num=152 end
if num==54 and _ENV:f_pkmn_has_move(143)then num=153 end
if substitute and substitute>0 then num=154 end
if not isactive or major ~=1 and not invisible and not(moveturn ~=0 and curmove.ofunc==f_move_flydig)then
if num<0 then _spr(107,x-4,y-4)return end
xscale,yscale=xscale or 1,yscale or 1
local outline_width=_max(_abs(xscale),1)\ 1
f_zcall(function(color,v1,v2,v3,v4)
for c=1,15 do _pal(c,color)end
for i=-outline_width,outline_width,outline_width*2 do
f_draw_pkmn(num,x+(v1 or i),y+(v2 or i),xscale,yscale)
f_draw_pkmn(num,x+(v3 or i),y+(v4 or i),xscale,yscale)
end
end,[[;,@,@,%c_no,@,%c_no;;,1,%c_no,0,0,%c_no]],col,-outline_width,outline_width)
_pal()f_draw_pkmn(num,x,y,xscale,yscale)
end
end,function(menu,pkmn)
menu:refresh{}
f_zobj_set(menu,[[;pkmn,@;;hidden,%c_yes;;name,lvl 50,style,5;;name,@]],pkmn,(pkmn.hp or pkmn.maxhp).."/"..pkmn.maxhp)
_foreach(f_zobj[[;key,special,name,spc;;key,attack,name,att;;key,defense,name,def;;key,speed,name,spd;;key,total,name,tot]],function(pair)
if not pair.key then
_add(menu,{name=pair.name,style=5})
elseif pkmn[pair.key]then
_add(menu,{name=pair.name.." "..pkmn[pair.key]})
end
end)
f_zcall(function(name,key)
if #c_pokemon[pkmn.num][key]>0 then
_add(menu,{name=name,style=5})
_foreach(c_pokemon[pkmn.num][key],function(m)
_add(menu,{name=c_moves[m].name})
end)
end
end,[[;,learn,moves_natural;;,teach,moves_teach;;,event,moves_event]])
end,function(game)game:push"team2story" end,function(game)game:push"team2match" end,function(_ENV)
f_begin_fight(_ENV,
{f_get_team(_ENV:cursor"team1"),"player 1",false,f_nop},
{f_get_team(_ENV:cursor"team2match"),"player 2",false,f_nop}
)
end,function(_ENV)
local nums={}
for i=1,152 do _add(nums,i%152)end
f_begin_fight_cpu(_ENV,nums,"horde",function(_,other)
f_unlock_pkmn(other)
_poke(0x5efe,_mid(@0x5efe,#f_get_team_dead(other.team),255))
end)
end,function(game)
game:push"editteam"
end,function(game,cursor)
return f_get_team(game:cursor(cursor))
end,function(game)
local team=f_get_team(game:cursor"team1")
return team[game:cursor"editteam"+1],team
end,function(pl,pkmn)
pl.active=f_team_pkmn_to_active(pkmn)
return f_newaction(pl,"|comes|out")
end,function(pl,pkmn)
f_addaction(pl,pl,"|comes|back",function(params)
params.selfactive.invisible=true
f_addaction(pl,pl,false,function()
_add(pl.actions,f_pkmn_comes_out(pl,pkmn))
end)
end)
pl.priority=3000
end,function(self,move)
f_addaction(self,self,"|uses|"..move.name,function(params)
params.move=move
local _ENV=params
if move.num>0 then
move.pp-=1
end
if move.num==47 or move.num==36 then
f_move_setdmg_self(_ENV,selfactive.hp)
end
if f_does_move_miss(selfactive,otheractive,move)then
addaction(self,"|missed|"..move.name)
if move.num==145 or move.num==73 then
f_move_setdmg_self(_ENV,1)
end
else
if move.accuracy ~=0 then
otheractive.lastmoverecv=move.num
end
if move.func(_ENV)then
addaction(self,"|failed|"..move.name)
end
end
end)
end,function(_ENV,newval,newcurmove)
if not curmove and moveturn==0 then
moveturn,curmove=newval,newcurmove
end
end,function(self,move)
f_addaction(self,self,false,function(params)
params.move=move
local _ENV=params
selfactive:f_decrement_timer("moveturn",f_nop)
if selfactive.major==6 then
end
if selfactive.major==3 then
if _rnd"1"<.2 then
addaction(self,"|thawed|out")
selfactive.shared.major=0
else
addaction(self,"|is|frozen")
return
end
end
if otheractive.curmove and otheractive.curmove.ofunc==f_move_trapping then
addaction(self,"|is|trapped")
return
end
if selfactive.disabledslot==move.slot then
addaction(self,"|is|disabled")
return
end
if selfactive.confused>0 and f_flr_rnd"2"==0 then
addaction(self,"|confuse|damage")
f_move_setdmg_self(_ENV,f_calc_move_damage(selfactive,otheractive,f_create_move(-1)))
return
end
if selfactive.flinching then
addaction(self,"|is|flinching")
return
end
f_movelogic(self,move)
end)
end,function(active,key,endfunc)
if active[key]>0 then
active[key]-=1
if active[key]==0 then
endfunc()
end
end
end,function(self)
return f_newaction(self,false,function(_ENV)
if selfactive.major==6 or selfactive.major==3 then
selfactive.moveturn=0
end
if selfactive.moveturn==0 then
selfactive.curmove=nil
end
local statdmg=_max(selfactive.maxhp\16,1)
local inflictstatdmg=function(title)
addaction(self,title.."|damage")
f_move_setdmg_self(_ENV,statdmg)
end
if selfactive.major==5 then
if selfactive.toxiced>0 then
statdmg*=selfactive.toxiced
selfactive.toxiced+=1
end
inflictstatdmg"|poison"
end
if selfactive.major==2 then inflictstatdmg"|burn" end
if selfactive.seeded then
inflictstatdmg"|seed"
if otheractive.hp<otheractive.maxhp then
addaction(other,"|seed|leeching")
f_move_heal(_ENV,other,statdmg)
end
end
selfactive:f_decrement_timer("confused",function()
addaction(self,"|confusion|ended")
end)
selfactive:f_decrement_timer("disabledtimer",function()
addaction(self,"|"..selfactive.mynewmoves[selfactive.disabledslot].name.."|enabled")
selfactive.disabledslot=0
end)
end)
end,function(pl,move)
pl.actions={}
local priority_class=1000
f_premovelogic(pl,move)
if move.num==120 then priority_class=2000 end
if move.num==18 or move.num==4 or move.num==89 or move.num==30 then
priority_class=0000
end
pl.priority=_min(3000,priority_class+pl.active:f_movehelp_getstat"speed")
end,function(game,pl)
return pl==game.p1 and game.p2 or game.p1
end,function(pactive,message,logic,name)
return{pl=pactive,name=name or pactive.active.name,active=pactive.active,message=message,logic=logic or f_nop}
end,function(p0,...)
_add(p0.actions,f_newaction(...))
end,function(game)
if g_bpo then f_beep()end
if g_bpx then f_minisfx"154" end
if g_bpx or not game.cur_action then
while true do
for p in _all{game.p1,game.p2}do
if not f_get_next_active(p.team)then
game.p0=f_get_other_pl(game,p)
game:load"fightover"
return
end
end
local action=f_pop_next_action(game)
if action then
local actionpl=action.active==game.p1.active and game.p1 or game.p2
local envparams=f_zobj([[move,@,self,@,other,@,addaction,@]],move,actionpl,f_get_other_pl(game,actionpl),function(...)
f_addaction(actionpl,...)
end)
envparams.selfactive=envparams.self.active
envparams.otheractive=envparams.other.active
action.logic(envparams)
if action.message then
game.cur_action=action
return
else
end
else
game:load()
return
end
end
end
end,function(game)
for p in _all{game.p1,game.p2}do
if p.active.hp<=0 then
if p.active.major ~=1 then
return f_newaction(p,"|is|fainted",function(_ENV)
selfactive.shared.major=1
end)
elseif p ~=game.p0 then
return f_pkmn_comes_out(p,f_get_next_active(p.team))
end
end
end
for s in _all{game.p0,f_get_other_pl(game,game.p0)}do
local o=f_get_other_pl(game,s)
while #s.actions>0 do
local action=_deli(s.actions,1)
if action.active.major ~=1 and(action.active==s.active or action.active==o.active)then
return action
end
end
if s.active.hp<=0 and s.active.major==1 then
return f_pkmn_comes_out(s,f_get_next_active(s.team))
end
if not s.turnover then
s.turnover=true
return f_postmove_logic(s)
end
end
end)
f_zobj_set(_g,[[f_pkmn_has_move,@,f_pkmn_isempty,@,f_get_moves,@,f_get_possible_moves,@,f_select_random_move,@,f_get_crit_ratio,@,f_does_move_miss,@,f_get_type_modifier,@,f_get_type_advantage,@,f_calc_move_damage,@,f_psel_init,@,f_psel_forfeit,@,f_begin_fight,@,f_begin_fight_cpu,@,f_extract_sheet,@,f_vget,@,f_vset,@,f_px9_decomp,@,f_game_state_init,@]],function(_ENV,moveid)
for m in _all(mynewmoves)do
if m.num==moveid then
return true
end
end
end,function(_ENV)
return #f_get_moves(_ENV,true)==0
end,function(pkmn,ismimic)
local moves={}
_foreach(pkmn.mynewmoves,function(m)
if m.num>0 and(ismimic or m.pp>0 and pkmn.disabledslot ~=m.slot)then
_add(moves,m)
moves[m]=true
end
end)
return moves
end,function(_ENV)
if moveturn ~=0 then
return{curmove}
else
return f_get_moves(_ENV)
end
end,function(active)
local possible_moves=f_get_possible_moves(active)
return possible_moves[f_flr_rnd(#possible_moves)+1]or f_create_move(0)
end,function(_ENV,movenum)
local divisor=1024
if movenum==-1 then return 1 end
if movenum==107 or movenum==164 or movenum==57 or movenum==157 then divisor*=.3 end
if focused then divisor*=.3 end
return _rnd"1"<_min(.99,(base_speed+76)/divisor)and 2 or 1
end,function(attacker,defender,move)
if move.accuracy<=0 then return false end
if(move.ofunc==f_move_prepare or move.ofunc==f_move_flydig)and not attacker.curmove then return false end
if defender.curmove and defender.curmove.ofunc==f_move_flydig then return true end
if attacker.curmove and attacker.curmove.ofunc==f_move_trapping then return false end
return _rnd(defender:f_movehelp_getstat"evasion")>move.accuracy/100*attacker:f_movehelp_getstat"accuracy"or f_flr_rnd"256"==0 and f_flr_rnd"256"==0
end,function(move_type,pkmn_type)
return c_types[move_type][pkmn_type]or 1
end,function(move,defender)
return f_get_type_modifier(move.type,defender.type1)*f_get_type_modifier(move.type,defender.type2)
end,function(attacker,defender,move)
local attack,defense=attacker:f_movehelp_getstat"special",defender:f_movehelp_getstat"special"
if move.type%2==1 then
attack,defense=attacker:f_movehelp_getstat"attack",defender:f_movehelp_getstat"defense"
if defender.reflected then
defense*=2
end
elseif defender.screened then
defense*=2
end
local base_damage=_mid(
3,997,
(2*attacker.level*f_get_crit_ratio(attacker,move.num)/5+2)/50
*move.damage
*_mid(10,.2,attack/defense)
)+2
return base_damage
*((move.type==attacker.type1 or move.type==attacker.type2)and 1.5 or 1)
*f_get_type_advantage(move,defender)
*(_rnd".15"+.85)\1
end,function(_ENV)
p0=_ENV[p0key]
do local _ENV=p0.active
counterdmg,flinching=0,false
end
p0.turnover=false
if p0.iscpu then
f_select_move(p0,f_select_random_move(p0.active))
_ENV:load()
elseif #p0.actions>0 then
_ENV:load()
else
pselactions.menu,
pselmove.menu,
pselswitch.menu,
cur_action,
stack[#stack]=p0.menu_action,
p0.menu_move,
p0.menu_switch,
f_newaction(p0,""),
curr
_ENV:push"pselactions"
end
end,function(_ENV)
_ENV:pop()
p0=_ENV:f_get_other_pl(p0)
_ENV:load"fightover"
end,function(_ENV,d1,d2)
d1.key,d2.key="p1","p2"
for dd in _all{d1,d2}do
_ENV[dd.key]=f_zobj([[actions,#,priority,1,menu_action,@,menu_move,@,menu_switch,@,team,@,name,@,iscpu,@,winlogic,@]],f_create_menu(f_menu_drawentry),
f_create_menu(f_menu_drawentry),
f_create_menu(f_browse_drawentry,3),
_unpack(dd))
local _ENV=_ENV[dd.key]
menu_action.cancel=f_beep
_add(actions,f_pkmn_comes_out(_ENV,f_get_next_active(team)))
end
p0=p1
_ENV:push"turn"
end,function(_ENV,pkmn_nums,name,plwinfunc)
local cpu_team_draft={}
for i=1,#pkmn_nums do
f_set_default_team_pkmn(cpu_team_draft,i,pkmn_nums[i])
end
f_begin_fight(_ENV,
{_ENV:f_get_team_cursor"team1","player",false,plwinfunc},
{cpu_team_draft,name,true,f_nop}
)
end,function(index)
f_px9_decomp(_peek2(index),
function(...)return f_vget(0x8000+index*0x1000,...)end,
function(...)return f_vset(0x8000+index*0x1000,...)end)
end,function(offset,x,y)
x=_min(_max(0,x),127)\1
y=y\1
local val=_peek(y*64+offset+x\2)
if x%2==1 then return(val & 0xf0)>>>4
else return(val & 0x0f)end
end,function(offset,x,y,val)
x=_min(_max(0,x),127)\1
y=y\1
local mem_coord=y*64+offset+x\2
local oldval=_peek(mem_coord)
if x%2==1 then _poke(mem_coord,(oldval & 0x0f)|(((val or 0)& 0x0f)<<4))
else _poke(mem_coord,(oldval & 0xf0)|(((val or 0)& 0x0f)<<0))
end
end,function(src,f_vget,f_vset)
local function vlist_val(l,val)
local v,i=l[1],1
while v!=val do
i+=1
v,l[i]=l[i],v
end
l[1]=val
end
local cache,cache_bits=0,0
function getval(bits)
if cache_bits<8 then
cache_bits+=8
cache+=@src>>cache_bits
src+=1
end
cache<<=bits
local val=cache&0xffff
cache^^=val
cache_bits-=bits
return val
end
function gnp(n)
local bits=0
repeat
bits+=1
local vv=getval(bits)
n+=vv
until vv<(1<<bits)-1
return n
end
local w,h_1,eb,el,pr,x,y,splen,predict=gnp"1",gnp"0",gnp"1",{},{},0,0,0
for i=1,gnp"1" do _add(el,getval(eb))end
for y=0,h_1 do
for x=0,w-1 do
splen-=1
if(splen<1)then
splen,predict=gnp"1",not predict
end
local a=y>0 and f_vget(x,y-1)or 0
local l=pr[a]or{_unpack(el)}
pr[a]=l
local v=l[predict and 1 or gnp"2"]
vlist_val(l,v)
vlist_val(el,v)
f_vset(x,y,v)
end
end
end,function(state)
f_minisfx(state.sfx)
state:sinit()
end)
c_pokemon_names[0]=""
_g.c_moves_raw=f_zobj[[-1;,none,%f_move_default;0;,struggle,%f_move_recoil;;,megapnch,%f_move_default;;,razrwind,%f_move_prepare;;,sworddnc,%f_move_self,%f_move_stat,attack,2;;,whrlwind,%f_move_roar;;,megakick,%f_move_default;;,toxic,%f_move_toxic;;,horndril,%f_move_ohko;;,bodyslam,%f_move_default,30,%f_move_major_other,4;;,takedown,%f_move_recoil;;,doubedge,%f_move_recoil;;,bublbeam,%f_move_default,10,%f_move_other,%f_move_stat,speed,-1;;,watergun,%f_move_default;;,icebeam,%f_move_default,10,%f_move_major_other,3;;,blizzard,%f_move_default,10,%f_move_major_other,3;;,hyprbeam,%f_move_hyperbeam;;,payday,%f_move_default;;,submsion,%f_move_recoil;;,counter,%f_move_counter;;,seistoss,%f_move_setdmg,50;;,rage,%f_move_rage;;,megdrain,%f_move_drain;;,solrbeam,%f_move_prepare;;,drgnrage,%f_move_setdmg,40;;,thndrblt,%f_move_default,10,%f_move_major_other,4;;,thunder,%f_move_default,10,%f_move_major_other,4;;,earthqke,%f_move_default;;,fissure,%f_move_ohko;;,dig,%f_move_flydig,digging;;,psychic,%f_move_default,30,%f_move_other,%f_move_stat,special,-1;;,teleport,%f_move_teleport;;,mimic,%f_move_mimic;;,doubteam,%f_move_self,%f_move_stat,evasion,1;;,reflect,%f_move_self,%f_movehelp_minor,|raises|defense,reflected;;,bide,%f_move_bide;;,metrnome,%f_move_metronome;;,selfdstr,%f_move_default;;,eggbomb,%f_move_default;;,fireblst,%f_move_default,30,%f_move_major_other,2;;,swift,%f_move_default;;,skulbash,%f_move_prepare;;,softboil,%f_move_recover;;,dreameat,%f_move_dreameater;;,skyattck,%f_move_prepare;;,rest,%f_move_rest;;,thndrwav,%f_move_major_other,4;;,psywave,%f_move_psywave;;,explsion,%f_move_default;;,rockslid,%f_move_default;;,triattck,%f_move_default;;,substute,%f_move_substitute;;,cut,%f_move_default;;,fly,%f_move_flydig,flying;;,surf,%f_move_default;;,strength,%f_move_default;;,flash,%f_move_other,%f_move_stat,accuracy,-1;;,pound,%f_move_default;;,karatchp,%f_move_default;;,doubslap,%f_move_multihit_var;;,comtpnch,%f_move_multihit_var;;,firepnch,%f_move_default,10,%f_move_major_other,2;;,icepnch,%f_move_default,10,%f_move_major_other,3;;,thndpnch,%f_move_default,10,%f_move_major_other,4;;,scratch,%f_move_default;;,vicegrip,%f_move_default;;,guilotin,%f_move_ohko;;,gust,%f_move_default;;,wingatck,%f_move_default;;,bind,%f_move_trapping;;,slam,%f_move_default;;,vinewhip,%f_move_default;;,stomp,%f_move_default,30,%f_move_other,%f_movehelp_flinch;;,doubkick,%f_move_multihit_set,2,%f_nop;;,jumpkick,%f_move_default;;,rllngkck,%f_move_default,30,%f_move_other,%f_movehelp_flinch;;,sandatck,%f_move_other,%f_move_stat,accuracy,-1;;,headbutt,%f_move_default,30,%f_move_other,%f_movehelp_flinch;;,hornatck,%f_move_default;;,furyatck,%f_move_multihit_var;;,tackle,%f_move_default;;,wrap,%f_move_trapping;;,thrash,%f_move_thrash;;,tailwhip,%f_move_other,%f_move_stat,defense,-1;;,psnsting,%f_move_default,20,%f_move_major_other,5;;,twineedl,%f_move_multihit_twin;;,pinmisil,%f_move_multihit_var;;,leer,%f_move_other,%f_move_stat,defense,-1;;,bite,%f_move_default,10,%f_move_other,%f_movehelp_flinch;;,growl,%f_move_other,%f_move_stat,attack,-1;;,roar,%f_move_roar;;,sing,%f_move_major_other,6;;,sprsonic,%f_move_other,%f_movehelp_confuse;;,sonicbom,%f_move_setdmg,20;;,disable,%f_move_disable;;,acid,%f_move_default,10,%f_move_other,%f_move_stat,defense,-1;;,ember,%f_move_default,10,%f_move_major_other,2;;,flamthwr,%f_move_default,10,%f_move_major_other,2;;,mist,%f_move_self,%f_movehelp_minor,|stat lower|immunity,misted;;,hydropmp,%f_move_default;;,psybeam,%f_move_default,10,%f_move_other,%f_movehelp_confuse;;,aurorabm,%f_move_default,10,%f_move_other,%f_move_stat,attack,-1;;,peck,%f_move_default;;,drillpck,%f_move_default;;,lowkick,%f_move_default,30,%f_move_other,%f_movehelp_flinch;;,absorb,%f_move_drain;;,leechsed,%f_move_other,%f_movehelp_minor,|is now|seeded,seeded;;,growth,%f_move_self,%f_move_stat,special,1;;,razrleaf,%f_move_default;;,psnpowdr,%f_move_major_other,5;;,stunspor,%f_move_major_other,4;;,slppowdr,%f_move_major_other,6;;,petldanc,%f_move_thrash;;,strngsht,%f_move_other,%f_move_stat,speed,-1;;,firespin,%f_move_trapping;;,thndshck,%f_move_default,10,%f_move_major_other,4;;,rockthrw,%f_move_default;;,cnfusion,%f_move_default,10,%f_move_other,%f_movehelp_confuse;;,hypnosis,%f_move_major_other,6;;,meditate,%f_move_self,%f_move_stat,attack,1;;,agility,%f_move_self,%f_move_stat,speed,2;;,quickatk,%f_move_default;;,ngtshade,%f_move_setdmg,50;;,screech,%f_move_other,%f_move_stat,defense,-2;;,recover,%f_move_recover;;,harden,%f_move_self,%f_move_stat,defense,1;;,minimize,%f_move_self,%f_move_stat,evasion,1;;,smokscrn,%f_move_other,%f_move_stat,accuracy,-1;;,cnfusray,%f_move_other,%f_movehelp_confuse;;,withdraw,%f_move_self,%f_move_stat,defense,1;;,dfnscurl,%f_move_self,%f_move_stat,defense,1;;,barrier,%f_move_self,%f_move_stat,defense,2;;,lghtscrn,%f_move_self,%f_movehelp_minor,|raises|spcdefense,screened;;,haze,%f_move_haze;;,fcsenrgy,%f_move_self,%f_movehelp_minor,|raises|crit ratio,focused;;,mirrmove,%f_move_mirror_move;;,lick,%f_move_default,30,%f_move_major_other,4;;,smog,%f_move_default,30,%f_move_major_other,5;;,sludge,%f_move_default,30,%f_move_major_other,5;;,boneclub,%f_move_default,10,%f_move_other,%f_movehelp_flinch;;,watrfall,%f_move_default;;,clamp,%f_move_trapping;;,spikcann,%f_move_multihit_var;;,constrct,%f_move_default,10,%f_move_other,%f_move_stat,speed,-1;;,amnesia,%f_move_self,%f_move_stat,special,2;;,kinesis,%f_move_other,%f_move_stat,accuracy,-1;;,hijmpkck,%f_move_default;;,glare,%f_move_major_other,4;;,poisngas,%f_move_major_other,5;;,barrage,%f_move_multihit_var;;,leechlif,%f_move_drain;;,lovekiss,%f_move_major_other,6;;,tranform,%f_move_transform;;,bubble,%f_move_default,10,%f_move_other,%f_move_stat,speed,-1;;,dizypnch,%f_move_default;;,spore,%f_move_major_other,6;;,splash,%f_move_splash;;,acidarmr,%f_move_self,%f_move_stat,defense,2;;,crabhamr,%f_move_default;;,furyswps,%f_move_multihit_var;;,bonerang,%f_move_multihit_set,2,%f_nop;;,hyprfang,%f_move_default,10,%f_move_other,%f_movehelp_flinch;;,sharpen,%f_move_self,%f_move_stat,attack,1;;,convrson,%f_move_conversion;;,suprfang,%f_move_superfang;;,slash,%f_move_default]]
c_menustyles=f_zobj[[;bg,13,fg,1,out,5;;bg,6,fg,13,out,13;;bg,5,fg,1,out,5;;bg,6,fg,5,out,5;;bg,1,fg,13,out,5]]
c_team_memlocs=f_zobj[[0,0x5e00,1,0x5e1e,2,0x5e3c]]
g_loaded_row=16
function _init()
local _ENV=_g
_memset(0x8000,0,0x7fff)
g_picodex=f_zclass[[curr,wait;init,%f_game_state_init,light,4;defaults;foldstate,closed,light,4,sfx,-1,backbuttonheld,%c_no,sinit,%f_nop,update,%f_nop,draw,%f_nop,draw1,%f_nop,draw2,%f_nop,draw3,%f_nop,modes,;wait;next,moveup,duration,.5,draw,%f_draw_picodex;moveup;next,closed,duration,.5,draw,%f_draw_picodex,sinit,%f_moveup_init;shaking;foldstate,closed,next,closed,duration,.5,draw,%f_draw_picodex;closed;foldstate,closed,next,opening,sinit,%f_closed_init,draw,%f_draw_picodex,update,%f_closed_update;opening;foldstate,opening,next,starting_1,duration,.2,draw,%f_draw_picodex;starting_1;foldstate,open,next,starting_2,light,3,duration,.2,sfx,155,draw,%f_draw_picodex;starting_2;foldstate,open,next,starting_3,light,2,duration,.2,sfx,154,draw,%f_draw_picodex;starting_3;foldstate,open,next,game,light,1,duration,.2,sfx,153,draw,%f_draw_picodex;game;foldstate,open,next,closing,light,0,sinit,%f_game_init,draw,%f_draw_picodex,update,%f_game_update,draw1,%f_game_draw1,draw2,%f_game_draw2,draw3,%f_game_draw3;closing;foldstate,closing,next,closed,duration,.25,draw,%f_draw_picodex,update,%f_nop;]]
f_draw_picodex(g_picodex)
_flip()
f_minisfx"158"
f_extract_sheet(0x0)
f_extract_sheet(0x2)
f_extract_sheet(0x4)
f_zcall(_poke,[[;,0x5f5c,8;;,0x5f5d,2;;,0x5f56,0xe0]])
f_px9_decomp(_peek2"0x6",_mget,_mset)
f_populate_c_moves()
f_populate_c_pokemon()
local trainer_loc=_peek2"0xc"
for i,v in _pairs(c_trainers)do
local tbl={name=v}
for j=1,6 do
_add(tbl,_peek(trainer_loc))
trainer_loc+=1
end
c_trainers[i]=tbl
end
_memcpy(0x0000,0xc000,0x2000)
end
function _update60()
local _ENV=_g
g_bpo,g_bpx=_btnp"4",_btnp"5"
g_bph,g_bpv=f_btn_helper(_btnp,0,1),f_btn_helper(_btnp,2,3)
if@0x5eff==1 then
g_bpo,g_bpx=g_bpx,g_bpo
end
g_picodex:state()
end
function _draw()
local _ENV=_g
g_picodex:draw()
end