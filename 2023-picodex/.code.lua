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
f_zobj_set(_g,[[g_zclass_constructors,@,g_zclass_entities,@,g_zclass_new_entities,@,f_zclass,@,f_register_entities,@,f_deregister_entity,@,f_call_not_nil,@,f_does_entity_exist,@,f_loop_entities,@,f_clean_all_entities,@,f_zobj,@,f_zobj_set,@,f_zobj_eval,@,f_zspr,@,f_flr_rnd,@,f_rnd_one,@,f_zcall_tbl,@,f_zcall,@,f_zcls,@,f_zcamera,@,f_btn_helper,@,f_actor_load,@,f_actor_loadlogic,@,f_actor_state,@,f_actor_is_alive,@,f_actor_kill,@,f_actor_clean,@,f_timer_reset_timer,@,f_timer_end_timer,@,f_timer_get_elapsed_percent,@,f_timer_is_active,@,f_timer_tick,@,f_print_draw2_message,@,f_print_draw3_message,@,c_pokemon,@,c_pokemon_names,@,c_major_names,@,c_types,@,c_bg_styles,@,c_zmovetype,@,c_moves,@,c_moves_raw,@,c_trainers,@,f_menu_state_callback,@,f_create_menu_view,@,f_create_menu,@,f_menu_refresh,@,f_menu_cancel,@,f_menu_set,@,f_menu_view_update,@,f_menu_update,@,f_menu_draw1,@,f_menu_drawentry,@,f_browse_drawentry,@,f_populate_c_moves,@,f_get_natural_moveset,@,f_create_move,@,f_create_empty_moveset,@,f_calc_max_stat,@,f_populate_c_pokemon,@,f_team_pkmn_to_active,@,f_unlock_pkmn,@,f_get_team_dead,@,f_get_team_live,@,f_get_next_active,@,f_create_team_pkmn,@,f_get_fight_team,@,f_get_team,@,f_save_team,@,f_editteam_draw1,@,f_draw_hp,@,f_turn_draw1,@,f_draw_battle_side,@,f_browse_draw2,@,f_editteam_draw2,@,f_teammoves_draw2,@,f_team_draw2,@,f_fightover_draw2,@,f_pselactions_draw2,@,f_pselmove_draw2,@,f_teammovesel_draw2,@,f_main_draw2,@,f_turn_draw2,@,f_editteam_draw3,@,f_move_draw3,@,f_browse_draw3,@,f_main_draw3,@,f_pselactions_draw3,@,f_pstat_draw3,@,f_fight_draw3_helper,@,f_pselswitch_draw3,@,f_team_draw3,@,f_pselmove_draw3,@,f_fightover_draw3,@,f_turn_draw3,@,f_fightover_init,@,f_main_init,@,f_browse_init_shared,@,f_browse_init,@,f_teampkmn_init,@]],{},{},{},function(meta_and_att_str)
local meta,template,memloc,expected_memloc_value=_unpack(_split(meta_and_att_str,"|"))
local parents=_split(meta)
local class=_deli(parents,1)
g_zclass_entities[class]=g_zclass_entities[class]or{}
g_zclass_constructors[class]=function(inst,done,...)
_foreach(parents,function(parent)
if not done[parent]then g_zclass_constructors[parent](inst,done)end
end)
done[class]=true
inst.parents[class]=true
_add(g_zclass_new_entities,{class,inst})
return f_zobj_set(inst,template,...)
end
_g[class]=function(...)
if not memloc or _peek(memloc)==expected_memloc_value then
return g_zclass_constructors[class](f_zobj([[id,@;parents;,;ecs_exclusions;,]],class),{},...)
end
end
end,function()
while #g_zclass_new_entities>0 do
local class,inst=_unpack(_deli(g_zclass_new_entities))
if not inst.ecs_exclusions[class]then _add(g_zclass_entities[class],inst)end
end
end,function(inst,...)
for class,entities in _pairs(g_zclass_entities)do
_del(entities,inst)
end
end,function(table,key,...)
if table and table[key]then
return table[key](...)
end
end,function(entity_name)
return #g_zclass_entities[entity_name]>0
end,function(class,method_name,...)
for inst in _all(g_zclass_entities[class])do
f_call_not_nil(inst,method_name,inst,...)
end
end,function(...)
local objs_to_clean,exclusions={},{}
_foreach({...},function(exclusion)exclusions[exclusion]=true end)
for class,entities in _pairs(g_zclass_entities)do
for entity in _all(entities)do
objs_to_clean[entity]=entity.id
end
end
for obj,id in _pairs(objs_to_clean)do
if not exclusions[id]then
f_deregister_entity(obj)
end
end
g_zclass_new_entities={}
end,f_zobj,f_zobj_set,f_zobj_eval,function(sind,x,y,sw,sh,...)
sw,sh=sw or 1,sh or 1
_spr(sind,x-sw*4,y-sh*4,sw,sh,...)
end,function(x)
return _flr(_rnd(x))
end,function(val)
return(f_flr_rnd"3"-1)*(val or 1)
end,function(func,tbl)
_foreach(tbl,function(params)
func(_unpack(params))
end)
end,function(func,text,...)
f_zcall_tbl(func,f_zobj(text,...))
end,function(col)
_rectfill(0x8000,0x8000,0x7fff,0x7fff,col or 0)
end,function(nx,ny,func)
local ox,oy=%0x5f28,%0x5f2a
_camera(ox-nx,oy-ny)
func()
_camera(ox,oy)
end,function(f,a,b)
return f(a)and f(b)and 0 or f(a)and-1 or f(b)and 1 or 0
end,function(_ENV,stateName)
next_state=stateName or next
end,function(_ENV,stateName)
next_state,isnew=nil
if stateName=="dead"then
alive=false
else
_ENV:finit()
_ENV:end_timer(curr)
next,duration=nil
for k,v in _pairs(defaults)do _ENV[k]=v end
for k,v in _pairs(_ENV[stateName])do _ENV[k]=v end
curr=stateName
_ENV:start_timer(curr,duration,duration and function()_ENV:load(next or "dead")end)
_ENV:init()
end
end,function(_ENV)
if isnew then _ENV:loadlogic(curr)end
while next_state do
_ENV:loadlogic(next_state)
end
_ENV:update()
_ENV:stateless_update()
end,function(_ENV)
return not effectively_dead and _ENV:is_active"ending"==nil and alive
end,function(_ENV)
effectively_dead=true
if ending then
if curr=="start"then
next="ending"
elseif _ENV:is_active"ending"==nil then
_ENV:load"ending"
end
else
alive=nil
end
end,function(_ENV)
if not alive then
_ENV:destroyed()
f_deregister_entity(_ENV)
end
end,function(a,timer_name,duration,callback)
a.timers[timer_name]={active=true,elapsed=false,duration=duration and 0+duration,callback=callback or function()end}
end,function(a,timer_name)
if a.timers[timer_name]then
a.timers[timer_name].elapsed=a.timers[timer_name].duration or a.timers[timer_name].elapsed
a.timers[timer_name].active=false
end
end,function(a,timer_name)
local o_timer=a.timers[timer_name]
if not o_timer then return 0
elseif not o_timer.duration then return 0
elseif o_timer.duration<=0 then return 1
end
return _min(1,(o_timer.elapsed or 0)/o_timer.duration)
end,function(a,timer_name)
local o_timer=a.timers[timer_name]
return o_timer and o_timer.active
end,function(a)
local finished_timers={}
for name,o_timer in _pairs(a.timers)do
if o_timer.active then
if o_timer.elapsed then
o_timer.elapsed=o_timer.elapsed+1/60
if o_timer.duration and o_timer.elapsed>=o_timer.duration then
_add(finished_timers,o_timer)
end
elseif not o_timer.elapsed then
o_timer.elapsed=0
end
end
end
_foreach(finished_timers,function(o_timer)
o_timer.active=false
o_timer.callback(a)
end)
end,function(txt)
f_zprint(txt or "",23,4,1,0)
end,function(str)
f_zcall(_rectfill,[[;,0,0,45,6,1]])
f_zcall(f_zprint,[[;,@,23,1,13,0;;,@,23,8,1,0;;,@,23,15,1,0]],unpack(split(str,"|",false)))
end,f_zobj[[]],split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew",split"fainted,burned,frozen,paralyzed,poisoned,sleeping",f_zobj[[0;bg,0,name,%c_empty;0;good;,;0;null;,;0;weak;,;1;bg,0,name,normal;1;good;,;1;null;,15;1;weak;,13;2;bg,5,name,fire;2;good;,8,10,11;2;null;,;2;weak;,2,4,13,14;3;bg,2,name,fighting;3;good;,10,1,13;3;null;,15;3;weak;,11,9,5,12;4;bg,4,name,water;4;good;,2,7,13;4;null;,;4;weak;,14,8,4;5;bg,1,name,poison;5;good;,11,8;5;null;,;5;weak;,15,7,5,13;6;bg,6,name,electric;6;good;,9,4;6;null;,7;6;weak;,14,6,8;7;bg,2,name,ground;7;good;,6,2,5,13;7;null;,9;7;weak;,11,8;8;bg,3,name,grass;8;good;,7,13,4;8;null;,;8;weak;,11,14,2,9,8,5;9;bg,0,name,flying;9;good;,11,3,8;9;null;,;9;weak;,6,13;10;bg,4,name,ice;10;good;,14,9,8;10;null;,;10;weak;,2,10,4;11;bg,3,name,bug;11;good;,8,12;11;null;,;11;weak;,3,2,9,15,5;12;bg,1,name,psychic;12;good;,3,5;12;null;,;12;weak;,12;13;bg,0,name,rock;13;good;,11,2,9,10;13;null;,;13;weak;,3,7;14;bg,0,name,dragon;14;good;,14;14;null;,;14;weak;,;15;bg,1,name,ghost;15;good;,15;15;null;,1,12;15;weak;,;16;bg,0,name,bird;16;good;,;16;null;,;16;weak;,]],f_zobj[[0;bg,6,aa,13;;bg,14,aa,4;;bg,9,aa,4;;bg,11,aa,3;;bg,12,aa,5;;bg,8,aa,2;;bg,10,aa,4]],f_zobj[[0;name,status;;name,physical;;name,special;]],f_zobj[[]],f_zobj[[-1;,none,0,0,0,0;0;,struggle,1,0,50,1;;,megapnch,1,20,80,.85;;,razrwind,1,10,80,1;;,sworddnc,1,20,0,0;;,whrlwind,1,20,0,0;;,megakick,1,5,120,.75;;,toxic,5,10,0,.9;;,horndril,1,5,-1,.3;;,bodyslam,1,15,85,1;;,takedown,1,20,90,.85;;,doubedge,1,15,120,1;;,bublbeam,4,20,65,1;;,watergun,4,25,40,1;;,icebeam,10,10,90,1;;,blizzard,10,5,110,.7;;,hyprbeam,1,5,150,.9;;,payday,1,20,40,1;;,submsion,3,20,80,.8;;,counter,3,20,-1,1;;,siestoss,3,20,-1,1;;,rage,1,20,20,1;;,megdrain,8,15,40,1;;,solrbeam,8,10,120,1;;,drgnrage,14,10,-1,1;;,thndrblt,6,15,90,1;;,thunder,6,10,110,.7;;,earthqke,7,10,100,1;;,fissure,7,5,-1,.3;;,dig,7,10,80,1;;,psychic,12,10,90,1;;,teleport,12,20,0,0;;,mimic,1,10,0,0;;,doubteam,1,15,0,0;;,reflect,12,20,0,0;;,bide,1,10,-1,0;;,metronom,1,10,0,0;;,selfdstr,1,5,200,1;;,eggbomb,1,10,100,.75;;,fireblst,2,5,110,.85;;,swift,1,20,60,-1;;,skulbash,1,10,130,1;;,softboil,1,5,0,0;;,dreameat,12,15,100,1;;,skyattck,9,5,140,.9;;,rest,12,5,0,0;;,thndrwav,6,20,0,.9;;,psywave,12,15,-1,1;;,explsion,1,5,250,1;;,rockslid,13,10,75,.9;;,triattck,1,10,80,1;;,substute,1,10,0,0;;,cut,1,30,50,.95;;,fly,9,15,90,.95;;,surf,4,15,90,1;;,strength,1,15,80,1;;,flash,1,20,0,1;;,pound,1,35,40,1;;,karatchp,3,25,50,1;;,doubslap,1,10,15,.85;;,comtpnch,1,15,18,.85;;,firepnch,2,15,75,1;;,icepnch,10,15,75,1;;,thndpnch,6,15,75,1;;,scratch,1,35,40,1;;,vicegrip,1,30,55,1;;,guilotin,1,5,-1,.3;;,gust,9,35,40,1;;,wingatck,9,35,60,1;;,bind,1,20,15,.85;;,slam,1,20,80,.75;;,vinewhip,8,25,45,1;;,stomp,1,20,65,1;;,doubkick,3,30,30,1;;,jumpkck,3,10,100,.95;;,rllngkck,3,15,60,.85;;,sandatck,7,15,0,1;;,headbutt,1,15,70,1;;,hornatck,1,25,65,1;;,furyatck,1,20,15,.85;;,tackle,1,35,40,1;;,wrap,1,20,15,.9;;,thrash,1,10,120,1;;,tailwhip,1,30,0,1;;,psnsting,5,35,15,1;;,twineedl,11,20,25,1;;,pinmisil,11,20,25,.95;;,leer,1,30,0,1;;,bite,1,25,60,1;;,growl,1,40,0,1;;,roar,1,20,0,1;;,sing,1,15,0,.55;;,supersnc,1,20,0,.55;;,sonicbom,1,20,-1,.9;;,disable,1,20,0,1;;,acid,5,30,40,1;;,ember,2,25,40,1;;,flamthwr,2,15,90,1;;,mist,10,30,0,0;;,hydropmp,4,5,110,.8;;,psybeam,12,20,65,1;;,aurorabm,10,20,65,1;;,peck,9,35,35,1;;,drillpck,9,20,80,1;;,lowkick,3,20,0,1;;,absorb,8,25,20,1;;,leechsed,8,10,0,.9;;,growth,1,20,0,0;;,razrleaf,8,25,55,.95;;,psnpowdr,5,35,0,.75;;,stunspor,8,30,0,.75;;,slppowdr,8,15,0,.75;;,petldanc,8,10,120,1;;,strngsht,11,40,0,.95;;,firespin,2,15,35,.85;;,thndshck,6,30,40,1;;,rockthrw,13,15,50,.9;;,cnfusion,12,25,50,1;;,hypnosis,12,20,0,.6;;,meditate,12,40,0,0;;,agility,12,30,0,0;;,quickatk,1,30,40,1;;,nghtshde,15,15,-1,1;;,screech,1,40,0,.85;;,recover,1,5,0,0;;,harden,1,30,0,0;;,minimize,1,10,0,0;;,smokscrn,1,20,0,1;;,cnfusray,15,10,0,1;;,withdraw,4,40,0,0;;,dfnscurl,1,40,0,0;;,barrier,12,20,0,0;;,lghtscrn,12,30,0,0;;,haze,10,30,0,0;;,fcsenrgy,1,30,0,0;;,mirrmove,9,20,-1,0;;,lick,15,30,30,1;;,smog,5,20,30,.7;;,sludge,5,20,65,1;;,boneclub,7,20,65,.85;;,waterfal,4,15,80,1;;,clamp,4,15,35,.85;;,spikcann,1,15,20,1;;,constrct,1,35,10,1;;,amnesia,12,20,0,0;;,kinesis,12,15,0,.8;;,hijmpkck,3,10,130,.9;;,glare,1,30,0,1;;,psngas,5,40,0,.9;;,barrage,1,20,15,.85;;,leechlif,11,10,80,1;;,lovekiss,1,10,0,.75;;,tranform,1,10,0,0;;,bubble,4,30,40,1;;,dizypnch,1,10,70,1;;,spore,8,15,0,1;;,splash,1,40,0,0;;,acidarmr,5,20,0,0;;,crabhamr,4,10,100,.9;;,furyswps,1,15,18,.8;;,bonerang,7,10,50,.9;;,hyprfang,1,15,80,.9;;,sharpen,1,30,0,0;;,convrson,1,30,0,0;;,suprfang,1,10,-1,.9;;,slash,1,20,70,1]],f_zobj[[;,youngstr,19,16,10,21,13,69;;,bugcatch,13,46,14,10,11,127;;,junior,23,7,27,4,19,1;;,brock,74,138,104,37,140,95;;,lass,43,52,35,29,84,39;;,hiker,74,50,41,66,46,75;;,swimmer,116,60,90,129,120,118;;,misty,120,117,54,119,86,121;;,gentlman,58,32,147,77,27,133;;,sailor,90,72,54,60,98,61;;,rocker,100,41,48,81,63,25;;,ltsurge,25,135,100,125,82,26;;,channelr,92,39,104,35,93,105;;,gambler,17,75,61,111,58,44;;,beauty,69,113,40,70,133,36;;,erika,47,71,102,12,114,45;;,biker,109,56,72,88,67,73;;,birdkeep,84,17,22,83,85,18;;,juggler,48,44,122,96,101,79;;,koga,30,89,110,15,33,49;;,blckbelt,66,67,106,56,57,107;;,rocket,28,20,101,42,110,24;;,psychic,79,63,80,96,102,64;;,sabrina,122,103,64,124,97,65;;,scientst,132,71,92,49,97,137;;,pkmaniac,113,127,125,123,108,55;;,suprnerd,77,82,57,136,37,78;;,blaine,78,59,136,38,76,126;;,cooltrnr,148,8,47,5,62,2;;,fishrman,118,73,117,119,91,99;;,tamer,105,128,28,20,111,53;;,giovanni,51,34,53,31,115,112;;,lorelei,91,124,134,131,80,87;;,bruno,95,107,139,106,76,68;;,agatha,42,89,93,45,24,94;;,lance,130,148,142,149,141,143;;,blue,18,65,135,59,103,9;;,green,94,115,36,130,38,3;;,red,123,143,26,131,85,6;;,legendry,149,145,146,144,150,151]],function(game,entry)
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
f_beep_back()
end,function(menu,delta,is_ud)
if is_ud then
local newval=menu.c+delta*menu.r
if newval==_mid(0,newval,#menu-1)then
menu.c=newval
if 0+delta ~=0 then f_beep_back()end
else
f_beep()
end
else
local newval=menu.c+delta
local left=menu.c-menu.c%menu.r
if newval==_mid(left,newval,left+menu.r-1)then
menu.c=newval
if 0+delta ~=0 then f_beep_back()end
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
f_beep_back()
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
f_beep_okay()
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
end,function()
for i=-1,#c_moves_raw do
local move=c_moves_raw[i]
c_moves[i]=f_zobj([[name,@,type,@,pp,@,maxpp,~pp,damage,@,accuracy,@,num,@]],
move[1],
move[2],
move[3],
move[4],
move[5],
i
)
end
end,function(num)
local pkmn,moveset=c_pokemon[num],f_create_empty_moveset()
for i=1,min(4,#pkmn.moves_natural)do
moveset[i]=f_create_move(pkmn.moves_natural[i])
end
return moveset
end,function(id)
return _setmetatable(f_zobj[[]],{__index=c_moves[id]})
end,function()
local moveset={}
for i=1,4 do _add(moveset,f_create_move(-1))end
return moveset
end,function(base)
return _ceil(base+.5*93)+5
end,function()
local movemem=_peek2"8"
for num=-1,151 do
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
local evolvesfrom=num-pkmndata[1]
local pkmn=f_zobj([[browse,%c_yes,mynewmoves,@,num,@,evolvesfrom,@,name,@,type1,@,type2,@,base_maxhp,@,base_attack,@,base_defense,@,base_speed,@,base_special,@,moves_natural,@,moves_teach,@,moves_event,@]],
f_create_empty_moveset(),
num,
evolvesfrom,
c_pokemon_names[num+1],
pkmndata[2],
pkmndata[3],
pkmndata[4],
pkmndata[5],
pkmndata[6],
pkmndata[7],
pkmndata[8],
{},{},{}
)
local move_bucket=pkmn.moves_natural
for i=9,#pkmndata do
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
f_zobj_set(pkmn,[[attack,@,defense,@,special,@,speed,@,maxhp,@,hp,~maxhp,level,50]],f_calc_max_stat(pkmn.base_attack),
f_calc_max_stat(pkmn.base_defense),
f_calc_max_stat(pkmn.base_special),
f_calc_max_stat(pkmn.base_speed),
f_calc_max_stat(pkmn.base_maxhp)+5+50
)
pkmn.total=pkmn.attack+pkmn.defense+pkmn.special+pkmn.speed+pkmn.maxhp
pkmn.draw=function(pkmn,...)
local num=pkmn:available()and pkmn.num or-1
if num==25 and pkmn:hasmove(53)then num=158 end
if num==54 and pkmn:hasmove(143)then num=159 end
f_draw_pkmn_out(num,...)
end
pkmn.hasmove=function(pkmn,moveid)
for j=1,4 do
if pkmn.mynewmoves[j].num==moveid then
return true
end
end
return false
end
pkmn.isempty=function(pkmn)
for j=1,4 do
if pkmn.mynewmoves[j].num ~=-1 then
return false
end
end
return true
end
pkmn.available=function(pkmn)
if pkmn.num>=0 then
return not pkmn.browse or@(0x5e5a+pkmn.num)>0
end
end
c_pokemon[num]=pkmn
end
end,function(teampkmn)
return _setmetatable(f_zobj([[shared,@,getstat,@,minor,#;stages;special,0,defense,0,attack,0,speed,0,accuracy,0,evasion,0;]],teampkmn,function(a,stat)
local stage=a.stages[stat]
return _ceil(_mid(1,999,
a.shared[stat]*(
(stat=="evasion"or stat=="accuracy")
and _mid(1,1+stage/3,3)/_mid(1,1-stage/3,3)
or _mid(2,2+stage,8)/_mid(2,2-stage,8)
)
))
end),{__index=teampkmn})
end,function(trainer)
foreach(f_get_team_dead(trainer.team),function(pkmn)
_poke(0x5e5a+pkmn.num,1)
end)
end,function(team)
local newteam={}
foreach(team,function(pkmn)
if pkmn.num>-1 and pkmn.major==1 then
_add(newteam,pkmn)
end
end)
return newteam
end,function(team,exclude_missingno)
local newteam={}
foreach(team,function(pkmn)
if pkmn.num>(exclude_missingno and 0 or-1)and pkmn.major ~=1 then
_add(newteam,pkmn)
end
end)
return newteam
end,function(team)
return f_get_team_live(team)[1]
end,function(num,mynewmoves)
return _setmetatable(f_zobj([[mynewmoves,@,major,0,browse,%c_no]],mynewmoves),{__index=c_pokemon[num]})
end,function(team)
local fightteam={}
foreach(team,function(pkmn)
_add(fightteam,f_create_team_pkmn(pkmn.num,pkmn.mynewmoves))
end)
return fightteam
end,function(team_index)
local mem=c_team_memlocs[team_index]
local team=f_zobj[[]]
for i=1,6 do
local memstart=mem+(i-1)*5
local mynewmoves={}
local has_moves=false
for i=1,4 do
mynewmoves[i]=f_create_move(_peek(memstart+i))
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
local memstart=mem+(i-1)*5
local pkmn=team[i]
_poke(memstart,max(0,pkmn.num))
for i=1,4 do
_poke(memstart+i,pkmn.mynewmoves[i].num>0 and pkmn.mynewmoves[i].num or 0)
end
end
end,function(game)
f_modes_default_draw1(game)
f_wobble_text("team #"..game:cursor"team1"+1,20,27,1)
end,function(x,y,hp,maxhp,align,col)
_rectfill(x,y-2,x-align*_max(_ceil(hp/maxhp*40),0),y+2,col)
end,function(_ENV)
f_zcall(_rectfill,[[;,0,0,39,39,5;;,0,5,39,34,13]])
f_draw_battle_side(p1.active,cur_action.active==p1.active,1)
f_draw_battle_side(p2.active,cur_action.active==p2.active,-1)
end,function(_ENV,a1a,flip)
if major ~=1 and not invisible then
local col=a1a and 6 or 1
_pal(1,col)_spr(198,8+12*flip,16.5+9.5*flip,3,1)_pal(1,1)
f_zprint(hp.."H",21+20*flip,17.5+9.5*flip,13,flip)
f_draw_hp(19.5+20.5*flip,19.5+17.5*flip,hp,maxhp,flip,col)
_ENV:draw(20-10*flip,20+5*flip,5,flip)
end
end,function(game)f_draw2_pokeinfo(c_pokemon[game:cursor"browse"])end,function(game)f_print_draw2_message("spot #"..(game:cursor"editteam"+1))end,function(game)f_print_draw2_message("move #"..(game:cursor"teammoves"+1))end,function(game)f_print_draw2_message(game.ui_pl)end,function(game)f_print_draw2_message"match over" end,function(_)end,function(game)end,function(game)
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
end,function(game)
f_print_draw2_message(game.cur_action.pl.name)
end,function(game)
f_draw3_pokeinfo(game:f_get_pkmn_team_edit())
end,function(game)
local move=game:entry(game.movemode).move
if move.num>=0 then
local accuracy=move.accuracy*100\1
f_print_draw3_message(c_types[move.type].name.."|"..move.pp.."/"..move.maxpp.."|"..(move.damage>=0 and move.damage or "??").."P "..(accuracy>=0 and accuracy or "??").."A")
else
f_print_draw3_message"????|?/?|??P ???A"
end
end,function(game)
f_draw3_pokeinfo(game:entry"browse".pkmn)
end,function(game)f_print_draw3_message(game:entry"main".desc)end,function(game)f_print_draw3_message(game:entry"pselactions".desc)end,function(_ENV)f_fight_draw3_helper(p0.statplayer.active)end,function(_ENV)
if num>-1 then
f_print_draw3_message(name.."|"..hp.."/"..maxhp.."|"..c_major_names[major])
else
f_print_draw3_message"?????????|???/???|"
end
end,function(_ENV)f_fight_draw3_helper(_ENV:entry"pselswitch".pkmn)end,function(game)
local count,power=0,0
for i=1,6 do
local num=game:entry().team[i]
if num then
count+=1
power+=c_pokemon[num].total
end
end
f_print_draw3_message("team stats|pkmn "..count.."/6|pow "..power)
end,function(game)end,function(game)
f_print_draw3_message(game.p0.name.."|is the|winner")
end,function(game)
f_print_draw3_message(game.cur_action.active.name..game.cur_action.message)
end,function(_ENV)
local winner,loser=p0,f_get_other_pl(_ENV,p0)
winner:winlogic(loser)
stack={stack[1]}
menu:refresh{}
f_zobj_set(menu,[[v,0;;pkmn,@;;hidden,%c_yes;;name,@,style,5;;name,@;;name,@;;pkmn,@;;hidden,%c_yes;;name,@,style,5;;name,@;;name,@]],winner.active,winner.name,(#f_get_team_live(winner.team,true)).." live",(#f_get_team_dead(winner.team)).." dead",
loser.active,loser.name,(#f_get_team_live(loser.team,true)).." live",(#f_get_team_dead(loser.team)).." dead")
end,function(_ENV)
menu:refresh(
f_zobj[[;name,browse,state,browse,select,%f_menu_state_callback,desc,browse|;;name,edit,state,team1,select,%f_menu_state_callback,desc,edit|stored|teams;;name,league,state,team1story,select,%f_menu_state_callback,desc,league|;;name,player,state,team1match,select,%f_menu_state_callback,desc,player|custom|battles;;name,?????,state,team1horde,select,%f_menu_state_callback,desc,?????|beat|league,disabled,%c_yes;;name,credits,state,credits,select,%f_menu_state_callback,desc,credits|amorg|games]]
)
local count=0
for i=0,151 do count+=c_pokemon[i]:available()and 1 or 0 end
menu[1].desc..=count.."/151|pokemon"
menu[3].desc..=(@0x5efd).."/40|trainers"
if@0x5efd>=40 then
menu[5].disabled=false
menu[5].name="horde"
menu[5].desc="horde|"..(@0x5efe).."/151|hi-score"
end
end,function(_ENV,selectfunc)
local tbl={}
for i=0,151 do
add(tbl,i)
end
menu:refresh(
tbl,
function(num)
local pkmn=c_pokemon[num]
return{
select=selectfunc,
disabled=not pkmn:available(),
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
end)
f_zobj_set(_g,[[f_browsestat_init,@,f_credits_init,@,f_fightsel_init,@,f_teamaction_init,@,f_moveaction_init,@,f_movedel,@,f_moves_init_helper,@,f_teammoves_init,@,f_switchmoves_init,@,f_teammovesel_init,@,f_pselmove_init,@,f_pselactions_init,@,f_team_init,@,f_get_team_num,@,f_editteam_init,@,f_switchteam_init,@,f_pselswitch_init,@,f_turn_init,@,f_pstat_init,@,f_turn_update,@,f_browsestat_lrfunc,@,f_pstat_lrfunc,@,f_pstat_xfunc,@,f_browsestat_xfunc,@,f_credits_xfunc,@,f_fightover_xfunc,@,f_modes_default_update,@,f_modes_default_draw1,@,f_modes_cursor,@,f_modes_entry,@,f_modes_push,@,f_modes_popuntil,@,f_modes_pop,@,f_game_init,@,f_game_update,@,f_game_draw1,@,f_game_draw2,@,f_game_draw3,@,f_moveup_init,@,f_closed_init,@,f_any_btn,@,f_closed_update,@,f_minisfx,@,f_beep_done,@,f_beep_okay,@,f_beep_back,@,f_beep,@,f_draw_picodex,@,f_picodex_map,@,f_wobble_text,@,f_zprint,@,f_draw_screen,@,f_draw2_pokeinfo,@,f_draw3_pokeinfo,@,f_draw_pkmn,@,f_draw_pkmn_out,@,f_update_stat_menu,@,f_teamdel,@,f_set_default_team_pkmn,@,f_story_select,@,f_match_select,@,f_match_start,@,f_horde_select,@,f_horde_win_func,@,f_team_select,@,f_get_team_cursor,@,f_get_pkmn_team_edit,@,f_select_move,@,f_get_other_pl,@,f_newaction,@,f_addaction,@,f_logic_faint,@,f_pop_next_action,@,f_get_possible_moves,@,f_select_random_move,@,f_generic_attack,@,f_get_crit_ratio,@,f_move_accuracy_rate,@,f_calc_move_damage,@,f_psel_init,@,f_psel_random,@,f_psel_forfeit,@,f_begin_fight,@,f_begin_fight_cpu,@,f_extract_sheet,@,f_vget,@,f_vset,@,f_px9_decomp,@,f_game_state_init,@]],function(_ENV)
f_update_stat_menu(menu,_ENV:entry"browse".pkmn)
end,function(_ENV)
menu:refresh(
_split"106,,!alanxoc3,code,design,6,,!gr8cadet,graphics,sound,129,,!wadlo,magikarp,gyarados,123,,!snippets,zep px9,mot smap,137,,!pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
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
local disabled,team=num-1>@0x5efd,{}
for i=1,6 do team[i]=trainer[i+1]end
return{
name=trainer[1],
team=team,
disabled=disabled,
select=function(game,entry)
f_begin_fight_cpu(game,entry.team,entry.name,f_nop,function(pl,other)
poke(0x5efd,mid(@0x5efd,num,#c_trainers))
f_unlock_pkmn(other)
end,f_nop)
end
}
end)
end,function(_ENV)
menu:refresh(f_zobj[[;name,moves,state,teammoves,select,%f_menu_state_callback;;name,switch,state,switchteam,select,%f_menu_state_callback;;name,delete,select,%f_teamdel]])
teammovesel.menu.c=0
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
local moveind=teampkmn.mynewmoves[i]
return{
move=teampkmn.mynewmoves[i],
name=moveind.name,
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
_add(movemetadata,{name=c_moves[moveind].name,disabled=teampkmn:hasmove(moveind),num=moveind,desc=prefix..i})
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
menu:refresh(p0.active.mynewmoves,function(move)
return{
disabled=move.pp<=0,
name=move.name,
move=move,
select=function()
_ENV:pop()_ENV:pop()
f_select_move(p0,move)
end
}
end)
end,function(_ENV)
menu:refresh(f_zobj([[;name,fight,desc,fight|select|move,select,%f_menu_state_callback,state,pselmove;;name,switch,desc,switch|active|pokemon,select,%f_menu_state_callback,state,pselswitch;;name,stats,desc,stats|player &|opponent,select,%f_menu_state_callback,state,pstat;;name,forfeit,desc,forfeit|pokemon|battle,select,%f_psel_forfeit]],p0.name,f_get_other_pl(_ENV,p0).name))
end,function(_ENV)
menu:refresh(f_zobj[[,1,2,3]],function(i)
local team=f_get_team(i-1)
local newteam={}
local is_disabled=true
for i=1,6 do
newteam[i]=team[i].num
if not team[i]:isempty()then
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
if team[_ENV:cursor"editteam"+1]:available()then
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
local disabled=p0.team[i]:isempty()or p0.active.shared==p0.team[i]or p0.team[i].major==1
return{
disabled=disabled,
select=function()
_ENV:pop()_ENV:pop()
f_select_move(p0,i,true)
end,
pkmn=p0.team[i]
}
end)
end,function(_ENV)
local p1,p2=p1,p2
if p1.priority==p2.priority then p2.priority+=_sgn(_rnd"2"-1)end
p0=p1.priority>p2.priority and p1 or p2
end,function(_ENV)
menu:refresh{}
local player=p0.statplayer
local moves=player.active.mynewmoves
f_zobj_set(menu,[[;pkmn,@;;hidden,%c_yes;;name,@,style,5;;name,@;;name,@;;name,moves,style,5]],player.active,player.name,(#f_get_team_live(player.team,true)).." live",(#f_get_team_dead(player.team)).." dead")
_foreach(player.active.mynewmoves,function(move)
_add(menu,{name=move.name})
end)
f_zobj_set(menu,[[;name,modifier,style,5;;name,atk +1;;name,def -1;;name,state,style,5;;name,confused;;name,digging;;name,flying]])
end,function(game)
if g_bpx or not game.cur_action then
for p in _all{game.p1,game.p2}do
if not f_get_next_active(p.team)then
game.p0=f_get_other_pl(game,p)
game:load"fightover"
return
end
end
local action=f_pop_next_action(game)
if action then
game.cur_action=action
local actionpl=game.cur_action.active==game.p1.active and game.p1 or game.p2
action.logic(actionpl,f_get_other_pl(game,actionpl),game)
else
game:load()
end
end
if g_bpo then f_beep()end
end,function(_ENV,lr)
local stayed=true
for i=browse.menu.c+lr,75.5+75.5*lr,lr do
if c_pokemon[i]:available()then
browse.menu.c=i
stayed=false
f_beep_back()
break
end
end
if stayed then f_beep()end
f_browsestat_init(_ENV)
end,function(_ENV)
p0.statplayer=f_get_other_pl(_ENV,p0.statplayer)
f_beep_back()
f_pstat_init(_ENV)
end,function(_ENV)
f_minisfx(p0.statplayer.active.num)
end,function(game)
f_minisfx(game:cursor"browse")
end,function()
f_minisfx(f_flr_rnd"152")
end,function(_ENV)
f_minisfx(p0.active.num)
end,function(_ENV)menu.update(_ENV)end,function(_ENV)menu.draw1(_ENV)end,function(_ENV,menu_name)
return _ENV[menu_name].menu.c
end,function(_ENV,menu_name)
local menu=menu_name and _ENV[menu_name].menu or menu
return menu[menu.c+1]
end,function(_ENV,newstate)
_add(stack,newstate)
_ENV:f_actor_load(newstate)
end,function(_ENV,untilstate)
while next_state ~=untilstate do
_ENV:pop()
end
end,function(_ENV)
_deli(stack)
_ENV:load(stack[#stack]or "main")
end,function(_ENV)
for i=1,151 do _poke(0x5e5a+i,1)end
poke(0x5efd,40)
local team={}
for ind,num in _pairs(_split"133,7,35,1,25,4")do
f_set_default_team_pkmn(team,ind,num)
_poke(0x5e5a+num,1)
end
if@0x5efc==0 then
_poke(0x5efc,1)
f_save_team(0,team)
end
modes=o_modes()
f_zcall(function(menu_name,create_func,...)
modes[menu_name].menu=create_func(...)
end,[[;,browse,~f_create_menu,~f_browse_drawentry,4;;,browsestat,~f_create_menu_view,~f_menu_drawentry;;,credits,~f_create_menu_view,~f_menu_drawentry;;,fightover,~f_create_menu_view,~f_menu_drawentry;;,editteam,~f_create_menu,~f_browse_drawentry,3;;,switchteam,~f_create_menu,~f_browse_drawentry,3;;,main,~f_create_menu,~f_menu_drawentry;;,teamaction,~f_create_menu,~f_menu_drawentry;;,moveaction,~f_create_menu,~f_menu_drawentry;;,teammovesel,~f_create_menu,~f_menu_drawentry;;,teammoves,~f_create_menu,~f_menu_drawentry;;,switchmoves,~f_create_menu,~f_menu_drawentry;;,team1,~f_create_menu,~f_menu_drawentry;;,team2story,~f_create_menu,~f_menu_drawentry;;,team2match,~f_create_menu,~f_menu_drawentry]])
f_zobj_set(modes,[[team1menu,@,browsemenu,@;main;menu;cancel,%f_beep;pselactions;menu;cancel,%f_beep;team1horde;menu,~team1menu;team1match;menu,~team1menu;team1story;menu,~team1menu;teampkmn;menu,~browsemenu;]],modes.team1.menu,modes.browse.menu)
f_beep_done()
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
end,function()g_picodex.modes:draw1()end,function()g_picodex.modes:draw2()end,function()g_picodex.modes:draw3()end,function()
_sfx(-2,1)
end,function(_ENV)
_menuitem(1,"factory reset",function()
_sfx(59,0)
_memset(0x5e00,0,0x100)
_ENV:start_timer("shaking",.5)
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
end,function(num)
g_picodex:start_timer((0+num<=152)and "pkmn"or 0+num,.25)
_sfx(44+num\8,0,num%8*4,4)
end,function()f_minisfx"152" end,function()f_minisfx"153" end,function()f_minisfx"154" end,function()f_minisfx"155" end,function(_ENV)
_cls"0"
f_zcamera(0,128+sin(_ENV:get_elapsed_percent"moveup"/4)*128,function()
f_zcall(f_zprint,[[;,aMORG gAMES,64,-68,7,0;;,pRESENTS,64,-61,7,0;;,a pICO-8 pOKEDEX sIM,64,15,7,0]])
f_zcall(f_zspr,[[;,102,64,11,5,1]])
local top_row_buttons,bot_row_buttons,rotation=modes and modes.main.menu.c,modes and #modes.stack-1,foldstate=="open"and 1 or foldstate=="closed"and-1 or(foldstate=="opening"and-1 or 1)*_cos(_ENV:get_elapsed_percent(foldstate)/2)
f_zcamera(30-(rotation+1)*15+(_ENV:is_active"shaking"and f_flr_rnd"3"-1 or 0),27,function()
f_zcall(_rectfill,[[;,14,18,@,87,5]],63+max(0,rotation*54))
if light>=4 then
f_zcall(_rectfill,[[;,14,18,117,87,13]])
f_zcall(f_draw_screen,[[;,14,21,40,40,@;;,71,18,46,13,@;;,71,67,46,21,@]],draw1,draw2,draw3)
end
f_zcall(_map,[[;,24,0,2,1,8,3;;,8,0,2,9,8,11]])
f_zcall(function(l,s,off,on,flash,x,y)
return _spr((light>l)and(g_picodex:is_active(s)and flash or on)or off,x,y)
end,[[;,0,153,132,130,131,22,3;;,1,154,132,129,131,17,3;;,2,155,132,128,131,12,3;;,3,pkmn,135,133,134,6,3]])
f_zcall(function(b,s1,s2,x,y)
_spr(_btn(b)and s1 or s2,x,y)
end,[[;,0,186,154,10,77;;,1,188,156,26,77;;,2,171,139,18,73;;,3,187,155,18,81;;,4,170,138,42,77;;,5,172,140,50,77]])
if rotation<=0 then
f_picodex_map(0,2+64*(1-_abs(rotation)),_abs(rotation))
if rotation==-1 and backbuttonheld then _spr(123,6,49)end
else
f_picodex_map(16,62,rotation)
if rotation==1 then
if top_row_buttons then _spr(100,70+top_row_buttons*8,41)end
if bot_row_buttons and bot_row_buttons>=0 then _spr(100,70+bot_row_buttons*8,49)end
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
end,function(pkmn)
f_print_draw2_message("pkmn #"..pkmn.num)
end,function(pkmn)
if pkmn:available()then
f_print_draw3_message(pkmn.name.."|"..c_types[pkmn.type1].name.."|"..c_types[pkmn.type2].name)
else
f_print_draw3_message"?????????|????|??????"
end
end,function(num,x,y,sw,sh)
sw=sw or 1
sh=sh or 1
local row=num/8\1
local col=num%8
if row ~=g_loaded_row then
g_loaded_row=row
_memcpy(0x0000,0x8000+0x400*row,0x400)
end
local w,h=16*sw,16*sh
_sspr(col*16,0,16,16,x-w/2,y-h/2,w,h)
end,function(num,x,y,col,xscale,yscale)
if num<0 then _spr(107,x-4,y-4)return end
xscale=xscale or 1
yscale=yscale or 1
local outline_width=_max(_abs(xscale),1)\ 1
for c=1,15 do _pal(c,col)end
for i=-outline_width,outline_width,outline_width*2 do f_draw_pkmn(num,x-outline_width,y+i,xscale,yscale)end
for i=-outline_width,outline_width,outline_width*2 do f_draw_pkmn(num,x+outline_width,y+i,xscale,yscale)end
for c=1,15 do _pal(c,1)end
for i=-outline_width,outline_width,outline_width*2 do f_draw_pkmn(num,x+i,y,xscale,yscale)end
for i=-outline_width,outline_width,outline_width*2 do f_draw_pkmn(num,x,y+i,xscale,yscale)end
for c=1,15 do _pal(c,c)end
f_draw_pkmn(num,x,y,xscale,yscale)
end,function(menu,pkmn)
menu:refresh{}
_add(menu,{pkmn=pkmn})
_add(menu,{hidden=true})
_add(menu,{name="lvl 50",style=5})
_add(menu,{name=(pkmn.hp or pkmn.maxhp).."/"..pkmn.maxhp})
_foreach(f_zobj[[;key,special,name,spc;;key,attack,name,att;;key,defense,name,def;;key,speed,name,spd;;key,total,name,tot;;key,accuracy,name,acc;;key,evasion,name,eva]],function(pair)
if not pair.key then
_add(menu,{name=pair.name,style=5})
elseif pkmn[pair.key]then
_add(menu,{name=pair.name.." "..pkmn[pair.key]})
end
end)
_add(menu,{name="learn",style=5})
_foreach(c_pokemon[pkmn.num].moves_natural,function(m)
_add(menu,{name=c_moves[m].name})
end)
if #c_pokemon[pkmn.num].moves_teach>0 then
_add(menu,{name="teach",style=5})
_foreach(c_pokemon[pkmn.num].moves_teach,function(m)
_add(menu,{name=c_moves[m].name})
end)
end
if #c_pokemon[pkmn.num].moves_event>0 then
_add(menu,{name="event",style=5})
_foreach(c_pokemon[pkmn.num].moves_event,function(m)
_add(menu,{name=c_moves[m].name})
end)
end
end,function(game)
local team=game:f_get_team_cursor"team1"
team[game:cursor"editteam"+1]=f_create_team_pkmn(-1,f_create_empty_moveset())
f_save_team(game:cursor"team1",team)
game:pop()
end,function(team,ind,num)
team[ind]=f_create_team_pkmn(num,f_get_natural_moveset(num))
return team
end,function(game)game:push"team2story" end,function(game)game:push"team2match" end,function(_ENV)
f_begin_fight(_ENV,
{f_get_team(_ENV:cursor"team1"),"player 1",false,f_nop,f_nop},
{f_get_team(_ENV:cursor"team2match"),"player 2",false,f_nop,f_nop}
)
end,function(_ENV)
local nums={}
for i=1,152 do _add(nums,i%152)end
f_begin_fight_cpu(_ENV,nums,"horde",f_nop,
function(_,other)f_horde_win_func(other)end,
f_horde_win_func
)
end,function(horde)
f_unlock_pkmn(horde)
poke(0x5efe,mid(@0x5efe,#f_get_team_dead(horde.team),255))
end,function(game)
game:push"editteam"
end,function(game,cursor)
return f_get_team(game:cursor(cursor))
end,function(game)
local team=f_get_team(game:cursor"team1")
return team[game:cursor"editteam"+1],team
end,function(pl,slot,switch)
pl.actions={}
local priority_class=1000
if switch then
priority_class=3000
f_addaction(pl,pl,"|comes|back",function(s,o)
s.active=f_team_pkmn_to_active(s.team[slot])
s.active.invisible=true
f_addaction(s,s,"|comes|out",function(s,o)
s.active.invisible=false
end)
end)
else
local move=slot
f_addaction(pl,pl,"|uses|"..move.name,function(s,o)
f_generic_attack(s,o,slot)
end)
if move.num==120 then priority_class=2000 end
if move.num==18 or move.num==4 or move.num==89 or move.num==30 then
priority_class=0000
end
end
pl.priority=_min(3000,priority_class+pl.active:getstat"speed")
end,function(game,pl)
return pl==game.p1 and game.p2 or game.p1
end,function(pactive,message,logic)
return{pl=pactive,active=pactive.active,message=message,logic=logic or f_nop}
end,function(p0,...)
_add(p0.actions,f_newaction(...))
end,function(s)
s.active.shared.major=1
s:dielogic()
end,function(game)
for p in _all{game.p1,game.p2}do
if p.active.hp<=0 then
if p.active.major ~=1 then
return f_newaction(p,"|is|fainted",f_logic_faint)
else
p.active=f_team_pkmn_to_active(f_get_next_active(p.team))
return f_newaction(p,"|comes|out")
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
end
end,function(active)
local possible_moves={}
for i=1,4 do
if active.mynewmoves[i].num>0 and active.mynewmoves[i].pp>0 then
_add(possible_moves,active.mynewmoves[i])
end
end
return possible_moves
end,function(active)
local possible_moves=f_get_possible_moves(active)
return possible_moves[f_flr_rnd(#possible_moves)+1]or f_create_move(0)
end,function(self,other,move)
if move.num>0 then
move.pp-=1
end
local dmg=move.damage
if dmg>0 then
f_addaction(self,other,"|-"..dmg.."|hitpoints",function()
other.active.shared.hp=_max(0,other.active.shared.hp-dmg)
end)
else
f_addaction(self,self,"|does|nothing")
end
end,function(base_speed)
return _min(.99,(base_speed+76)/1024)
end,function()
return f_flr_rnd"256"==0 and f_flr_rnd"256"==0
end,function(level,attack,defense,critical,move_power)
local base_damage=(2*level*critical/5+2)*move_power*(attack/defense)/50+2
return base_damage*stab*type1*type2*random
end,function(game)
game.p0=game[game.p0key]
if game.p0.iscpu then
f_select_move(game.p0,f_select_random_move(game.p0.active))
game:load()
elseif #game.p0.actions>0 then
game:load()
else
game.pselactions.menu=game.p0.menu_action
game.pselmove.menu=game.p0.menu_move
game.pselswitch.menu=game.p0.menu_switch
game.pstat.menu=game.p0.menu_stats
game.cur_action=f_newaction(game.p0,"")
game.stack[#game.stack]=game.curr
game:push"pselactions"
end
end,function(game)
game:pop()
f_select_move(game.p0,f_select_random_move(game.p0.active))
end,function(game)
game:pop()
game.p0=f_get_other_pl(game,game.p0)
game:load"fightover"
end,function(_ENV,d1,d2)
d1.key,d2.key="p1","p2"
for dd in _all{d1,d2}do
_ENV[dd.key]=f_zobj([[actions,#,priority,1,menu_action,@,menu_move,@,menu_stats,@,menu_switch,@,team,@,name,@,iscpu,@,dielogic,@,winlogic,@]],f_create_menu(f_menu_drawentry),
f_create_menu(f_menu_drawentry),
f_create_menu_view(f_menu_drawentry),
f_create_menu(f_browse_drawentry,3),
_unpack(dd))
local _ENV=_ENV[dd.key]
statplayer=_ENV
menu_action.cancel,team=f_beep,f_get_fight_team(team)
active=f_team_pkmn_to_active(f_get_next_active(team))
_add(actions,f_newaction(_ENV,"|comes|out"))
end
p0=p1
_ENV:push"turn"
end,function(_ENV,team,name,deathfunc,plwinfunc,cpuwinfunc)
local cpu_team_draft={}
_foreach(team,function(pkmn)
_add(cpu_team_draft,f_create_team_pkmn(pkmn,f_get_natural_moveset(pkmn)))
end)
f_begin_fight(_ENV,
{_ENV:f_get_team_cursor"team1","player",false,f_nop,plwinfunc},
{cpu_team_draft,name,true,deathfunc,cpuwinfunc}
)
end,function(index)
f_px9_decomp(0,0,_peek2(index*2),
function(...)return f_vget(0x8000+index*0x2000,...)end,
function(...)return f_vset(0x8000+index*0x2000,...)end)
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
end,function(x0,y0,src,f_vget,f_vset)
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
for y=y0,y0+h_1 do
for x=x0,x0+w-1 do
splen-=1
if(splen<1)then
splen,predict=gnp"1",not predict
end
local a=y>y0 and f_vget(x,y-1)or 0
local l=pr[a]or{_unpack(el)}
pr[a]=l
local v=l[predict and 1 or gnp"2"]
vlist_val(l,v)
vlist_val(el,v)
f_vset(x,y,v)
end
end
end,function(state)
f_clean_all_entities("o_game_state","o_fader_in")
state:sinit()
end)
f_zclass[[o_actor,o_timer|load,%f_actor_load,loadlogic,%f_actor_loadlogic,state,%f_actor_state,kill,%f_actor_kill,clean,%f_actor_clean,is_alive,%f_actor_is_alive,alive,%c_yes,isnew,%c_yes,curr,start,init,%f_nop,finit,%f_nop,stateless_update,%f_nop,update,%f_nop,destroyed,%f_nop;]]
f_zclass[[o_timer|timers;,;start_timer,%f_timer_reset_timer,end_timer,%f_timer_end_timer,is_active,%f_timer_is_active,get_elapsed_percent,%f_timer_get_elapsed_percent,tick,%f_timer_tick,]]
c_pokemon_names[0]=""
c_major_names[0]=""
c_menustyles=f_zobj[[;bg,13,fg,1,out,5;;bg,6,fg,13,out,13;;bg,5,fg,1,out,5;;bg,6,fg,5,out,5;;bg,1,fg,13,out,5]]
c_team_memlocs=f_zobj[[0,0x5e00,1,0x5e1e,2,0x5e3c]]
f_zclass[[o_modes,o_actor|cursor,%f_modes_cursor,entry,%f_modes_entry,push,%f_modes_push,pop,%f_modes_pop,popuntil,%f_modes_popuntil,pkmn,%f_nop,update,%f_nop,draw1,%f_nop,draw2,%f_nop,draw3,%f_nop,curr,main;stack;,;defaults;menu,%c_no,ui_pl,error,finit,%f_nop,init,%f_nop,lrfunc,%f_beep,xfunc,%f_nop,update,%f_modes_default_update,movemode,%c_no,draw1,%f_modes_default_draw1,draw2,%f_nop,draw3,%f_nop;main;init,~f_main_init,draw2,~f_main_draw2,draw3,~f_main_draw3;browse;init,%f_browse_init,draw2,%f_browse_draw2,draw3,%f_browse_draw3;browsestat;init,%f_browsestat_init,draw2,%f_browse_draw2,draw3,%f_browse_draw3,lrfunc,%f_browsestat_lrfunc,xfunc,%f_browsestat_xfunc;editteam;init,%f_editteam_init,draw2,%f_editteam_draw2,draw3,%f_editteam_draw3,draw1,%f_editteam_draw1;switchteam;init,%f_switchteam_init,draw2,%f_editteam_draw2,draw3,%f_editteam_draw3,draw1,%f_editteam_draw1;teampkmn;init,%f_teampkmn_init,draw2,%f_browse_draw2,draw3,%f_browse_draw3;teamaction;init,%f_teamaction_init,draw2,%f_editteam_draw2,draw3,%f_editteam_draw3;moveaction;init,%f_moveaction_init,draw2,%f_teammoves_draw2,draw3,%f_move_draw3,movemode,teammoves;teammovesel;init,%f_teammovesel_init,draw2,%f_teammovesel_draw2,draw3,%f_move_draw3;teammoves;init,%f_teammoves_init,draw2,%f_teammoves_draw2,draw3,%f_move_draw3;switchmoves;init,%f_switchmoves_init,draw2,%f_teammoves_draw2,draw3,%f_move_draw3;team1;ui_pl,player,init,%f_team_init,draw2,%f_team_draw2,draw3,%f_team_draw3,disable_empty_team,%c_no,select_func,%f_team_select;team1story;ui_pl,player,init,%f_team_init,draw2,%f_team_draw2,draw3,%f_team_draw3,disable_empty_team,%c_yes,select_func,%f_story_select;team1match;ui_pl,player 1,init,%f_team_init,draw2,%f_team_draw2,draw3,%f_team_draw3,disable_empty_team,%c_yes,select_func,%f_match_select;team1horde;ui_pl,player,init,%f_team_init,draw2,%f_team_draw2,draw3,%f_team_draw3,disable_empty_team,%c_yes,select_func,%f_horde_select;team2match;ui_pl,player 2,init,%f_team_init,draw2,%f_team_draw2,draw3,%f_team_draw3,disable_empty_team,%c_yes,select_func,%f_match_start;team2story;ui_pl,trainer,init,%f_fightsel_init,draw2,%f_team_draw2,draw3,%f_team_draw3;fightover;init,%f_fightover_init,draw2,%f_fightover_draw2,draw3,%f_fightover_draw3,xfunc,%f_fightover_xfunc;pselactions;init,%f_pselactions_init,draw2,%f_turn_draw2,draw3,%f_pselactions_draw3;pselmove;init,%f_pselmove_init,draw2,%f_turn_draw2,draw3,%f_move_draw3;pselswitch;init,%f_pselswitch_init,draw2,%f_turn_draw2,draw3,%f_pselswitch_draw3,draw1,%f_editteam_draw1;pstat;init,%f_pstat_init,draw2,%f_turn_draw2,draw3,%f_pstat_draw3,lrfunc,%f_pstat_lrfunc,xfunc,%f_pstat_xfunc;p1sel;next,p2sel,init,%f_psel_init,update,%f_nop,draw1,%f_nop,p0key,p1;p2sel;next,turn,init,%f_psel_init,update,%f_nop,draw1,%f_nop,p0key,p2;turn;next,p1sel,init,%f_turn_init,update,%f_turn_update,draw1,%f_turn_draw1,draw2,%f_turn_draw2,draw3,%f_turn_draw3,cur_action,%c_no;credits;init,%f_credits_init,draw2,%f_main_draw2,draw3,%f_main_draw3,xfunc,%f_credits_xfunc;]]
g_loaded_row=16
f_zclass[[o_game_state,o_actor|curr,wait;init,%f_game_state_init,light,0;ecs_exclusions;o_actor,%c_yes;defaults;foldstate,closed,light,0,backbuttonheld,%c_no,sinit,%f_nop,update,%f_nop,draw,%f_nop,draw1,%f_nop,draw2,%f_nop,draw3,%f_nop,modes,;wait;next,moveup,duration,.5,draw,%f_draw_picodex;moveup;next,closed,duration,.5,draw,%f_draw_picodex,sinit,%f_moveup_init;closed;foldstate,closed,next,opening,sinit,%f_closed_init,draw,%f_draw_picodex,update,%f_closed_update;opening;foldstate,opening,next,starting_1,duration,.2,draw,%f_draw_picodex;starting_1;foldstate,open,next,starting_2,light,1,duration,.2,sinit,%f_beep_okay,draw,%f_draw_picodex;starting_2;foldstate,open,next,starting_3,light,2,duration,.2,sinit,%f_beep_back,draw,%f_draw_picodex;starting_3;foldstate,open,next,game,light,3,duration,.2,sinit,%f_beep,draw,%f_draw_picodex;game;foldstate,open,next,closing,light,4,sinit,%f_game_init,draw,%f_draw_picodex,update,%f_game_update,draw1,%f_game_draw1,draw2,%f_game_draw2,draw3,%f_game_draw3;closing;foldstate,closing,next,closed,duration,.25,draw,%f_draw_picodex,update,%f_nop;]]
function _init()
local _ENV=_g
_memset(0x8000,0,0x7fff)
_poke(0x5f5c,8)
_poke(0x5f5d,2)
g_picodex=o_game_state()
f_draw_picodex(g_picodex)
_sfx(63,1,24)
f_extract_sheet(0)
f_extract_sheet(1)
f_extract_sheet(2)
_poke(0x5f56,0xe0)
f_px9_decomp(0,0,_peek2(3*2),_mget,_mset)
f_populate_c_moves()
f_populate_c_pokemon()
_memcpy(0x0000,0xc000,0x2000)
end
function _update60()
local _ENV=_g
g_bpo,g_bpx=_btnp"4",_btnp"5"
g_bph,g_bpv=f_btn_helper(_btnp,0,1),f_btn_helper(_btnp,2,3)
if@0x5eff==1 then
g_bpo,g_bpx=g_bpx,g_bpo
end
f_zcall(f_loop_entities,[[1;,o_actor,clean;2;,o_fader,clean;]])
f_register_entities()
f_zcall(f_loop_entities,[[1;,o_fader,tick;2;,o_game_state,tick;3;,o_fader,state;4;,o_game_state,state;]])
end
function _draw()
local _ENV=_g
_cls()
f_loop_entities("o_game_state","draw")
end