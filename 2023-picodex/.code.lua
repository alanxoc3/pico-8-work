function f_nop(...)return...end
function f_zobj_eval(val,table,parameters)
if _ord(val)==37 then return _g[_sub(val,2)]
elseif val=="~"then return table
elseif _ord(val)==126 then return table[_sub(val,2)]
elseif val=="@"then return _deli(parameters,1)
elseif val=="yes"or val=="no"then return val=="yes"
elseif val=="empty"then return ""
elseif val=="null"or val==""then return
end return val
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
f_zobj_set(_g,[[g_zclass_constructors,@,g_zclass_entities,@,g_zclass_new_entities,@,f_zclass,@,f_register_entities,@,f_deregister_entity,@,f_call_not_nil,@,f_does_entity_exist,@,f_loop_entities,@,f_clean_all_entities,@,f_zobj,@,f_zobj_set,@,f_zobj_eval,@,f_nop,@,f_zspr,@,f_flr_rnd,@,f_rnd_one,@,f_zcall_tbl,@,f_zcall,@,f_zcls,@,f_zcamera,@,f_actor_load,@,f_actor_loadlogic,@,f_actor_state,@,f_actor_is_alive,@,f_actor_kill,@,f_actor_clean,@,f_timer_reset_timer,@,f_timer_end_timer,@,f_timer_get_elapsed_percent,@,f_timer_is_active,@,f_timer_tick,@,f_print_draw2_message,@,f_print_draw3_message,@,c_pokemon,@,f_calc_max_stat,@,f_populate_c_pokemon,@,f_get_natural_moveset,@,c_types,@,c_bg_styles,@,c_zmovetype,@,c_moves_raw,@,c_moves,@,f_populate_c_moves,@,c_trainers,@,f_menu_state_callback,@,f_create_menu_view,@,f_create_menu,@,f_menu_refresh,@,f_menu_cancel,@,f_menu_set,@,f_menu_view_update,@,f_menu_update,@,f_menu_draw1,@,f_menu_drawentry,@,f_browse_drawentry,@,f_create_team_pkmn,@,f_get_fight_party,@,f_party_pkmn_to_active,@,f_fightover_draw1,@,f_editparty_draw1,@,f_turn_draw1,@,f_browse_draw2,@,f_editparty_draw2,@,f_partymoves_draw2,@,f_fightover_draw2,@,f_pselactions_draw2,@,f_pselmove_draw2,@,f_partymovesel_draw2,@,f_main_draw2,@,f_turn_draw2,@,f_editparty_draw3,@,f_move_draw3,@,f_browse_draw3,@,f_main_draw3,@,f_pselactions_draw3,@,f_party_draw3,@,f_pselmove_draw3,@,f_fightover_draw3,@,f_turn_draw3,@,f_fightover_init,@,f_main_init,@,f_browse_init,@,f_browsestat_init,@,f_partystat_init,@,f_credits_init,@,f_story_winlogic,@,f_fightsel_init,@,f_partyaction_init,@,f_partypkmn_init,@,f_partymoves_init,@,f_partymovesel_init,@,f_pselmove_init,@,f_pselactions_init,@,f_party_init,@,f_editparty_init,@,f_turn_init,@,f_turn_update,@,f_browsestat_update,@,f_partystat_update,@,f_modes_default_update,@,f_modes_default_draw1,@,f_modes_cursor,@,f_modes_entry,@,f_modes_push,@,f_modes_pop,@,f_game_init,@,f_game_update,@,f_game_draw,@,f_gamefadein_init,@,f_closed_init,@,f_any_btn,@,f_closed_update,@,f_closed_draw,@,f_closing_draw,@,f_opened_draw,@,f_opening_draw,@,f_beep,@,f_draw_picodex,@,f_picodex_map,@,f_wobble_text,@,f_zprint,@,f_draw_screen,@,f_draw_left_flap,@,f_draw_right_flap,@,f_draw_back_panel,@,f_draw2_pokeinfo,@,f_draw3_pokeinfo,@,f_draw_pkmn,@,f_draw_pkmn_out,@,f_format_num,@,f_get_pokemon,@,f_get_browse_pokemon,@,f_update_stat_menu,@,f_partydel,@,f_set_default_party_pkmn,@,f_fight_select,@,f_set_party_pkmn_move,@,f_party_select,@,f_get_party,@,f_save_party,@,f_select_move,@,f_get_other_pl,@,f_draw_hp,@,f_newaction,@,f_addaction,@,f_logic_faint,@,f_pop_next_action,@,f_get_possible_move_slots,@,f_select_random_move_slot,@,f_generic_attack,@,f_get_crit_ratio,@,f_move_accuracy_rate,@,f_calc_move_damage,@,f_psel_init,@,f_psel_forfeit,@,f_begin_fight,@,f_get_next_active,@,g_fade,@,g_fade_table,@,f_fade,@,f_fader_out_update,@,f_fader_in_update,@,f_logo_init,@,f_logo_draw,@,f_extract_sheet,@,f_vget,@,f_vset,@,f_px9_decomp,@,f_game_state_init,@,f_parse_numlist,@]],{},{},{},function(meta_and_att_str)
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
end,f_zobj,f_zobj_set,f_zobj_eval,f_nop,function(sind,x,y,sw,sh,...)
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
end,function(tbl)
for i=0,2 do
local txt,bg,fg=tbl[i+1],13,1
if _sub(txt,1,1)=="."then
txt,bg,fg=_sub(txt,2),1,13
end
_rectfill(0,i*7,45,i*7+7,bg)
f_zprint(txt,23,1+i*7,fg,0)
end
end,f_zobj[[]],function(base)
return _ceil(base+.5*93)+5
end,function()
local movemem,names=_peek2(8),split"missingno,bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard,squirtle,wartortle,blastoise,caterpie,metapod,butterfree,weedle,kakuna,beedrill,pidgey,pidgeotto,pidgeot,rattata,raticate,spearow,fearow,ekans,arbok,pikachu,raichu,sandshrew,sandslash,nidoran f,nidorina,nidoqueen,nidoran m,nidorino,nidoking,clefairy,clefable,vulpix,ninetales,jigglypuff,wigglytuff,zubat,golbat,oddish,gloom,vileplume,paras,parasect,venonat,venomoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primeape,growlithe,arcanine,poliwag,poliwhirl,poliwrath,abra,kadabra,alakazam,machop,machoke,machamp,bellsprout,weepinbell,victreebel,tentacool,tentacruel,geodude,graveler,golem,ponyta,rapidash,slowpoke,slowbro,magnemite,magneton,farfetchd,doduo,dodrio,seel,dewgong,grimer,muk,shellder,cloyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,electrode,exeggcute,exeggutor,cubone,marowak,hitmonlee,hitmonchan,lickitung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangaskhan,horsea,seadra,goldeen,seaking,staryu,starmie,mr mime,scyther,jynx,electabuzz,magmar,pinsir,tauros,magikarp,gyarados,lapras,ditto,eevee,vaporeon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabutops,aerodactyl,snorlax,articuno,zapdos,moltres,dratini,dragonair,dragonite,mewtwo,mew"
for num=0,151 do
local EVENT=252
local TMHM=253
local DASH=254
local NEXT=255
local pkmndata,is_range={},false
while@movemem ~=NEXT do
if@movemem==DASH then
is_range=true
elseif is_range then
for i=pkmndata[#pkmndata],@movemem do
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
local pkmn=f_zobj([[num,@,evolvesfrom,@,name,@,type1,@,type2,@,base_maxhp,@,base_attack,@,base_defense,@,base_speed,@,base_special,@,moves_natural,@,moves_tm,@,moves_event,@]],
num,
evolvesfrom,
names[num+1],
pkmndata[2],
pkmndata[3],
pkmndata[4],
pkmndata[5],
pkmndata[6],
pkmndata[7],
pkmndata[8],
{},{},{}
)
if evolvesfrom<num then
_foreach(c_pokemon[evolvesfrom].moves_natural,function(move)_add(pkmn.moves_natural,move)end)
_foreach(c_pokemon[evolvesfrom].moves_tm,function(move)_add(pkmn.moves_tm,move)end)
_foreach(c_pokemon[evolvesfrom].moves_event,function(move)_add(pkmn.moves_event,move)end)
end
local move_bucket=pkmn.moves_natural
for i=9,#pkmndata do
local val=pkmndata[i]
if val==TMHM then
move_bucket=pkmn.moves_tm
elseif val==EVENT then
move_bucket=pkmn.moves_event
else
_add(move_bucket,val)
end
end
f_zobj_set(pkmn,[[attack,@,defense,@,special,@,speed,@,maxhp,@,level,50]],f_calc_max_stat(pkmn.base_attack),
f_calc_max_stat(pkmn.base_defense),
f_calc_max_stat(pkmn.base_special),
f_calc_max_stat(pkmn.base_speed),
f_calc_max_stat(pkmn.base_maxhp)+5+50
)
pkmn.total=pkmn.attack+pkmn.defense+pkmn.special+pkmn.speed+pkmn.maxhp
pkmn.draw=function(...)
f_draw_pkmn_out(pkmn.num,...)
end
c_pokemon[num]=pkmn
end
end,function(num)
local pkmn,moveset=c_pokemon[num],{}
printh(#pkmn.moves_natural)
for i=#pkmn.moves_natural,1,-1 do
if #moveset<4 then
_add(moveset,pkmn.moves_natural[i])
end
end
return moveset
end,f_zobj[[0;bg,0,name,empty;0;good;,;0;null;,;0;weak;,;1;bg,0,name,normal;1;good;,;1;null;,15;1;weak;,13;2;bg,5,name,fire;2;good;,8,10,11;2;null;,;2;weak;,2,4,13,14;3;bg,2,name,fighting;3;good;,10,1,13;3;null;,15;3;weak;,11,9,5,12;4;bg,4,name,water;4;good;,2,7,13;4;null;,;4;weak;,14,8,4;5;bg,1,name,poison;5;good;,11,8;5;null;,;5;weak;,15,7,5,13;6;bg,6,name,electric;6;good;,9,4;6;null;,7;6;weak;,14,6,8;7;bg,2,name,ground;7;good;,6,2,5,13;7;null;,9;7;weak;,11,8;8;bg,3,name,grass;8;good;,7,13,4;8;null;,;8;weak;,11,14,2,9,8,5;9;bg,0,name,flying;9;good;,11,3,8;9;null;,;9;weak;,6,13;10;bg,4,name,ice;10;good;,14,9,8;10;null;,;10;weak;,2,10,4;11;bg,3,name,bug;11;good;,8,12;11;null;,;11;weak;,3,2,9,15,5;12;bg,1,name,psychic;12;good;,3,5;12;null;,;12;weak;,12;13;bg,0,name,rock;13;good;,11,2,9,10;13;null;,;13;weak;,3,7;14;bg,0,name,dragon;14;good;,14;14;null;,;14;weak;,;15;bg,1,name,ghost;15;good;,15;15;null;,1,12;15;weak;,;16;bg,0,name,bird;16;good;,;16;null;,;16;weak;,]],f_zobj[[0;bg,6,aa,13;;bg,13,aa,5;;bg,9,aa,4;;bg,11,aa,3;;bg,12,aa,5;;bg,8,aa,2;;bg,10,aa,4]],f_zobj[[0;name,status;;name,physical;;name,special;]],f_zobj[[0;,struggle,1,0,50,1;;,megapnch,1,20,80,.85;;,razrwind,1,10,80,1;;,swordanc,1,20,0,0;;,whrlwind,1,20,0,0;;,megakick,1,5,120,.75;;,toxic,5,10,0,.9;;,horndril,1,5,0,.3;;,bodyslam,1,15,85,1;;,takedown,1,20,90,.85;;,doubledg,1,15,120,1;;,bublbeam,4,20,65,1;;,watergun,4,25,40,1;;,icebeam,10,10,90,1;;,blizzard,10,5,110,.7;;,hyprbeam,1,5,150,.9;;,payday,1,20,40,1;;,submsion,3,20,80,.8;;,counter,3,20,0,1;;,siestoss,3,20,0,1;;,rage,1,20,20,1;;,megdrain,8,15,40,1;;,solrbeam,8,10,120,1;;,drgnrage,14,10,0,1;;,thndrblt,6,15,90,1;;,thunder,6,10,110,.7;;,earthqke,7,10,100,1;;,fissure,7,5,0,.3;;,dig,7,10,80,1;;,psychic,12,10,90,1;;,teleport,12,20,0,0;;,mimic,1,10,0,0;;,doubteam,1,15,0,0;;,reflect,12,20,0,0;;,bide,1,10,0,0;;,metronom,1,10,0,0;;,selfdstr,1,5,200,1;;,eggbomb,1,10,100,.75;;,fireblst,2,5,110,.85;;,swift,1,20,60,2;;,skulbash,1,10,130,1;;,softboil,1,5,0,0;;,dreameat,12,15,100,1;;,skyattck,9,5,140,.9;;,rest,12,5,0,0;;,thndrwav,6,20,0,.9;;,psywave,12,15,0,1;;,explsion,1,5,250,1;;,rockslid,13,10,75,.9;;,triattck,1,10,80,1;;,substute,1,10,0,0;;,cut,1,30,50,.95;;,fly,9,15,90,.95;;,surf,4,15,90,1;;,strength,1,15,80,1;;,flash,1,20,0,1;;,pound,1,35,40,1;;,karatchp,3,25,50,1;;,doublslp,1,10,15,.85;;,comtpnch,1,15,18,.85;;,firepnch,2,15,75,1;;,icepnch,10,15,75,1;;,thndpnch,6,15,75,1;;,scratch,1,35,40,1;;,vicegrip,1,30,55,1;;,guilotin,1,5,0,.3;;,gust,9,35,40,1;;,wingatck,9,35,60,1;;,bind,1,20,15,.85;;,slam,1,20,80,.75;;,vinewhip,8,25,45,1;;,stomp,1,20,65,1;;,doublkck,3,30,30,1;;,jumpkck,3,10,100,.95;;,rllngkck,3,15,60,.85;;,sandatck,7,15,0,1;;,headbutt,1,15,70,1;;,hornatck,1,25,65,1;;,furyatck,1,20,15,.85;;,tackle,1,35,40,1;;,wrap,1,20,15,.9;;,thrash,1,10,120,1;;,tailwhip,1,30,0,1;;,psnsting,5,35,15,1;;,twineedl,11,20,25,1;;,pinmisil,11,20,25,.95;;,leer,1,30,0,1;;,bite,1,25,60,1;;,growl,1,40,0,1;;,roar,1,20,0,1;;,sing,1,15,0,.55;;,supersnc,1,20,0,.55;;,sonicbm,1,20,0,.9;;,disable,1,20,0,1;;,acid,5,30,40,1;;,ember,2,25,40,1;;,flamthwr,2,15,90,1;;,mist,10,30,0,0;;,hydropmp,4,5,110,.8;;,psybeam,12,20,65,1;;,aurorabm,10,20,65,1;;,peck,9,35,35,1;;,drillpck,9,20,80,1;;,lowkick,3,20,0,1;;,absorb,8,25,20,1;;,leechsed,8,10,0,.9;;,growth,1,20,0,0;;,razrleaf,8,25,55,.95;;,psnpowdr,5,35,0,.75;;,stunspor,8,30,0,.75;;,slppowdr,8,15,0,.75;;,petldanc,8,10,120,1;;,strngsht,11,40,0,.95;;,firespin,2,15,35,.85;;,thndshck,6,30,40,1;;,rockthrw,13,15,50,.9;;,cnfusion,12,25,50,1;;,hypnosis,12,20,0,.6;;,meditate,12,40,0,0;;,agility,12,30,0,0;;,quickatk,1,30,40,1;;,nghtshde,15,15,0,1;;,screech,1,40,0,.85;;,recover,1,5,0,0;;,harden,1,30,0,0;;,minimize,1,10,0,0;;,smokscrn,1,20,0,1;;,cnfusray,15,10,0,1;;,withdraw,4,40,0,0;;,dfnscurl,1,40,0,0;;,barrier,12,20,0,0;;,lghtscrn,12,30,0,0;;,haze,10,30,0,0;;,fcsenrgy,1,30,0,0;;,mirrmove,9,20,0,0;;,lick,15,30,30,1;;,smog,5,20,30,.7;;,sludge,5,20,65,1;;,boneclub,7,20,65,.85;;,waterfal,4,15,80,1;;,clamp,4,15,35,.85;;,spikcann,1,15,20,1;;,constrct,1,35,10,1;;,amnesia,12,20,0,0;;,kinesis,12,15,0,.8;;,hijmpkck,3,10,130,.9;;,glare,1,30,0,1;;,psngas,5,40,0,.9;;,barrage,1,20,15,.85;;,leechlif,11,10,80,1;;,lovekiss,1,10,0,.75;;,tranform,1,10,0,0;;,bubble,4,30,40,1;;,dizypnch,1,10,70,1;;,spore,8,15,0,1;;,splash,1,40,0,0;;,acidarmr,5,20,0,0;;,crabhamr,4,10,100,.9;;,furyswps,1,15,18,.8;;,bonerang,7,10,50,.9;;,hyprfang,1,15,80,.9;;,sharpen,1,30,0,0;;,convrson,1,30,0,0;;,suprfang,1,10,0,.9;;,slash,1,20,70,1]],f_zobj[[]],function()
for i=0,#c_moves_raw do
local move=c_moves_raw[i]
c_moves[i]=f_zobj([[name,@,type,@,pp,@,damage,@,accuracy,@,ref,@,num,@]],
move[1],
move[2],
move[3],
move[4],
move[5],
(i>=1 and i<=50 and "tm "..i)or(i>=51 and i<=55 and "hm "..(i-50)),
i
)
end
end,f_zobj[[;,youngstr,19,16,10,21,13,69;;,junior,23,27,19,7,4,1;;,bugcatch,13,46,14,10,11,127;;,brock,74,138,104,37,140,95;;,lass,43,52,35,29,84,39;;,hiker,74,50,41,66,46,75;;,swimmer,116,60,90,129,120,118;;,misty,120,117,54,119,86,121;;,gentlman,58,32,147,77,27,133;;,sailor,90,72,54,60,98,61;;,rocker,100,41,48,81,63,25;;,ltsurge,25,135,100,125,82,26;;,channelr,92,39,104,35,93,105;;,gambler,17,75,61,111,58,44;;,beauty,69,113,40,70,133,36;;,erika,47,71,102,12,114,45;;,birdkeep,84,17,22,83,85,18;;,biker,109,56,72,88,67,73;;,juggler,48,44,122,96,101,79;;,koga,30,89,110,15,33,49;;,blckbelt,66,67,106,56,57,107;;,rocket,28,20,101,42,110,24;;,psychic,79,63,80,96,102,64;;,sabrina,122,103,64,124,97,65;;,scientst,132,71,92,49,97,137;;,pkmaniac,113,127,125,123,108,55;;,suprnerd,77,82,57,136,37,78;;,blaine,78,59,136,38,76,126;;,fishrman,118,73,117,119,91,99;;,cooltrnr,148,47,55,8,5,2;;,tamer,105,128,28,20,111,53;;,giovanni,51,34,53,31,115,112;;,lorelei,91,124,134,131,80,87;;,bruno,95,107,139,106,76,68;;,agatha,42,89,93,45,24,94;;,lance,130,148,142,149,141,143;;,blue,18,65,135,59,103,9;;,green,94,115,36,130,38,3;;,red,123,143,26,131,85,6;;,legendry,149,145,146,144,150,151]],function(game,entry)
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
end,function(game)game:pop()end,function(menu,delta)
local newval=menu.c+delta
if newval==_mid(0,newval,#menu-1)then menu.c=newval end
menu.c=_mid(0,menu.c,#menu-1)
if menu.c\menu.r<menu.v then menu.v=menu.c\menu.r end
if menu.c\menu.r>menu.v+2 then menu.v=menu.c\menu.r-2 end
menu.v=_mid(0,menu.v,(#menu-1)\menu.r)
end,function(game)
local menu=game.menu
if g_bpo then menu.cancel(game)end
if g_bpu then menu.v-=1 end
if g_bpd then menu.v+=1 end
menu.v=_mid(menu.viewmin,menu.v,#menu-3)
end,function(game)
local menu=game.menu
menu:set"0"
if g_bpu then menu:set(-menu.r)end
if g_bpd then menu:set(menu.r)end
if g_bpl then menu:set"-1" end
if g_bpr then menu:set"1" end
if g_bpx then
local entry=menu[menu.c+1]
if entry.disabled then f_beep()
elseif entry.select then entry.select(game,entry)
end
end
if g_bpo then menu.cancel(game)end
end,function(game)
local menu=game.menu
local c,v=menu.c,menu.v
local y=-10
local cellw=menu.r>1 and 10 or 40
local y1,y2=0,39
local xoff=20-(menu.r*cellw)/2
_rectfill(0,y1,39,y2,1)
_rectfill(0,0+5-menu.v*10,39,0+4+(_max(_ceil(#menu/menu.r),40\10-1)-menu.v)*10,13)
for i=-1,menu.r*5-1 do
local index=(menu.v-1)*menu.r+i+1
local entry=menu[index]
local style_ind,x,y=(entry or{style=0}).style or 1,xoff+i%menu.r*10,0+i\menu.r*10
if entry then
if entry.disabled then style_ind=3 end
if index-1==menu.c then style_ind+=1 end
end
local style=c_menustyles[style_ind]
if entry and not entry.hidden then
_rectfill(x,y-5,x+cellw-1,y+4,style.bg)
f_zcamera(i%menu.r*cellw+xoff+cellw/2,0+i\menu.r*10-3,function()
menu.edraw(entry,style)
end)
end
end
end,function(entry,style)
if entry.pkmn then
local pkmn=f_get_pokemon(entry.pkmn)
local style=c_bg_styles[c_types[pkmn.type1].bg]
_rectfill(0-20,5-10+3,39-20,24-10+3,style.bg)
_rectfill(0-20,21-10+3,39-20,24-10+3,style.aa)
pkmn.draw(20-20,-5+20-10+3,style.aa,1,1)
else
f_wobble_text(entry.name,0,0,style.fg)
end
end,function(entry,style)
f_draw_pkmn_out(entry.num,0,3,style.out,.375,.375)
end,function()
end,function(party)
local fightparty={}
for i=1,6 do
local cur=party[i]
if cur then
local pkmn=c_pokemon[cur.num]
fightparty[i]={
num=cur.num,
lvl=pkmn.level,
maxhp=pkmn.maxhp,
attack=pkmn.attack,
defense=pkmn.defense,
speed=pkmn.speed,
special=pkmn.special,
moveids=(function()local m={}for i=1,4 do m[i]=cur.moves[i]end return m end)(),
hp=pkmn.maxhp,
movepps=(function()local m={}for i=1,4 do m[i]=cur.moves[i]and c_moves[cur.moves[i]].pp end return m end)(),
}
end
end
return fightparty
end,function(partypkmn)
return{
type1=c_pokemon[partypkmn.num].type1,
type2=c_pokemon[partypkmn.num].type2,
moveids=(function()local m={}for i=1,4 do m[i]=partypkmn.moveids[i]end return m end)(),
movepps=partypkmn.movepps,
stages=f_zobj[[special,0,defense,0,attack,0,speed,0,accuracy,0,evasion,0]],
getstat=function(a,stat)
local stage=a.stages[stat]
return _ceil(_mid(1,999,
a.shared[stat]*(
(stat=="evasion"or stat=="accuracy")
and _mid(1,1+stage/3,3)/_mid(1,1-stage/3,3)
or _mid(2,2+stage,8)/_mid(2,2-stage,8)
)
))
end,
minor={},
shared=partypkmn,
}
end,function(game)_print("todo",5,5,1)end,function(game)
f_modes_default_draw1(game)
f_wobble_text("team #"..game:cursor"team1"+1,20,27,1)
end,function(game)
local a1,a2,active=game.p1.active,game.p2.active,game.cur_action.active
local a1a,a2a=active==a1,active==a2
_rectfill(0,0,39,39,5)
_rectfill(0,5,39,34,13)
if a1.shared.major ~=1 then
_pal(1,a1a and 6 or 1)_spr(198,20,26,3,1)_pal(1,1)
f_zprint(a1.shared.hp.."H",41,29-2,13,1)
f_draw_hp(40,31+6,a1.shared.hp,a1.shared.maxhp,1,1)
c_pokemon[a1.shared.num].draw(10,40-15,5)
end
if a2.shared.major ~=1 then
_pal(1,a2a and 6 or 1)_spr(198,-4,7,3,1)_pal(1,1)
f_zprint(a2.shared.hp.."H",1,6+2,13,-1)
f_draw_hp(-1,8-6,a2.shared.hp,a2.shared.maxhp,-1,1)
c_pokemon[a2.shared.num].draw(40-10,15,5,-1)
end
end,function(game)f_draw2_pokeinfo(f_get_browse_pokemon(game:cursor"browse"+1))end,function(game)f_print_draw2_message("spot #"..(game:cursor"editparty"+1))end,function(game)f_print_draw2_message("move #"..(game:cursor"partymoves"+1))end,function(game)f_print_draw2_message"match over" end,function(_)end,function(game)end,function(game)
local move=game:entry"partymovesel"
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
local team=f_get_party(game:cursor"team1")
local partypkmn=team[game:cursor"editparty"+1]
if partypkmn then
f_draw3_pokeinfo(f_get_pokemon(partypkmn.num))
else
f_print_draw3_message{".?????????","????","??????"}
end
end,function(game)
local num=game:entry().num
if num then
local move=c_moves[num]
f_print_draw3_message{"."..c_types[move.type].name,move.pp.."/"..move.pp,move.damage.."P "..(move.accuracy*100\1).."A"}
else
f_print_draw3_message{".????","?/?","??P ???A"}
end
end,function(game)f_draw3_pokeinfo(f_get_browse_pokemon(game:cursor"browse"+1))end,function(game)f_print_draw3_message(_split(game:entry"main".desc,"|"))end,function(game)f_print_draw3_message(_split(game:entry"pselactions".desc,"|"))end,function(game)
local count,power=0,0
for i=1,6 do
local num=game:entry().team[i]
if num then
count+=1
power+=c_pokemon[num].total
end
end
f_print_draw3_message{".team stats","pkm "..count.."/6","pow "..power}
end,function(game)end,function(game)f_print_draw3_message{game.p0.name,"is the","winner"}end,function(game)
local message_tbl=_split(game.cur_action.message)
if message_tbl[1]=="#"then message_tbl[1]=c_pokemon[game.cur_action.active.shared.num].name end
f_print_draw3_message(message_tbl)
end,function(_ENV)
local winner,loser=p0,f_get_other_pl(_ENV,p0)
winner.winlogic()
menu:refresh{}
_add(menu,{pkmn=winner.active.shared.num})
_add(menu,{hidden=true})
_add(menu,{name="winner",style=3})
_add(menu,{name=winner.name})
_add(menu,{name="6/6"})
_add(menu,{pkmn=loser.active.shared.num})
_add(menu,{hidden=true})
_add(menu,{name="loser",style=3})
_add(menu,{name=loser.name})
_add(menu,{name="pkm 6/6"})
end,function(_ENV)
menu:refresh(
f_zobj[[;name,browse,state,browse,select,%f_menu_state_callback,desc,view|pokemon|info;;name,teams,state,team1,select,%f_menu_state_callback,desc,edit|stored|teams;;name,fight,state,games,select,%f_menu_state_callback,desc,custom|2 player|battle,disabled,yes;;name,story,state,team1fight,select,%f_menu_state_callback,desc,battle|against|trainers;;name,hoard,state,hoard,select,%f_menu_state_callback,desc,battle all|pokemon|in order,disabled,yes;;name,credits,state,credits,select,%f_menu_state_callback,desc,made by|amorg|games]]
)
end,function(_ENV)
menu:refresh(
g_available_pokemon,
function(num)return{select=function(_ENV)_ENV:push"browsestat" end,num=num}end
)
end,function(_ENV)
f_update_stat_menu(menu,f_get_browse_pokemon(_ENV:cursor"browse"+1))
end,function(_ENV)
local team=f_get_party(_ENV:cursor"team1")
local partypkmn=team[_ENV:cursor"editparty"+1]
f_update_stat_menu(menu,c_pokemon[partypkmn.num])
end,function(_ENV)
menu:refresh(
_split"65,,!scores,pkmn ,hoard ,106,,!alanxoc3,code,design,6,,!gr8cadet,graphics,sound,129,,!wadlo,magikarp,gyarados,123,,!snippets,zep px9,mot smap,137,,!pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
function(txt)
if _type(txt)=="number"then
return{pkmn=txt}
end
local style=1
if _sub(txt,1,1)=="!"then
txt,style=_sub(txt,2),3
end
return{name=txt,style=style,hidden=txt==""}
end
)
menu[4].name..=#g_available_pokemon
menu[5].name..=0
end,function(pl,other)
poke(0x5efd,min(@0x5efd+1,#c_trainers))
end,function(_ENV)
menu:refresh(c_trainers,function(trainer,num)
local disabled,team=num-1>@0x5efd,{}
for i=1,6 do team[i]=trainer[i+1]end
return{
name=trainer[1],
team=team,
disabled=disabled,
desc=disabled and "beat|previous|to unlock",
select=function(_ENV,entry)
local cpu_party_draft={}
for i=1,6 do
local num=entry.team[i]
if num then
_add(cpu_party_draft,{num=num,moves=c_pokemon[num]:get_natural_moveset()})
end
end
f_begin_fight(_ENV,f_get_party(_ENV:cursor"team1"),cpu_party_draft,"player 1",entry.name,false,true,f_nop,f_nop,f_story_winlogic,f_nop)
end
}
end)
end,function(_ENV)
menu:refresh(f_zobj[[;name,info,state,partystat,select,%f_menu_state_callback,;;name,moves,state,partymoves,select,%f_menu_state_callback;;name,delete,select,%f_partydel]])
partymovesel.menu.c=0
end,function(_ENV)
menu:refresh(
g_available_pokemon,
function(num)
return{
select=function(_ENV)
f_save_party(_ENV:cursor"team1",f_set_default_party_pkmn(f_get_party(_ENV:cursor"team1"),_ENV:cursor"editparty"+1,g_available_pokemon[_ENV:cursor"browse"+1]))
_ENV:pop()
end,
num=num
}
end
)
end,function(_ENV)
local team=f_get_party(_ENV:cursor"team1")
local partypkmn=team[_ENV:cursor"editparty"+1]
menu:refresh(f_zobj[[,1,2,3,4]],function(i)
return{
num=partypkmn.moves[i],
name=partypkmn.moves[i]and c_moves[partypkmn.moves[i]].name or "???",
select=function(_ENV)_ENV:push"partymovesel" end
}
end)
end,function(_ENV)
local team=f_get_party(_ENV:cursor"team1")
local partypkmn=team[_ENV:cursor"editparty"+1]
local pkmn=c_pokemon[partypkmn.num]
local moves={}
local add_to_moves=function(movelist,prefix)
for i=1,#movelist do
_add(moves,{num=movelist[i],desc=prefix and prefix..i or c_moves[movelist[i]].ref or "error"})
end
end
add_to_moves(pkmn.moves_natural,"learn ")
add_to_moves(pkmn.moves_tm)
add_to_moves(pkmn.moves_event,"event ")
menu:refresh(moves,function(m)
return{
name=c_moves[m.num].name,
num=m.num,
ref=m.desc,
select=function()
f_save_party(_ENV:cursor"team1",f_set_party_pkmn_move(f_get_party(_ENV:cursor"team1"),_ENV:cursor"editparty"+1,_ENV:cursor"partymoves"+1,m.num))
_ENV:pop()
end
}
end)
end,function(_ENV)
menu:refresh(f_get_possible_move_slots(p0.active),function(move_slot)
local move=c_moves[p0.active.moveids[move_slot]]
return{
name=move.name,
num=move.num,
select=function()
_ENV:pop()_ENV:pop()
f_select_move(p0,move_slot)
end
}
end)
end,function(_ENV)
menu:refresh(f_zobj[[;name,fight,desc,select|next|move,select,%f_menu_state_callback,state,pselmove;;name,random,desc,select|random|move,select,%f_menu_cancel;;name,switch,desc,change|active|pokemon,select,%f_menu_state_callback,state,pselswitch,disabled,yes;;name,forfeit,desc,leave|the|fight,select,%f_psel_forfeit]])
end,function(_ENV)
menu:refresh(f_zobj[[,1,2,3]],function(i)
local team=f_get_party(i-1)
local newteam={}
local is_disabled=true
for i=1,6 do
if team[i]then newteam[i]=team[i].num is_disabled=false end
end
return{
name="team #"..i,
team=newteam,
select=function()_ENV:select_func()end,
disabled=disable_empty_party and is_disabled
}
end)
end,function(_ENV)
local team=f_get_party(_ENV:cursor"team1")
menu:refresh(f_zobj[[,1,2,3,4,5,6]],function(i)
return{
select=function(_ENV)
if team[_ENV:cursor"editparty"+1]then
_ENV:push"partyaction"
else
_ENV:push"partypkmn"
end
end,
num=team[i]and team[i].num or-1
}
end)
end,function(_ENV)
for p in _all{p1,p2}do
if #p.actions==0 then
f_select_move(p,f_select_random_move_slot(p.active))
end
end
local p1,p2=p1,p2
if p1.priority==p2.priority then p2.priority+=_sgn(_rnd"2"-1)end
p0=p1.priority>p2.priority and p1 or p2
end,function(game)
if g_bpx or not game.cur_action then
for p in _all{game.p1,game.p2}do
if not f_get_next_active(p.party)then
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
end,function(game)
if g_bpl then
game.browse.menu:set"-1"
f_browsestat_init(game)
end
if g_bpr then
game.browse.menu:set"1"
f_browsestat_init(game)
end
f_modes_default_update(game)
end,function(game)
if g_bpl then
local team=f_get_party(game:cursor"team1")
for i=game.editparty.menu.c-1,0,-1 do
if team[i+1]then
game.editparty.menu.c=i
break
end
end
f_partystat_init(game)
end
if g_bpr then
local team=f_get_party(game:cursor"team1")
for i=game.editparty.menu.c+1,5,1 do
if team[i+1]then
game.editparty.menu.c=i
break
end
end
f_partystat_init(game)
end
f_modes_default_update(game)
end,function(_ENV)menu.update(_ENV)end,function(_ENV)menu.draw1(_ENV)end,function(_ENV,menu_name)
return _ENV[menu_name].menu.c
end,function(_ENV,menu_name)
local menu=(menu_name and _ENV[menu_name].menu or menu)
return menu[menu.c+1]
end,function(_ENV,newstate)
_add(stack,newstate)
_ENV:f_actor_load(newstate)
end,function(_ENV)
_deli(stack)
_ENV:load(stack[#stack]or "main")
end,function(_ENV)
for i=0,151 do
_poke(0x5e5a+i,1)
end
local party={}
_foreach(_split"133,7,35,1,25,4",function(num)
_add(party,{num=num,moves=f_get_natural_moveset(num)})
_poke(0x5e5a+num,1)
end)
if@0x5efc ~=0 then
_poke(0x5efc,1)
f_save_party(0,party)
end
modes=o_modes()
f_zcall(function(menu_name,create_func,...)
modes[menu_name].menu=create_func(...)
end,[[;,browse,~f_create_menu,~f_browse_drawentry,4;;,browsestat,~f_create_menu_view,~f_menu_drawentry;;,partystat,~f_create_menu_view,~f_menu_drawentry;;,credits,~f_create_menu_view,~f_menu_drawentry;;,fightover,~f_create_menu_view,~f_menu_drawentry;;,editparty,~f_create_menu,~f_browse_drawentry,3;;,main,~f_create_menu,~f_menu_drawentry;;,partyaction,~f_create_menu,~f_menu_drawentry;;,partymovesel,~f_create_menu,~f_menu_drawentry;;,partymoves,~f_create_menu,~f_menu_drawentry;;,pselactions,~f_create_menu,~f_menu_drawentry;;,pselmove,~f_create_menu,~f_menu_drawentry;;,team1,~f_create_menu,~f_menu_drawentry;;,team2,~f_create_menu,~f_menu_drawentry]])
modes.main.menu.cancel=f_beep
modes.pselactions.menu.cancel=f_beep
modes.team1fight.menu=modes.team1.menu
modes.team2cpu.menu=modes.team2.menu
modes.partypkmn.menu=modes.browse.menu
_sfx(61,0)
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
end,function(program)
_cls()
f_draw_picodex(program:is_active"shaking",1,
function()program.modes:draw1()end,
function()program.modes:draw2()end,
function()program.modes:draw3()end,
4,false,program.modes.main.menu.c,#program.modes.stack)
end,function()
o_fader_in()
_sfx(-2,0)
end,function(_ENV)
_menuitem(1,"factory reset",function()
_sfx(59,0)
_memset(0x5e00,0,0x100)
_ENV:start_timer("shaking",.5)
end)
end,function()
return g_bl or g_br or g_bu or g_bd or g_bx or g_bo
end,function(_ENV)
if not f_any_btn()and backbuttonheld then
backbuttonheld=false
_ENV:load()
_menuitem(1)
elseif f_any_btn()then
backbuttonheld=true
_menuitem(1)
end
end,function(_ENV)
f_draw_picodex(_ENV:is_active"shaking",-1,f_nop,f_nop,f_nop,light,backbuttonheld)
end,function(_ENV)
f_draw_picodex(_ENV:is_active"shaking",_cos(_ENV:get_elapsed_percent"closing"/2),f_nop,f_nop,f_nop)
end,function(_ENV)
f_draw_picodex(_ENV:is_active"shaking",1,f_nop,f_nop,f_nop,light)
end,function(_ENV)
f_draw_picodex(_ENV:is_active"shaking",-_cos(_ENV:get_elapsed_percent"opening"/2),f_nop,f_nop,f_nop)
end,function()_sfx(60,0)end,function(shaking,rotation,l_screen,tr_screen,br_screen,light,backbuttonheld,top_row_buttons,bot_row_buttons)
light=light or 0
f_zcamera(28-(rotation+1)*14+(shaking and _flr(_rnd(3)-1)or 0),15,function()
f_draw_back_panel(light)
f_draw_left_flap(light>=4,l_screen)
f_draw_right_flap(light>=4,rotation,backbuttonheld,tr_screen,br_screen,top_row_buttons,bot_row_buttons)
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
end,function(is_on,screen_func)
_rectfill(4,14,59,83,is_on and 13 or 5)
if is_on then f_draw_screen(11,21,40,40,screen_func)end
_map(8,0,-1,9,8,11)
_spr(g_bl and 186 or 154,07,77)
_spr(g_br and 188 or 156,23,77)
_spr(g_bu and 171 or 139,15,73)
_spr(g_bd and 187 or 155,15,81)
_spr(g_bo and 170 or 138,39,77)
_spr(g_bx and 172 or 140,47,77)
end,function(is_on,flap_rotation,backbuttonheld,topscreen_func,botscreen_func,top_row_buttons,bot_row_buttons)
if flap_rotation<0 then
f_picodex_map(0,64*(1-_abs(flap_rotation))-1,_abs(flap_rotation))
if flap_rotation==-1 and backbuttonheld then _spr(123,3,49)end
elseif flap_rotation>0 then
_rectfill(65+5,9+5,65+8*8*flap_rotation-5,9+11*8-5,is_on and 13 or 5)
if flap_rotation==1 and is_on then
f_draw_screen(74,18,46,13,topscreen_func)
f_draw_screen(74,67,46,21,botscreen_func)
end
f_picodex_map(16,65,flap_rotation)
if flap_rotation==1 then
if top_row_buttons then _spr(100,73+(top_row_buttons\1%6)*8,41)end
if bot_row_buttons and bot_row_buttons>0 then _spr(100,73+(bot_row_buttons\1-1)%6*8,49)end
end
end
end,function(light)
local rate=_t()*7
_map(24,0,-1,1,9,12)
_spr((light>0)and(rate%11<.5 and 131 or 130)or 132,19,3)
_spr((light>1)and(rate%13<.5 and 131 or 129)or 132,14,3)
_spr((light>2)and(rate%17<.5 and 131 or 128)or 132,9,3)
_spr((light>3)and(rate%43<.5 and 134 or 133)or 135,3,3)
end,function(pkmn)
f_print_draw2_message("pkmn "..f_format_num(pkmn.num))
end,function(pkmn)
f_print_draw3_message{"."..pkmn.name,c_types[pkmn.type1].name,c_types[pkmn.type2].name}
end,function(num,x,y,sw,sh)
if num<0 then _rectfill(x-1,y-1,x,y,6)return end
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
end,function(num)
local str=""..num
for i=#str+1,3 do
str="0"..str
end
return "#"..str
end,function(num)
return c_pokemon[num]
end,function(num)
return c_pokemon[g_available_pokemon[num]]or{draw=f_nop}
end,function(menu,pkmn)
menu:refresh{}
_add(menu,{pkmn=pkmn.num})
_add(menu,{hidden=true})
_add(menu,{name="lvl 50",style=3})
_add(menu,{name=(pkmn.hp or pkmn.maxhp).."/"..pkmn.maxhp})
_foreach(f_zobj[[;key,special,name,spc;;key,attack,name,att;;key,defense,name,def;;key,speed,name,spd;;key,total,name,tot;;key,accuracy,name,acc;;key,evasion,name,eva]],function(pair)
if not pair.key then
_add(menu,{name=pair.name,style=3})
elseif pkmn[pair.key]then
_add(menu,{name=pair.name.." "..pkmn[pair.key]})
end
end)
end,function(game)
local team=f_get_party(game:cursor"team1")
team[game:cursor"editparty"+1]=nil
f_save_party(game:cursor"team1",team)
game:pop()
end,function(team,ind,num)
team[ind]={num=num,moves=f_get_natural_moveset(num)}
return team
end,function(game)
game:push"team2cpu"
end,function(party,ind,moveind,move)
local partypkmn=party[ind]
for i=1,4 do
if partypkmn.moves[i]==move then
partypkmn.moves[i]=nil
end
end
partypkmn.moves[moveind]=move
return party
end,function(game)
game:push"editparty"
end,function(party_index)
local mem=c_party_memlocs[party_index]
local party={}
for i=1,6 do
local memstart=mem+(i-1)*5
local moves={}
local has_moves=false
for i=1,4 do
local move=_peek(memstart+i)
if move>0 then
moves[i]=move
has_moves=true
end
end
if has_moves then
party[i]={num=_peek(memstart),moves=moves}
end
end
return party
end,function(party_index,party)
local mem=c_party_memlocs[party_index]
_memset(mem,0,30)
for i=1,6 do
local memstart=mem+(i-1)*5
local pkmn=party[i]
if pkmn then
_poke(memstart,pkmn.num)
for i=1,4 do
_poke(memstart+i,pkmn.moves[i])
end
end
end
end,function(pl,slot,switch)
pl.actions={}
local priority_class=1000
if switch then
priority_class=3000
else
local move=pl.active.moveids[slot]or 0
f_addaction(pl,pl,"#,uses,"..c_moves[move].name,function(s,o)
f_generic_attack(s,o,slot)
end)
if move==120 then priority_class=2000 end
if move==18 or move==4 or move==89 or move==30 then
priority_class=0000
end
end
pl.priority=_min(3000,priority_class+pl.active:getstat"speed")
end,function(game,pl)
return pl==game.p1 and game.p2 or game.p1
end,function(x,y,hp,maxhp,align,col)
_rectfill(x,y-2,x-align*_max(_ceil(hp/maxhp*40),0),y+2,col)
end,function(pactive,message,logic)
return{pl=pactive,active=pactive.active,message=message,logic=logic or f_nop}
end,function(p0,...)
_add(p0.actions,f_newaction(...))
end,function(s)
s.active.shared.major=1
end,function(game)
for p in _all{game.p1,game.p2}do
if p.active.shared.hp<=0 then
if p.active.shared.major ~=1 then
return f_newaction(p,"#,is,fainted",f_logic_faint)
else
p.active=f_party_pkmn_to_active(f_get_next_active(p.party))
return f_newaction(p,"#,comes,out")
end
end
end
for s in _all{game.p0,f_get_other_pl(game,game.p0)}do
local o=f_get_other_pl(game,s)
while #s.actions>0 do
local action=_deli(s.actions,1)
if action.active.shared.major ~=1 and(action.active==s.active or action.active==o.active)then
return action
end
end
end
end,function(active)
local possible_moves={}
for i=1,4 do
if active.moveids[i]and active.movepps[i]>0 then
_add(possible_moves,i)
end
end
return possible_moves
end,function(active)
local possible_moves=f_get_possible_move_slots(active)
return possible_moves[f_flr_rnd(#possible_moves)+1]or 0
end,function(s,o,m)
local move=c_moves[s.active.moveids[m]or 0]
if move.num!=0 then
s.active.movepps[m]-=1
end
local dmg=move.damage
if dmg>0 then
f_addaction(s,o,"#,-"..dmg..",hitpoints",function()
o.active.shared.hp=_max(0,o.active.shared.hp-dmg)
end)
else
f_addaction(s,s,"#,does,nothing")
end
end,function(base_speed)
return _min(.99,(base_speed+76)/1024)
end,function()
return f_flr_rnd"256"==0 and f_flr_rnd"256"==0
end,function(lvl,attack,defense,critical,move_power)
local base_damage=(2*lvl*critical/5+2)*move_power*(attack/defense)/50+2
return base_damage*stab*type1*type2*random
end,function(game)
game.p0=game[game.p0key]
if game.p0.iscpu or #game.p0.actions>0 then
game:load()
else
game.cur_action=f_newaction(game.p0,"")
game:push"pselactions"
end
end,function(game)
game:pop()
game.p0=f_get_other_pl(game,game.p0)
game:load"fightover"
end,function(game,party1,party2,name1,name2,iscpu1,iscpu2,p1_die_logic,p2_die_logic,p1_win_logic,p2_win_logic)
local party1,party2=f_get_fight_party(party1),f_get_fight_party(party2)
game.p1={name=name1,priority=1,iscpu=iscpu1,actions={},active=f_party_pkmn_to_active(f_get_next_active(party1)),party=party1,winlogic=p1_win_logic,dielogic=p1_die_logic}
game.p2={name=name2,priority=0,iscpu=iscpu2,actions={},active=f_party_pkmn_to_active(f_get_next_active(party2)),party=party2,winlogic=p2_win_logic,dielogic=p2_die_logic}
_add(game.p1.actions,f_newaction(game.p1,"#,comes,out"))
_add(game.p2.actions,f_newaction(game.p2,"#,comes,out"))
game.p0=game.p1
game.pselactions.menu.c,game.pselmove.menu.c=0,0
game:push"turn"
end,function(party)
for i=1,6 do
if party[i]and party[i].major ~=1 then
return party[i]
end
end
end,1,f_zobj[[0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,0,0,0,0;2;,2,2,2,1,0,0,0,0;3;,3,3,3,3,1,1,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,0,0,0,0;6;,6,6,13,13,5,5,0,0;7;,7,7,6,13,13,5,0,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,0,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,0,0,0;13;,13,13,5,5,1,0,0,0;14;,14,14,13,4,2,2,0,0;15;,15,15,13,13,5,5,0,0;]],function(threshold)
for c=0,15 do
_pal(c,g_fade_table[c][1+_flr(7*_min(1,_max(0,threshold)))],1)
end
end,function(a)
_poke(0x5f43,0xff)
_g.g_fade=a:get_elapsed_percent"start"
end,function(a)
_g.g_fade=1-a:get_elapsed_percent"start"
end,function()_sfx(63,1)end,function(a)
_g.g_fade=_cos(a:get_elapsed_percent"logo")+1
_camera(g_fade>.5 and f_rnd_one())
f_zspr(108,64,64,4,2)
_camera()
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
end,function(str)
local tbl={}
for x in _all(_split(str or "","|"))do
if _type(x)=="number"then
_add(tbl,x)
end
end
return tbl
end)
f_zclass[[o_actor,o_timer|load,%f_actor_load,loadlogic,%f_actor_loadlogic,state,%f_actor_state,kill,%f_actor_kill,clean,%f_actor_clean,is_alive,%f_actor_is_alive,alive,yes,duration,null,curr,start,next,null,isnew,yes,init,%f_nop,finit,%f_nop,stateless_update,%f_nop,update,%f_nop,destroyed,%f_nop;]]
f_zclass[[o_timer|timers;,;start_timer,%f_timer_reset_timer,end_timer,%f_timer_end_timer,is_active,%f_timer_is_active,get_elapsed_percent,%f_timer_get_elapsed_percent,tick,%f_timer_tick,]]
c_menustyles=f_zobj[[;bg,13,fg,1,out,5;;bg,6,fg,13,out,13;;bg,1,fg,13,out,2;;bg,5,fg,13,out,2]]
f_zclass[[o_modes,o_actor|cursor,%f_modes_cursor,entry,%f_modes_entry,push,%f_modes_push,pop,%f_modes_pop,update,%f_nop,draw1,%f_nop,draw2,%f_nop,draw3,%f_nop,curr,main;stack;,;defaults;menu,no,finit,%f_nop,init,%f_nop,update,%f_modes_default_update,draw1,%f_modes_default_draw1,draw2,%f_nop,draw3,%f_nop;browse;init,%f_browse_init,draw2,%f_browse_draw2,draw3,%f_browse_draw3;partypkmn;init,%f_partypkmn_init,draw2,%f_browse_draw2,draw3,%f_browse_draw3;browsestat;init,%f_browsestat_init,draw2,%f_browse_draw2,draw3,%f_browse_draw3,update,%f_browsestat_update;partystat;init,%f_partystat_init,draw2,%f_editparty_draw2,draw3,%f_editparty_draw3,update,%f_partystat_update;credits;init,%f_credits_init,draw2,%f_main_draw2,draw3,%f_main_draw3;fightover;init,%f_fightover_init,draw2,%f_fightover_draw2,draw3,%f_fightover_draw3;editparty;init,%f_editparty_init,draw2,%f_editparty_draw2,draw3,%f_editparty_draw3,draw1,%f_editparty_draw1;main;init,~f_main_init,draw2,~f_main_draw2,draw3,~f_main_draw3;partyaction;init,%f_partyaction_init,draw2,%f_editparty_draw2,draw3,%f_editparty_draw3;partymovesel;init,%f_partymovesel_init,draw2,%f_partymovesel_draw2,draw3,%f_move_draw3;partymoves;init,%f_partymoves_init,draw2,%f_partymoves_draw2,draw3,%f_move_draw3;pselactions;init,%f_pselactions_init,draw2,%f_turn_draw2,draw3,%f_pselactions_draw3;pselmove;init,%f_pselmove_init,draw2,%f_turn_draw2,draw3,%f_move_draw3;team1;init,%f_party_init,draw2,%f_main_draw2,draw3,%f_party_draw3,disable_empty_party,no,select_func,%f_party_select;team1fight;init,%f_party_init,draw2,%f_main_draw2,draw3,%f_party_draw3,disable_empty_party,yes,select_func,%f_fight_select;team2;init,%f_party_init,draw2,%f_main_draw2,draw3,%f_party_draw3,disable_empty_party,yes,select_func,%f_fight_select;team2cpu;init,%f_fightsel_init,draw2,%f_main_draw2,draw3,%f_party_draw3;p1sel;next,p2sel,init,%f_psel_init,p0key,p1,update,%f_nop,draw1,%f_nop;p2sel;next,turn,init,%f_psel_init,p0key,p2,update,%f_nop,draw1,%f_nop;turn;next,p1sel,update,%f_turn_update,draw1,%f_turn_draw1,draw2,%f_turn_draw2,draw3,%f_turn_draw3,init,%f_turn_init,cur_action,no;]]
g_loaded_row=16
c_party_memlocs=f_zobj[[0,0x5e00,1,0x5e1e,2,0x5e3c]]
f_zclass[[o_fader,o_actor|ecs_exclusions;o_actor,yes,o_timer,yes;]]
f_zclass[[o_fader_out,o_fader|start;duration,.5,destroyed,@,update,%f_fader_out_update]]
f_zclass[[o_fader_in,o_fader|start;duration,.5,update,%f_fader_in_update]]
f_zclass[[o_game_state,o_actor|curr,fadein;init,%f_game_state_init;ecs_exclusions;o_actor,yes;defaults;sinit,%f_nop,update,%f_nop,draw,%f_nop,light,0,backbuttonheld,no,modes,;logo;next,fadein,sinit,%f_logo_init,update,%f_nop,draw,%f_logo_draw,duration,2.5;fadein;next,game,duration,0,sinit,%f_gamefadein_init;closed;next,opening,sinit,%f_closed_init,update,%f_closed_update,draw,%f_closed_draw;opening;next,starting_1,duration,.25,draw,%f_opening_draw;starting_1;next,starting_2,light,1,duration,.125,sinit,%f_beep,draw,%f_opened_draw;starting_2;next,starting_3,light,2,duration,.125,sinit,%f_beep,draw,%f_opened_draw;starting_3;next,game,light,3,duration,.125,sinit,%f_beep,draw,%f_opened_draw;game;next,closing,light,4,sinit,%f_game_init,update,%f_game_update,draw,%f_game_draw;closing;next,closed,duration,.25,update,%f_nop,draw,%f_closing_draw;]]
function _init()
local _ENV=_g
_memset(0x8000,0,0x7fff)
_poke(0x5f5c,12)
_poke(0x5f5d,2)
_cls()
_sfx(62,0)
f_extract_sheet(0)
f_extract_sheet(1)
f_extract_sheet(2)
_poke(0x5f56,0xe0)
f_px9_decomp(0,0,_peek2(3*2),_mget,_mset)
f_populate_c_moves()
f_populate_c_pokemon()
_memcpy(0x0000,0xc000,0x2000)
g_tl=o_game_state()
end
function _update60()
local _ENV=_g
g_bl,g_br,g_bu,g_bd,g_bo,g_bx,g_bpl,g_bpr,g_bpu,g_bpd,g_bpo,g_bpx=_btn"0",_btn"1",_btn"2",_btn"3",_btn"4",_btn"5",_btnp"0",_btnp"1",_btnp"2",_btnp"3",_btnp"4",_btnp"5"
g_available_pokemon={}
for i=0,151 do
if@(0x5e5a+i)>0 then
_add(g_available_pokemon,i)
end
end
if@0x5eff==1 then
g_bo,g_bx=g_bx,g_bo
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
f_fade(g_fade)
end