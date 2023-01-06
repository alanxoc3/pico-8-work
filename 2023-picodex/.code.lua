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
_g=zobj([[actor_load,@,actor_loadlogic,@,actor_state,@,actor_is_alive,@,actor_kill,@,actor_clean,@,timer_reset_timer,@,timer_end_timer,@,timer_get_elapsed_percent,@,timer_is_active,@,timer_tick,@,test_init,@,test_update,@,test_draw,@,game_init,@,game_update,@,game_draw,@,fader_out_update,@,fader_in_update,@,logo_init,@,logo_draw,@]],function(a,stateName)
a.next_state=a.next_state or stateName
end,function(a,stateName)
a.next_state,a.isnew=nil
if stateName=="dead"then
a.alive=false
else
a:end_timer(a.curr)
a.next,a.duration=nil
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
end,function(a)
return a:is_active"ending"==nil and a.alive
end,function(a)
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
end,function(a)a.color+=1 end,function(a)a.x+=xbtn()a.y+=ybtn()end,function(a)circfill(a.x,a.y,2,a.color)end,function()
_g.fader_in()
_g.test_obj(64,64)
end,function()
loop_entities("actor","state")
end,function()
cls()
camera(0,-20)
draw_back_panel()
draw_right_flap()
draw_left_flap()
draw_closed_flap()
camera()
end,function(a)
poke(0x5f43,0xff)
g_fade=a:get_elapsed_percent"start"
end,function(a)
g_fade=1-a:get_elapsed_percent"start"
end,function()sfx(63,0)end,function(a)
g_fade=cos(a:get_elapsed_percent"logo")+1
camera(g_fade>.5 and rnd_one())
zspr(108,64,64,4,2)
camera()
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
function btn_helper(f,a,b)
return f(a)and f(b)and 0 or f(a)and 0xffff or f(b)and 1 or 0
end
function zcall_tbl(func,tbl)
foreach(tbl,function(params)
func(unpack(params))
end)
end
function zcall(func,text,...)
zcall_tbl(func,zobj(text,...))
end
function zbtn(f,a)return f(a)and f(a+1)and 0 or f(a)and-1 or f(a+1)and 1 or 0 end
function xbtn()return zbtn(btn,0)end
function ybtn()return zbtn(btn,2)end
zclass[[actor,timer|load,%actor_load,loadlogic,%actor_loadlogic,state,%actor_state,kill,%actor_kill,clean,%actor_clean,is_alive,%actor_is_alive,alive,yes,duration,null,curr,start,next,null,isnew,yes,init,nop,update,nop,destroyed,nop;]]
zclass[[drawlayer_50|]]
zclass[[timer|timers;,;start_timer,%timer_reset_timer,end_timer,%timer_end_timer,is_active,%timer_is_active,get_elapsed_percent,%timer_get_elapsed_percent,tick,%timer_tick,]]
zclass[[test_obj,actor,drawlayer_50|x,@,y,@,color,7,init,%test_init,update,%test_update,draw,%test_draw;]]
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
function draw_main_screen()
sspr(0,0,16,16,23,0+t()*2%2,16,16)
sspr(0,0,16,16,-1,21+(t()*2+1)%2,16,16,true)
end
function draw_screen(xoff,yoff,w,h,bg_color,screen_func)
local ox,oy=%0x5f28,%0x5f2a
clip(-ox+xoff,-oy+yoff,w,h)
camera(ox-xoff,oy-yoff)
rectfill(0,0,w,h,bg_color)
screen_func()
camera(ox,oy)
clip()
end
function draw_left_flap()
draw_screen(12,29,38,38,5,draw_main_screen)
map(103,21,-1,16,8,11)
spr(btn(0)and 186 or 154,07,84)
spr(btn(1)and 188 or 156,23,84)
spr(btn(2)and 171 or 139,15,80)
spr(btn(3)and 187 or 155,15,88)
spr(btn(4)and 170 or 138,39,84)
spr(btn(5)and 172 or 140,47,84)
end
function draw_right_flap()
draw_screen(74,25,46,14,5,function()wobble_text("nidoran?",46/2,4,6)end)
draw_screen(74,73,46,22,5,function()sspr(32,32,16,16,1,1,16,16,true)end)
map(111,21,-1+8*8+2,16,8,11)
spr(btn(0)and 100 or 99,73,48)spr(btn(0)and 100 or 99,89,56)
spr(btn(1)and 100 or 99,89,48)spr(btn(1)and 100 or 99,81,56)
spr(btn(2)and 100 or 99,81,48)spr(btn(2)and 100 or 99,97,56)
spr(btn(3)and 100 or 99,97,48)spr(btn(3)and 100 or 99,105,56)
spr(btn(4)and 100 or 99,105,48)spr(btn(4)and 100 or 99,113,56)
spr(btn(5)and 100 or 99,113,48)spr(btn(5)and 100 or 99,73,56)
end
function draw_closed_flap()
map(95,21,-1,16,8,11)
spr(128,3,56)
end
function draw_back_panel()
map(119,20,-1,8,9,12)
local tval=t()*2\1%5
spr((tval>0)and 120 or 121,20-1,10)
spr((tval>1)and 119 or 121,15-1,10)
spr((tval>2)and 118 or 121,10-1,10)
spr((tval>3)and 122 or 123,3,10)
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
memset(0x8000+index*0x2000,0,0x2000)
px9_decomp(0,0,peek2(index*2),
function(...)return vget(0x8000+index*0x2000,...)end,
function(...)return vset(0x8000+index*0x2000,...)end)
end
function h_draw()
cls()
map(32,16,0,0,16,16)
map(0,16,0,0,16,16)
map(16,16,0,0,16,16)
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
zclass[[game_state,actor|ecs_exclusions;actor,true;curr,logo;logo;init,%logo_init,update,nop,draw,%logo_draw,duration,2.5,next,game;game;init,%game_init,update,%game_update,draw,%game_draw;]]
function _init()
extract_sheet(0)
extract_sheet(1)
extract_sheet(2)
memcpy(0x0000,0xc000,0x2000)
g_tl=_g.game_state()
end
function _update60()
zcall(loop_entities,[[1;,actor,clean;2;,fader,clean;]])
register_entities()
zcall(loop_entities,[[1;,fader,tick;2;,game_state,tick;3;,fader,state;4;,game_state,state;]])
end
function _draw()
cls()
loop_entities("game_state","draw")
fade(g_fade)
end