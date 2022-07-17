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
_g=zobj([[actor_load,@,actor_loadlogic,@,actor_state,@,actor_is_alive,@,actor_kill,@,actor_clean,@,timer_reset_timer,@,timer_end_timer,@,timer_get_elapsed_percent,@,timer_is_active,@,timer_tick,@,dice_draw_model,@,dice_roll,@,dice_sit,@,dice_update,@,box_touching,@,box_outside,@,box_inside,@,box_side,@,box_abside,@,box_getdelta,@,pos_dist_point,@,vec_update,@,mov_update,@,calc_deltas,@,adjust_deltas_for_solids,@,adjust_deltas_for_tiles,@,adjust_deltas_for_screen,@,tcol_coll_tile,@,ant_init,@,ant_update,@,ant_draw,@,ant_tile_hit,@,game_init,@,game_update,@,game_draw,@,fader_out_update,@,fader_in_update,@,logo_init,@,logo_draw,@]],function(a,stateName)
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
end,function(a)
local model=a.model
local cam=a.cam
local m={
1,0,0,0,
0,1,0,0,
0,0,1,0,
-0.5,-0.5,-0.5,1
}
local cam_pos=m_inv_x_v(m,cam.pos)
m=m_x_m(cam.m,m)
for _,face in pairs(model.f)do
if v_dot(face.n,cam_pos)>face.cp then
local verts={}
for k=1,4 do
local p=m_x_v(m,face[k])
p.u=face.uv[2*k-1]
p.v=face.uv[2*k]
verts[k]=p
end
verts=cam:project(verts,a.x*8,a.y*8)
polytex(verts)
end
end
end,function(a,dir)
if a.is_sit then
a.is_sit=false
a.cam.dx_ang=.0625*dir/3
a.cam.dy_ang=-.0037*dir/3
a.cam.dz_ang=.0332*dir/3
a.cam.dx_frc=1
a.cam.dy_frc=1
a.cam.dz_frc=1
end
end,function(a)
if not a.is_sit then
a.is_sit=true
a.cam.dx_frc=.8
a.cam.dy_frc=.8
a.cam.dz_frc=.8
end
end,function(a)
a:roll(sgn(a.dir))
a.ay=.0125
a.cam:control(1-a:get_elapsed_percent"life")
end,function(a,b)
return not a:outside(b)and not a:inside(b)
end,function(a,b)
local xp,yp,xr,yr=a:side(b)
return xp<=-1-xr or xp>=1+xr or yp<=-1-yr or yp>=1+yr
end,function(a,b)
local xp,yp,xr,yr=a:side(b)
return xp>-1+xr and xp<1-xr and yp>-1+yr and yp<1-yr
end,function(a,b)
return(a.x-b.x)/b.rx,(a.y-b.y)/b.ry,a.rx/b.rx,a.ry/b.ry
end,function(a,b)
local xp,yp=a:side(b)
if abs(yp)>abs(xp)
then return 0,sgn(yp)
else return sgn(xp),0 end
end,function(a,b,dx,dy)
local abx,aby=a:abside(b)
local xp,yp=a:side(b)
if not a:outside(b)then
if abx ~=0 and zsgn(dx)==-abx then
dx=get_delta_axis(dx,a.x,a.rx,b.x,b.rx)
elseif aby ~=0 and zsgn(dy)==-aby then
dy=get_delta_axis(dy,a.y,a.ry,b.y,b.ry)
elseif aby ~=0 then
dx=get_delta_axis(dx,a.x,a.rx,b.x,b.rx)
elseif abx ~=0 then
dy=get_delta_axis(dy,a.y,a.ry,b.y,b.ry)
end
end
return dx,dy
end,function(a,x,y)
local dx,dy=x-a.x,y-a.y
local maskx,masky=dx>>31,dy>>31
local a0,b0=(dx+maskx)^^maskx,(dy+masky)^^masky
if a0>b0 then
return a0*0.9609+b0*0.3984
end
return b0*0.9609+a0*0.3984
end,function(a)
a.x+=a.dx
a.y+=a.dy
end,function(a)
a.dx+=a.ax
a.dy+=a.ay
a.dx*=a.ix a.dy*=a.iy
if abs(a.dx)<MIN_SPEED then a.dx=0 end
if abs(a.dy)<MIN_SPEED then a.dy=0 end
if abs(a.dy)>MAX_SPEED then a.dy=sgn(a.dy)*MAX_SPEED end
a.ax=0 a.ay=0
end,function(a,b)
local box={x=b.x-a.dx,y=b.y-a.dy,rx=b.rx,ry=b.ry}
return a:getdelta(box,a.dx,a.dy)
end,function(a,list)
foreach(list,function(b)
local box={x=b.x-a.dx,y=b.y-a.dy,rx=b.rx,ry=b.ry}
a.dx,a.dy=a:getdelta(box,a.dx,a.dy)
end)
end,function(a)
for tx=flr(a.x-a.rx)-1,ceil(a.x+a.rx)do
for ty=flr(a.y-a.ry)-1,ceil(a.y+a.ry)do
if fget(mget(g_room_bounds.tx_off+tx,g_room_bounds.ty_off+ty),0)then
local rx,ry=.5,.5
a.dx,a.dy=a:calc_deltas{x=tx+.5,y=ty+.5,rx=rx,ry=ry}
end
end
end
end,function(a)
if a.should_collide_with_screen_edge then
local box={
x=g_room_bounds.x+g_room_bounds.w/2-a.dx,
y=g_room_bounds.y+g_room_bounds.h/2-a.dy,
rx=g_room_bounds.w/2,
ry=g_room_bounds.h/2
}
a.dx=get_delta_axis2(a.dx,a.x,a.rx,box.x,box.rx)
a.dy=get_delta_axis2(a.dy,a.y,a.ry,box.y,box.ry)
end
end,function(a,solid_func)
local x,dx=coll_tile_help(a.x,a.y,a.dx,a.rx,a.ry,0,a,a.tile_hit,solid_func)
local y,dy=coll_tile_help(a.y,a.x,a.dy,a.ry,a.rx,2,a,a.tile_hit,function(y,x)return solid_func(x,y)end)
if a.tile_solid then
a.x,a.y,a.dx,a.dy=x,y,dx,dy
end
end,function(a)
a.color+=1
end,function(a)
a.ay=.015
if g_zbtn_0 ~=0 then
a.ax=(a.touching_ground and.065 or.065)*g_zbtn_0
a.xf=a.ax<0
end
if a:is_active"jump"then a.dy=-.2
elseif a:is_active"ldjump"then a.ax=.125 a.dy=.25/2
elseif a:is_active"lujump"then a.ax=.125 a.dy=-.25
elseif a:is_active"rdjump"then a.ax=-.125 a.dy=.25/2
elseif a:is_active"rujump"then a.ax=-.125 a.dy=-.25
else
if btn(4)then
if a.touching_ground then a:start_timer("jump",.125)
elseif a.touching_left_wall then a:start_timer(btn"3"and "ldjump"or "lujump",.125/2)
elseif a.touching_right_wall then a:start_timer(btn"3"and "rdjump"or "rujump",.125/2)
end
end
end
if btn(5)and not a:is_active"diceroll"then
a:start_timer("diceroll",.5)
create_dice(a.x,a.y,0,a.xf and 1 or-1)
end
if not a.touching_ground and(a.touching_left_wall or a.touching_right_wall)then
a.sind=23
elseif not a.touching_ground then
if a:is_active"jump"then
a.sind=9
elseif a.dy>0 then
a.sind=11
else
a.sind=10
end
else
if a.dx ~=0 then
if t()%.25<.125 then
a.sind=7
else
a.sind=8
end
else
if t()%1<.5 then
a.sind=7
else
a.sind=8
end
end
end
if not a.touching_ground and a.touching_left_wall then
end
a.touching_ground=false
a.touching_left_wall=false
a.touching_right_wall=false
end,function(a)
zspr(a.sind,a.x*8,a.y*8,1,1,a.xf,false)
end,function(a,dir)
if dir==3 then a.touching_ground=true end
if dir==0 then
a.touching_left_wall=true
end
if dir==1 then
a.touching_right_wall=true
end
end,function()
g_room_bounds=g_levels[1]
_g.fader_in()
g_ant=_g.ant(find_in_room(32))
end,function()
zcall(loop_entities,[[1;,timer,tick;2;,actor,state;3;,mov,mov_update;4;,tcol,coll_tile,@;5;,collidable,adjust_deltas_for_tiles;6;,vec,vec_update;]],function(x,y)
return x>=g_room_bounds.x and x<g_room_bounds.w and
y>=g_room_bounds.y and y<g_room_bounds.h and
fget(mget(g_room_bounds.tx_off+x,g_room_bounds.ty_off+y),0)
end)
end,function()
camera(g_ant.x*8-64,0)
rect(0,0,127,127,8)
map(g_room_bounds.tx_off,g_room_bounds.ty_off,0,0,g_room_bounds.w,g_room_bounds.h,0x80)
loop_entities("drawlayer_50","draw")
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
local cam
function lerp(a,b,t)
return a*(1-t)+b*t
end
function make_v(a,b)
return{
b[1]-a[1],
b[2]-a[2],
b[3]-a[3]}
end
function v_clone(v)
return{v[1],v[2],v[3]}
end
function v_dot(a,b)
return a[1]*b[1]+a[2]*b[2]+a[3]*b[3]
end
function v_scale(v,scale)
v[1]*=scale
v[2]*=scale
v[3]*=scale
end
function v_add(v,dv,scale)
scale=scale or 1
return{
v[1]+scale*dv[1],
v[2]+scale*dv[2],
v[3]+scale*dv[3]}
end
function v_len(v)
local x,y,z=v[1],v[2],v[3]
local d=max(max(abs(x),abs(y)),abs(z))
if(d<0.001)return 0
x/=d
y/=d
z/=d
return d*(x*x+y*y+z*z)^0.5
end
function v_normz(v)
local x,y,z=v[1],v[2],v[3]
local d=x*x+y*y+z*z
if d>0.001 then
d=d^.5
return{x/d,y/d,z/d}
end
return v
end
function v_lerp(a,b,t)
return{
lerp(a[1],b[1],t),
lerp(a[2],b[2],t),
lerp(a[3],b[3],t)
}
end
function v_cross(a,b)
local ax,ay,az=a[1],a[2],a[3]
local bx,by,bz=b[1],b[2],b[3]
return{ay*bz-az*by,az*bx-ax*bz,ax*by-ay*bx}
end
function m_inv_x_v(m,v)
local x,y,z=v[1]-m[13],v[2]-m[14],v[3]-m[15]
return{m[1]*x+m[2]*y+m[3]*z,m[5]*x+m[6]*y+m[7]*z,m[9]*x+m[10]*y+m[11]*z}
end
function m_fwd(m)
return{m[9],m[10],m[11]}
end
function m_up(m)
return{m[5],m[6],m[7]}
end
function m_x_v(m,v)
local x,y,z=v[1],v[2],v[3]
return{m[1]*x+m[5]*y+m[9]*z+m[13],m[2]*x+m[6]*y+m[10]*z+m[14],m[3]*x+m[7]*y+m[11]*z+m[15]}
end
function m_x_m(a,b)
local a11,a12,a13,a21,a22,a23,a31,a32,a33=a[1],a[5],a[9],a[2],a[6],a[10],a[3],a[7],a[11]
local b11,b12,b13,b14,b21,b22,b23,b24,b31,b32,b33,b34=b[1],b[5],b[9],b[13],b[2],b[6],b[10],b[14],b[3],b[7],b[11],b[15]
return{
a11*b11+a12*b21+a13*b31,a21*b11+a22*b21+a23*b31,a31*b11+a32*b21+a33*b31,0,
a11*b12+a12*b22+a13*b32,a21*b12+a22*b22+a23*b32,a31*b12+a32*b22+a33*b32,0,
a11*b13+a12*b23+a13*b33,a21*b13+a22*b23+a23*b33,a31*b13+a32*b23+a33*b33,0,
a11*b14+a12*b24+a13*b34+a[13],a21*b14+a22*b24+a23*b34+a[14],a31*b14+a32*b24+a33*b34+a[15],1
}
end
function make_m_from_euler(x,y,z)
local a,b=cos(x),-sin(x)
local c,d=cos(y),-sin(y)
local e,f=cos(z),-sin(z)
local ce,cf,de,df=c*e,c*f,d*e,d*f
return{
ce+df*b,a*f,cf*b-de,0,
de*b-cf,a*e,df+ce*b,0,
a*d,-b,a*c,0,
0,0,0,1}
end
function prepare_model(model)
for _,f in pairs(model.f)do
for i=1,4 do
f[i]=model.v[f[i]]
end
f.n=v_normz(
v_cross(
make_v(f[1],f[4]),
make_v(f[1],f[2])))
f.cp=v_dot(f.n,f[1])
end
return model
end
function make_cam()
return{
x_ang=rnd(1),dx_ang=0,dx_frc=1,
y_ang=rnd(1),dy_ang=0,dy_frc=1,
z_ang=rnd(1),dz_ang=0,dz_frc=1,
pos={0,0,0},
control=function(a,size)
a.x_ang+=a.dx_ang
a.y_ang+=a.dy_ang
a.z_ang+=a.dz_ang
a.dx_ang*=a.dx_frc
a.dy_ang*=a.dy_frc
a.dz_ang*=a.dz_frc
local m=make_m_from_euler(a.z_ang,a.y_ang,a.x_ang)
local pos=m_fwd(m)
v_scale(pos,size*2.25+2)
m[2],m[5]=m[5],m[2]
m[3],m[9]=m[9],m[3]
m[7],m[10]=m[10],m[7]
a.m=m_x_m(m,{
1,0,0,0,
0,1,0,0,
0,0,1,0,
-pos[1],-pos[2],-pos[3],1
})
a.pos=pos
end,
project=function(a,verts,x0,y0)
local n,f=0.1,.15
for i,v in pairs(verts)do
local x,y,z=v[1],v[2],v[3]
local w=24/z
verts[i]={x=x0+x*w,y=y0-y*w,w=w,u=v.u,v=v.v}
end
return verts
end
}
end
zclass[[dice,actor,mov,box,drawlayer_50|x,@,y,@,dx,@,dy,@,cam,@,model,@,dir,~dx,ix,.85,is_sit,yes,rx,1,ry,1,draw,%dice_draw_model,roll,%dice_roll,sit,%dice_sit,update,%dice_update;curr,life;life;duration,1.5;]]
function create_dice(x,y,ax,dir)
local create_dice_defaults=function()
return _g.dice(x,y,-dir*(.25+rnd(.75)),-(rnd(.25)+.125),make_cam(63.5,63.5),prepare_model({
v={
{0,0,0},{1,0,0},{1,0,1},{0,0,1},
{0,1,0},{1,1,0},{1,1,1},{0,1,1},
},
f={
{3,4,8,7,uv=zobj[[,122,0,124,0,124,2,122,2]]},
{4,1,5,8,uv=zobj[[,124,0,126,0,126,2,124,2]]},
{1,4,3,2,uv=zobj[[,126,0,128,0,128,2,126,2]]},
{5,6,7,8,uv=zobj[[,122,2,124,2,124,4,122,4]]},
{2,3,7,6,uv=zobj[[,124,2,126,2,126,4,124,4]]},
{1,2,6,5,uv=zobj[[,126,2,128,2,128,4,126,4]]},
}
})
)
end
for i=0,flr(rnd(6))do
create_dice_defaults()
end
end
function polytex(v)
local p0,nodes=v[#v],{}
local x0,y0,u0,v0=p0.x,p0.y,p0.u,p0.v
for i=1,#v do
local p1=v[i]
local x1,y1,u1,v1=p1.x,p1.y,p1.u,p1.v
local _x1,_y1,_u1,_v1=x1,y1,u1,v1
if(y0>y1)x0,y0,x1,y1,u0,v0,u1,v1=x1,y1,x0,y0,u1,v1,u0,v0
local dy=y1-y0
local dx,du,dv=(x1-x0)/dy,(u1-u0)/dy,(v1-v0)/dy
if(y0<0)x0-=y0*dx u0-=y0*du v0-=y0*dv y0=0
local cy0=ceil(y0)
local sy=cy0-y0
x0+=sy*dx
u0+=sy*du
v0+=sy*dv
for y=cy0,min(ceil(y1)-1,127)do
local x=nodes[y]
if x then
local a,au,av,b,bu,bv=x[1],x[2],x[3],x0,u0,v0
if(a>b)a,au,av,b,bu,bv=b,bu,bv,a,au,av
local x0,x1=ceil(a),ceil(b)-1
if x0<=x1 then
local dab=b-a
local dau,dav=(bu-au)/dab,(bv-av)/dab
local sa=x0-a
au+=sa*dau
av+=sa*dav
tline(x0,y,x1,y,au,av,dau,dav)
end
else
nodes[y]={x0,u0,v0}
end
x0+=dx
u0+=du
v0+=dv
end
x0,y0,u0,v0=_x1,_y1,_u1,_v1
end
end
zclass[[box,pos|rx,0,ry,0,touching,%box_touching,inside,%box_inside,outside,%box_outside,side,%box_side,abside,%box_abside,getdelta,%box_getdelta]]
function zsgn(num)
return num==0 and 0 or sgn(num)
end
function get_delta_axis(dx,x,rx,tdx,tdrx)
local xp=(x-tdx)/tdrx
return abs(xp)-rx/tdrx<1 and tdx+sgn(xp)*(rx+tdrx)-(x-dx)or dx
end
zclass[[pos|x,0,y,0,dist_point,%pos_dist_point]]
zclass[[vec,pos|dx,0,dy,0,vec_update,%vec_update]]
zclass[[mov,vec|ax,0,ay,0,ix,.8,iy,1,mov_update,%mov_update,towards_point,%mov_towards_point]]
MIN_SPEED=.0125
MAX_SPEED=.75
zclass[[room_bounds,box|x,@,y,@,rx,@,ry,@,tx_off,@,ty_off,@]]
function get_solid_tile(room,index)
local t2=room.tiles_2[index]
if t2 then return fget(t2,0)and t2 end
t2=room.tiles_1[index]
return fget(t2,0)and t2
end
zclass[[collidable,box,vec|calc_deltas,%calc_deltas,should_collide_with_screen_edge,yes,adjust_deltas_for_solids,%adjust_deltas_for_solids,adjust_deltas_for_tiles,%adjust_deltas_for_tiles,adjust_deltas_for_screen,%adjust_deltas_for_screen]]
function get_delta_axis2(dx,x,rx,tdx,tdrx)
local xp=(x-tdx)/tdrx
if abs(xp)+rx/tdrx>1 then
return tdx+sgn(xp)*(tdrx-rx)-(x-dx)
else
return dx
end
end
zclass[[tcol,vec,box|tile_solid,yes,tile_hit,nop,coll_tile,%tcol_coll_tile]]
function coll_tile_help(pos,per,spd,pos_rad,per_rad,dir,a,hit_func,solid_func)
local coll_tile_bounds=function(pos,rad)
return flr(pos-rad),-flr(-(pos+rad))-1
end
local pos_min,pos_max=coll_tile_bounds(pos+spd,pos_rad)
local per_min,per_max=coll_tile_bounds(per,per_rad)
for j=per_min,per_max do
if spd<0 and solid_func(pos_min,j)then
hit_func(a,dir)
return pos_min+pos_rad+1,0
elseif spd>0 and solid_func(pos_max,j)then
hit_func(a,dir+1)
return pos_max-pos_rad,0
end
end
return pos,spd
end
zclass[[ant,actor,tcol,mov,drawlayer_50|x,@,y,@,rx,.375,ry,.5,sind,7,xf,no,color,7,init,%ant_init,update,%ant_update,draw,%ant_draw,tile_hit,%ant_tile_hit]]
function find_in_room(sind,def_x,def_y)
for y=g_room_bounds.ty_off,g_room_bounds.ty_off+g_room_bounds.h-1 do
for x=g_room_bounds.tx_off,g_room_bounds.tx_off+g_room_bounds.w-1 do
if mget(x,y)==sind then
return x-g_room_bounds.tx_off+.5,y-g_room_bounds.ty_off+.5
end
end
end
return def_x,def_y
end
g_levels=zobj[[1;x,0,y,0,w,122,h,16,tx_off,0,ty_off,0;2;x,0,y,0,w,128,h,16,tx_off,0,ty_off,16;3;x,0,y,0,w,128,h,16,tx_off,0,ty_off,32;]]
g_fade,g_fade_table=1,zobj[[0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,0,0,0,0;2;,2,2,2,1,0,0,0,0;3;,3,3,3,3,1,1,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,0,0,0,0;6;,6,6,13,13,5,5,0,0;7;,7,7,6,13,13,5,0,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,0,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,0,0,0;13;,13,13,5,5,1,0,0,0;14;,14,14,13,4,2,2,0,0;15;,15,15,13,13,5,5,0,0;]]
function fade(threshold)
for c=0,15 do
pal(c,g_fade_table[c][1+flr(7*min(1,max(0,threshold)))],1)
end
end
zclass[[fader,actor|ecs_exclusions;actor,yes,timer,yes;]]
zclass[[fader_out,fader|start;duration,.5,destroyed,@,update,%fader_out_update]]
zclass[[fader_in,fader|start;duration,.5,update,%fader_in_update]]
zclass[[game_state,actor|ecs_exclusions;actor,true;curr,game;logo;init,%logo_init,update,nop,draw,%logo_draw,duration,2.5,next,game;game;init,%game_init,update,%game_update,draw,%game_draw;]]
function _init()
g_tl=_g.game_state()
end
function _update60()
g_zbtn_0,g_zbtn_2=zbtn(btn,0),zbtn(btn,2)
zcall(loop_entities,[[1;,actor,clean;2;,fader,clean;]])
register_entities()
zcall(loop_entities,[[1;,fader,tick;2;,game_state,tick;3;,fader,state;4;,game_state,state;]])
end
function _draw()
cls()
loop_entities("game_state","draw")
fade(g_fade)
end