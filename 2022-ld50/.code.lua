g_zclass_constructors,g_zclass_entities,g_zclass_new_entities={},{},{}
function zclass(meta_and_att_str)
local meta,template=unpack(split(meta_and_att_str,"|"))
local parents=split(meta)
local class=deli(parents,1)
g_zclass_constructors[class]=function(inst,...)
foreach(parents,function(parent)
if not inst[parent]then g_zclass_constructors[parent](inst)end
end)
inst.id=class
inst[class]=true
add(g_zclass_new_entities,{class,inst})
return zobj_set(inst,template,...)
end
_g[class]=function(...)return g_zclass_constructors[class]({},...)end
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
del(entities,inst)
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
_g=zobj([[actor_load,@,actor_state,@,actor_kill,@,actor_clean,@,timer_set_timer,@,timer_delete_timer,@,timer_get_elapsed,@,timer_get_elapsed_percent,@,timer_tick,@,vec_update,@,acc_update,@,mov_update,@,collision_init,@,collision_follow_anchoring,@,check_collision,@,collision_draw_debug,@,model_draw,@,model_init,@,model_collide,@,model_explode,@,line_particle_update,@,line_particle_draw,@,view_match_following,@,missile_init,@,twinkle_draw,@,twinkle_init,@,planet_init,@,planet_update,@,logo_init,@,logo_draw,@,game_init,@,game_update,@,game_draw,@,pl_init,@,pl_update,@,pl_hit,@,cateroid_init,@]],function(a,stateName)
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
a.ang+=a.d_ang
a.ax=a.speed*cos(a.ang)
a.ay=a.speed*sin(a.ang)
end,function(a)
add(a.anchoring.collisions,a)
a:follow_anchoring()
end,function(a)
local b=a.anchoring
local off_magnitude=approx_dist(a.offset_x,a.offset_y)
local off_ang_new=atan2(a.offset_x,a.offset_y)+b.ang+b.d_ang
a.alive,a.dx,a.dy,a.x,a.y=b.alive,b.dx,b.dy,b.x+off_magnitude*cos(off_ang_new),b.y+off_magnitude*sin(off_ang_new)
end,function(a,others)
foreach(others,function(other)
if a==other then return end
local x,y=other.x-a.x,other.y-a.y
local minimum_dist=a.radius+other.radius
local dist=approx_dist(x,y)-minimum_dist
if dist<0 then
local ang=atan2(x,y)
local dx,dy=cos(ang)*dist,sin(ang)*dist
a.anchoring:hit(other.anchoring,dx,dy)
other.anchoring:hit(a.anchoring,-dx,-dy)
end
end)
end,function(a)
if g_debug then
circ(zoomx(a.x),zoomy(a.y),a.radius*g_view.zoom_factor,8)
end
end,function(a)
srand(t()*4\1)
local modelpoints={}
foreach(a.model.lines,function(lines)
local points=get_points_from_shape(a.x,a.y,a.ang,lines)
foreach(points,function(point)point.x=zoomx(point.x)point.y=zoomy(point.y)end)
draw_polygon(points,lines[2],points.fill_color)
add(modelpoints,{c=lines[1],points=points})
end)
foreach(modelpoints,function(points)
line_loop(points.points,points.c,wobble_line)
end)
if g_debug and a.field_radius then
circ(zoomx(a.x),zoomy(a.y),a.field_radius*g_view.zoom_factor,2)
end
end,function(a,zobj_str)
a.model=zobj(zobj_str)
a.field_radius=a.model.field
a.collisions={}
foreach(a.model.collisions or{},function(collision)
a.collision_func(a,collision[1],collision[2],collision[3])
end)
end,function(a,other_list)
foreach(other_list,function(other)
local should_check_fine_grained_collisions=false
if a.field_radius and other.field_radius then
local x,y=other.x-a.x,other.y-a.y
local minimum_dist=a.field_radius+other.field_radius
should_check_fine_grained_collisions=approx_dist(x,y)<minimum_dist
else
should_check_fine_grained_collisions=true
end
if should_check_fine_grained_collisions then
foreach(a.collisions,function(b)
b:check_collision(other.collisions)
end)
end
end)
end,function(a)
if a.alive then
a:kill()
foreach(a.model.lines,function(lines)
line_loop(get_points_from_shape(a.x,a.y,a.ang,lines),lines[1],function(x1,y1,x2,y2,color)
local midx,midy=(x2-x1)/2+x1,(y2-y1)/2+y1
x1,y1=x1-midx,y1-midy
x2,y2=x2-midx,y2-midy
_g.line_particle(atan2(midx-a.x,midy-a.y),midx,midy,x1,y1,x2,y2,color,a.dx,a.dy)
end)
end)
end
end,function(a)
a.dx+=cos(a.ang)*.005
a.dy+=sin(a.ang)*.005
end,function(a)
local percent=1-a:get_elapsed_percent"state"
line(zoomx(a.x+a.x1*percent),zoomy(a.y+a.y1*percent),zoomx(a.x+a.x2*percent),zoomy(a.y+a.y2*percent),a.color)
end,function(a)
if a.following then
local x,y=a.following.x-a.x,a.following.y-a.y
local dir=atan2(x,y)
local dist=approx_dist(x,y)
a.dx=cos(dir)*dist*.25
a.dy=sin(dir)*dist*.25
if g_debug then
if btn"4"then a.zoom_factor=min(20,a.zoom_factor+1)end
if btn"5"then a.zoom_factor=max(8,a.zoom_factor-1)end
end
end
end,function(a)
a:model_init[[lines;1;,7,7,-0.1,0,0.1,0;collisions;1;,0,0,0.1;]]
end,function(a)
local x=(-g_view.x+flr(a.x*g_view.zoom_factor))%128
local y=(-g_view.y+flr(a.y*g_view.zoom_factor))%128
pset(x,y,sin(time()/10+a.twinkle_offset)>0.5 and 6 or 5)
end,function(a)
a.twinkle_offset=rnd()
a.x=rnd(256)
a.y=rnd(256)
end,function(a)
a.model=zobj[[lines;1;,3,0.5,0,-0.5,0]]
end,function(a)
a.ang-=.001
end,function()sfx"63" end,function(a)
local logo_opacity=cos(a:get_elapsed_percent"state")+1
fade(logo_opacity)
camera(logo_opacity>.5 and rnd_one())
zspr(108,64,64,4,2)
fade"0"
camera()
end,function()
g_pl=_g.pl(0,0)
g_view=_g.view(g_pl)
_g.planet(1,3)
g_cateroid=_g.cateroid(10,0)
for i=1,50 do
_g.twinkle()
end
end,function()
loop_zobjs("actor","state")
loop_zobjs("view","match_following")
loop_zobjs("wall","collide",g_zclass_entities["pl"])
loop_zobjs("collision_circ","follow_anchoring")
loop_zobjs("mov","mov_update")
loop_zobjs("acc","acc_update")
loop_zobjs("vec","vec_update")
end,function()
loop_zobjs("drawable","draw")
end,function(a)
a:model_init[[field,1;collisions;1;,-0.4,0,0.6;collisions;2;,0.2,0,0.3;collisions;3;,0.5,0,0.3;collisions;4;,0.8,0,0.2;collisions;5;,-0.7,-0.4,0.2;collisions;6;,-0.7,0.4,0.2;lines;1;,7,-1,-0.5,-0.2,-0.7,-0.3,-0.8,-0.1,-0.8,0.1,-0.7,0.3,-0.5,0.2;lines;2;,13,-1,0,-0.3,-0.2,-0.5,-0.6,-0.6,-0.8,-0.6,-0.9,-0.5,-0.6,-0.4,-0.5,-0.2;lines;3;,13,-1,0,0.3,-0.2,0.5,-0.6,0.6,-0.8,0.6,-0.9,0.5,-0.6,0.4,-0.5,0.2;lines;4;,13,-1,0,0,-0.9,0;lines;5;,7,-1,1,0,0.7,-0.2,0.2,-0.3,0,-0.3,-0.5,-0.2,-0.6,0;lines;6;,7,-1,1,0,0.7,0.2,0.2,0.3,0,0.3,-0.5,0.2,-0.6,0;lines;7;,13,2,0.7,-0.2,1,0,0.7,0.2,0.6,0.1,0.6,-0.1,0.7,-0.2;lines;8;,13,1,0.5,0,0.4,-0.1,0.3,-0.1,0.2,0,0.3,0.1,0.4,0.1,0.5,0;]]
end,function(a)
if btn"4"and a.missile_ready then
_g.missile(a.x+cos(a.ang)*.8,a.y+sin(a.ang)*.8,a.ang)
a.missile_ready=false
a:set_timer("missile_cooldown",0.1,function()a.missile_ready=true end)
end
a.speed=-ybtn()*.01
a.d_ang=-xbtn()*.01
end,function(a,b,dx,dy)
a.dx+=dx
a.dy+=dy
a:explode()
b:explode()
end,function(a)
a:model_init[[field,2;lines;1;,7,-1,-1.2,-0.4,-1.3,0,-1.2,0.5,-0.8,0.9,-0.4,1,0,1;lines;2;,7,-1,1.2,-0.4,1.3,0,1.2,0.5,0.8,0.9,0.4,1,0,1;lines;3;,7,-1,0,0.4,0.2,0.3,0.1,0.2,-0.1,0.2,-0.2,0.3,0,0.4;lines;4;,7,-1,0,0.4,0,0.5,-0.1,0.6,-0.2,0.6;lines;5;,7,-1,0,0.4,0,0.5,0.1,0.6,0.2,0.6;lines;6;,7,-1,0.6,0.2,0.5,0.1,0.5,-0.1,0.6,-0.2,0.7,-0.1,0.7,0.1,0.6,0.2;lines;7;,7,-1,-0.6,0.2,-0.5,0.1,-0.5,-0.1,-0.6,-0.2,-0.7,-0.1,-0.7,0.1,-0.6,0.2;lines;8;,7,-1,-1,-0.6,-0.8,-0.8,-0.5,-1,-0.1,-1.1,0,-1.1;lines;9;,7,-1,1,-0.6,0.8,-0.8,0.5,-1,0.1,-1.1,0,-1.1;lines;10;,7,-1,-1.2,-0.5,-1.1,-1.1,-0.9,-1.5,-0.5,-1;lines;11;,7,-1,1.2,-0.5,1.1,-1.1,0.9,-1.5,0.5,-1;lines;12;,7,-1,0.9,-1.5,0.8,-1.2,0.8,-0.8;lines;13;,7,-1,-0.9,-1.5,-0.8,-1.2,-0.8,-0.8;lines;14;,7,-1,0.9,0.3,1.2,0.3;lines;15;,7,-1,-0.9,0.3,-1.2,0.3;lines;16;,7,-1,0.9,0.2,1.1,0;lines;17;,7,-1,-0.9,0.2,-1.1,0;lines;18;,7,-1,0.9,0.4,1.1,0.6;lines;19;,7,-1,-0.9,0.4,-1.1,0.6;collisions;1;,0.3,0,1;collisions;2;,-0.3,0,1;collisions;3;,-0.8,-0.9,0.4;collisions;4;,-0.9,-1.3,0.2;collisions;5;,-0.8,-0.6,0.4;collisions;6;,0.8,-0.9,0.4;collisions;7;,0.9,-1.3,0.2;collisions;8;,0.8,-0.6,0.4;collisions;9;,0,-0.3,0.9;]]
a.d_ang=.001
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
function draw_polygon(points,color)
if color>=0 then
local xl,xr,ymin,ymax={},{},129,0xffff
for k,v in pairs(points)do
local p2=points[k%#points+1]
local x1,y1,x2,y2=v.x,flr(v.y),p2.x,flr(p2.y)
if y1>y2 then
y1,y2,x1,x2=y2,y1,x2,x1
end
local d=y2-y1
for y=y1,y2 do
local xval=flr(x1+(x2-x1)*(d==0 and 1 or(y-y1)/d))
xl[y],xr[y]=min(xl[y]or 32767,xval),max(xr[y]or 0x8001,xval)
end
ymin,ymax=min(y1,ymin),max(y2,ymax)
end
for y=ymin,ymax do
rectfill(xl[y],y,xr[y],y,color)
end
end
end
function wobble_line(x1,y1,x3,y3,color)
if color>=0 then
local x2,y2=(x3-x1)/2+x1+flr_rnd(3)-1,(y3-y1)/2+y1+flr_rnd(3)-1
line(x1,y1,x2,y2,color)
line(x2,y2,x3,y3,color)
end
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
zclass[[mov,acc|ang,0,speed,0,d_ang,0,mov_update,%mov_update]]
zclass[[collision_circ,vec,actor,drawable|anchoring,@,offset_x,@,offset_y,@,radius,@,inertia_x,1,inertia_y,1,follow_anchoring,%collision_follow_anchoring,check_collision,%check_collision,init,%collision_init,hit,nop,draw,%collision_draw_debug]]
zclass[[bad_collision_circ,collision_circ|anchoring,@,offset_x,@,offset_y,@,radius,@]]
zclass[[good_collision_circ,collision_circ|anchoring,@,offset_x,@,offset_y,@,radius,@]]
function zoomx(x)return(x-g_view.x)*g_view.zoom_factor+64 end
function zoomy(y)return(y-g_view.y)*g_view.zoom_factor+64 end
zclass[[model,mov,drawable,actor|model;,;hit,nop,collision_func,%bad_collision_circ,draw,%model_draw,explode,%model_explode,collide,%model_collide,model_init,%model_init]]
function line_loop(points,color,linefunc)
for i=1,#points-1,1 do
local p1,p2=points[i],points[i+1]
linefunc(p1.x,p1.y,p2.x,p2.y,color)
end
end
function get_points_from_shape(x,y,dir,shape)
local points={}
for i=3,#shape/2\1*2,2 do
local x1,y1=shape[i],shape[i+1]
local ang1=atan2(x1,y1)
local mag1=approx_dist(x1,y1)
add(points,{x=x+cos(ang1+dir)*mag1,y=y+sin(ang1+dir)*mag1})
end
return points
end
zclass[[line_particle,vec,actor,drawable|ang,@,x,@,y,@,x1,@,y1,@,x2,@,y2,@,color,@,dx,@,dy,@,draw,%line_particle_draw,update,%line_particle_update;start;duration,.5;]]
zclass[[view,vec|following,@,zoom_factor,16,match_following,%view_match_following]]
zclass[[missile,model|x,@,y,@,ang,@,speed,0.1,init,%missile_init;start;duration,2;]]
zclass[[twinkle,actor,drawable|x,0,y,0,draw,%twinkle_draw,init,%twinkle_init,]]
zclass[[planet,actor,model|x,@,y,@,init,%planet_init,update,%planet_update;]]
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
if btnp(4)and btnp(5)then g_debug=not g_debug end
loop_zobjs("actor","clean")
register_zobjs()
loop_zobjs("timer","tick")
loop_zobjs("game_state","state")
end
function _draw()
cls()
loop_zobjs("game_state","draw")
if g_debug then rect(0,0,127,127,8)end
end
zclass[[pl,actor,model|x,@,y,@,missile_ready,yes,init,%pl_init,update,%pl_update,hit,%pl_hit,collision_func,%good_collision_circ]]
zclass[[wall|]]
zclass[[cateroid,model,wall|x,@,y,@,init,%cateroid_init]]