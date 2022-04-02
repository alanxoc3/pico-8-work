g_zclass_constructors,g_zclass_entities,g_zclass_new_entities={},{},{}
function zclass(meta_and_att_str)
local meta,template=unpack(split(meta_and_att_str,"|"))
local parents=split(meta)
local class=deli(parents,1)
g_zclass_constructors[class]=function(inst,done,...)
foreach(parents,function(parent)
if not done[parent]then g_zclass_constructors[parent](inst,done)end
end)
done[class]=true
add(g_zclass_new_entities,{class,inst})
return zobj_set(inst,template,...)
end
_g[class]=function(...)return g_zclass_constructors[class]({},{},...)end
end
function register_zobjs()
while #g_zclass_new_entities>0 do
local class,inst=unpack(deli(g_zclass_new_entities))
g_zclass_entities[class]=g_zclass_entities[class]or{}
if inst[class]~="ignore"then add(g_zclass_entities[class],inst)end
end
end
function deregister_zobj(inst)
for class,entities in pairs(g_zclass_entities)do
if inst[class]then del(entities,inst)end
end
end
function call_not_nil(table,key,...)
if table and table[key]then
return table[key](...)
end
end
function loop_zobjs(class,method_name,...)
for inst in all(g_zclass_entities[class])do
call_not_nil(inst,method_name,inst,...)
end
end
function zobj_eval(val,table,parameters)
if ord(val)==37 then return _g[sub(val,2)]
elseif ord(val)==126 then return table[sub(val,2)]
elseif val=="@"then return deli(parameters,1)
elseif val=="yes"or val=="no"then return val=="yes"
elseif val=="null"or val==""then return
elseif val=="nop"then return function()end
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
_g=zobj([[actor_load,@,actor_state,@,actor_kill,@,actor_clean,@,timer_set_timer,@,timer_delete_timer,@,timer_get_elapsed,@,timer_get_elapsed_percent,@,timer_tick,@,vec_update,@,acc_update,@,mov_update,@,model_draw,@,view_match_following,@,logo_init,@,logo_draw,@,game_init,@,game_update,@,game_draw,@,pl_init,@,pl_update,@]],function(a,stateName)
if stateName then
a.next,a.duration=nil
for k,v in pairs(a[stateName])do a[k]=v end
a.curr=stateName
a:set_timer("state",a.duration,a.duration and function()a:load(a.next)end)
else
a:kill()
end
end,function(a)
if not a:get_elapsed"state"then a:load(a.curr)end
if a:get_elapsed"state"==0 then a:init()end
a:update()
end,function(a)a.alive=nil end,function(a)
if not a.alive then
a:destroyed()
deregister_zobj(a)
end
end,function(a,timer_name,duration,callback)
a.timers[timer_name]={elapsed=0,duration=duration or 32767,callback=callback or function()end}
end,function(a,timer_name)
a.timers[timer_name]=nil
end,function(a,timer_name)
local timer=a.timers[timer_name]
return timer and timer.elapsed
end,function(a,timer_name)
local timer=a.timers[timer_name]
return timer and timer.elapsed/timer.duration
end,function(a)
local finished_timers={}
for name,timer in pairs(a.timers)do
if timer.elapsed<timer.duration then
timer.elapsed=timer.elapsed+1/60
if timer.elapsed>=timer.duration then
add(finished_timers,timer)
end
end
end
foreach(finished_timers,function(timer)
timer.callback(a)
end)
end,function(a)
a.x+=a.dx
a.y+=a.dy
end,function(a)
a.dx+=a.ax a.dy+=a.ay
a.dx*=a.inertia_x a.dy*=a.inertia_y
if a.ax==0 and abs(a.dx)<.01 then a.dx=0 end
if a.ay==0 and abs(a.dy)<.01 then a.dy=0 end
end,function(a)
a.ax=a.speed*cos(a.ang)
a.ay=a.speed*sin(a.ang)
end,function(a)
local dir=a.ang
local x,y=a.x,a.y
foreach(a.model.lines or{},function(shape)
for i=2,#shape-2,2 do
local x1,y1=shape[i],shape[i+1]
local x2,y2=shape[i+2],shape[i+3]
local ang1,ang2=atan2(x1,y1),atan2(x2,y2)
local mag1,mag2=approx_dist(x1,y1),approx_dist(x2,y2)
line(
zoomx(x+cos(ang1+dir)*mag1),zoomy(y+sin(ang1+dir)*mag1),
zoomx(x+cos(ang2+dir)*mag2),zoomy(y+sin(ang2+dir)*mag2),shape[1]
)
end
end)
end,function(a)
if a.following then
local x,y=a.following.x-a.x,a.following.y-a.y
local dir=atan2(x,y)
local dist=approx_dist(x,y)
a.dx=cos(dir)*dist*.25
a.dy=sin(dir)*dist*.25
if btn"4"then a.zoom_factor=max(1,a.zoom_factor+1)end
if btn"5"then a.zoom_factor=max(1,a.zoom_factor-1)end
end
end,function()sfx"63" end,function(a)
local logo_opacity=cos(a:get_elapsed_percent"state")+1
fade(logo_opacity)
camera(logo_opacity>.5 and rnd_one())
zspr(108,64,64,4,2)
fade"0"
camera()
end,function()
local g_pl=_g.pl(0,0)
g_view=_g.view(g_pl)
end,function()
loop_zobjs("actor","state")
loop_zobjs("mov","mov_update")
loop_zobjs("acc","acc_update")
loop_zobjs("vec","vec_update")
loop_zobjs("view","match_following")
end,function()
rect(0,0,127,127,8)
loop_zobjs("drawable","draw")
end,function(a)
a.model=zobj[[lines;1;,9,0.5,0,-0.5,-0.3,-0.3,0,-0.5,0.3,0.5,0;]]
end,function(a)
a.speed=-ybtn()*.01
a.ang-=xbtn()*.01
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
function xbtn()return btn_helper(btn,0,1)end
function ybtn()return btn_helper(btn,2,3)end
function approx_dist(dx,dy)
local maskx,masky=dx>>31,dy>>31
local a0,b0=(dx+maskx)^^maskx,(dy+masky)^^masky
if a0>b0 then
return a0*0.9609+b0*0.3984
end
return b0*0.9609+a0*0.3984
end
function tostring(any)
if type(any)~="table"then return tostr(any)end
local str="{"
for k,v in pairs(any)do
if str~="{"then str=str.."," end
str=str..tostring(k).."="..tostring(v)
end
return str.."}"
end
zclass[[actor,timer|load,%actor_load,state,%actor_state,kill,%actor_kill,clean,%actor_clean,alive,yes,duration,null,curr,start,next,null,init,nop,update,nop,destroyed,nop;]]
zclass[[drawable|draw,nop]]
zclass[[timer|timers;,;set_timer,%timer_set_timer,delete_timer,%timer_delete_timer,get_elapsed,%timer_get_elapsed,get_elapsed_percent,%timer_get_elapsed_percent,tick,%timer_tick,]]
zclass[[pos|x,0,y,0]]
zclass[[vec,pos|dx,0,dy,0,vec_update,%vec_update]]
zclass[[acc,vec|inertia_x,.95,inertia_y,.95,ax,0,ay,0,acc_update,%acc_update]]
zclass[[mov,acc|ang,0,speed,0,mov_update,%mov_update]]
function zoomx(x)return(x-g_view.x)*g_view.zoom_factor+64 end
function zoomy(y)return(y-g_view.y)*g_view.zoom_factor+64 end
zclass[[model,mov,drawable|model;,;draw,%model_draw;]]
zclass[[view,vec|following,@,zoom_factor,16,match_following,%view_match_following]]
g_fade_table=zobj[[0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,0,0,0,0;2;,2,2,2,2,1,0,0,0;3;,3,3,3,3,1,0,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,1,1,0,0;6;,6,6,13,13,5,5,1,0;7;,7,7,6,13,13,5,1,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,5,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,1,1,0;13;,13,13,5,5,1,1,1,0;14;,14,14,13,4,2,2,1,0;15;,15,15,13,13,5,5,1,0;]]
function fade(threshold)
for c=0,15 do
pal(c,g_fade_table[c][1+flr(7*min(1,max(0,threshold)))])
end
end
zclass[[game_state,actor|actor,ignore;curr,game;logo;init,%logo_init,update,%logo_update,draw,%logo_draw,duration,2.5,next,game;game;init,%game_init,update,%game_update,draw,%game_draw;]]
function _init()
g_tl=_g.game_state()
end
function _update60()
register_zobjs()
loop_zobjs("timer","tick")
loop_zobjs("game_state","state")
loop_zobjs("actor","clean")
end
function _draw()
cls()
loop_zobjs("game_state","draw")
end
zclass[[pl,actor,model|x,@,y,@,init,%pl_init,update,%pl_update,]]