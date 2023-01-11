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
_g=zobj([[actor_load,@,actor_loadlogic,@,actor_state,@,actor_is_alive,@,actor_kill,@,actor_clean,@,timer_reset_timer,@,timer_end_timer,@,timer_get_elapsed_percent,@,timer_is_active,@,timer_tick,@,modes_push,@,modes_pop,@,game_init,@,game_update,@,game_draw,@,main_update,@,main_draw1,@,main_draw2,@,main_draw3,@,gamefadein_init,@,closed_init,@,closed_update,@,closed_draw,@,closing_draw,@,light_init,@,opened_draw,@,opening_draw,@,browse_update,@,browsestat_update,@,browse_draw1,@,browsestat_draw1,@,browse_draw2,@,browse_draw3,@,credits_init,@,credits_update,@,credits_draw1,@,editparty_update,@,editparty_draw1,@,editparty_draw2,@,editparty_draw3,@,fight_update,@,fight_draw1,@,fight_draw2,@,fight_draw3,@,party_update,@,party_draw1,@,party_draw2,@,party_draw3,@,fader_out_update,@,fader_in_update,@,logo_init,@,logo_draw,@,game_state_init,@]],function(a,stateName)
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
end,function(a,newstate)
add(a.stack,newstate)
a:load(newstate)
end,function(a)
deli(a.stack)
a:load(a.stack[#a.stack]or "main")
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
a.modes:state()
end,function(a)
cls()
draw_picodex(a:is_active"shaking",1,
function()a.modes:draw1()end,
function()a.modes:draw2()end,
function()a.modes:draw3()end,
4,false,@0x5ef8,#a.modes.stack)
end,function(a)
if g_bpu or g_bpl then poke(0x5ef8,(@0x5ef8-1)%c_modes.len)end
if g_bpd or g_bpr then poke(0x5ef8,(@0x5ef8+1)%c_modes.len)end
if g_bpx then a:push(c_modes[@0x5ef8].state)end
end,function(a)
rectfill(0,15,39,24,1)
for i=0,4 do
local text,y=c_modes[(i-2+@0x5ef8)%c_modes.len].name,c_mode_positions[i+1]
if i==2 then
wobble_text(text,20,y,13)
else
zprint(text,20,y,1,0)
end
end
end,function(a)
rectfill(0,0,46,13,13)
pal(7,1)
local xx=0
for i,v in ipairs(g_picodex_div)do
sspr(6*8+xx,6*8,v,8,xx+3,3.5+cos((t()+i)/4))
xx+=v
end
pal()
end,function(a)
print_draw3_message(unpack(split(c_modes[@0x5ef8].desc,"/")))
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
browseupdate_shared(a)
if g_bpu then set_browse"-4" end
if g_bpd then set_browse"4" end
if g_bpx then a:push"browsestat" end
end,function(a)
browseupdate_shared(a)
if g_bpu then poke(0x5ef5,max(0,@0x5ef5-1))end
if g_bpd then poke(0x5ef5,min(1,@0x5ef5+1))end
if g_bpx then sfx(flr(rnd(9)))end
end,function(a)
local pkmn=get_pokemon(@0x5ef7)
if@0x5ef7\4<@0x5ef6 then poke(0x5ef6,@0x5ef7\4)end
if@0x5ef7\4>@0x5ef6+3 then poke(0x5ef6,@0x5ef7\4-3)end
poke(0x5ef6,max(0,@0x5ef6))
poke(0x5ef6,min(152/4-4,@0x5ef6))
for j=0,3 do
for i=0,3 do
get_pokemon((@0x5ef6+j)*4+i).draw(i*10+5,j*10+5,5,.375)
end
end
local x,y=(@0x5ef7%4)*10+5,(@0x5ef7\4-@0x5ef6)*10+5
if(@0x5ef7)%4==0 then x+=1 end
if(@0x5ef7)%4==3 then x-=1 end
if(@0x5ef7)\4-@0x5ef6==0 then y+=1 end
if(@0x5ef7)\4-@0x5ef6==3 then y-=1 end
rectfill(x-7-1,y-7-1,x+6+1,y+6+1,13)
rectfill(x-6-1,y-6-1,x+5+1,y+5+1,6)
pkmn.draw(x,y,13,.5)
rect(x-7,y-7,x+6,y+6,1)
end,function(a)
local pkmn=get_pokemon(@0x5ef7)
local style=c_bg_styles[c_types[pkmn.type1].bg]
rectfill(0,0,39,39,style.bg)
if@0x5ef5==0 then
rectfill(0,32,39,39,style.aa)
pkmn.draw(20,20,style.aa,2,2)
elseif@0x5ef5==1 then
rectfill(0,16,39,39,style.aa)
pkmn.draw(20,10,style.aa,1)
rectfill(0,21,39,39,1)
rectfill(6,21,33,39,7)
print("a",1,22,13)print("h",36,22,13)
print("d",1,28,13)print("s",36,28,13)
print("*",1,34,13)print("t",36,34,13)
rectfill(19,20,20,39,1)
rectfill(0,20,39,20,1)
local total=pkmn.attack+pkmn.hp+pkmn.defence+pkmn.speed+pkmn.special
print(pkmn.attack,7,2+20,13)zprint(pkmn.hp,35,2+20,13,1)
print(pkmn.defence,7,8+20,13)zprint(pkmn.speed,35,8+20,13,1)
print(pkmn.special,7,14+20,13)zprint(total,35,14+20,13,1)
end
end,function(a)
zprint(get_pokemon(@0x5ef7).name,46/2,4,1,0)
end,function(a)
local pkmn=get_pokemon(@0x5ef7)
rectfill(0,0,46,6,1)
zprint(format_num(pkmn.num),23,1,13,0)
zprint(c_types[pkmn.type1].name,23,8,1,0)
if pkmn.type2 then
rectfill(0,14,46,20,1)
zprint(c_types[pkmn.type2].name,23,15,13,0)
end
end,function(a)
g_credits_offset=5
end,function(a)
if g_bpo then a:pop()end
if g_bu then g_credits_offset-=1/6 end
if g_bd then g_credits_offset+=1/6 end
g_credits_offset=g_credits_offset%#c_creditlist
end,function(a)
rectfill(0,0,39,39,1)
for i,txt in ipairs(c_creditlist)do
zprint(txt,20,(i-g_credits_offset)*6,13,0)
end
end,function(a)
local test={}
if g_bx then
for i=1,6 do add(test,{num=rnd(151)\1+1})end
save_party(@0x5ef4,test)
end
if g_bpo then a:pop()end
end,function(a)
for i,v in ipairs(get_party(@0x5ef4))do
get_pokemon(v.num).draw(7+(i-1)%3*13,20+(i-1)\3*13,13,.625)
end
end,function(a)
end,function(a)
print_draw3_message("editing","your","party")
end,function(a)
if g_bpx or g_bpo then a:pop()end
end,function(a)
rectfill(0,0,39,39,1)
zprint("no",20,12-2,13,0)
zprint("active",20,19-2,13,0)
zprint("party",20,26-2,13,0)
end,function(a)
end,function(a)
end,function(a)
if g_bpu then poke(0x5ef4,max(0,@0x5ef4-1))end
if g_bpd then poke(0x5ef4,min(2,@0x5ef4+1))end
if g_bpl then poke(0x5ef7,(@0x5ef7-1)%152)end
if g_bpr then poke(0x5ef7,(@0x5ef7+1)%152)end
if g_bpo then a:pop()end
if g_bpx then a:push"editparty" end
end,function(a)
draw_party_screen(@0x5ef4)
end,function(a)
zprint("party #"..@0x5ef4+1,46/2,4,1,0)
end,function(a)
print_draw3_message("select","your","party")
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
c_pokemon=zobj[[0;,missingno,10,10,15,0,33,136,0,29,6,43/1|12/1|1|2|3|5|6|9|10|11|13|14|17|19|20|25|26|27|29|30|44|45|49|50|51|52;1;,bulbasaur,69,7,4,7,45,49,49,45,65,88/1|79/1|105/7|70/13|108/20|107/27|106/34|110/41|22/48|3|6|8|9|10|20|21|31|32|33|34|44|50|51;2;,ivysaur,130,10,4,7,60,62,63,60,80,88/1|105/1|79/1|70/13|108/22|107/30|106/38|110/46|22/54|3|6|8|9|10|20|21|31|32|33|34|44|50|51;3;,venusaur,1000,20,4,7,80,82,83,80,100,88/1|105/1|79/1|70/1|108/22|107/30|106/43|110/55|22/65|3|6|8|9|10|15|20|21|31|32|33|34|44|50|51;4;,charmander,85,6,1,no,39,52,43,65,50,88/1|63/1|95/9|86/15|20/22|164/30|96/38|113/46|1|3|5|6|8|9|10|17|18|19|23|28|31|32|33|34|38|39|40|44|50|51|54;5;,charmeleon,190,11,1,no,58,64,58,80,65,95/1|88/1|63/1|86/15|20/24|164/33|96/42|113/56|1|3|5|6|8|9|10|17|18|19|23|28|31|32|33|34|38|39|40|44|50|51|54;6;,charizard,905,17,1,9,78,84,78,100,85,95/1|88/1|86/1|63/1|20/24|164/36|96/46|113/55|1|3|5|6|8|9|10|15|17|18|19|23|26|27|28|31|32|33|34|38|39|40|44|50|51|54;7;,squirtle,90,5,2,no,44,48,65,43,50,79/1|82/1|152/8|12/15|87/22|128/28|40/35|98/42|1|5|6|8|9|10|11|13|14|17|18|19|20|28|31|32|33|34|44|50|53|54;8;,wartortle,225,10,2,no,59,63,80,58,65,152/1|79/1|82/1|12/15|87/24|128/31|40/39|98/47|1|5|6|8|9|10|11|13|14|17|18|19|20|28|31|32|33|34|44|50|53|54;9;,blastoise,855,16,2,no,79,83,100,78,85,152/1|79/1|82/1|12/1|87/24|128/31|40/42|98/52|1|5|6|8|9|10|11|13|14|15|17|18|19|20|26|27|28|31|32|33|34|44|50|53|54;10;,caterpie,29,3,11,no,45,30,35,45,20,112/1|79/1;11;,metapod,99,7,11,no,50,20,55,30,25,124/1;12;,butterfree,320,11,11,9,60,45,50,70,80,116/1|108/15|109/16|110/17|91/21|4/26|99/32|2|6|9|10|15|20|21|22|29|30|31|32|33|34|39|44|46|50;13;,weedle,32,3,11,7,40,35,30,50,20,83/1|112/1;14;,kakuna,100,6,11,7,45,25,50,35,25,124/1;15;,beedrill,295,10,11,7,65,80,40,75,45,78/1|133/16|84/20|20/25|85/30|119/35|3|6|9|10|15|21|31|32|33|34|39|40|44|50|51;16;,pidgey,18,3,0,9,40,45,40,56,35,66/1|75/5|120/12|4/19|67/28|119/36|134/44|2|6|9|10|20|31|32|33|34|39|43|44|50|52;17;,pidgeotto,300,11,0,9,63,60,55,71,50,66/1|75/1|120/12|4/21|67/31|119/40|134/49|2|6|9|10|20|31|32|33|34|39|43|44|50|52;18;,pidgeot,395,15,0,9,83,80,75,91,70,66/1|120/1|75/1|4/21|67/31|119/44|134/54|2|6|9|10|15|20|31|32|33|34|39|43|44|50|52;19;,rattata,35,3,0,no,30,56,35,72,25,79/1|82/1|120/7|160/14|133/23|163/34|6|8|9|10|11|12|14|20|24|25|28|31|32|34|39|40|44|50;20;,raticate,185,7,0,no,55,81,60,97,50,120/1|79/1|82/1|160/14|133/27|163/41|6|8|9|10|11|12|13|14|15|20|24|25|28|31|32|34|39|40|44|50;21;,spearow,20,3,0,9,40,60,30,70,31,88/1|101/1|86/9|78/15|134/22|102/29|119/36|2|4|6|9|10|20|31|32|34|39|43|44|50|52;22;,fearow,380,12,0,9,65,90,65,100,61,88/1|86/1|101/1|78/15|134/25|102/34|119/43|2|4|6|9|10|15|20|31|32|34|39|43|44|50|52;23;,ekans,69,20,7,no,35,60,44,55,40,86/1|80/1|83/10|87/17|146/24|122/31|94/38|6|8|9|10|20|21|26|27|28|31|32|34|40|44|48|50|54;24;,arbok,650,35,7,no,60,85,69,80,65,86/1|83/1|80/1|87/17|146/27|122/36|94/47|6|8|9|10|15|20|21|26|27|28|31|32|34|40|44|48|50|54;25;,pikachu,60,4,3,no,35,55,30,90,50,88/1|114/1|45/9|120/16|39/26|119/33|25/43|1|5|6|8|9|10|16|17|19|20|24|31|32|33|34|40|44|50|53|55;26;,raichu,300,8,3,no,60,90,55,100,90,88/1|114/1|45/1|1|5|6|8|9|10|15|16|17|19|20|24|25|31|32|33|34|39|40|44|50|55;27;,sandshrew,120,6,8,no,50,75,85,40,30,63/1|75/10|164/17|83/24|39/31|158/38|3|6|8|9|10|17|19|20|26|27|28|31|32|34|40|44|48|50|51|54;28;,sandslash,295,10,8,no,75,100,110,65,55,75/1|63/1|164/17|83/27|39/36|158/47|3|6|8|9|10|15|17|19|20|26|27|28|31|32|34|40|44|48|50|51|54;29;,nidoran?,70,4,7,no,55,47,52,41,40,88/1|79/1|63/8|83/14|82/21|87/29|158/36|72/43|6|8|9|10|14|20|24|25|31|32|33|34|40|44|50;30;,nidorina,200,8,7,no,70,62,67,56,55,88/1|79/1|63/8|83/14|82/23|87/32|158/41|72/50|6|7|8|9|10|11|12|13|14|20|24|25|31|32|33|34|40|44|50;31;,nidoqueen,600,13,7,8,90,82,87,76,75,8/1|63/1|79/1|82/1|83/14|1|5|6|7|9|10|11|12|13|14|15|16|17|18|19|20|24|25|26|27|31|32|33|34|38|40|44|48|50|53|54;32;,nidoran!,90,5,7,no,46,57,40,50,40,86/1|79/1|77/8|83/14|133/21|78/29|7/36|72/43|6|8|9|10|14|20|24|25|31|32|33|34|40|44|50;33;,nidorino,195,9,7,no,61,72,57,65,55,77/1|86/1|79/1|83/14|133/23|78/32|7/41|72/50|6|8|9|10|11|12|13|14|20|24|25|31|32|33|34|40|44|50;34;,nidoking,620,14,7,8,81,92,77,85,75,77/1|83/1|79/1|81/1|1|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|24|25|26|27|31|32|33|34|38|40|44|48|50|53|54;35;,clefairy,75,6,0,no,70,45,48,35,60,88/1|56/1|90/13|58/18|125/24|35/31|129/39|131/48|1|5|6|8|9|10|11|12|13|14|17|18|19|20|22|24|25|29|30|31|32|33|34|38|40|44|45|46|49|50|54|55;36;,clefable,400,13,0,no,95,70,73,60,85,58/1|35/1|125/1|90/1|1|5|6|8|9|10|11|12|13|14|15|17|18|19|20|22|24|25|29|30|31|32|33|34|38|40|44|45|46|49|50|54|55;37;,vulpix,99,6,1,no,38,41,40,65,65,95/1|82/1|120/16|89/21|127/28|96/35|113/42|6|8|9|10|20|28|31|32|33|34|38|39|40|44|50;38;,ninetales,199,11,1,no,73,76,75,100,100,95/1|120/1|89/1|82/1|6|8|9|10|15|20|28|31|32|33|34|38|39|40|44|50;39;,jigglypuff,55,5,0,no,115,45,20,20,25,90/1|56/9|93/14|129/19|58/24|44/29|8/34|10/39|1|5|6|9|11|12|13|14|17|18|19|20|22|24|25|29|30|31|32|33|34|38|40|45|46|49|50|54|55;40;,wigglytuff,120,10,0,no,140,70,45,45,50,129/1|93/1|58/1|90/1|1|5|6|8|9|10|11|12|13|14|15|17|18|19|20|22|24|25|29|30|31|32|33|34|38|40|44|45|46|49|50|54|55;41;,zubat,75,8,7,9,40,45,35,55,40,149/1|91/10|87/15|127/21|67/28|132/36|2|4|6|9|10|20|21|31|32|34|39|44|50;42;,golbat,550,16,7,9,75,80,70,90,75,87/1|149/1|122/1|91/10|127/21|67/32|132/43|2|4|6|9|10|15|20|21|31|32|34|39|44|50;43;,oddish,54,5,4,7,45,50,55,30,75,104/1|108/15|109/17|110/19|94/24|111/33|22/46|3|6|9|10|20|21|31|32|33|34|44|50|51;44;,gloom,86,8,4,7,60,65,70,40,85,104/1|108/1|109/1|110/19|94/28|111/38|22/52|3|6|9|10|20|21|31|32|33|34|44|50|51;45;,vileplume,186,12,4,7,75,80,85,50,100,94/1|111/1|110/1|109/1|108/15|3|6|8|9|10|15|20|21|22|31|32|33|34|44|50|51;46;,paras,54,3,11,4,35,70,55,25,55,63/1|109/13|149/20|154/27|164/34|106/41|3|6|8|9|10|20|21|22|28|31|32|33|34|40|44|50|51;47;,parasect,295,10,11,4,60,95,80,30,80,149/1|63/1|109/1|154/30|164/39|106/48|3|6|8|9|10|15|20|21|22|28|31|32|33|34|40|44|50|51;48;,venonat,300,10,11,7,60,55,50,45,40,93/1|79/1|108/24|149/27|109/30|99/35|110/38|29/43|6|9|10|20|21|22|31|32|33|34|44|46|50;49;,venomoth,125,15,11,7,70,65,60,90,90,93/1|149/1|108/1|79/1|109/30|99/38|110/43|29/50|2|4|6|9|10|15|20|21|22|30|31|32|33|34|39|44|46|50;50;,diglett,8,2,8,no,10,55,25,95,45,63/1|88/15|28/19|75/24|164/31|26/40|6|8|9|10|20|27|31|32|34|44|48|50;51;,dugtrio,333,7,8,no,35,80,50,120,70,28/1|88/1|63/1|75/24|164/35|26/47|6|8|9|10|15|20|27|31|32|34|44|48|50;52;,meowth,42,4,0,no,40,45,35,90,40,88/1|63/1|87/12|16/17|122/24|158/33|164/44|6|8|9|10|11|12|20|24|25|31|32|34|39|40|44|50;53;,persian,320,10,0,no,65,70,60,115,65,87/1|88/1|63/1|122/1|16/17|158/37|164/51|6|8|9|10|11|12|15|20|24|25|31|32|34|39|40|44|50;54;,psyduck,196,8,2,no,50,52,48,55,50,63/1|82/28|93/31|116/36|158/43|98/52|1|5|6|8|9|10|11|12|13|14|16|17|18|19|20|28|31|32|34|39|40|44|50|53|54;55;,golduck,766,17,2,no,80,82,78,85,80,93/1|63/1|82/1|116/39|158/48|98/59|1|5|6|8|9|10|11|12|13|14|15|16|17|18|19|20|28|31|32|34|39|40|44|50|53|54;56;,mankey,280,5,6,no,40,80,35,70,35,86/1|63/1|57/15|158/21|133/27|19/33|81/39|1|5|6|8|9|10|16|17|18|20|24|25|28|31|32|34|35|39|40|44|48|50|54;57;,primeape,320,10,6,no,65,105,60,95,60,158/1|57/1|86/1|63/1|133/27|19/37|81/46|1|5|6|8|9|10|15|16|17|18|20|24|25|28|31|32|34|35|39|40|44|48|50|54;58;,growlithe,190,7,1,no,55,70,45,60,50,87/1|89/1|95/18|86/23|9/30|119/39|96/50|6|8|10|20|23|28|31|32|33|34|38|39|40|44|50;59;,arcanine,1550,19,1,no,90,110,80,95,80,95/1|86/1|89/1|9/1|6|8|10|15|20|23|28|30|31|32|33|34|38|39|40|44|50;60;,poliwag,124,6,2,no,40,50,40,90,40,152/1|117/16|12/19|58/25|8/31|143/38|98/45|6|9|10|11|13|14|20|29|31|32|34|40|44|46|50|53;61;,poliwhirl,200,10,2,no,65,65,65,90,50,152/1|117/1|12/1|58/26|8/33|143/41|98/49|1|5|6|9|10|11|13|14|17|18|19|20|26|27|29|31|32|34|35|40|44|46|50|53|54;62;,poliwrath,540,13,2,6,90,85,95,70,70,8/1|58/1|117/1|12/1|1|5|6|9|10|11|13|14|15|17|18|19|20|26|27|29|31|32|34|35|40|44|46|50|53|54;63;,abra,195,9,10,no,25,20,15,90,105,30/1|1|5|6|8|9|10|17|18|19|20|29|31|32|33|34|35|40|44|45|46|49|50|55;64;,kadabra,565,13,10,no,40,35,30,105,120,116/1|93/1|30/1|99/27|123/31|29/38|33/42|1|5|6|8|9|10|17|18|19|20|28|31|32|34|35|40|44|45|46|49|50|55;65;,alakazam,480,15,10,no,55,50,45,120,135,116/1|93/1|30/1|99/27|123/31|29/38|33/42|1|5|6|8|9|10|15|17|18|19|20|28|31|32|34|35|40|44|45|46|49|50|55;66;,machop,195,8,6,no,70,80,50,35,35,57/1|103/20|86/25|133/32|19/39|17/46|1|5|6|8|9|10|18|20|26|27|28|31|32|34|35|38|40|44|48|50|54;67;,machoke,705,15,6,no,80,100,70,45,50,57/1|86/1|103/1|133/36|19/44|17/52|1|5|6|8|9|10|18|20|26|27|28|31|32|34|35|38|40|44|48|50|54;68;,machamp,1300,16,6,no,90,130,80,55,65,57/1|86/1|103/1|133/36|19/44|17/52|1|5|6|8|9|10|15|18|20|26|27|28|31|32|34|35|38|40|44|48|50|54;69;,bellsprout,40,7,4,7,50,75,35,40,70,106/1|70/1|80/13|108/15|110/18|109/21|94/26|107/33|69/42|3|6|9|10|20|21|22|31|32|33|34|44|50|51;70;,weepinbell,64,10,4,7,65,90,50,55,85,106/1|70/1|80/1|108/15|110/18|109/23|94/29|107/38|69/49|3|6|9|10|20|21|22|31|32|33|34|44|50|51;71;,victreebel,155,17,4,7,80,105,65,70,100,94/1|107/1|110/1|109/1|80/13|108/15|3|6|8|9|10|15|20|21|22|31|32|33|34|44|50|51;72;,tentacool,455,9,2,7,40,40,35,70,100,94/1|91/7|80/13|83/18|12/22|142/27|130/33|122/40|98/48|3|6|9|10|11|13|14|20|21|31|32|33|34|40|44|50|51|53;73;,tentacruel,550,16,2,7,80,70,65,100,120,94/1|91/1|80/1|83/18|12/22|142/27|130/35|122/43|98/50|3|6|9|10|11|13|14|15|20|21|31|32|33|34|40|44|50|51|53;74;,geodude,200,4,12,8,40,80,100,20,30,79/1|129/11|115/16|36/21|124/26|26/31|47/36|1|6|8|9|10|17|18|19|20|27|28|31|32|34|35|38|44|48|50|54;75;,graveler,1050,10,12,8,55,95,115,35,45,129/1|79/1|115/16|36/21|124/29|26/36|47/43|1|6|8|9|10|17|18|19|20|27|28|31|32|34|35|38|44|48|50|54;76;,golem,3000,14,12,8,80,110,130,45,55,129/1|79/1|115/16|36/21|124/29|26/36|47/43|1|5|6|8|9|10|15|17|18|19|20|27|28|31|32|34|35|38|44|48|50|54;77;,ponyta,300,10,1,no,50,85,55,90,65,95/1|82/30|71/32|88/35|113/39|9/43|119/48|6|7|8|10|20|31|32|33|34|38|39|40|44|50;78;,rapidash,950,17,1,no,65,100,70,105,80,95/1|88/1|71/1|82/1|113/39|9/47|119/55|6|7|8|10|15|20|31|32|33|34|38|39|40|44|50;79;,slowpoke,360,12,2,10,90,65,65,15,40,116/1|93/18|76/22|88/27|12/33|143/40|29/48|6|8|9|10|11|13|14|16|20|26|27|28|30|31|32|33|34|38|39|40|44|45|46|49|50|53|54|55;80;,slowbro,785,16,2,10,95,75,110,30,80,116/1|93/1|76/1|88/27|12/33|128/37|143/44|29/55|1|5|6|8|9|10|11|13|14|15|16|17|18|19|20|26|27|28|30|31|32|33|34|38|39|40|44|45|46|49|50|53|54|55;81;,magnemite,60,3,3,no,25,35,70,45,95,79/1|92/21|114/25|91/29|45/35|39/41|122/47|6|9|10|20|24|25|30|31|32|33|34|44|50|55;82;,magneton,600,10,3,no,50,60,95,70,120,92/1|79/1|114/1|91/29|45/38|39/46|122/54|6|9|10|15|20|24|25|30|31|32|33|34|44|50|55;83;,farfetchd,150,8,0,9,52,65,55,60,58,101/1|75/1|86/7|78/15|3/23|119/31|164/39|2|4|6|8|9|10|20|31|32|33|34|39|40|44|50|51|52;84;,doduo,392,14,0,9,35,85,45,75,35,101/1|88/20|78/24|102/30|20/36|49/40|119/44|4|6|8|9|10|31|32|33|34|40|43|44|50|52;85;,dodrio,852,18,0,9,60,110,70,100,60,78/1|88/1|101/1|102/30|20/39|49/45|119/51|4|6|8|9|10|15|31|32|33|34|40|43|44|50|52;86;,seel,900,11,2,no,65,45,55,45,70,76/1|88/30|100/35|44/40|9/45|13/50|6|7|8|10|11|12|14|16|20|31|32|34|40|50|53|54;87;,dewgong,1200,17,2,5,90,70,80,70,95,100/1|88/1|76/1|44/44|9/50|13/56|6|7|8|10|11|12|14|15|16|20|31|32|34|40|50|53|54;88;,grimer,300,9,7,no,80,80,50,25,40,93/1|56/1|147/30|125/33|137/37|124/42|122/48|156/55|6|8|20|21|24|25|31|32|34|36|38|44|47|50;89;,muk,300,12,7,no,105,105,75,50,65,93/1|147/1|56/1|125/33|137/37|124/45|122/53|156/60|6|8|15|20|21|24|25|31|32|34|36|38|44|47|50;90;,shellder,40,3,2,no,30,65,100,40,45,79/1|128/1|91/18|140/23|100/30|86/39|13/50|6|9|10|11|12|14|20|30|31|32|33|34|36|39|44|47|49|50|53;91;,cloyster,1325,15,2,5,50,95,180,70,85,100/1|140/1|91/1|128/1|141/50|6|9|10|11|12|13|14|15|20|30|31|32|33|34|36|39|44|47|49|50|53;92;,gastly,1,13,13,7,30,35,30,80,100,127/1|135/1|121/1|117/27|42/35|6|20|21|24|25|29|31|32|34|36|44|46|47|50;93;,haunter,1,16,13,7,45,50,45,95,115,127/1|135/1|121/1|117/29|42/38|6|20|21|24|25|29|31|32|34|36|44|46|47|50;94;,gengar,405,15,13,7,60,65,60,110,130,127/1|135/1|121/1|117/29|42/38|1|5|6|8|9|10|15|17|18|19|20|21|24|25|29|31|32|34|35|36|40|44|46|47|50|54;95;,onix,2100,88,12,8,35,45,160,70,30,122/1|79/1|68/15|115/19|20/25|69/33|124/43|6|8|9|10|26|27|28|31|32|34|36|40|44|47|48|50|54;96;,drowzee,324,10,10,no,60,48,45,42,90,117/1|56/1|93/12|116/17|76/24|147/29|29/32|118/37|1|5|6|8|9|10|17|18|19|20|30|31|32|33|34|35|40|42|44|45|46|49|50|55;97;,hypno,756,16,10,no,85,73,70,67,115,116/1|93/1|117/1|56/1|76/24|147/33|29/37|118/43|1|5|6|8|9|10|15|17|18|19|20|30|31|32|33|34|35|40|42|44|45|46|49|50|55;98;,krabby,65,4,2,no,30,105,90,50,25,152/1|86/1|64/20|65/25|71/30|157/35|124/40|3|6|8|9|10|11|12|13|14|20|31|32|34|44|50|51|53|54;99;,kingler,600,13,2,no,55,130,115,75,50,152/1|86/1|64/1|65/25|71/34|157/42|124/49|3|6|8|9|10|11|12|13|14|15|20|31|32|34|44|50|51|53|54;100;,voltorb,104,5,3,no,40,30,50,100,55,122/1|79/1|92/17|36/22|131/29|39/36|47/43|6|9|20|24|25|30|31|32|33|34|44|45|50|55;101;,electrode,666,12,3,no,60,50,70,140,80,122/1|92/1|79/1|36/22|131/29|39/40|47/50|6|9|15|20|24|25|30|31|32|33|34|40|44|45|50|55;102;,exeggcute,25,4,4,10,60,40,80,40,60,148/1|117/1|33/25|105/28|109/32|108/37|22/42|110/48|6|9|10|20|29|30|31|32|34|36|37|44|46|47|50;103;,exeggutor,1200,20,4,10,95,95,85,55,125,148/1|117/1|71/28|6|9|10|15|20|21|22|29|30|31|32|33|34|36|37|44|46|47|50|54;104;,cubone,65,4,8,no,50,50,95,35,40,138/1|88/1|86/25|133/31|81/38|159/43|20/46|1|5|6|8|9|10|11|12|13|14|17|18|19|26|27|28|31|32|34|38|40|44|50|54;105;,marowak,450,10,8,no,60,80,110,45,50,138/1|133/1|88/1|86/1|81/41|159/48|20/55|1|5|6|8|9|10|11|12|13|14|15|17|18|19|26|27|28|31|32|34|38|40|44|50|54;106;,hitmonlee,498,15,6,no,50,120,53,87,35,72/1|118/1|74/33|73/38|133/43|145/48|5/53|1|6|8|9|10|17|18|19|20|31|32|34|35|39|40|44|50|54;107;,hitmonchan,502,14,6,no,50,105,79,76,35,119/1|59/1|60/33|61/38|62/43|1/48|18/53|5|6|8|9|10|17|19|20|31|32|34|35|39|40|44|50|54;108;,lickitung,655,12,0,no,90,55,75,30,60,91/1|80/1|71/7|93/15|129/23|69/31|122/39|1|3|5|6|8|9|10|11|12|13|14|15|17|18|19|20|24|25|26|27|31|32|34|38|40|44|50|51|53|54;109;,koffing,10,6,7,no,40,65,95,35,60,136/1|79/1|137/32|126/37|36/40|132/45|47/48|6|20|24|25|31|32|34|38|44|50;110;,weezing,95,12,7,no,65,90,120,60,85,137/1|136/1|79/1|126/39|36/43|132/49|47/53|6|15|20|24|25|31|32|34|38|44|50;111;,rhyhorn,1150,10,8,12,80,85,95,25,30,77/1|71/30|82/35|78/40|7/45|86/50|9/55|6|8|10|20|24|25|26|27|28|31|32|34|38|40|44|48|50|54;112;,rhydon,1200,19,8,12,105,130,120,40,45,78/1|77/1|71/1|82/1|7/48|86/55|9/64|1|5|6|8|10|11|12|13|14|15|16|17|18|19|20|24|25|26|27|28|31|32|34|38|40|44|48|50|53|54;113;,chansey,346,11,0,no,250,5,5,50,105,58/1|56/1|90/24|88/30|125/38|129/44|131/48|10/54|1|5|6|8|9|11|12|13|14|15|17|18|19|20|22|24|25|29|30|31|32|33|34|35|37|38|40|41|44|45|46|49|50|54|55;114;,tangela,350,10,4,no,65,55,115,60,100,68/1|142/1|104/29|108/32|109/36|110/39|69/45|106/49|3|6|8|9|10|15|20|21|22|31|32|34|40|44|50|51;115;,kangaskhan,800,22,0,no,105,95,80,90,40,59/1|20/1|87/26|82/31|1/36|86/41|153/46|5|6|8|9|10|11|12|13|14|15|17|18|19|24|25|26|27|31|32|34|38|40|44|48|50|53|54;116;,horsea,80,4,2,no,30,40,70,60,70,152/1|126/19|86/24|12/30|119/37|98/45|6|9|10|11|13|14|20|31|32|34|39|40|44|50|53;117;,seadra,250,12,2,no,55,65,95,85,95,152/1|126/1|86/24|12/30|119/41|98/52|6|9|10|11|13|14|15|20|31|32|34|39|40|44|50|53;118;,goldeen,150,6,2,no,45,67,60,63,50,101/1|82/1|91/19|77/24|78/30|139/37|7/45|119/54|6|9|10|11|12|13|14|20|31|32|34|39|40|44|50|53;119;,seaking,390,13,2,no,80,92,65,68,80,101/1|91/1|82/1|77/24|78/30|139/39|7/48|119/54|6|9|10|11|12|13|14|15|20|31|32|34|39|40|44|50|53;120;,staryu,345,8,2,no,30,45,55,85,70,79/1|12/17|124/22|123/27|39/32|125/37|131/42|98/47|6|9|10|11|13|14|20|24|25|29|30|31|32|33|34|40|44|45|46|49|50|53|55;121;,starmie,800,11,2,10,60,75,85,115,100,124/1|79/1|12/1|6|9|10|11|13|14|15|20|24|25|29|30|31|32|33|34|39|40|44|45|46|49|50|53|55;122;,mr mime,545,13,10,no,40,45,65,90,100,130/1|116/1|131/23|58/31|118/39|50/47|1|5|6|8|9|10|15|17|18|19|20|22|24|25|29|30|31|32|33|34|35|40|44|45|46|55;123;,scyther,560,15,11,9,70,110,80,105,55,120/1|86/17|133/20|32/24|164/29|3/35|119/42|6|9|10|15|20|31|34|39|40|44|50|51;124;,jynx,406,14,5,10,65,50,35,95,95,150/1|56/1|135/18|58/23|61/31|8/39|81/47|14/58|1|5|6|9|10|11|12|13|15|17|18|19|20|29|30|31|32|33|34|35|40|44|46|50;125;,electabuzz,300,11,3,no,65,83,57,105,85,86/1|120/1|114/34|122/37|62/42|131/49|25/54|1|5|6|8|9|10|15|17|18|19|20|24|29|30|31|32|33|34|35|39|40|44|45|46|50|54|55;126;,magmar,445,13,1,no,65,95,57,93,85,95/1|86/36|127/39|60/43|126/48|136/52|96/55|1|5|6|8|9|10|15|17|18|19|20|29|30|31|32|34|35|38|40|44|46|50|54;127;,pinsir,550,15,11,no,65,125,100,85,55,64/1|19/25|65/30|133/36|124/43|164/49|3/54|6|8|9|10|15|17|20|31|32|34|44|50|51|54;128;,tauros,884,14,0,no,75,100,95,110,70,79/1|71/21|82/28|86/35|20/44|9/51|6|7|8|10|13|14|15|24|25|26|27|31|32|34|38|40|44|50|54;129;,magikarp,100,9,2,no,20,10,55,80,20,155/1|79/15;130;,gyarados,2350,65,2,9,95,125,79,81,100,87/1|23/1|98/1|86/1|15/52|6|8|9|10|11|12|13|14|20|24|25|31|32|33|34|38|40|44|50|53|54;131;,lapras,2200,25,2,5,130,85,80,60,95,88/1|12/1|90/16|97/20|8/25|127/31|13/38|98/46|6|7|9|10|11|14|15|20|22|23|24|25|29|31|32|33|34|40|44|46|50|53|54;132;,ditto,40,3,0,no,48,48,48,48,48,151/1;133;,eevee,65,3,0,no,55,55,50,55,65,75/1|79/1|120/27|82/31|87/37|9/45|6|8|10|20|31|32|33|34|39|40|44|50;134;,vaporeon,290,10,2,no,130,65,60,65,110,120/1|75/1|79/1|12/1|82/37|87/40|156/42|132/44|97/48|98/54|6|8|9|10|11|13|14|15|20|31|32|33|34|39|40|44|50|53;135;,jolteon,245,8,3,no,65,65,60,130,110,120/1|75/1|79/1|114/1|82/37|45/40|72/42|119/44|85/48|25/54|6|8|9|10|15|20|24|31|32|33|34|39|40|44|50|55;136;,flareon,250,9,1,no,65,130,60,65,110,95/1|120/1|75/1|79/1|82/37|87/40|86/42|113/44|20/48|96/54|6|8|9|10|15|31|32|33|34|38|39|40|44|50;137;,porygon,365,8,0,no,65,60,70,40,75,162/1|161/1|79/1|99/23|123/28|119/35|49/42|6|9|10|13|14|15|20|24|25|29|30|31|32|33|34|39|40|44|45|46|50|55;138;,omanyte,75,4,12,2,35,40,100,35,90,12/1|128/1|77/34|86/39|141/46|98/53|6|8|9|10|11|13|14|20|31|32|33|34|44|50|53;139;,omastar,350,10,12,2,70,60,125,55,115,77/1|12/1|128/1|86/39|141/44|98/49|6|7|8|9|10|11|13|14|15|17|19|20|31|32|33|34|40|44|50|53;140;,kabuto,115,5,12,2,30,80,90,55,45,124/1|63/1|104/34|164/39|86/44|98/49|6|8|9|10|11|12|13|14|20|31|32|33|34|44|50|53;141;,kabutops,405,13,12,2,60,115,105,80,70,104/1|124/1|63/1|164/39|86/46|98/53|2|3|5|6|8|9|10|11|12|13|14|15|17|19|20|31|32|33|34|40|44|50|53;142;,aerodactyl,590,18,12,9,80,105,65,130,60,119/1|67/1|91/33|87/38|9/45|15/54|2|4|6|10|20|23|31|32|33|34|38|39|43|44|50|52;143;,snorlax,4600,21,0,no,160,110,65,30,65,143/1|76/1|44/1|8/35|124/41|10/48|15/56|1|5|6|9|11|12|13|14|16|17|18|19|20|22|24|25|26|27|29|31|32|33|34|35|36|38|40|46|48|50|53|54;144;,articuno,554,17,5,9,90,85,100,85,125,13/1|101/1|14/51|119/55|97/60|2|4|6|9|10|11|12|15|20|31|32|33|34|39|43|44|50|52;145;,zapdos,526,16,3,9,90,90,85,100,125,102/1|114/1|25/51|119/55|131/60|2|4|6|9|10|15|20|24|31|32|33|34|39|43|44|45|50|52|55;146;,moltres,600,20,1,9,90,100,90,90,125,113/1|101/1|86/51|119/55|43/60|2|4|6|9|10|15|20|31|32|33|34|38|39|44|50|52;147;,dratini,33,18,14,no,41,64,45,50,50,86/1|80/1|45/10|119/20|69/30|23/40|15/50|6|8|9|10|11|12|13|14|20|24|25|31|32|33|34|38|39|40|44|50|53;148;,dragonair,165,40,14,no,61,84,65,70,70,86/1|45/1|80/1|119/20|69/35|23/45|15/55|6|7|8|9|10|11|12|13|14|20|24|25|31|32|33|34|38|39|40|44|50|53;149;,dragonite,2100,22,14,9,91,134,95,80,100,119/1|86/1|45/1|80/1|69/35|23/45|15/60|2|6|7|8|9|10|11|12|13|14|20|24|25|31|32|33|34|38|39|40|44|50|53|54;150;,mewtwo,1220,20,10,no,106,110,90,130,154,116/1|93/1|29/1|39/1|130/63|123/70|97/75|143/81|1|5|6|8|9|10|11|12|13|14|15|16|17|18|19|20|22|24|25|30|31|32|33|34|35|36|38|40|44|45|46|49|50|54|55;151;,mew,40,4,10,no,100,100,100,100,100,56/1|151/10|1/20|35/30|29/40|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|30|31|32|33|34|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55;]]
c_types=zobj[[0;bg,0,name,normal,0;good;,;0;null;,13;0;weak;,12;1;bg,5,name,fire,1;good;,4,5,11;1;null;,;1;weak;,1,2,12,14;2;bg,4,name,water,2;good;,1,8,12;2;null;,;2;weak;,14,4,2;3;bg,6,name,electric,3;good;,9,2;3;null;,8;3;weak;,14,3,4;4;bg,3,name,grass,4;good;,8,12,2;4;null;,;4;weak;,11,14,1,9,4,7;5;bg,4,name,ice,5;good;,14,9,4;5;null;,;5;weak;,1,5,2;6;bg,2,name,fighting,6;good;,5,0,12;6;null;,13;6;weak;,11,9,7,10;7;bg,1,name,poison,7;good;,11,4;7;null;,;7;weak;,13,8,7,12;8;bg,2,name,ground,8;good;,3,1,7,12;8;null;,9;8;weak;,11,4;9;bg,0,name,flying,9;good;,11,6,4;9;null;,;9;weak;,3,12;10;bg,1,name,psychic,10;good;,6,7;10;null;,;10;weak;,10;11;bg,3,name,bug,11;good;,4,10;11;null;,;11;weak;,6,1,9,13,7;12;bg,0,name,rock,12;good;,11,1,9,5;12;null;,;12;weak;,6,8;13;bg,1,name,ghost,13;good;,13;13;null;,0,10;13;weak;,;14;bg,0,name,dragon,14;good;,14;14;null;,;14;weak;,;15;bg,0,name,bird,15;good;,;15;null;,;15;weak;,;]]
c_bg_styles=zobj[[0;bg,6,aa,13;1;bg,13,aa,5;2;bg,9,aa,4;3;bg,11,aa,3;4;bg,12,aa,5;5;bg,8,aa,2;6;bg,10,aa,4;]]
c_zmovetype=zobj[[0;name,status;1;name,physical;2;name,special;]]
c_moves=zobj[[0;name,struggle,t,0,z,1,p,-,d,50,a,—;1;name,mega-punch,t,0,z,1,p,20,d,80,a,.85;2;name,razor-wind,t,0,z,2,p,10,d,80,a,1;3;name,swords-dance,t,0,z,0,p,20,d,—,a,—;4;name,whirlwind,t,0,z,0,p,20,d,—,a,—;5;name,mega-kick,t,0,z,1,p,5,d,120,a,.75;6;name,toxic,t,7,z,0,p,10,d,—,a,.9;7;name,horn-drill,t,0,z,1,p,5,d,—,a,.3;8;name,body-slam,t,0,z,1,p,15,d,85,a,1;9;name,take-down,t,0,z,1,p,20,d,90,a,.85;10;name,double-edge,t,0,z,1,p,15,d,120,a,1;11;name,bubble-beam,t,2,z,2,p,20,d,65,a,1;12;name,water-gun,t,2,z,2,p,25,d,40,a,1;13;name,ice-beam,t,5,z,2,p,10,d,90,a,1;14;name,blizzard,t,5,z,2,p,5,d,110,a,.7;15;name,hyper-beam,t,0,z,2,p,5,d,150,a,.9;16;name,pay-day,t,0,z,1,p,20,d,40,a,1;17;name,submission,t,6,z,1,p,20,d,80,a,.8;18;name,counter,t,6,z,1,p,20,d,—,a,1;19;name,seismic-toss,t,6,z,1,p,20,d,—,a,1;20;name,rage,t,0,z,1,p,20,d,20,a,1;21;name,mega-drain,t,4,z,2,p,15,d,40,a,1;22;name,solar-beam,t,4,z,2,p,10,d,120,a,1;23;name,dragon-rage,t,14,z,2,p,10,d,—,a,1;24;name,thunderbolt,t,3,z,2,p,15,d,90,a,1;25;name,thunder,t,3,z,2,p,10,d,110,a,.7;26;name,earthquake,t,8,z,1,p,10,d,100,a,1;27;name,fissure,t,8,z,1,p,5,d,—,a,.3;28;name,dig,t,8,z,1,p,10,d,80,a,1;29;name,psychic,t,10,z,2,p,10,d,90,a,1;30;name,teleport,t,10,z,0,p,20,d,—,a,—;31;name,mimic,t,0,z,0,p,10,d,—,a,—;32;name,double-team,t,0,z,0,p,15,d,—,a,—;33;name,reflect,t,10,z,0,p,20,d,—,a,—;34;name,bide,t,0,z,1,p,10,d,—,a,—;35;name,metronome,t,0,z,0,p,10,d,—,a,—;36;name,self-destruct,t,0,z,1,p,5,d,200,a,1;37;name,egg-bomb,t,0,z,1,p,10,d,100,a,.75;38;name,fire-blast,t,1,z,2,p,5,d,110,a,.85;39;name,swift,t,0,z,2,p,20,d,60,a,—;40;name,skull-bash,t,0,z,1,p,10,d,130,a,1;41;name,soft-boiled,t,0,z,0,p,5,d,—,a,—;42;name,dream-eater,t,10,z,2,p,15,d,100,a,1;43;name,sky-attack,t,9,z,1,p,5,d,140,a,.9;44;name,rest,t,10,z,0,p,5,d,—,a,—;45;name,thunder-wave,t,3,z,0,p,20,d,—,a,.9;46;name,psywave,t,10,z,2,p,15,d,—,a,1;47;name,explosion,t,0,z,1,p,5,d,250,a,1;48;name,rock-slide,t,12,z,1,p,10,d,75,a,.9;49;name,tri-attack,t,0,z,2,p,10,d,80,a,1;50;name,substitute,t,0,z,0,p,10,d,—,a,—;51;name,cut,t,0,z,1,p,30,d,50,a,.95;52;name,fly,t,9,z,1,p,15,d,90,a,.95;53;name,surf,t,2,z,2,p,15,d,90,a,1;54;name,strength,t,0,z,1,p,15,d,80,a,1;55;name,flash,t,0,z,0,p,20,d,—,a,1;56;name,pound,t,0,z,1,p,35,d,40,a,1;57;name,karate-chop,t,6,z,1,p,25,d,50,a,1;58;name,double-slap,t,0,z,1,p,10,d,15,a,.85;59;name,comet-punch,t,0,z,1,p,15,d,18,a,.85;60;name,fire-punch,t,1,z,1,p,15,d,75,a,1;61;name,ice-punch,t,5,z,1,p,15,d,75,a,1;62;name,thunder-punch,t,3,z,1,p,15,d,75,a,1;63;name,scratch,t,0,z,1,p,35,d,40,a,1;64;name,vice-grip,t,0,z,1,p,30,d,55,a,1;65;name,guillotine,t,0,z,1,p,5,d,—,a,.3;66;name,gust,t,9,z,2,p,35,d,40,a,1;67;name,wing-attack,t,9,z,1,p,35,d,60,a,1;68;name,bind,t,0,z,1,p,20,d,15,a,.85;69;name,slam,t,0,z,1,p,20,d,80,a,.75;70;name,vine-whip,t,4,z,1,p,25,d,45,a,1;71;name,stomp,t,0,z,1,p,20,d,65,a,1;72;name,double-kick,t,6,z,1,p,30,d,30,a,1;73;name,jump-kick,t,6,z,1,p,10,d,100,a,.95;74;name,rolling-kick,t,6,z,1,p,15,d,60,a,.85;75;name,sand-attack,t,8,z,0,p,15,d,—,a,1;76;name,headbutt,t,0,z,1,p,15,d,70,a,1;77;name,horn-attack,t,0,z,1,p,25,d,65,a,1;78;name,fury-attack,t,0,z,1,p,20,d,15,a,.85;79;name,tackle,t,0,z,1,p,35,d,40,a,1;80;name,wrap,t,0,z,1,p,20,d,15,a,.9;81;name,thrash,t,0,z,1,p,10,d,120,a,1;82;name,tail-whip,t,0,z,0,p,30,d,—,a,1;83;name,poison-sting,t,7,z,1,p,35,d,15,a,1;84;name,twineedle,t,11,z,1,p,20,d,25,a,1;85;name,pin-missile,t,11,z,1,p,20,d,25,a,.95;86;name,leer,t,0,z,0,p,30,d,—,a,1;87;name,bite,t,0,z,1,p,25,d,60,a,1;88;name,growl,t,0,z,0,p,40,d,—,a,1;89;name,roar,t,0,z,0,p,20,d,—,a,—;90;name,sing,t,0,z,0,p,15,d,—,a,.55;91;name,supersonic,t,0,z,0,p,20,d,—,a,.55;92;name,sonic-boom,t,0,z,2,p,20,d,—,a,.9;93;name,disable,t,0,z,0,p,20,d,—,a,1;94;name,acid,t,7,z,2,p,30,d,40,a,1;95;name,ember,t,1,z,2,p,25,d,40,a,1;96;name,flamethrower,t,1,z,2,p,15,d,90,a,1;97;name,mist,t,5,z,0,p,30,d,—,a,—;98;name,hydro-pump,t,2,z,2,p,5,d,110,a,.8;99;name,psybeam,t,10,z,2,p,20,d,65,a,1;100;name,aurora-beam,t,5,z,2,p,20,d,65,a,1;101;name,peck,t,9,z,1,p,35,d,35,a,1;102;name,drill-peck,t,9,z,1,p,20,d,80,a,1;103;name,low-kick,t,6,z,1,p,20,d,—,a,1;104;name,absorb,t,4,z,2,p,25,d,20,a,1;105;name,leech-seed,t,4,z,0,p,10,d,—,a,.9;106;name,growth,t,0,z,0,p,20,d,—,a,—;107;name,razor-leaf,t,4,z,1,p,25,d,55,a,.95;108;name,poison-powder,t,7,z,0,p,35,d,—,a,.75;109;name,stun-spore,t,4,z,0,p,30,d,—,a,.75;110;name,sleep-powder,t,4,z,0,p,15,d,—,a,.75;111;name,petal-dance,t,4,z,2,p,10,d,120,a,1;112;name,string-shot,t,11,z,0,p,40,d,—,a,.95;113;name,fire-spin,t,1,z,2,p,15,d,35,a,.85;114;name,thunder-shock,t,3,z,2,p,30,d,40,a,1;115;name,rock-throw,t,12,z,1,p,15,d,50,a,.9;116;name,confusion,t,10,z,2,p,25,d,50,a,1;117;name,hypnosis,t,10,z,0,p,20,d,—,a,.6;118;name,meditate,t,10,z,0,p,40,d,—,a,—;119;name,agility,t,10,z,0,p,30,d,—,a,—;120;name,quick-attack,t,0,z,1,p,30,d,40,a,1;121;name,night-shade,t,13,z,2,p,15,d,—,a,1;122;name,screech,t,0,z,0,p,40,d,—,a,.85;123;name,recover,t,0,z,0,p,5,d,—,a,—;124;name,harden,t,0,z,0,p,30,d,—,a,—;125;name,minimize,t,0,z,0,p,10,d,—,a,—;126;name,smokescreen,t,0,z,0,p,20,d,—,a,1;127;name,confuse-ray,t,13,z,0,p,10,d,—,a,1;128;name,withdraw,t,2,z,0,p,40,d,—,a,—;129;name,defense-curl,t,0,z,0,p,40,d,—,a,—;130;name,barrier,t,10,z,0,p,20,d,—,a,—;131;name,light-screen,t,10,z,0,p,30,d,—,a,—;132;name,haze,t,5,z,0,p,30,d,—,a,—;133;name,focus-energy,t,0,z,0,p,30,d,—,a,—;134;name,mirror-move,t,9,z,0,p,20,d,—,a,—;135;name,lick,t,13,z,1,p,30,d,30,a,1;136;name,smog,t,7,z,2,p,20,d,30,a,.7;137;name,sludge,t,7,z,2,p,20,d,65,a,1;138;name,bone-club,t,8,z,1,p,20,d,65,a,.85;139;name,waterfall,t,2,z,1,p,15,d,80,a,1;140;name,clamp,t,2,z,1,p,15,d,35,a,.85;141;name,spike-cannon,t,0,z,1,p,15,d,20,a,1;142;name,constrict,t,0,z,1,p,35,d,10,a,1;143;name,amnesia,t,10,z,0,p,20,d,—,a,—;144;name,kinesis,t,10,z,0,p,15,d,—,a,.8;145;name,high-jump-kick,t,6,z,1,p,10,d,130,a,.9;146;name,glare,t,0,z,0,p,30,d,—,a,1;147;name,poison-gas,t,7,z,0,p,40,d,—,a,.9;148;name,barrage,t,0,z,1,p,20,d,15,a,.85;149;name,leech-life,t,11,z,1,p,10,d,80,a,1;150;name,lovely-kiss,t,0,z,0,p,10,d,—,a,.75;151;name,transform,t,0,z,0,p,10,d,—,a,—;152;name,bubble,t,2,z,2,p,30,d,40,a,1;153;name,dizzy-punch,t,0,z,1,p,10,d,70,a,1;154;name,spore,t,4,z,0,p,15,d,—,a,1;155;name,splash,t,0,z,0,p,40,d,—,a,—;156;name,acid-armor,t,7,z,0,p,20,d,—,a,—;157;name,crabhammer,t,2,z,1,p,10,d,100,a,.9;158;name,fury-swipes,t,0,z,1,p,15,d,18,a,.8;159;name,bonemerang,t,8,z,1,p,10,d,50,a,.9;160;name,hyper-fang,t,0,z,1,p,15,d,80,a,.9;161;name,sharpen,t,0,z,0,p,30,d,—,a,—;162;name,conversion,t,0,z,0,p,30,d,—,a,—;163;name,super-fang,t,0,z,1,p,10,d,—,a,.9;164;name,slash,t,0,z,1,p,20,d,70,a,1;]]
zclass[[modes,actor|push,%modes_push,pop,%modes_pop,update,nop,draw1,nop,draw2,nop,draw3,nop,curr,main;stack;,;defaults;sub,0,init,nop,update,nop,draw1,nop,draw2,nop,draw3,nop;main;update,%main_update,draw1,%main_draw1,draw2,%main_draw2,draw3,%main_draw3;credits;update,%credits_update,draw1,%credits_draw1,draw2,%main_draw2,draw3,%main_draw3,init,%credits_init;browse;update,%browse_update,draw1,%browse_draw1,draw2,%browse_draw2,draw3,%browse_draw3;browsestat;update,%browsestat_update,draw1,%browsestat_draw1,draw2,%browse_draw2,draw3,%browse_draw3;fight;update,%fight_update,draw1,%fight_draw1,draw2,%fight_draw2,draw3,%fight_draw3;party;update,%party_update,draw1,%party_draw1,draw2,%party_draw2,draw3,%party_draw3;editparty;update,%editparty_update,draw1,%editparty_draw1,draw2,%editparty_draw2,draw3,%editparty_draw3;]]
c_modes=zobj[[len,6;0;name,browse,state,browse,desc,view/pokemon/info;1;name,credits,state,credits,desc,by/amorg/games;2;name,fight,state,fight,desc,pokemon/battle/simulator;3;name,games,state,games,desc,minigames/and/quizzes;4;name,party,state,party,desc,change/your/teams;5;name,settings,state,settings,desc,customize/this/picodex;]]
c_mode_positions=split"2,9,17,26,33"
g_picodex_div=zobj[[,6,5,5,6,6,5,6]]
function any_btn()return g_bl or g_br or g_bu or g_bd or g_bx or g_bo end
function draw_picodex(shaking,rotation,l_screen,tr_screen,br_screen,light,backbuttonheld,top_row_buttons,bot_row_buttons)
light=light or 0
camera(-28+(rotation+1)*14+(shaking and flr(rnd(3)-1)or 0),-15)
draw_back_panel(light)
draw_left_flap(light>=4,l_screen)
draw_right_flap(light>=4,rotation,backbuttonheld,tr_screen,br_screen,top_row_buttons,bot_row_buttons)
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
str=""..str
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
function draw_right_flap(is_on,flap_rotation,backbuttonheld,topscreen_func,botscreen_func,top_row_buttons,bot_row_buttons)
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
if top_row_buttons then spr(100,73+(top_row_buttons\1%6)*8,41)end
if bot_row_buttons then spr(100,73+(bot_row_buttons\1%6)*8,49)end
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
function set_browse(delta)
poke(0x5ef7,(@0x5ef7+delta)%152)
if@0x5ef7==0 and@0x5eff==0 then
set_browse(sgn(delta))
end
end
function browseupdate_shared(a)
set_browse"0"
if g_bpl then set_browse"-1" end
if g_bpr then set_browse"1" end
if g_bpo then a:pop()end
end
g_loaded_row=16
function draw_pkmn(num,x,y,sw,sh)
sw=sw or 1
sh=sh or 1
local row=num/8\1
local col=num%8
if row ~=g_loaded_row then
g_loaded_row=row
memcpy(0x0000,0x8000+0x400*row,0x400)
end
local w,h=16*sw,16*sh
sspr(col*16,0,16,16,x-w/2,y-h/2,w,h)
end
function draw_pkmn_out(num,x,y,col,scale_factor,outline_width)
scale_factor=scale_factor or 1
outline_width=outline_width or 1
for c=1,15 do pal(c,col)end
for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num,x-outline_width,y+i,scale_factor,scale_factor)end
for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num,x+outline_width,y+i,scale_factor,scale_factor)end
for c=1,15 do pal(c,1)end
for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num,x+i,y,scale_factor,scale_factor)end
for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num,x,y+i,scale_factor,scale_factor)end
for c=1,15 do pal(c,c)end
draw_pkmn(num,x,y,scale_factor,scale_factor)
end
function format_num(num)
local str=""..num
for i=#str+1,3 do
str="0"..str
end
return "#"..str
end
function get_pokemon(num)
return c_pokemon[num]
end
c_creditlist=split",,,,,,credits,,⬆️/⬇️  ,,,aLANXOC3,CODE,GFX|SFX,,tHE,gREAT,cADET,GFX|SFX,,wADLO,MAGIKARP,GYARADOS,,code,snippets,,zEP,fOR pX9,& pICO-8,,mOT,fOR sMAP,,pokemon,data,,bLBAPEDIA,,pOKEAPI,,sEREBII,,sMOGON,,vOLVOX,,nINTENDO,oF cOURSE,,,,gotta,catch,em,all,,,"
function print_draw3_message(top,mid,bot)
rectfill(0,0,45,20,1)
zprint(top,46/2,1,13,0)
zprint(mid,46/2,8,13,0)
zprint(bot,46/2,15,13,0)
end
function draw_party_screen(sel,party1,party2,party3)
rectfill(0,0,39,49,13)
local drawbg=function(yoff,party)
rect(-1,yoff-1,40,yoff+7,1)
for i,v in ipairs(party)do get_pokemon(v.num).draw(5+(i-1)*6,4+yoff,5,.2)end
end
local ty=0+sel*8
rectfill(0,ty,39,ty+23,6)
rect(-1,ty,40,ty+23,13)
local locs=zobj[[1;,10,12,1;2;,25,9,.5;3;,35,9,.375;4;,24,18,.2;5;,30,18,.2;6;,36,18,.2;]]
for i,v in ipairs(get_party(sel))do get_pokemon(v.num).draw(locs[i][1],ty+locs[i][2],13,locs[i][3])end
drawbg((sel*8+25)%41,get_party((sel+1)%3))
drawbg((sel*8+25+8)%41,get_party((sel+2)%3))
end
c_party_memlocs=zobj[[0,0x5e00,1,0x5e1f,2,0x5e3e]]
function get_party(party_index)
local mem=c_party_memlocs[party_index]
local party,party_len={},peek(mem)%7
for i=1,party_len do
local memstart=mem+1+(i-1)*5
local moves={}
for i=1,4 do add(moves,peek(memstart+i))end
add(party,{num=peek(memstart),moves=moves})
end
return party
end
function save_party(party_index,party)
local mem=c_party_memlocs[party_index]
local partylen=max(0,min(#party,6))
poke(mem,partylen)
for i=1,min(#party,6)do
local memstart=mem+1+(i-1)*5
local pkmn=party[i]
poke(memstart,pkmn.num)
for i=1,4 do
poke(memstart+i,(pkmn.moves or{})[i]or 0)
end
end
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
for i=0,151 do
c_pokemon[i]={
name=c_pokemon[i][1],
width=c_pokemon[i][2],
height=c_pokemon[i][3],
type1=c_pokemon[i][4],
type2=c_pokemon[i][5],
hp=c_pokemon[i][6],
attack=c_pokemon[i][7],
defence=c_pokemon[i][8],
speed=c_pokemon[i][9],
special=c_pokemon[i][10],
draw=function(...)draw_pkmn_out(i,...)end,
num=i,
}
end
c_pokemon[0].draw=function(...)
if@0x5eff ~=0 then
draw_pkmn_out(i,...)
end
end
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