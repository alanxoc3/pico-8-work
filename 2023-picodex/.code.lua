g_zclass_constructors,g_zclass_entities,g_zclass_new_entities={},{},{}
function zclass(meta_and_att_str)
local meta,template,memloc,expected_memloc_value=unpack(split(meta_and_att_str,"|"))
local parents=split(meta)
local class=deli(parents,1)
g_zclass_entities[class]=g_zclass_entities[class]or{}
g_zclass_constructors[class]=function(inst,done,...)
foreach(parents,function(parent)
if not done[parent]then g_zclass_constructors[parent](inst,done)end
end)
done[class]=true
inst.parents[class]=true
add(g_zclass_new_entities,{class,inst})
return zobj_set(inst,template,...)
end
_g[class]=function(...)if not memloc or peek(memloc)==expected_memloc_value then return g_zclass_constructors[class]({id=class,parents={},ecs_exclusions={}},{},...)end end
end
function register_entities()
while #g_zclass_new_entities>0 do
local class,inst=unpack(deli(g_zclass_new_entities))
if not inst.ecs_exclusions[class]then add(g_zclass_entities[class],inst)end
end
end
function deregister_entity(inst,...)
for class,entities in pairs(g_zclass_entities)do
del(entities,inst)
end
end
function call_not_nil(table,key,...)
if table and table[key]then
return table[key](...)
end
end
function does_entity_exist(entity_name)
return #g_zclass_entities[entity_name]>0
end
function loop_entities(class,method_name,...)
for inst in all(g_zclass_entities[class])do
call_not_nil(inst,method_name,inst,...)
end
end
function clean_all_entities(...)
local objs_to_clean,exclusions={},{}
foreach({...},function(exclusion)exclusions[exclusion]=true end)
for class,entities in pairs(g_zclass_entities)do
for entity in all(entities)do
objs_to_clean[entity]=entity.id
end
end
for obj,id in pairs(objs_to_clean)do
if not exclusions[id]then
deregister_entity(obj)
end
end
g_zclass_new_entities={}
end
function nop()end
function zobj_eval(val,table,parameters)
if ord(val)==37 then return _g[sub(val,2)]
elseif val=="~"then return table
elseif ord(val)==126 then return table[sub(val,2)]
elseif val=="@"then return deli(parameters,1)
elseif val=="yes"or val=="no"then return val=="yes"
elseif val=="null"or val==""then return
elseif val=="nop"then return nop
end return val
end
function zobj_set(table,str,...)
local params,statements,dest={...},split(str,";"),table
foreach(statements,function(statement)
local tokens=split(statement)
if #tokens>1 then
if tokens[1]==""then
foreach(tokens,function(val)
add(dest,zobj_eval(val,table,params))
end)
else
for i=1,#tokens,2 do
dest[tokens[i]]=zobj_eval(tokens[i+1],table,params)
end
end
dest=table
else
if type(dest[statement])~="table"then
dest[statement]={}
end
dest=dest[statement]
end
end)
return table
end
function zobj(...)
return zobj_set({},...)
end
_g=zobj([[actor_load,@,actor_loadlogic,@,actor_state,@,actor_is_alive,@,actor_kill,@,actor_clean,@,timer_reset_timer,@,timer_end_timer,@,timer_get_elapsed_percent,@,timer_is_active,@,timer_tick,@,game_init,@,game_update,@,game_draw,@,main_update,@,main_draw1,@,gamefadein_init,@,closed_init,@,closed_update,@,closed_draw,@,closing_draw,@,light_init,@,opened_draw,@,opening_draw,@,battle_update,@,battle_draw1,@,battle_draw2,@,battle_draw3,@,browse_update,@,browse_draw1,@,browse_draw2,@,browse_draw3,@,fader_out_update,@,fader_in_update,@,logo_init,@,logo_draw,@,game_state_init,@]],function(a,stateName)
a.next_state=stateName or a.next
end,function(a,stateName)
a.next_state,a.isnew=nil
if stateName=="dead"then
a.alive=false
else
a:end_timer(a.curr)
a.next,a.duration=nil
for k,v in pairs(a.defaults)do a[k]=v end
for k,v in pairs(a[stateName])do a[k]=v end
a.curr=stateName
a:start_timer(a.curr,a.duration,a.duration and function()a:load(a.next or "dead")end)
a:init()
end
end,function(a)
if a.isnew then
a:loadlogic(a.curr)
elseif a.next_state then
a:loadlogic(a.next_state)
end
a:update()
a:stateless_update()
end,function(a)
return not a.effectively_dead and a:is_active"ending"==nil and a.alive
end,function(a)
a.effectively_dead=true
if a.ending then
if a.curr=="start"then
a.next="ending"
elseif a:is_active"ending"==nil then
a:load"ending"
end
else
a.alive=nil
end
end,function(a)if not a.alive then a:destroyed()deregister_entity(a)end end,function(a,timer_name,duration,callback)
a.timers[timer_name]={active=true,elapsed=false,duration=duration and 0+duration,callback=callback or function()end}
end,function(a,timer_name)
if a.timers[timer_name]then
a.timers[timer_name].elapsed=a.timers[timer_name].duration or a.timers[timer_name].elapsed
a.timers[timer_name].active=false
end
end,function(a,timer_name)
local timer=a.timers[timer_name]
if not timer then return 0
elseif not timer.duration then return 0
elseif timer.duration<=0 then return 1
end
return min(1,(timer.elapsed or 0)/timer.duration)
end,function(a,timer_name)
local timer=a.timers[timer_name]
return timer and timer.active
end,function(a)
local finished_timers={}
for name,timer in pairs(a.timers)do
if timer.active then
if timer.elapsed then
timer.elapsed=timer.elapsed+1/60
if timer.duration and timer.elapsed>=timer.duration then
add(finished_timers,timer)
end
elseif not timer.elapsed then
timer.elapsed=0
end
end
end
foreach(finished_timers,function(timer)
timer.active=false
timer.callback(a)
end)
end,function(a)
a.modes=_g.modes()
sfx(61,0)
menuitem(1,"close picodex",function()
menuitem(1)
menuitem(2)
a:load"closing"
end)
menuitem(2,"swap 🅾️/❎",function()
poke(0x5efa,@0x5efa==0 and 1 or 0)
end)
end,function(a)
loop_entities("modes","state")
end,function(a)
cls()
draw_picodex(a:is_active"shaking",1,
function()a.modes:draw1()end,
function()a.modes:draw2()end,
function()a.modes:draw3()end,
4)
end,function(a)
if g_bpu or g_bpl then poke(0x5ef8,(@0x5ef8-1)%c_modes.len)end
if g_bpd or g_bpr then poke(0x5ef8,(@0x5ef8+1)%c_modes.len)end
if g_bpx then a:load(c_modes[@0x5ef8].state)end
end,function(a)
rectfill(0,14,39,23,1)
for i=0,4 do
local text,y=c_modes[(i-2+@0x5ef8)%c_modes.len].name,c_mode_positions[i+1]
if i==2 then
wobble_text(text,20,y,13)
else
zprint(text,20,y,1,0)
end
end
end,function(a)
_g.fader_in()
sfx(-2,0)
end,function(a)
menuitem(1,"factory reset",function()
sfx(59,0)
memset(0x5e00,0,0x100)
a:start_timer("shaking",.5)
end)
end,function(a)
if not any_btn()and a.backbuttonheld then
a.backbuttonheld=false
a:load()
menuitem(1)
elseif any_btn()then
a.backbuttonheld=true
menuitem(1)
end
end,function(a)
draw_picodex(a:is_active"shaking",-1,nop,nop,nop,a.light,a.backbuttonheld)
end,function(a)
draw_picodex(a:is_active"shaking",cos(a:get_elapsed_percent"closing"/2),nop,nop,nop)
end,function(a)
sfx(60,0)
end,function(a)
draw_picodex(a:is_active"shaking",1,nop,nop,nop,a.light)
end,function(a)
draw_picodex(a:is_active"shaking",-cos(a:get_elapsed_percent"opening"/2),nop,nop,nop)
end,function(a)
if g_bpx or g_bpo then a:load"main" end
end,function(a)
rectfill(0,0,39,39,1)
zprint("no",20,12-2,13,0)
zprint("active",20,19-2,13,0)
zprint("party",20,26-2,13,0)
end,function(a)
end,function(a)
end,function(a)
if g_bpl then poke(0x5ef7,(@0x5ef7-1)%pkmn_len())end
if g_bpr then poke(0x5ef7,(@0x5ef7+1)%pkmn_len())end
if g_bpo then a:load"main" end
if g_bpx then sfx(flr(rnd(9)))end
end,function(a)
local types=zobj[[0;pc,6,sc,13;1;pc,13,sc,5;2;pc,9,sc,4;3;pc,11,sc,3;4;pc,12,sc,13;]]
local type=c_bg_styles[c_pokemon[@0x5ef7+1].background]
rectfill(0,0,39,39,type.pc)
draw_pkmn_out(@0x5ef7+1,20,20,2,2,type.sc)
end,function(a)
zprint(c_pokemon[@0x5ef7+1].name,46/2,4,1,0)
end,function(a)
rectfill(0,0,46,22,13)
rectfill(0,0,6,46,1)
zprint(""..(c_pokemon[@0x5ef7+1].height/10).." m",9,3-1,1,-1)
zprint(""..(c_pokemon[@0x5ef7+1].width/10).." kg",9,9-1,1,-1)
print("h",2,3-1,13)
print("w",2,9-1,13)
end,function(a)
poke(0x5f43,0xff)
g_fade=a:get_elapsed_percent"start"
end,function(a)
g_fade=1-a:get_elapsed_percent"start"
end,function()sfx(63,1)end,function(a)
g_fade=cos(a:get_elapsed_percent"logo")+1
camera(g_fade>.5 and rnd_one())
zspr(108,64,64,4,2)
camera()
end,function(state)
clean_all_entities("game_state","fader_in")
state:sinit()
end)
function zspr(sind,x,y,sw,sh,...)
sw,sh=sw or 1,sh or 1
spr(sind,x-sw*4,y-sh*4,sw,sh,...)
end
function flr_rnd(x)
return flr(rnd(x))
end
function rnd_one(val)
return(flr_rnd"3"-1)*(val or 1)
end
function zcall_tbl(func,tbl)
foreach(tbl,function(params)
func(unpack(params))
end)
end
function zcall(func,text,...)
zcall_tbl(func,zobj(text,...))
end
function zcls(col)
rectfill(0x8000,0x8000,0x7fff,0x7fff,col or 0)
end
zclass[[actor,timer|load,%actor_load,loadlogic,%actor_loadlogic,state,%actor_state,kill,%actor_kill,clean,%actor_clean,is_alive,%actor_is_alive,alive,yes,duration,null,curr,start,next,null,isnew,yes,init,nop,stateless_update,nop,update,nop,destroyed,nop;]]
zclass[[drawlayer_50|]]
zclass[[timer|timers;,;start_timer,%timer_reset_timer,end_timer,%timer_end_timer,is_active,%timer_is_active,get_elapsed_percent,%timer_get_elapsed_percent,tick,%timer_tick,]]
c_pokemon=zobj[[0;,missingno,10,10,15,0,0,33,136,0,29,6;1;,bulbasaur,69,7,4,7,3,45,49,49,45,65;2;,ivysaur,130,10,4,7,3,60,62,63,60,80;3;,venusaur,1000,20,4,7,3,80,82,83,80,100;4;,charmander,85,6,1,no,2,39,52,43,65,50;5;,charmeleon,190,11,1,no,2,58,64,58,80,65;6;,charizard,905,17,1,9,2,78,84,78,100,85;7;,squirtle,90,5,2,no,1,44,48,65,43,50;8;,wartortle,225,10,2,no,1,59,63,80,58,65;9;,blastoise,855,16,2,no,1,79,83,100,78,85;10;,caterpie,29,3,11,no,3,45,30,35,45,20;11;,metapod,99,7,11,no,3,50,20,55,30,25;12;,butterfree,320,11,11,9,0,60,45,50,70,80;13;,weedle,32,3,11,7,2,40,35,30,50,20;14;,kakuna,100,6,11,7,2,45,25,50,35,25;15;,beedrill,295,10,11,7,2,65,80,40,75,45;16;,pidgey,18,3,0,9,0,40,45,40,56,35;17;,pidgeotto,300,11,0,9,0,63,60,55,71,50;18;,pidgeot,395,15,0,9,0,83,80,75,91,70;19;,rattata,35,3,0,no,1,30,56,35,72,25;20;,raticate,185,7,0,no,0,55,81,60,97,50;21;,spearow,20,3,0,9,2,40,60,30,70,31;22;,fearow,380,12,0,9,2,65,90,65,100,61;23;,ekans,69,20,7,no,1,35,60,44,55,40;24;,arbok,650,35,7,no,1,60,85,69,80,65;25;,pikachu,60,4,3,no,1,35,55,30,90,50;26;,raichu,300,8,3,no,2,60,90,55,100,90;27;,sandshrew,120,6,8,no,2,50,75,85,40,30;28;,sandslash,295,10,8,no,2,75,100,110,65,55;29;,nidoran?,70,4,7,no,1,55,47,52,41,40;30;,nidorina,200,8,7,no,1,70,62,67,56,55;31;,nidoqueen,600,13,7,8,1,90,82,87,76,75;32;,nidoran!,90,5,7,no,1,46,57,40,50,40;33;,nidorino,195,9,7,no,1,61,72,57,65,55;34;,nidoking,620,14,7,8,1,81,92,77,85,75;35;,clefairy,75,6,0,no,0,70,45,48,35,60;36;,clefable,400,13,0,no,0,95,70,73,60,85;37;,vulpix,99,6,1,no,2,38,41,40,65,65;38;,ninetales,199,11,1,no,2,73,76,75,100,100;39;,jigglypuff,55,5,0,no,0,115,45,20,20,25;40;,wigglytuff,120,10,0,no,0,140,70,45,45,50;41;,zubat,75,8,7,9,1,40,45,35,55,40;42;,golbat,550,16,7,9,1,75,80,70,90,75;43;,oddish,54,5,4,7,3,45,50,55,30,75;44;,gloom,86,8,4,7,2,60,65,70,40,85;45;,vileplume,186,12,4,7,2,75,80,85,50,100;46;,paras,54,3,11,4,2,35,70,55,25,55;47;,parasect,295,10,11,4,2,60,95,80,30,80;48;,venonat,300,10,11,7,1,60,55,50,45,40;49;,venomoth,125,15,11,7,1,70,65,60,90,90;50;,diglett,8,2,8,no,0,10,55,25,95,45;51;,dugtrio,333,7,8,no,0,35,80,50,120,70;52;,meowth,42,4,0,no,0,40,45,35,90,40;53;,persian,320,10,0,no,0,65,70,60,115,65;54;,psyduck,196,8,2,no,0,50,52,48,55,50;55;,golduck,766,17,2,no,0,80,82,78,85,80;56;,mankey,280,5,6,no,0,40,80,35,70,35;57;,primeape,320,10,6,no,0,65,105,60,95,60;58;,growlithe,190,7,1,no,0,55,70,45,60,50;59;,arcanine,1550,19,1,no,0,90,110,80,95,80;60;,poliwag,124,6,2,no,0,40,50,40,90,40;61;,poliwhirl,200,10,2,no,0,65,65,65,90,50;62;,poliwrath,540,13,2,6,0,90,85,95,70,70;63;,abra,195,9,10,no,0,25,20,15,90,105;64;,kadabra,565,13,10,no,0,40,35,30,105,120;65;,alakazam,480,15,10,no,0,55,50,45,120,135;66;,machop,195,8,6,no,0,70,80,50,35,35;67;,machoke,705,15,6,no,0,80,100,70,45,50;68;,machamp,1300,16,6,no,0,90,130,80,55,65;69;,bellsprout,40,7,4,7,0,50,75,35,40,70;70;,weepinbell,64,10,4,7,0,65,90,50,55,85;71;,victreebel,155,17,4,7,0,80,105,65,70,100;72;,tentacool,455,9,2,7,0,40,40,35,70,100;73;,tentacruel,550,16,2,7,0,80,70,65,100,120;74;,geodude,200,4,12,8,0,40,80,100,20,30;75;,graveler,1050,10,12,8,0,55,95,115,35,45;76;,golem,3000,14,12,8,0,80,110,130,45,55;77;,ponyta,300,10,1,no,0,50,85,55,90,65;78;,rapidash,950,17,1,no,0,65,100,70,105,80;79;,slowpoke,360,12,2,10,0,90,65,65,15,40;80;,slowbro,785,16,2,10,0,95,75,110,30,80;81;,magnemite,60,3,3,no,0,25,35,70,45,95;82;,magneton,600,10,3,no,0,50,60,95,70,120;83;,farfetchd,150,8,0,9,0,52,65,55,60,58;84;,doduo,392,14,0,9,0,35,85,45,75,35;85;,dodrio,852,18,0,9,0,60,110,70,100,60;86;,seel,900,11,2,no,0,65,45,55,45,70;87;,dewgong,1200,17,2,5,0,90,70,80,70,95;88;,grimer,300,9,7,no,0,80,80,50,25,40;89;,muk,300,12,7,no,0,105,105,75,50,65;90;,shellder,40,3,2,no,0,30,65,100,40,45;91;,cloyster,1325,15,2,5,0,50,95,180,70,85;92;,gastly,1,13,13,7,0,30,35,30,80,100;93;,haunter,1,16,13,7,0,45,50,45,95,115;94;,gengar,405,15,13,7,0,60,65,60,110,130;95;,onix,2100,88,12,8,0,35,45,160,70,30;96;,drowzee,324,10,10,no,0,60,48,45,42,90;97;,hypno,756,16,10,no,0,85,73,70,67,115;98;,krabby,65,4,2,no,0,30,105,90,50,25;99;,kingler,600,13,2,no,0,55,130,115,75,50;100;,voltorb,104,5,3,no,0,40,30,50,100,55;101;,electrode,666,12,3,no,0,60,50,70,140,80;102;,exeggcute,25,4,4,10,0,60,40,80,40,60;103;,exeggutor,1200,20,4,10,0,95,95,85,55,125;104;,cubone,65,4,8,no,0,50,50,95,35,40;105;,marowak,450,10,8,no,0,60,80,110,45,50;106;,hitmonlee,498,15,6,no,0,50,120,53,87,35;107;,hitmonchan,502,14,6,no,0,50,105,79,76,35;108;,lickitung,655,12,0,no,0,90,55,75,30,60;109;,koffing,10,6,7,no,0,40,65,95,35,60;110;,weezing,95,12,7,no,0,65,90,120,60,85;111;,rhyhorn,1150,10,8,12,0,80,85,95,25,30;112;,rhydon,1200,19,8,12,0,105,130,120,40,45;113;,chansey,346,11,0,no,0,250,5,5,50,105;114;,tangela,350,10,4,no,0,65,55,115,60,100;115;,kangaskhan,800,22,0,no,0,105,95,80,90,40;116;,horsea,80,4,2,no,0,30,40,70,60,70;117;,seadra,250,12,2,no,0,55,65,95,85,95;118;,goldeen,150,6,2,no,0,45,67,60,63,50;119;,seaking,390,13,2,no,0,80,92,65,68,80;120;,staryu,345,8,2,no,0,30,45,55,85,70;121;,starmie,800,11,2,10,0,60,75,85,115,100;122;,mr mime,545,13,10,no,0,40,45,65,90,100;123;,scyther,560,15,11,9,0,70,110,80,105,55;124;,jynx,406,14,5,10,0,65,50,35,95,95;125;,electabuzz,300,11,3,no,0,65,83,57,105,85;126;,magmar,445,13,1,no,0,65,95,57,93,85;127;,pinsir,550,15,11,no,0,65,125,100,85,55;128;,tauros,884,14,0,no,0,75,100,95,110,70;129;,magikarp,100,9,2,no,0,20,10,55,80,20;130;,gyarados,2350,65,2,9,0,95,125,79,81,100;131;,lapras,2200,25,2,5,0,130,85,80,60,95;132;,ditto,40,3,0,no,0,48,48,48,48,48;133;,eevee,65,3,0,no,0,55,55,50,55,65;134;,vaporeon,290,10,2,no,0,130,65,60,65,110;135;,jolteon,245,8,3,no,0,65,65,60,130,110;136;,flareon,250,9,1,no,0,65,130,60,65,110;137;,porygon,365,8,0,no,0,65,60,70,40,75;138;,omanyte,75,4,12,2,0,35,40,100,35,90;139;,omastar,350,10,12,2,0,70,60,125,55,115;140;,kabuto,115,5,12,2,0,30,80,90,55,45;141;,kabutops,405,13,12,2,0,60,115,105,80,70;142;,aerodactyl,590,18,12,9,0,80,105,65,130,60;143;,snorlax,4600,21,0,no,0,160,110,65,30,65;144;,articuno,554,17,5,9,0,90,85,100,85,125;145;,zapdos,526,16,3,9,0,90,90,85,100,125;146;,moltres,600,20,1,9,0,90,100,90,90,125;147;,dratini,33,18,14,no,0,41,64,45,50,50;148;,dragonair,165,40,14,no,0,61,84,65,70,70;149;,dragonite,2100,22,14,9,0,91,134,95,80,100;150;,mewtwo,1220,20,10,no,0,106,110,90,130,154;151;,mew,40,4,10,no,0,100,100,100,100,100;]]
for i=0,151 do
c_pokemon[i]={
name=c_pokemon[i][1],
width=c_pokemon[i][2],
height=c_pokemon[i][3],
type1=c_pokemon[i][4],
type2=c_pokemon[i][5],
background=c_pokemon[i][6],
hp=c_pokemon[i][7],
attack=c_pokemon[i][8],
defence=c_pokemon[i][9],
speed=c_pokemon[i][10],
special=c_pokemon[i][11]
}
end
c_types=zobj[[0;name,normal,0;good;,;0;null;,13;0;weak;,12;1;name,fire,1;good;,4,5,11;1;null;,;1;weak;,1,2,12,14;2;name,water,2;good;,1,8,12;2;null;,;2;weak;,14,4,2;3;name,electric,3;good;,9,2;3;null;,8;3;weak;,14,3,4;4;name,grass,4;good;,8,12,2;4;null;,;4;weak;,11,14,1,9,4,7;5;name,ice,5;good;,14,9,4;5;null;,;5;weak;,1,5,2;6;name,fighting,6;good;,5,0,12;6;null;,13;6;weak;,11,9,7,10;7;name,poison,7;good;,11,4;7;null;,;7;weak;,13,8,7,12;8;name,ground,8;good;,3,1,7,12;8;null;,9;8;weak;,11,4;9;name,flying,9;good;,11,6,4;9;null;,;9;weak;,3,12;10;name,psychic,10;good;,6,7;10;null;,;10;weak;,10;11;name,bug,11;good;,4,10;11;null;,;11;weak;,6,1,9,13,7;12;name,rock,12;good;,11,1,9,5;12;null;,;12;weak;,6,8;13;name,ghost,13;good;,13;13;null;,0,10;13;weak;,;14;name,dragon,14;good;,14;14;null;,;14;weak;,;15;name,bird,15;good;,;15;null;,;15;weak;,;]]
c_bg_styles=zobj[[0;pc,6,sc,13;1;pc,13,sc,5;2;pc,9,sc,4;3;pc,11,sc,3;4;pc,12,sc,13;]]
c_zmovetype=zobj[[0;name,status;1;name,physical;2;name,special;]]
c_moves=zobj[[0;name,struggle,t,0,z,1,p,-,d,50,a,—;1;name,pound,t,0,z,1,p,35,d,40,a,1;2;name,karate-chop,t,6,z,1,p,25,d,50,a,1;3;name,double-slap,t,0,z,1,p,10,d,15,a,.85;4;name,comet-punch,t,0,z,1,p,15,d,18,a,.85;5;name,mega-punch,t,0,z,1,p,20,d,80,a,.85;6;name,pay-day,t,0,z,1,p,20,d,40,a,1;7;name,fire-punch,t,1,z,1,p,15,d,75,a,1;8;name,ice-punch,t,5,z,1,p,15,d,75,a,1;9;name,thunder-punch,t,3,z,1,p,15,d,75,a,1;10;name,scratch,t,0,z,1,p,35,d,40,a,1;11;name,vice-grip,t,0,z,1,p,30,d,55,a,1;12;name,guillotine,t,0,z,1,p,5,d,—,a,.3;13;name,razor-wind,t,0,z,2,p,10,d,80,a,1;14;name,swords-dance,t,0,z,0,p,20,d,—,a,—;15;name,cut,t,0,z,1,p,30,d,50,a,.95;16;name,gust,t,9,z,2,p,35,d,40,a,1;17;name,wing-attack,t,9,z,1,p,35,d,60,a,1;18;name,whirlwind,t,0,z,0,p,20,d,—,a,—;19;name,fly,t,9,z,1,p,15,d,90,a,.95;20;name,bind,t,0,z,1,p,20,d,15,a,.85;21;name,slam,t,0,z,1,p,20,d,80,a,.75;22;name,vine-whip,t,4,z,1,p,25,d,45,a,1;23;name,stomp,t,0,z,1,p,20,d,65,a,1;24;name,double-kick,t,6,z,1,p,30,d,30,a,1;25;name,mega-kick,t,0,z,1,p,5,d,120,a,.75;26;name,jump-kick,t,6,z,1,p,10,d,100,a,.95;27;name,rolling-kick,t,6,z,1,p,15,d,60,a,.85;28;name,sand-attack,t,8,z,0,p,15,d,—,a,1;29;name,headbutt,t,0,z,1,p,15,d,70,a,1;30;name,horn-attack,t,0,z,1,p,25,d,65,a,1;31;name,fury-attack,t,0,z,1,p,20,d,15,a,.85;32;name,horn-drill,t,0,z,1,p,5,d,—,a,.3;33;name,tackle,t,0,z,1,p,35,d,40,a,1;34;name,body-slam,t,0,z,1,p,15,d,85,a,1;35;name,wrap,t,0,z,1,p,20,d,15,a,.9;36;name,take-down,t,0,z,1,p,20,d,90,a,.85;37;name,thrash,t,0,z,1,p,10,d,120,a,1;38;name,double-edge,t,0,z,1,p,15,d,120,a,1;39;name,tail-whip,t,0,z,0,p,30,d,—,a,1;40;name,poison-sting,t,7,z,1,p,35,d,15,a,1;41;name,twineedle,t,11,z,1,p,20,d,25,a,1;42;name,pin-missile,t,11,z,1,p,20,d,25,a,.95;43;name,leer,t,0,z,0,p,30,d,—,a,1;44;name,bite,t,0,z,1,p,25,d,60,a,1;45;name,growl,t,0,z,0,p,40,d,—,a,1;46;name,roar,t,0,z,0,p,20,d,—,a,—;47;name,sing,t,0,z,0,p,15,d,—,a,.55;48;name,supersonic,t,0,z,0,p,20,d,—,a,.55;49;name,sonic-boom,t,0,z,2,p,20,d,—,a,.9;50;name,disable,t,0,z,0,p,20,d,—,a,1;51;name,acid,t,7,z,2,p,30,d,40,a,1;52;name,ember,t,1,z,2,p,25,d,40,a,1;53;name,flamethrower,t,1,z,2,p,15,d,90,a,1;54;name,mist,t,5,z,0,p,30,d,—,a,—;55;name,water-gun,t,2,z,2,p,25,d,40,a,1;56;name,hydro-pump,t,2,z,2,p,5,d,110,a,.8;57;name,surf,t,2,z,2,p,15,d,90,a,1;58;name,ice-beam,t,5,z,2,p,10,d,90,a,1;59;name,blizzard,t,5,z,2,p,5,d,110,a,.7;60;name,psybeam,t,10,z,2,p,20,d,65,a,1;61;name,bubble-beam,t,2,z,2,p,20,d,65,a,1;62;name,aurora-beam,t,5,z,2,p,20,d,65,a,1;63;name,hyper-beam,t,0,z,2,p,5,d,150,a,.9;64;name,peck,t,9,z,1,p,35,d,35,a,1;65;name,drill-peck,t,9,z,1,p,20,d,80,a,1;66;name,submission,t,6,z,1,p,20,d,80,a,.8;67;name,low-kick,t,6,z,1,p,20,d,—,a,1;68;name,counter,t,6,z,1,p,20,d,—,a,1;69;name,seismic-toss,t,6,z,1,p,20,d,—,a,1;70;name,strength,t,0,z,1,p,15,d,80,a,1;71;name,absorb,t,4,z,2,p,25,d,20,a,1;72;name,mega-drain,t,4,z,2,p,15,d,40,a,1;73;name,leech-seed,t,4,z,0,p,10,d,—,a,.9;74;name,growth,t,0,z,0,p,20,d,—,a,—;75;name,razor-leaf,t,4,z,1,p,25,d,55,a,.95;76;name,solar-beam,t,4,z,2,p,10,d,120,a,1;77;name,poison-powder,t,7,z,0,p,35,d,—,a,.75;78;name,stun-spore,t,4,z,0,p,30,d,—,a,.75;79;name,sleep-powder,t,4,z,0,p,15,d,—,a,.75;80;name,petal-dance,t,4,z,2,p,10,d,120,a,1;81;name,string-shot,t,11,z,0,p,40,d,—,a,.95;82;name,dragon-rage,t,14,z,2,p,10,d,—,a,1;83;name,fire-spin,t,1,z,2,p,15,d,35,a,.85;84;name,thunder-shock,t,3,z,2,p,30,d,40,a,1;85;name,thunderbolt,t,3,z,2,p,15,d,90,a,1;86;name,thunder-wave,t,3,z,0,p,20,d,—,a,.9;87;name,thunder,t,3,z,2,p,10,d,110,a,.7;88;name,rock-throw,t,12,z,1,p,15,d,50,a,.9;89;name,earthquake,t,8,z,1,p,10,d,100,a,1;90;name,fissure,t,8,z,1,p,5,d,—,a,.3;91;name,dig,t,8,z,1,p,10,d,80,a,1;92;name,toxic,t,7,z,0,p,10,d,—,a,.9;93;name,confusion,t,10,z,2,p,25,d,50,a,1;94;name,psychic,t,10,z,2,p,10,d,90,a,1;95;name,hypnosis,t,10,z,0,p,20,d,—,a,.6;96;name,meditate,t,10,z,0,p,40,d,—,a,—;97;name,agility,t,10,z,0,p,30,d,—,a,—;98;name,quick-attack,t,0,z,1,p,30,d,40,a,1;99;name,rage,t,0,z,1,p,20,d,20,a,1;100;name,teleport,t,10,z,0,p,20,d,—,a,—;101;name,night-shade,t,13,z,2,p,15,d,—,a,1;102;name,mimic,t,0,z,0,p,10,d,—,a,—;103;name,screech,t,0,z,0,p,40,d,—,a,.85;104;name,double-team,t,0,z,0,p,15,d,—,a,—;105;name,recover,t,0,z,0,p,5,d,—,a,—;106;name,harden,t,0,z,0,p,30,d,—,a,—;107;name,minimize,t,0,z,0,p,10,d,—,a,—;108;name,smokescreen,t,0,z,0,p,20,d,—,a,1;109;name,confuse-ray,t,13,z,0,p,10,d,—,a,1;110;name,withdraw,t,2,z,0,p,40,d,—,a,—;111;name,defense-curl,t,0,z,0,p,40,d,—,a,—;112;name,barrier,t,10,z,0,p,20,d,—,a,—;113;name,light-screen,t,10,z,0,p,30,d,—,a,—;114;name,haze,t,5,z,0,p,30,d,—,a,—;115;name,reflect,t,10,z,0,p,20,d,—,a,—;116;name,focus-energy,t,0,z,0,p,30,d,—,a,—;117;name,bide,t,0,z,1,p,10,d,—,a,—;118;name,metronome,t,0,z,0,p,10,d,—,a,—;119;name,mirror-move,t,9,z,0,p,20,d,—,a,—;120;name,self-destruct,t,0,z,1,p,5,d,200,a,1;121;name,egg-bomb,t,0,z,1,p,10,d,100,a,.75;122;name,lick,t,13,z,1,p,30,d,30,a,1;123;name,smog,t,7,z,2,p,20,d,30,a,.7;124;name,sludge,t,7,z,2,p,20,d,65,a,1;125;name,bone-club,t,8,z,1,p,20,d,65,a,.85;126;name,fire-blast,t,1,z,2,p,5,d,110,a,.85;127;name,waterfall,t,2,z,1,p,15,d,80,a,1;128;name,clamp,t,2,z,1,p,15,d,35,a,.85;129;name,swift,t,0,z,2,p,20,d,60,a,—;130;name,skull-bash,t,0,z,1,p,10,d,130,a,1;131;name,spike-cannon,t,0,z,1,p,15,d,20,a,1;132;name,constrict,t,0,z,1,p,35,d,10,a,1;133;name,amnesia,t,10,z,0,p,20,d,—,a,—;134;name,kinesis,t,10,z,0,p,15,d,—,a,.8;135;name,soft-boiled,t,0,z,0,p,5,d,—,a,—;136;name,high-jump-kick,t,6,z,1,p,10,d,130,a,.9;137;name,glare,t,0,z,0,p,30,d,—,a,1;138;name,dream-eater,t,10,z,2,p,15,d,100,a,1;139;name,poison-gas,t,7,z,0,p,40,d,—,a,.9;140;name,barrage,t,0,z,1,p,20,d,15,a,.85;141;name,leech-life,t,11,z,1,p,10,d,80,a,1;142;name,lovely-kiss,t,0,z,0,p,10,d,—,a,.75;143;name,sky-attack,t,9,z,1,p,5,d,140,a,.9;144;name,transform,t,0,z,0,p,10,d,—,a,—;145;name,bubble,t,2,z,2,p,30,d,40,a,1;146;name,dizzy-punch,t,0,z,1,p,10,d,70,a,1;147;name,spore,t,4,z,0,p,15,d,—,a,1;148;name,flash,t,0,z,0,p,20,d,—,a,1;149;name,psywave,t,10,z,2,p,15,d,—,a,1;150;name,splash,t,0,z,0,p,40,d,—,a,—;151;name,acid-armor,t,7,z,0,p,20,d,—,a,—;152;name,crabhammer,t,2,z,1,p,10,d,100,a,.9;153;name,explosion,t,0,z,1,p,5,d,250,a,1;154;name,fury-swipes,t,0,z,1,p,15,d,18,a,.8;155;name,bonemerang,t,8,z,1,p,10,d,50,a,.9;156;name,rest,t,10,z,0,p,5,d,—,a,—;157;name,rock-slide,t,12,z,1,p,10,d,75,a,.9;158;name,hyper-fang,t,0,z,1,p,15,d,80,a,.9;159;name,sharpen,t,0,z,0,p,30,d,—,a,—;160;name,conversion,t,0,z,0,p,30,d,—,a,—;161;name,tri-attack,t,0,z,2,p,10,d,80,a,1;162;name,super-fang,t,0,z,1,p,10,d,—,a,.9;163;name,slash,t,0,z,1,p,20,d,70,a,1;164;name,substitute,t,0,z,0,p,10,d,—,a,—;]]
zclass[[modes,actor|draw1,nop,draw2,nop,draw3,nop,curr,main;defaults;init,nop,update,nop,draw1,nop,draw2,nop,draw3,nop;main;update,%main_update,draw1,%main_draw1;browse;update,%browse_update,draw1,%browse_draw1,draw2,%browse_draw2,draw3,%browse_draw3;battle;update,%battle_update,draw1,%battle_draw1,draw2,%battle_draw2,draw3,%battle_draw3;]]
c_modes=zobj[[len,6;4;name,battle,state,battle;5;name,party,state,party;0;name,browse,state,browse;1;name,quiz,state,quiz;2;name,config,state,config;3;name,credits,state,credits;]]
c_mode_positions=split"1,8,16,25,32"
function any_btn()return g_bl or g_br or g_bu or g_bd or g_bx or g_bo end
function draw_picodex(shaking,rotation,l_screen,tr_screen,br_screen,light,backbuttonheld)
light=light or 0
camera(-28+(rotation+1)*14+(shaking and flr(rnd(3)-1)or 0),-15)
draw_back_panel(light)
draw_left_flap(light>=4,l_screen)
draw_right_flap(light>=4,rotation,backbuttonheld,tr_screen,br_screen)
camera(0,0)
end
function smap(cx,cy,cw,ch,sx,sy,sw,sh,flipx)
local dx,dy=cw/sw,ch/sh
if flipx then
cx+=cw
dx=-dx
end
if(sx<0)cx-=sx*dx sx=0
if(sy<0)cy-=sy*dy sy=0
if(sw>128)sw=128
if(sh>128)sh=128
if sh<sw then
for y=sy,sy+sh-1 do
tline(sx,y,sx+sw-1,y,cx,cy,dx,0)
cy+=dy
end
else
for x=sx,sx+sw-1 do
tline(x,sy,x,sy+sh-1,cx,cy,0,dy)
cx+=dx
end
end
end
function wobble_text(text,x,y,color)
x-=#text*2
local t1=""
local t2=""
for i=1,#text do
letter=sub(text,i,i)
if letter=="!"then
letter="\^:040e040e0e000000"
end
if letter=="?"then
letter="\^:0e0e040e04000000"
end
if i%2==0 then
t1=t1.." "
t2=t2..letter
else
t1=t1..letter
t2=t2.." "
end
end
print(t1,x,y+(t()%2),color)
print(t2,x,y+((t()+1)%2),color)
end
function zprint(str,x,y,color,align)
if align==0 then x-=#str*2
elseif align>0 then x-=#str*4+1 end
print(str,x,y,color)
end
function draw_screen(xoff,yoff,w,h,screen_func)
local ox,oy=%0x5f28,%0x5f2a
clip(-ox+xoff,-oy+yoff,w,h)
camera(ox-xoff,oy-yoff)
screen_func()
camera(ox,oy)
clip()
end
function draw_left_flap(is_on,screen_func)
rectfill(-1+5,9+5,8*8-5,11*8-5,is_on and 13 or 5)
if is_on then draw_screen(11,21,40,40,screen_func)end
map(8,0,-1,9,8,11)
spr(g_bl and 186 or 154,07,77)
spr(g_br and 188 or 156,23,77)
spr(g_bu and 171 or 139,15,73)
spr(g_bd and 187 or 155,15,81)
spr(g_bo and 170 or 138,39,77)
spr(g_bx and 172 or 140,47,77)
end
function draw_right_flap(is_on,flap_rotation,backbuttonheld,topscreen_func,botscreen_func)
if flap_rotation<0 then
smap(0,0,8,11,8*8*(1-abs(flap_rotation))-1,9,8*8*abs(flap_rotation),11*8)
if flap_rotation==-1 and backbuttonheld then spr(123,3,49)end
elseif flap_rotation>0 then
rectfill(65+5,9+5,65+8*8*flap_rotation-5,9+11*8-5,is_on and 13 or 5)
if flap_rotation==1 and is_on then
draw_screen(74,18,46,13,topscreen_func)
draw_screen(74,67,46,21,botscreen_func)
end
smap(16,0,8,11,65,9,8*8*flap_rotation,11*8)
if flap_rotation==1 then
if g_bl then spr(100,73,41)spr(100,113,49)end
if g_br then spr(100,81,41)spr(100,105,49)end
if g_bu then spr(100,89,41)spr(100,97,49)end
if g_bd then spr(100,97,41)spr(100,89,49)end
if g_bo then spr(100,105,41)spr(100,81,49)end
if g_bx then spr(100,113,41)spr(100,73,49)end
end
end
end
function draw_back_panel(light)
local rate=t()*10
map(24,0,-1,1,9,12)
spr((light>0)and(rate%11<1 and 131 or 130)or 132,19,3)
spr((light>1)and(rate%13<1 and 131 or 129)or 132,14,3)
spr((light>2)and(rate%17<1 and 131 or 128)or 132,9,3)
spr((light>3)and(rate%43<1 and 134 or 133)or 135,3,3)
end
g_loaded_row=16
function draw_pkmn(num,x,y,sw,sh)
sw=sw or 1
sh=sh or 1
local row=(num-1)/8\1
local col=(num-1)%8
if row ~=g_loaded_row then
g_loaded_row=row
memcpy(0x0000,0x8000+0x400*row,0x400)
end
local w,h=16*sw,16*sh
sspr(col*16,0,16,16,x-w/2,y-h/2,w,h)
end
function draw_pkmn_out(num,x,y,sw,sh,col)
sw=sw or 1
sh=sh or 1
for c=1,15 do pal(c,col)end
for i=-sh,sh,sh*2 do draw_pkmn(num,x-sw,y+i,sw,sh)end
for i=-sh,sh,sh*2 do draw_pkmn(num,x+sw,y+i,sw,sh)end
for c=1,15 do pal(c,1)end
for i=-sw,sw,sw*2 do draw_pkmn(num,x+i,y,sw,sh)end
for i=-sh,sh,sh*2 do draw_pkmn(num,x,y+i,sw,sh)end
for c=1,15 do pal(c,c)end
draw_pkmn(num,x,y,sw,sh)
end
function pkmn_len()
return@0x5eff ~=0 and 152 or 151
end
function format_num(num)
local str=""..num
for i=#str+1,3 do
str="0"..str
end
return "#"..str
end
g_fade,g_fade_table=1,zobj[[0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,0,0,0,0;2;,2,2,2,1,0,0,0,0;3;,3,3,3,3,1,1,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,0,0,0,0;6;,6,6,13,13,5,5,0,0;7;,7,7,6,13,13,5,0,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,0,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,0,0,0;13;,13,13,5,5,1,0,0,0;14;,14,14,13,4,2,2,0,0;15;,15,15,13,13,5,5,0,0;]]
function fade(threshold)
for c=0,15 do
pal(c,g_fade_table[c][1+flr(7*min(1,max(0,threshold)))],1)
end
end
zclass[[fader,actor|ecs_exclusions;actor,yes,timer,yes;]]
zclass[[fader_out,fader|start;duration,.5,destroyed,@,update,%fader_out_update]]
zclass[[fader_in,fader|start;duration,.5,update,%fader_in_update]]
function extract_sheet(index)
px9_decomp(0,0,peek2(index*2),
function(...)return vget(0x8000+index*0x2000,...)end,
function(...)return vset(0x8000+index*0x2000,...)end)
end
function vget(offset,x,y)
x=min(max(0,x),127)\1
y=y\1
local val=peek(y*64+offset+x\2)
if x%2==1 then return(val & 0xf0)>>>4
else return(val & 0x0f)end
end
function vset(offset,x,y,val)
x=min(max(0,x),127)\1
y=y\1
local mem_coord=y*64+offset+x\2
local oldval=peek(mem_coord)
if x%2==1 then poke(mem_coord,(oldval & 0x0f)|(((val or 0)& 0x0f)<<4))
else poke(mem_coord,(oldval & 0xf0)|(((val or 0)& 0x0f)<<0))
end
end
function px9_decomp(x0,y0,src,vget,vset)
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
for i=1,gnp"1" do add(el,getval(eb))end
for y=y0,y0+h_1 do
for x=x0,x0+w-1 do
splen-=1
if(splen<1)then
splen,predict=gnp"1",not predict
end
local a=y>y0 and vget(x,y-1)or 0
local l=pr[a]or{unpack(el)}
pr[a]=l
local v=l[predict and 1 or gnp"2"]
vlist_val(l,v)
vlist_val(el,v)
vset(x,y,v)
end
end
end
zclass[[game_state,actor|curr,fadein;init,%game_state_init;ecs_exclusions;actor,yes;defaults;sinit,nop,update,nop,draw,nop,light,0,backbuttonheld,no,modes,;logo;next,fadein,sinit,%logo_init,update,nop,draw,%logo_draw,duration,2.5;fadein;next,game,duration,0,sinit,%gamefadein_init;closed;next,opening,sinit,%closed_init,update,%closed_update,draw,%closed_draw;opening;next,starting_1,duration,.25,draw,%opening_draw;starting_1;next,starting_2,light,1,duration,.125,sinit,%light_init,draw,%opened_draw;starting_2;next,starting_3,light,2,duration,.125,sinit,%light_init,draw,%opened_draw;starting_3;next,game,light,3,duration,.125,sinit,%light_init,draw,%opened_draw;game;next,closing,light,4,sinit,%game_init,update,%game_update,draw,%game_draw;closing;next,closed,duration,.25,update,nop,draw,%closing_draw;]]
function _init()
memset(0x8000,0,0x7fff)
poke(0x5f5c,15)
poke(0x5f5d,5)
cls()
sfx(62,0)
extract_sheet(0)
extract_sheet(1)
extract_sheet(2)
poke(0x5f56,0xe0)
px9_decomp(0,0,peek2(3*2),mget,mset)
memcpy(0x0000,0xc000,0x2000)
g_tl=_g.game_state()
end
function _update60()
g_bl=btn"0" g_br=btn"1"
g_bu=btn"2" g_bd=btn"3"
g_bo=btn"4" g_bx=btn"5"
g_bpl=btnp"0" g_bpr=btnp"1"
g_bpu=btnp"2" g_bpd=btnp"3"
g_bpo=btnp"4" g_bpx=btnp"5"
if@0x5efa==1 then
g_bo,g_bx=g_bx,g_bo
g_bpo,g_bpx=g_bpx,g_bpo
end
zcall(loop_entities,[[1;,actor,clean;2;,fader,clean;]])
register_entities()
zcall(loop_entities,[[1;,fader,tick;2;,game_state,tick;3;,fader,state;4;,game_state,state;]])
end
function _draw()
cls()
loop_entities("game_state","draw")
fade(g_fade)
end