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
_g=zobj([[actor_load,@,actor_loadlogic,@,actor_state,@,actor_is_alive,@,actor_kill,@,actor_clean,@,timer_reset_timer,@,timer_end_timer,@,timer_get_elapsed_percent,@,timer_is_active,@,timer_tick,@,box_touching,@,box_outside,@,box_inside,@,box_side,@,box_side2,@,box_abside,@,box_getdelta,@,box_getdelta,@,pos_dist_point,@,vec_update_x,@,vec_update_y,@,mov_update,@,adjust_deltas_for_solids,@,adjust_deltas_for_tiles,@,set_x_delta2,@,set_y_delta2,@,adjust_deltas_for_screen,@,grav_x_tile_check,@,grav_y_tile_check,@,pandas_col_y,@,spawn_panda,@,pbox_update,@,follow_panda_update,@,anchor_update_anchor,@,panda_update_control,@,panda_draw,@,panda_tile_hit,@,game_init,@,game_update,@,game_draw,@,fader_out_update,@,fader_in_update,@,logo_init,@,logo_draw,@]],function(a,stateName)
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
local magx=a.rx+b.rx
local magy=a.ry+b.ry
return(a.x-b.x)/magx,(a.y-b.y)/magy,magx,magy
end,function(a,b)
local xp,yp=a:side(b)
if abs(yp)>abs(xp)
then return 0,sgn(yp)
else return sgn(xp),0 end
end,function(a,b,dx,dy)
local b={x=b.x-dx,y=b.y-dy,rx=b.rx,ry=b.ry}
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
end,function(a,b,dx,dy)
local b={x=b.x-dx,y=b.y-dy,rx=b.rx,ry=b.ry}
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
end,function(a)
a.y+=a.dy
end,function(a)
a.dx+=a.ax a.dy+=a.ay
a.dx*=a.ix a.dy*=a.iy
if abs(a.dx)<MIN_SPEED then a.dx=0 end
if abs(a.dy)<MIN_SPEED then a.dy=0 end
if abs(a.dy)>MAX_SPEED then a.dy=sgn(a.dy)*MAX_SPEED end
a.ax=0 a.ay=0
end,function(a,setdelta,list)
foreach(list,function(b)
if a ~=b then
setdelta(a,b)
end
end)
end,function(a,checkfunc)
for tx=flr(a.x-a.rx)-1,ceil(a.x+a.rx)do
for ty=flr(a.y-a.ry)-1,ceil(a.y+a.ry)do
checkfunc(a,tx+.5,ty+.5,mget(g_bounds.tx_off+tx,g_bounds.ty_off+ty))
end
end
end,function(a,b)
b={x=b.x-a.dx,y=b.y,rx=b.rx,ry=b.ry}
local p=(a.x-b.x)/b.rx
if abs(p)+a.rx/b.rx>1 then
a.dx=b.x+sgn(p)*(b.rx-a.rx)-(a.x-a.dx)
end
end,function(a,b)
b={x=b.x,y=b.y-a.dy,rx=b.rx,ry=b.ry}
local p=(a.y-b.y)/b.ry
if abs(p)+a.ry/b.ry>1 then
a.dy=b.y+sgn(p)*(b.ry-a.ry)-(a.y-a.dy)
end
end,function(a,setdelta2)
if a.should_collide_with_screen_edge then
setdelta2(a,g_room_bounds)
end
end,function(a,tx,ty,loc)
if fget(loc,0)then
if fget(loc,4)then
local tile_box_left={x=tx+.125,y=ty,rx=.5,ry=.375}
local tile_box_right={x=tx-.125,y=ty,rx=.5,ry=.375}
if a:touching(tile_box_left)then
a.touching_left_wall=true
end
if a:touching(tile_box_right)then
a.touching_right_wall=true
end
end
a.dx,_=a:getdelta({x=tx,y=ty,rx=.5,ry=.5},a.dx,0)
end
end,function(a,tx,ty,loc)
if fget(loc,0)then
local tile_box_ground={x=tx,y=ty-.125,rx=.5,ry=.5}
if a:touching(tile_box_ground)then
a.touching_ground=true
end
_,a.dy=a:getdelta({x=tx,y=ty,rx=.5,ry=.5},0,a.dy)
elseif fget(loc,2)then
local b={x=tx,y=ty,rx=.5,ry=.5}
local xp,yp,magx,magy=_g.box_side2(a,b)
if a.dy>=0 and xp>-(b.rx-a.rx)/magx and xp<=1 then
if a.y>=(b.y-(-xp+1)*magy)*8\1/8+.125 then
a.touching_ground=true
a.y=(b.y-(-xp+1)*magy)*8\1/8+.125
a.dy=0
end
end
elseif fget(loc,3)then
local b={x=tx,y=ty,rx=.5,ry=.5}
local xp,yp,magx,magy=_g.box_side2(a,b)
if not(a:is_active"jump"and a.jumpdy>0)and abs(xp)<=1 and a.y<=ty-.5 and a.dy>=0 then
_,a.dy=a:getdelta(b,0,a.dy)
a.touching_ground=true
end
end
end,function(a)
for i=2,#a.pandas do
local aa,bb=a.pandas[i],a.pandas[1]
if aa.solid and bb.solid and aa:touching(bb)then
aa.touching_panda=true
aa.touching_ground=true
end
end
end,function(a)
local moves={}
foreach(a.pandas,function(panda)
add(moves,panda.moves)
panda:kill()
end)
g_pl=_g.panda(a.x,a.y,{},function(aa)
add(aa.moves,{btn(3),btn(4),btnp(5),zbtn(btn,0),zbtn(btn,2)})
_g.panda_update_control(aa,unpack(aa.moves[#aa.moves]))
end)
a.pandas={g_pl}
foreach(moves,function(m)
if #a.pandas<3 then
add(a.pandas,_g.panda(a.x,a.y,m,function(a)
if not a.move_ind then a.move_ind=1 end
if a.move_ind<=#a.moves then
_g.panda_update_control(a,unpack(a.moves[a.move_ind]))
a.move_ind+=1
end
end))
end
end)
end,function(a)
a.ay=.015
end,function(a)
local anchor=g_pbox
if g_pl then
anchor=g_pl
end
if anchor.touching_ground then
if g_zbtn_2>0 then
a.yoff=1
elseif g_zbtn_2<0 then
a.yoff=-1
else
a.yoff=0
end
else
a.yoff=0
end
a.x=anchor.x
local dist=(anchor.y+a.yoff)-a.y
if abs(dist)>.125 then
a.y+=dist/4
else
a.y=anchor.y+a.yoff
end
end,function(a)
a.x,a.y=a.anchoring.x+a.offx,a.anchoring.y+a.offy
end,function(a,b3,b4,bp5,zbtn0,zbtn2)
a.ax=0
a.ay=.015
a.ix=.95
a.iy=1
if bp5 then
g_pbox.x,g_pbox.y,a.x,a.y=a.x,a.y,g_pbox.x,g_pbox.y
elseif b4 and a.think_touch_ground then
a:start_timer("jump",.1)
if b3 then
a.jumpdx,a.jumpdy=false,JMPSP
else
a.jumpdx,a.jumpdy=false,-JMPSP
end
elseif a.touching_panda then
a:start_timer("jump",.1)
a.jumpdx,a.jumpdy=false,-JMPSP
a.touching_panda=false
elseif(b4 and a.active_ledge=="left")or(b4 and a.touching_left_wall)then
a:end_timer"jump"
if a.think_touch_ground then
a.active_ledge=nil
elseif a.touching_left_wall then
a.active_ledge="left"
a.ay=0 a.dx=-JMPSP a.iy=.8
if zbtn2 ~=0 then a.ay=.065/4*zbtn2 else a.dy=0 end
else
a.active_ledge=nil
a:start_timer("jump",.1)
a.jumpdx,a.jumpdy=0,-JMPSP/2
end
elseif(b4 and a.active_ledge=="right")or(b4 and a.touching_right_wall)then
a:end_timer"jump"
if a.think_touch_ground then
a.active_ledge=nil
elseif a.touching_right_wall then
a.active_ledge="right"
a.ay=0 a.dx=JMPSP a.iy=.8
if zbtn2 ~=0 then a.ay=.065/4*zbtn2 else a.dy=0 end
else
a.active_ledge=nil
a:start_timer("jump",.1)
a.jumpdx,a.jumpdy=0,-JMPSP/2
end
elseif not b4 and a.active_ledge=="left"then
a:start_timer("jump",.1)
a:start_timer("jump_recoil",.1)
if b3 then
a.jumpdx,a.jumpdy=JMPSP,JMPSP
else
a.jumpdx,a.jumpdy=JMPSP,-JMPSP
end
a.active_ledge=nil
elseif not b4 and a.active_ledge=="right"then
a:start_timer("jump",.1)
a:start_timer("jump_recoil",.1)
if b3 then
a.jumpdx,a.jumpdy=-JMPSP,JMPSP/2
else
a.jumpdx,a.jumpdy=-JMPSP,-JMPSP/2
end
a.active_ledge=nil
end
if a:is_active"jump"then
a.dx=a.jumpdx or a.dx
a.dy=a.jumpdy or a.dy
end
if not a:is_active"jump_recoil"and not a.active_ledge then
a.ix=.8
if zbtn0 ~=0 then
a.ax+=(a.touching_ground and.065/3 or.065/3)*zbtn0
a.xf=a.ax<0
end
else
if a.dx>0 then a.xf=false end
if a.dx<0 then a.xf=true end
end
if a.active_ledge then
a.sind=37
elseif not a.think_touch_ground then
if a:is_active"jump"then
a.sind=4
elseif a.dy>0 then
a.sind=6
else
a.sind=5
end
else
if a.dx ~=0 then
if t()%.25<.125 then
a.sind=3
else
a.sind=2
end
else
if t()%1<.5 then
a.sind=1
else
a.sind=2
end
end
end
if not a.touching_ground and a.think_touch_ground and not a:is_active"ground_timer"then
a:start_timer("ground_timer",.075,function()
a.think_touch_ground=false
end)
elseif a.touching_ground then
a.think_touch_ground=true
end
a.touching_left_wall=false
a.touching_right_wall=false
a.touching_ground=false
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
_g.fader_in()
g_pbox=_g.pbox(find_in_room(16))
g_follow_panda=_g.follow_panda()
end,function()
zcall(loop_entities,[[col_tile_func,@,pandas,@;1;,timer,tick;2;,actor,state;3;,mov,mov_update;4;,tcol,coll_tile,~col_tile_func;5;,collidable,adjust_deltas_for_tiles,%grav_x_tile_check;6;,vec,vec_update_x;7;,pbox,pandas_col_y;8;,collidable,adjust_deltas_for_tiles,%grav_y_tile_check;9;,vec,vec_update_y;10;,follow_panda,update;11;,anchor,update_anchor;]],function(x,y)
return x>=g_bounds.x and x<=g_bounds.w and
y>=g_bounds.y and y<=g_bounds.h and
fget(mget(g_bounds.tx_off+x,g_bounds.ty_off+y),0)
end,g_zclass_entities.panda)
end,function()
local camera_x=max(g_bounds.x,min((g_bounds.w-8)*8,g_follow_panda.x*8-32))
local camera_y=max(g_bounds.y,min((g_bounds.h-8)*8,g_follow_panda.y*8-32))
camera(camera_x,camera_y)
map(g_bounds.tx_off,g_bounds.ty_off,0,0,g_bounds.w,g_bounds.h,0x80)
loop_entities("drawlayer_25","draw")
loop_entities("drawlayer_50","draw")
loop_entities("drawlayer_75","draw")
camera()
end,function(a)
poke(0x5f43,0xff)
g_fade=a:get_elapsed_percent"start"
end,function(a)
g_fade=1-a:get_elapsed_percent"start"
end,function()sfx(63,0)end,function(a)
g_fade=cos(a:get_elapsed_percent"logo")+1
camera(g_fade>.5 and rnd_one())
zspr(108,32,32,4,2)
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
function zrect(x,y,rx,ry,color)rect(x-rx,y-ry,x+rx-1,y+ry-1,color)end
function scr_help_four(func,x1,y1,x2,y2,color)func(8*x1,8*y1,8*x2,8*y2,color)end
function scr_zrect(...)scr_help_four(zrect,...)end
zclass[[actor,timer|load,%actor_load,loadlogic,%actor_loadlogic,state,%actor_state,kill,%actor_kill,clean,%actor_clean,is_alive,%actor_is_alive,alive,yes,duration,null,curr,start,next,null,isnew,yes,init,nop,update,nop,destroyed,nop;]]
zclass[[drawlayer_25|]]
zclass[[drawlayer_50|]]
zclass[[drawlayer_75|]]
zclass[[timer|timers;,;start_timer,%timer_reset_timer,end_timer,%timer_end_timer,is_active,%timer_is_active,get_elapsed_percent,%timer_get_elapsed_percent,tick,%timer_tick,]]
zclass[[box,pos|rx,0,ry,0,touching,%box_touching,inside,%box_inside,outside,%box_outside,side,%box_side,abside,%box_abside,getdelta,%box_getdelta]]
function zsgn(num)
return num==0 and 0 or sgn(num)
end
function get_delta_axis(dx,x,rx,tdx,tdrx)
local xp=(x-tdx)/tdrx
return abs(xp)-rx/tdrx<1 and tdx+sgn(xp)*(rx+tdrx)-(x-dx)or dx
end
zclass[[pos|x,0,y,0,dist_point,%pos_dist_point]]
zclass[[vec,pos|dx,0,dy,0,vec_update_x,%vec_update_x,vec_update_y,%vec_update_y]]
MIN_SPEED=.0125
MAX_SPEED=.75
zclass[[mov,vec|ax,0,ay,0,ix,1,iy,1,mov_update,%mov_update]]
function get_solid_tile(room,index)
local t2=room.tiles_2[index]
if t2 then return fget(t2,0)and t2 end
t2=room.tiles_1[index]
return fget(t2,0)and t2
end
zclass[[collidable,box,vec|calc_deltas,%calc_deltas,should_collide_below,yes,should_collide_with_screen_edge,yes,adjust_deltas_for_solids,%adjust_deltas_for_solids,adjust_deltas_for_tiles,%adjust_deltas_for_tiles,adjust_deltas_for_screen,%adjust_deltas_for_screen]]
function find_in_room(sind,def_x,def_y)
for y=g_bounds.ty_off,g_bounds.ty_off+g_bounds.h-1 do
for x=g_bounds.tx_off,g_bounds.tx_off+g_bounds.w-1 do
if mget(x,y)==sind then
return x-g_bounds.tx_off+.5,y-g_bounds.ty_off+.5
end
end
end
return def_x,def_y
end
zclass[[pbox,actor,collidable,mov,drawlayer_25|x,@,y,@,rx,.25,ry,.25,sind,13,update,%pbox_update,draw,%panda_draw,pandas_col_y,%pandas_col_y,normal,yes,curr,idle;pandas;,;idle;duration,5,init,%spawn_panda,next,idle;]]
zclass[[follow_panda,mov|x,0,y,43,update,%follow_panda_update]]
zclass[[anchor,pos|update_anchor,%anchor_update_anchor;offx,0,offy,0,anchoring;,]]
zclass[[panda,actor,collidable,mov,drawlayer_50|x,@,y,@,moves,@,update,@,rx,.25,ry,.25,sind,1,xf,no,touching_panda,yes,draw,%panda_draw,tile_hit,%panda_tile_hit;start;duration,1,next,normal;normal;solid,yes;]]
JMPSP=.125
g_bounds=zobj[[x,0,y,0,w,128,h,64,tx_off,0,ty_off,0]]
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
poke(0x5f2c,3)
poke(0x5f5c,255)
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
cls(12)
loop_entities("game_state","draw")
fade(g_fade)
end