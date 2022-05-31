g_obj_map=split[[bedpillow,bedblanket,pot,house231,navyblock,signlank,signkeep,signnavy,signteach,signlark,signjane,house224,house225,house226,house227,house228,house229,navyhouse,bobblock,bobhouse,keep,teach,jane,lark,r1spike,r2spike,l1spike,l2spike,saveplat,woodtbl,greytbl,soupbucket,slimy,miny,woodcrate,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]]
function decode_map()
local rooms,cur_loc={},0x2000
local peek_inc=function()
cur_loc+=1
return@(cur_loc-1)
end
while@cur_loc ~=255 do
local room,room_ind=zobj[[tiles_1;,;tiles_2;,;objects;,;w,12,h,10,color,0,music,0]],peek_inc()
if room_ind>223 then room.w,room.h=8,6 end
room.color=0x0f &@cur_loc
room.music=(0xf0 & peek_inc())>>>4
local byte,is_tile,layer,ind,offx,offy,is_fill=0,true,room.tiles_1,0,0,0
while byte ~=255 do
byte=peek_inc()
if byte>=248 and byte<=253 then
is_fill,is_tile=nil
end
if byte==248 then is_tile=true layer=room.tiles_1
elseif byte==249 then is_tile=true layer=room.tiles_2
elseif byte==250 then offx=0 offy=0
elseif byte==251 then offx=.5 offy=0
elseif byte==252 then offx=0 offy=.5
elseif byte==253 then offx=.5 offy=.5
elseif byte==254 then is_fill=true
elseif byte<128 then ind=byte
elseif byte<255 then
local p1=0x7f & byte
if is_tile then
if is_fill then
local p2=0x7f & peek_inc()
for yy=p1\12,p2\12 do
for xx=p1%12,p2%12 do
layer[yy*12+xx]=ind+128
end
end
else
layer[p1]=ind+128
end
else
add(room.objects,{index=ind+1,x=p1%12+offx,y=p1\12+offy})
end
end
end
rooms[room_ind]=room
end
return rooms
end
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
_g=zobj([[actor_load,@,actor_state,@,actor_is_alive,@,actor_kill,@,actor_clean,@,animation_init,@,auto_outline_draw,@,timer_start_timer,@,timer_stop_timer,@,timer_play_timer,@,timer_delete_timer,@,timer_get_elapsed,@,timer_get_elapsed_percent,@,timer_is_active,@,timer_tick,@,box_touching,@,box_outside,@,box_inside,@,box_side,@,box_abside,@,box_getdelta,@,pos_dist_point,@,vec_update,@,mov_update,@,mov_towards_point,@,explode_draw,@,standard_explosion,@,calc_deltas,@,adjust_deltas_for_solids,@,adjust_deltas_for_tiles,@,adjust_deltas_for_screen,@,healthobj_hurt,@,healthobj_health_update,@,inventory_start_init,@,inventory_start_update,@,inventory_press_update,@,inventory_draw,@,simple_spr_draw,@,anchor_update_anchor,@,targettouch_update_target,@,arrow_draw,@,bow_ending_init,@,shield_item_hit_func,@,banjo_start_init,@,banjo_ending_init,@,item_horizontal_start_init,@,item_horizontal_normal_init,@,item_horizontal_ending_init,@,brang_drawout,@,brang_start_init,@,brang_normal_update,@,brang_ending_init,@,brang_ending_update,@,bomb_start_init,@,bomb_destroyed,@,bomb_ending_update,@,pl_update,@,pl_drawout,@,rstat_update,@,rstat_set,@,rstat_get,@,rstat_get,@,stat_draw,@,tbox_init,@,tbox_update,@,tbox_draw,@,fairy_update,@,fairy_draw,@,spawn_walls,@,house_init,@,person_target_with_tbox_disable_callback,@,person_target_with_tbox_finish_callback,@,target_with_tbox_init,@,sign_target_with_tbox_disable_callback,@,slimy,@,miny,@,slimy_destroyed,@,slimy_start,@,slimy_shake,@,slimy_jump,@,slimy_statcollide,@,saveplat_update,@,fader_out_update,@,fader_in_update,@,logo_init,@,logo_draw,@,gameover_control_ending,@,gameover_init,@,gameover_draw,@,room_init,@,room_update,@,room_draw,@,title_init,@,simple_update,@,title_draw,@,title_logo_update,@,title_logo_drawout,@,game_state_init,@]],function(a,stateName)
if stateName then
a.next,a.duration=nil
for k,v in pairs(a[stateName])do a[k]=v end
a.curr=stateName
a:stop_timer(a.curr,a.duration,a.duration and function()a:load(a.next)end)
else
a.alive=false
end
end,function(a)
if a:get_elapsed(a.curr)==nil then a:load(a.curr)end
if a:get_elapsed(a.curr)==false then a:play_timer(a.curr)a:init()end
a:update()
end,function(a)
return not a:get_elapsed"ending"and a.alive
end,function(a)
if a.ending then
if a.curr=="start"then
a.next="ending"
elseif not a:get_elapsed"ending"then
a:load"ending"
end
else
a.alive=nil
end
end,function(a)if not a.alive then a:destroyed()deregister_entity(a)end end,function(a)
a.index+=1
a.index%=60
end,function(a)
draw_outline(a.outline_color,function()a:drawout()end)
a:drawout()
end,function(...)
_g.timer_stop_timer(...)
_g.timer_play_timer(...)
end,function(a,timer_name,duration,callback)
a.timers[timer_name]={elapsed=false,duration=0+(duration or 32767),callback=callback or function()end}
end,function(a,timer_name)
if a.timers[timer_name]and not a.timers[timer_name].elapsed then
a.timers[timer_name].elapsed=0
end
end,function(a,timer_name)
a.timers[timer_name]=nil
end,function(a,timer_name)
local timer=a.timers[timer_name]
return timer and(timer.elapsed or false)
end,function(a,timer_name)
local timer=a.timers[timer_name]
return timer and min(1,(timer.elapsed or 0)/timer.duration)
end,function(a,timer_name)
local timer=a.timers[timer_name]
return timer and timer.elapsed and timer.elapsed<timer.duration
end,function(a)
local finished_timers={}
for name,timer in pairs(a.timers)do
if timer.elapsed and timer.elapsed<=timer.duration then
timer.elapsed=timer.elapsed+1/60
if timer.elapsed>=timer.duration then
add(finished_timers,timer)
end
end
end
foreach(finished_timers,function(timer)
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
local ax,ay=a.speed*cos(a.ang),a.speed*sin(a.ang)
a.dx+=ax a.dy+=ay
a.dx*=.80 a.dy*=.80
if ax==0 and abs(a.dx)<.01 then a.dx=0 end
if ay==0 and abs(a.dy)<.01 then a.dy=0 end
end,function(a,x,y)
a.ang=atan2(x-a.x,y-a.y)
end,function(a)
for i=0,a.len-1 do
scr_zrect(a.x+sin(a:get_elapsed_percent"start"/2)*cos(i/a.len+.125),a.y+sin(a:get_elapsed_percent"start"/2)*sin(i/a.len+.125),i%a.mod*.125+.125,i%a.mod*.125+.125,1)
end
end,function(a)
_g.explode(a.x,a.y,4,1,nop)
end,function(a,b)
local box={x=b.x-a.dx,y=b.y-a.dy,rx=b.rx,ry=b.ry}
return a:getdelta(box,a.dx,a.dy)
end,function(a,list)
foreach(list,function(b)
local box={x=b.x-a.dx,y=b.y-a.dy,rx=b.rx,ry=b.ry}
a.dx,a.dy=a:getdelta(box,a.dx,a.dy)
end)
end,function(a,room)
for tx=max(flr(a.x-a.rx)-1,0),min(ceil(a.x+a.rx),12-1)do
for ty=flr(a.y-a.ry)-1,ceil(a.y+a.ry)do
local sind=get_solid_tile(room,ty*12+tx)
if sind then
local rx,ry=.5,.5
if not fget(sind,1)or fget(sind,1)and a.should_collide_below then
if fget(sind,2)then rx,ry=.375,.375 end
a.dx,a.dy=a:calc_deltas{x=tx+.5,y=ty+.5,rx=rx,ry=ry}
end
end
end
end
end,function(a)
if a.should_collide_with_screen_edge then
local box={x=g_room_bounds.x-a.dx,y=g_room_bounds.y-a.dy,rx=g_room_bounds.rx,ry=g_room_bounds.ry}
a.dx=get_delta_axis2(a.dx,a.x,a.rx,box.x,box.rx)
a.dy=get_delta_axis2(a.dy,a.y,a.ry,box.y,box.ry)
end
end,function(a,amount)
a.health=max(0,min((a.health or a.max_health)-amount,a.max_health))
end,function(a)
a.health=a.health or a.max_health
a.display_health=a.display_health or a.health/a.max_health
local diff=a.health/a.max_health-a.display_health
a.display_health+=zsgn(diff)*min(abs(diff),.05)
if a.health<=0 then a:kill()end
end,function(a)
a.stat=peek"0x5d08" ~=4 and{cspr=a[peek"0x5d08"+1].sind}
end,function(a)
g_rstat_inventory:set(a.stat)
if not does_entity_exist"fader"and not does_entity_exist"tbox"and not does_entity_exist"banjo"and btn"5"then
poke(0x5d08,9)
a.ind=4
a:load"expand"
end
end,function(a)
a.ind=mid(0,2,a.ind%3+zbtn(btnp,0))+mid(0,2,a.ind\3+zbtn(btnp,2))*3
if does_entity_exist"fader"or does_entity_exist"tbox"or not btn"5"then
poke(0x5d08,peek(a[a.ind+1].mem_loc)~=0 and a.ind or 4)
a:load"contract"
end
end,function(a)
local percent=a.curr=="contract"and(1-a:get_elapsed_percent"contract")or a:get_elapsed_percent"expand"
zrect(a.pl.x*8,a.pl.y*8-2,percent*8,percent*8,1)
for item in all(a)do
local exist=peek(item.mem_loc)~=0
local sind=exist and item.sind or 0
local sxo,syo=exist and item.sxo or 0,exist and item.syo or 0
local drawfunc=function()
zspr(sind,sxo+a.pl.x*8+item.xoff*percent,syo+a.pl.y*8+item.yoff*percent,1,1,item.flip_enabled and a.pl.xf)
end
draw_outline(item.index==a.ind and 2 or 1,drawfunc)
drawfunc()
end
end,function(a)
zspr(a.sind,a.x*8+a.sx,a.y*8+a.sy,a.sw,a.sh,a.xf,a.yf)
end,function(a)
a.offx+=a.offdx a.offy+=a.offdy
a.x,a.y=a.anchoring.x+a.offx,a.anchoring.y+a.offy
end,function(target,objs)
foreach(objs,function(a)
if target:outside(a)then
target:callback_outside(a)
else
target:callback_touch(a)
end
end)
end,function(a)
draw_tail(a.x,a.y,a.dx,0,3)
pset(a.x*8,a.y*8,12)
end,function(a)
_g.item_horizontal_ending_init(a)
_g.arrow(a.x,a.y-.125,a.xf*.25,a.xf)
end,function(a)
a.anchoring.dx-=a.plpushspeed*a.xf
end,function(a)
sfx(5,0)
sfx(6,1)
sfx(7,2)
end,function(a)
sfx(5,-2)
sfx(6,-2)
sfx(7,-2)
if(g_rstat_right:get()or{}).id=="saveplat"and a:get_elapsed_percent"min_play"and a:get_elapsed_percent"min_play">=1 then
zcall(poke,[[1;,0x5d02,@;2;,0x5d03,@;3;,0x5d04,@;]],a.anchoring.x*16,
a.anchoring.y*16,
(a.anchoring.xf+1)\2
)
memcpy(0x5e00,0x5d00,64)
_g.tbox("great banjo playing.^saving complete!",nop)
end
end,function(a)a.offdx=a.xf*a.offspeed end,function(a)a.offx=abs(a.offx*8)\1/8*sgn(a.offx)end,function(a)a:normal_init()a.offdx=-a.xf*a.offspeed end,function(a)
zspr(a.sind,a.x*8+a.sx,a.y*8+a.sy,1,1,cos(g_fi/5),sin(g_fi/5))
end,function(a)
a.x,a.y=a.anchoring.x,a.anchoring.y
a.ang=atan2(a.xf,0)
end,function(a)
a.speed=0
if g_zbtn_0|g_zbtn_2 ~=0 then
a.ang,a.speed=atan2(g_zbtn_0,g_zbtn_2),.0375
end
end,function(a)
a.end_x,a.end_y=a.x,a.y
end,function(a)
local percent=a:get_elapsed_percent"ending"
a.x=a.end_x+(a.anchoring.x-a.end_x)*percent
a.y=a.end_y+(a.anchoring.y-a.end_y)*percent
end,function(a)
a.x,a.y=a.anchoring.x+a.xf,a.anchoring.y
a.dx=a.dx+a.xf*.125
end,function(a)
_g.explode(a.x,a.y,8,2,nop)
end,function(a)
a.rx+=.05
a.ry+=.05
end,function(a)
g_rstat_left:set(a)
local item=a.item
if not item.alive then item=a.default_item end
if btn(5)or does_entity_exist"tbox"or does_entity_exist"fader"or a.is_energy_cooling_down or not btn"4"then
item:kill()
elseif not a.is_energy_cooling_down and item.is_default and btn"4"then
local item_func=a.item_funcs[peek"0x5d08"]
if item_func then
item=item_func(a,a.xf)
a.target_energy+=item.initial_energy
end
end
a.speed=0
if not a:inside(g_room_bounds)then
a.ang,a.speed=atan2(a:abside(g_room_bounds)),.025
elseif not does_entity_exist"fader"and not does_entity_exist"tbox"and not btn(5)then
if g_zbtn_0|g_zbtn_2 ~=0 then
a.ang,a.speed=atan2(g_zbtn_0,g_zbtn_2),.025*item.speed_multiplier
if not item.block_direction and cos(a.ang)~=0 then
a.xf=sgn(cos(a.ang))
end
end
end
a.target_energy=max(0,a.target_energy+item.gradual_energy)
if a.target_energy==0 then a.is_energy_cooling_down=false
elseif a.target_energy>=1 then a.is_energy_cooling_down=true
end
local diff=a.target_energy-a.energy
a.energy+=zsgn(diff)*min(abs(diff),.03125)
a.item,a.sind=item,a.dx|a.dy ~=0 and 88+t()*12%3 or 88
end,function(a)
local xf=a.xf
local top=91
if does_entity_exist"banjo"then
top=92
end
zspr(a.sind,a.x*8,a.y*8-2,1,1,xf)
zspr(top,a.x*8,a.y*8-2,1,1,xf)
if a.item.visible then
zspr(a.item.sind,a.item.x*8,a.item.y*8-2,1,1,xf)
end
end,function(a)
local buffer=a.buffer
a.buffer={}
local cur_obj,first_obj=a.stat and a.stat.obj,buffer[1]
for obj in all(buffer)do
if cur_obj==obj then return end
end
if does_entity_exist"tbox"then return end
if a.stat then a.stat:load"ending" end
a.stat=first_obj and _g.stat(a.align,a.x,first_obj)
end,function(a,s)
add(a.buffer,s)
end,function(a)
return a.stat and a.stat.obj
end,function(a)
return a.stat and a.stat.obj
end,function(a)
local obj=a.obj
if align ~=0 then
zcamera(a.x+2,a.y,function()
local xyo=-8*a.align-1
if obj.cname then zprinttbox(obj.cname,xyo,-10,a.align,7,5)end
if obj.parents and obj.parents.healthobj then
draw_bar(xyo,-2,xyo-35*a.align,1,obj.display_health,-1,11,3)
zprinttbox(flr(obj.health).."/"..obj.max_health,xyo,4,a.align,7,5)
end
end)
end
draw_card(a.x,a.y+(does_entity_exist"tbox"and 0 or-cos(g_si/4)*a.align),6,8,2,4,function()
spr(obj.cspr,0,0,1,1,a.align>0)
end,nop)
end,function(a)
a.texts=split(a.rawtext,"^")
end,function(a)
local text1=a.texts[a.cur_text_index]
local text2=a.texts[a.cur_text_index+1]or ""
local textslen=#text1+#text2+4
a.line_1=sub(text1,1,a.anim)
a.line_2=sub(text2,1,max(0,a.anim-#text1))
if a.anim==textslen then
a.done=true
end
if btnp(4)or btnp(5)then
if a.anim==textslen then
if a.cur_text_index+2>#a.texts then
a:load"ending"
else
a.cur_text_index+=2
a:load"normal"
end
else
a.anim=textslen
end
end
a.anim=min(textslen,a.anim+.5)
end,function(a)
draw_card(65,a.y,46.5,10,2.5,5,
function()
zcall(zprinttbox,[[1;,@,0,-2,-1,7,5;2;,@,0,6,-1,7,5;]],a.line_1 or "",a.line_2 or "")
end,function()
if a.done then
zspr(38,44,16+g_si%2)
end
end)
end,function(a)
local relact=g_rstat_right:get()or g_pl
local offx,offy=relact.x+(t()\10%2==0 and 1 or-1)*cos(t()*.75),relact.y+sin(t()*.75)-.25
a:towards_point(offx,offy)
a.speed=a:dist_point(offx,offy)*.013
end,function(a)
draw_tail(a.x,a.y,a.dx,a.dy,6)
scr_pset(a.x,a.y,13)
end,function(a)
zcall_tbl(_g.wall,a.walls)
end,function(a)
_g.spawn_walls(a)
zcall(_g.target,[[1;,.125,.375,0,.5,@,@,nop;]],a,function()
zcall(poke,[[1;,0x5d05,@;2;,0x5d06,@;3;,0x5d07,@;]],peek"0x5d01",
a.x*16,
(a.y+1.5)*16
)
load_room(a.room,4,5,g_pl.xf)
end)
end,function(a)
local abx=a:abside(g_pl)
a.xf=sgn(g_pl.x-a.x)
return peek"0x5d08" ~=4 or abx==-g_pl.xf
end,function(a)
poke(a.memloc_trigger,a.memloc_trigger_value)
load_room(%0x5d01,g_pl.x,g_pl.y,g_pl.xf)
end,function(a)
_g.target(a.trx,a.try,a.tx,a.ty,a,function()
if not a:target_with_tbox_disable_callback()then
g_rstat_right:set(a)
if btnp"4"and not does_entity_exist"tbox"then
_g.tbox(a.text,function()
a:target_with_tbox_finish_callback()
end)
end
end
end,nop)
end,function(a)
return peek"0x5d08" ~=4
end,function(x,y)
_g.explode(x,y,4,1,function()_g.slimy_actual(x,y)end)
end,function(x,y)
_g.explode(x,y,4,1,function()_g.miny_actual(x,y)end)
end,function(a)
_g.miny(a.x,a.y-.5)
_g.miny(a.x,a.y+.5)
end,function(a)
if a.isma then g_rstat_right:set(a)end
a.xf=sgn(g_pl.x-a.x)
a.target_ang=atan2(g_pl.x-a.x,g_pl.y-a.y)
end,function(a)
if a.isma then g_rstat_right:set(a)end
a.sx=rnd_one()
end,function(a)
if a.isma then g_rstat_right:set(a)end
a.ang=a.target_ang
a.sy=sin(a:get_elapsed_percent"jump"/2)*8
end,function(a,items)
foreach(items,function(item)
if not a:outside(item)and item:is_alive()then
a:start_timer("isma",1.5,function()a.isma=false end)
a.isma=true
if not a:is_active"stunned"then
a:start_timer("stunned",item.stunlen,nop)
a:hurt(item.damage)
end
item:item_hit_func()
if item.should_use_xf then
a.dx+=item.pushspeed*item.xf
else
local abx,aby=a:abside(item)
a.dx+=item.pushspeed*abx
a.dy+=item.pushspeed*aby
end
end
end)
end,function(a)
if not a:outside(g_pl)then
g_rstat_right:set(a)
end
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
end,function(a)
_g.fader_out(function()g_state:load"room" end)
end,function(state)
_g.gameover_control()
state.game_over_sind,state.game_over_text=unpack(rnd_item(zobj[[1;,32,quack quack;2;,68,and play with me;3;,9,to save hi-roll;4;,81,in time for dinner;5;,83,and make me rich;6;,96,the banjo awaits you;7;,99,for your fans;8;,118,splat splat boing;]]))
end,function(state)
local drawfunc=function()
zspr(state.game_over_sind,0,g_si%2,1,1,true,false,1)
end
zcall(zprinttbox,[[1;,come back lank,64,38,0,10,4,1;2;,@,64,69,0,7,5,1;]],state.game_over_text)
draw_card(64,56+g_si%2,6,8,2,4,function()
spr(state.game_over_sind,0,0)
end,nop)
end,function(state)
local r=g_rooms[peek"0x5d01"]
local mus=flr(r.music/2)*8+(r.music%2)*5
poke(0x5f43,0)
if g_music_ind ~=mus then
g_music_ind=mus
music(mus,0,7)
end
g_room_bounds=_g.room_bounds(r.w/2,r.h/2,r.w/2-.375,r.h/2-.375)
g_pl=_g.pl(peek"0x5d02"/16,peek"0x5d03"/16,peek"0x5d04"*2-1)
g_fairy=_g.fairy(g_pl.x,g_pl.y-.125)
g_rstat_left,g_rstat_inventory,g_rstat_right=_g.rstat(-1,10),_g.rstat(0,64),_g.rstat(1,118)
_g.inventory(g_pl)
foreach(r.objects,function(obj_template)
_g[g_obj_map[obj_template.index]](obj_template.x+.5,obj_template.y+.5)
end)
end,function(state)
zcall(loop_entities,[[1;,timer,tick;2;,actor,state;3;,mov,mov_update;4;,collidable,adjust_deltas_for_solids,@;5;,collidable,adjust_deltas_for_tiles,@;6;,collidable,adjust_deltas_for_screen;7;,vec,vec_update;8;,slimy_actual,statcollide,@;9;,anchor,update_anchor;10;,target,update_target,@;11;,rstat,update;12;,healthobj,health_update;]],g_zclass_entities.solid,g_rooms[peek"0x5d01"],g_zclass_entities.statitem,g_zclass_entities.pl)
if not does_entity_exist"fader"and not g_pl:inside(g_room_bounds)then
local abx,aby=g_pl:abside(g_room_bounds)
local nri=peek"0x5d01"+aby*16+abx
if peek"0x5d01">223 then
load_room(peek"0x5d05",peek"0x5d06"/16,peek"0x5d07"/16,g_pl.xf)
elseif g_rooms[nri]then
if abx ~=0 then load_room(nri,6-abx*6+1.25*abx,g_pl.y,abx)
else load_room(nri,g_pl.x,5-aby*5+1.25*aby+.25,g_pl.xf)
end
else
zcall(load_room,[[1;,151,6,5,@;]],g_pl.xf)
end
end
end,function(state)
isorty(g_zclass_entities["drawlayer_50"])
draw_room(g_rooms[peek"0x5d01"],64,57,function()
zcall(loop_entities,[[1;,drawlayer_25,draw;2;,drawlayer_50,draw;3;,drawlayer_75,draw;]])
end,function()
zcall(loop_entities,[[1;,drawlayer_90,draw;2;,drawlayer_95,draw;3;,drawlayer_99,draw;]])
end)
zcall(draw_bar,[[1;,18,6,109,11,@,0,@,@]],g_pl.energy,g_pl.is_energy_cooling_down and 13 or 8,g_pl.is_energy_cooling_down and 1 or 2)
end,function()
_g.title_logo()
end,function()
if does_entity_exist"fader"then return end
zcall(loop_entities,[[1;,timer,tick;2;,actor,state;]])
end,function()
draw_room(g_rooms[136],64,57,nop,nop)
zcall(loop_entities,[[1;,drawlayer_99,draw;]])
zcall(zprinttbox,[[1;,code/sfx:  @alanxoc3  ,64,104,0,7,5;2;,tile/spr:  @greatcadet,64,114,0,7,5;3;,amorg games presents,64,6,0,7,5;]])
end,function(a)
if btnp"4"or btnp"5"then
_g.fader_out(function()g_state:load"room" end)
end
end,function(a)
for i=-2,2 do
zspr(45+i,i*10+64,57+cos((g_si+i)/4)/2,1,2)
end
zcall(zprinttbox,[[1;,not the story of,64,39,0,10,4;]])
if g_si%2==0 then
zcall(zprinttbox,[[1;,🅾️ or ❎ to play  ,64,68,0,7,5;]])
end
end,function(state)
clean_all_entities"game_state"
_g.fader_in()
g_slow_animation=_g.animation".5"
g_fast_animation=_g.animation".05"
state:state_init()
end)
function rnd_item(list)return list[flr_rnd(#list)+1]end
function rnd_one(val)return rnd_item{-1,0,1}end
function flr_rnd(x)return flr(rnd(x))end
function zbtn(f,a)return f(a)and f(a+1)and 0 or f(a)and-1 or f(a+1)and 1 or 0 end
function zspr(sind,x,y,sw,sh,xf,yf)
sw,sh=sw or 1,sh or 1
xf,yf=xf and xf<0,yf and yf<0
x,y=x-sw*4,y-sh*4
spr(sind,flr(x+.5),flr(y+.5),sw,sh,xf,yf)
end
function zcamera(x,y,func)
camera(-x,-y)func()camera()
end
function zprint(str,x,y,align,color)
if align==0 then x-=#str*2
elseif align>0 then x-=#str*4+1 end
print(str,x,y,color)
end
function zprinttbox(str,x,y,align,fg,bg)
zprint(str,x,y+1,align,bg)
zprint(str,x,y,align,fg)
end
function zcall_tbl(func,tbl)
foreach(tbl,function(params)
func(unpack(params))
end)
end
function zcall(func,text,...)
zcall_tbl(func,zobj(text,...))
end
function zrect(x,y,rx,ry,color)rect(x-rx,y-ry,x+rx-1,y+ry-1,color)end
function zrectfill(x,y,rx,ry,color)rectfill(x-rx,y-ry,x+rx-1,y+ry-1,color)end
function scr_help_four(func,x1,y1,x2,y2,color)func(8*x1,8*y1,8*x2,8*y2,color)end
function scr_zrect(...)scr_help_four(zrect,...)end
function scr_zrectfill(...)scr_help_four(zrectfill,...)end
function scr_line(...)scr_help_four(line,...)end
function scr_pset(x,y,color)pset(8*x,8*y,color)end
zclass[[actor,timer|load,%actor_load,state,%actor_state,kill,%actor_kill,clean,%actor_clean,is_alive,%actor_is_alive,alive,yes,duration,null,curr,start,next,null,init,nop,update,nop,destroyed,nop;]]
zclass[[drawlayer_25|]]
zclass[[drawlayer_50|]]
zclass[[drawlayer_75|]]
zclass[[drawlayer_90|]]
zclass[[drawlayer_95|]]
zclass[[drawlayer_99|]]
zclass[[animation,actor|index,0,init,%animation_init;start;duration,@,next,start]]
zclass[[auto_outline|draw,%auto_outline_draw,outline_color,1]]
function draw_outline(color,drawfunc)
for c=1,15 do pal(c,color)end
local ox,oy=%0x5f28,%0x5f2a
for y=-1,1 do for x=-1,1 do
camera(ox+x,oy+y)drawfunc()
end end
camera(ox,oy)
pal()
end
function isorty(t)
for n=2,#t do
local i=n
while i>1 and t[i].y<t[i-1].y do
t[i],t[i-1]=t[i-1],t[i]
i=i-1
end
end
end
zclass[[timer|timers;,;start_timer,%timer_start_timer,stop_timer,%timer_stop_timer,play_timer,%timer_play_timer,is_active,%timer_is_active,delete_timer,%timer_delete_timer,get_elapsed,%timer_get_elapsed,get_elapsed_percent,%timer_get_elapsed_percent,tick,%timer_tick,]]
function loop_through_tiles(room,func)
for tiles in all{room.tiles_1,room.tiles_2}do
for location,index in pairs(tiles)do
local x,y=location%12,location\12
func(lookup_tile_animation(index),x*8,y*8)
end
end
end
function draw_room(room,center_x,center_y,post_tile_func,post_card_func)
local x1,y1=center_x-room.w*8\2,center_y-room.h*8\2
draw_card(center_x,center_y,room.w*4-2,room.h*4-2,-2,-2,function()
rectfill(0,0,127,127,room.color)
loop_through_tiles(room,spr)
post_tile_func(x1,y1)
end,post_card_func)
end
function create_tile_animation_lookup(room)
local lookup={}
for layer in all{room.tiles_1,room.tiles_2}do
for x=0,11 do
local tbl={}
for y=0,9 do add(tbl,layer[y*12+x])end
lookup[layer[x]or 0]=tbl
end
end
return lookup
end
function lookup_tile_animation(sind)
local anim=g_tile_animation_lookup[sind]
return anim and anim[g_si%#anim+1]or sind
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
zclass[[mov,vec|ang,0,speed,0,mov_update,%mov_update,towards_point,%mov_towards_point]]
zclass[[explode,actor,drawlayer_50|x,@,y,@,len,@,mod,@,destroyed,@,draw,%explode_draw;start;duration,.25;]]
function get_solid_tile(room,index)
local t2=room.tiles_2[index]
if t2 then return fget(t2,0)and t2 end
t2=room.tiles_1[index]
return fget(t2,0)and t2
end
zclass[[collidable,box,vec|calc_deltas,%calc_deltas,should_collide_below,yes,should_collide_with_screen_edge,yes,adjust_deltas_for_solids,%adjust_deltas_for_solids,adjust_deltas_for_tiles,%adjust_deltas_for_tiles,adjust_deltas_for_screen,%adjust_deltas_for_screen]]
function get_delta_axis2(dx,x,rx,tdx,tdrx)
local xp=(x-tdx)/tdrx
if abs(xp)+rx/tdrx>1 then
return tdx+sgn(xp)*(tdrx-rx)-(x-dx)
else
return dx
end
end
zclass[[healthobj|max_health,1,hurt,%healthobj_hurt,health_update,%healthobj_health_update]]
zclass[[inventory,actor,drawlayer_90|pl,@,ind,4;start;init,%inventory_start_init,update,%inventory_start_update,draw,nop;press;init,nop,update,%inventory_press_update,draw,%inventory_draw;expand;init,nop,update,nop,draw,%inventory_draw,duration,.0625,next,press;contract;init,nop,update,nop,draw,%inventory_draw,duration,.0625,next,start;1;mem_loc,0x5d12,index,0,name,bomb,sxo,-1,syo,1,xoff,-7,yoff,-9,sind,5;2;mem_loc,0x5d10,index,1,name,bowl,sxo,0,syo,-1,xoff,0,yoff,-10,sind,8;3;mem_loc,0x5d15,index,2,name,mask,sxo,1,syo,1,xoff,7,yoff,-9,sind,3;4;mem_loc,0x5d13,index,3,name,shield,sxo,0,syo,0,xoff,-8,yoff,-2,sind,6;5;mem_loc,0x5dff,sxo,0,syo,0,xoff,0,yoff,0,sind,0;6;mem_loc,0x5d16,index,5,name,sword,sxo,1,syo,0,xoff,8,yoff,-2,sind,2;7;mem_loc,0x5d17,index,6,name,banjo,sxo,1,syo,0,xoff,-7,yoff,5,sind,1;8;mem_loc,0x5d11,index,7,name,brang,sxo,1,syo,1,xoff,0,yoff,6,sind,4;9;mem_loc,0x5d14,index,8,name,bow,sxo,0,syo,0,xoff,7,yoff,5,sind,7;10;mem_loc,0x5d00,index,4,sxo,0,syo,-2,xoff,0,yoff,0,sind,103,flip_enabled,on;]]
zclass[[solid,box|]]
zclass[[wall,solid,anchor|anchoring,@,offx,@,offy,@,rx,@,ry,@]]
zclass[[simple_spr,auto_outline,pos|drawout,%simple_spr_draw,sind,0,sw,1,sh,1,xf,1,yf,1,sx,0,sy,0]]
zclass[[anchor,pos|update_anchor,%anchor_update_anchor;offx,0,offy,0,offdx,0,offdy,0,anchoring;,]]
zclass[[target,anchor,box|rx,@,ry,@,offx,@,offy,@,anchoring,@,callback_touch,@,callback_outside,@,update_target,%targettouch_update_target]]
zclass[[statitem,box|]]
zclass[[item_horizontal,anchor|offspeed,0,normal_init,%item_horizontal_normal_init;start;init,%item_horizontal_start_init,duration,.08,next,normal;normal;init,%item_horizontal_normal_init,offdx,0;ending;init,%item_horizontal_ending_init,duration,.08;]]
zclass[[mask,anchor,actor|anchoring,@,xf,@,visible,yes,block_direction,no,speed_multiplier,2,initial_energy,.125,gradual_energy,.0078125,offy,.2,sind,3;start;offdy,-.0625,duration,.08,next,normal;normal;offy,-.125,offdy,0;ending;offdy,.0625,duration,.08;]]
zclass[[bow,item_horizontal,actor|anchoring,@,xf,@,visible,yes,block_direction,yes,speed_multiplier,.5,initial_energy,.25,gradual_energy,0,offspeed,.105,sind,7;ending;init,%item_horizontal_ending_init,duration,.08;ending;init,%bow_ending_init,duration,.08;]]
zclass[[arrow,vec,actor,drawlayer_50,statitem|x,@,y,@,dx,@,xf,@,damage,1,stunlen,.125,pushspeed,.375,should_use_xf,yes,item_hit_func,~kill,rx,.375,ry,.125,destroyed,%standard_explosion,draw,%arrow_draw;start;duration,.5;]]
zclass[[shield,item_horizontal,actor,statitem|anchoring,@,xf,@,rx,.25,ry,.5,damage,0,stunlen,2,pushspeed,.25,should_use_xf,yes,item_hit_func,%shield_item_hit_func,plpushspeed,.125,visible,yes,block_direction,yes,speed_multiplier,.5,initial_energy,.125,gradual_energy,0,offspeed,.105,sind,6;]]
zclass[[sword,item_horizontal,actor,statitem|anchoring,@,xf,@,rx,.375,ry,.25,damage,2,stunlen,.25,pushspeed,.125,should_use_xf,yes,item_hit_func,%shield_item_hit_func,plpushspeed,.25,visible,yes,block_direction,yes,speed_multiplier,.5,initial_energy,.25,gradual_energy,0,offspeed,.125,sind,2;]]
zclass[[banjo,anchor,actor|anchoring,@,xf,@,visible,yes,block_direction,no,speed_multiplier,.5,initial_energy,.125,gradual_energy,0,offy,-.05,sind,1;start;init,%banjo_start_init,offdy,.0625,duration,.08,next,min_play;min_play;init,nop,offdy,0,duration,2,next,normal;normal;init,nop,offy,.25,next,ending;ending;init,%banjo_ending_init,offdy,-.0625,duration,.08;]]
zclass[[brang,collidable,simple_spr,drawlayer_50,mov,actor,statitem|anchoring,@,xf,@,rx,.25,ry,.25,damage,0,stunlen,.25,pushspeed,.25,should_use_xf,no,item_hit_func,~kill,visible,no,block_direction,yes,speed_multiplier,.25,initial_energy,.25,gradual_energy,0,should_collide_below,no,offspeed,.125,drawout,%brang_drawout,sind,4;start;init,%brang_start_init,speed,.075,duration,.125,next,normal;normal;init,nop,speed,0,duration,1.5,update,%brang_normal_update,next,ending;ending;init,%brang_ending_init,speed,0,speed,0,update,%brang_ending_update,duration,.125,adjust_deltas_for_solids,nop,adjust_deltas_for_tiles,nop;final;init,nop,update,nop,alive,no;]]
zclass[[bomb,actor,vec,simple_spr,drawlayer_50,statitem|anchoring,@,xf,@,sind,5,sy,-2,damage,1,stunlen,5,pushspeed,.25,should_use_xf,yes,item_hit_func,nop,visible,no,block_direction,no,speed_multiplier,1,initial_energy,.25,gradual_energy,0,offspeed,.185;start;init,%bomb_start_init,dy,.08,duration,.08,next,normal;normal;init,nop,duration,.5,dx,0,dy,0,next,exploding;exploding;init,%bomb_destroyed,update,%bomb_ending_update,duration,.25,next,ending,draw,nop;ending;init,nop,alive,no;]]
zclass[[pl,actor,mov,collidable,auto_outline,healthobj,drawlayer_50|cname,lank,cspr,103,max_health,10,x,@,y,@,xf,@,sind,88,rx,.375,ry,.375,should_collide_with_screen_edge,no,update,%pl_update,energy,0,is_energy_cooling_down,no,target_energy,0,drawout,%pl_drawout;item_funcs;5,%sword,2,%mask,8,%bow,3,%shield,0,%bomb,6,%banjo,7,%brang;default_item;visible,no,is_default,yes,block_direction,no,speed_multiplier,1,alive,yes,gradual_energy,-.0078125,initial_energy,0,kill,nop;item,~default_item;]]
function draw_bar(x1,y1,x2,y2,percent,align,fg,bg)
if x1>x2 then x1-=3 x2-=3 end
local bar_off=x2-x1-min(percent,1)*(x2-x1)
if align==0 then bar_off/=2 end
if percent>0 then
local xx=ceil(x1+(align>=0 and bar_off or 0))
local yy=flr(x2-(align<=0 and bar_off or 0))
rectfill(x1,y1,x1,y2,13)
rectfill(x2,y1,x2,y2,13)
rectfill(xx,y1,yy,y2,fg)
rectfill(xx,y2,yy,y2,bg)
end
end
function draw_card(x,y,rx,ry,coffx,coffy,card_func,post_card_func)
local x1,x2,y1,y2=x-rx,x+rx-1,y-ry,y+ry-1
local cam_x,cam_y=x1+coffx,y1+coffy
clip(x1,y1,x2-x1,y2-y1)
rectfill(-100,-100,9000,9000,1)
zcamera(cam_x,cam_y,card_func)
clip()
for i,c in pairs{1,13,0}do
i=2-i
color(c)
if c ~=0 then rect(x1+i,y1+i,x2-i,y2-i)end
i+=1
pset(x1+i,y1+i)pset(x1+i,y2-i)
pset(x2-i,y1+i)pset(x2-i,y2-i)
end
zcamera(cam_x,cam_y,post_card_func)
end
zclass[[rstat|align,@,x,@,update,%rstat_update,set,%rstat_set,get,%rstat_get;buffer;,;]]
zclass[[stat,vec,actor,drawlayer_95|align,@,x,@,obj,@,y,138,draw,%stat_draw;start;dy,-2,duration,.2,next,normal;normal;dy,0;ending;dy,2,duration,.2;]]
zclass[[tbox,vec,actor,drawlayer_99|rawtext,@,destroyed,@,y,138,cur_text_index,1,anim,0,line_1,,line_2,,update,%tbox_update,draw,%tbox_draw;texts;,;start;dy,-2,duration,.2,next,normal,update,nop,init,%tbox_init;normal;dy,0,anim,0,done,no,update,%tbox_update,init,nop;ending;dy,2,update,nop,duration,.2,init,nop;]]
zclass[[fairy,actor,mov,drawlayer_50|x,@,y,@,update,%fairy_update,draw,%fairy_draw]]
function draw_tail(x,y,dx,dy,mult)
for i=-2,2 do
local m=.125*sgn(i)
scr_line(x+abs(i)\2*m,y+i%2*m,x-dx*mult,y-dy*mult,1)
end
end
zclass[[woodtbl,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.375,draw,~drawout,sind,16]]
zclass[[greytbl,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.375,draw,~drawout,sind,17]]
zclass[[soupbucket,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.375,draw,~drawout,sind,18]]
zclass[[pot,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.375,draw,~drawout,sind,49]]
zclass[[woodcrate,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.375,draw,~drawout,sind,35]]
zclass[[bedblanket,actor,simple_spr,drawlayer_50|x,@,y,@,sind,55,init,%spawn_walls;walls;1;,~,-.25,.25,.25,.25;walls;2;,~,.25,.25,.25,.25;]]
zclass[[bedpillow,simple_spr,drawlayer_25|x,@,y,@,sind,39]]
zclass[[house,actor,simple_spr,drawlayer_50|cspr,174,sind,174,sw,2,sh,2,init,%house_init;walls;1;,~,.75,.5,.25,.75;walls;2;,~,-.75,.5,.25,.75;walls;3;,~,0,0,.75,.25;]]
zclass[[house231,house|x,@,y,@,room,231]]
zclass[[house224,house|x,@,y,@,room,224]]
zclass[[house225,house|x,@,y,@,room,225]]
zclass[[house226,house|x,@,y,@,room,226]]
zclass[[house227,house|x,@,y,@,room,227]]
zclass[[house228,house|x,@,y,@,room,228]]
zclass[[house229,house|x,@,y,@,room,229]]
zclass[[person,target_with_tbox,solid,simple_spr,drawlayer_50|text,,rx,.375,ry,.375,sy,-2,trx,.5,try,.25,ty,.25,target_with_tbox_disable_callback,%person_target_with_tbox_disable_callback]]
zclass[[navyblock,person|x,@,y,@,cname,navy,cspr,97,sind,97,text,my sister has been in^the forest all day.^find something to^protect yourself with^and bring her home.,ry,1,memloc_trigger,0x5d09,memloc_trigger_value,1,target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback|0x5d09|0]]
zclass[[navyhouse,person|x,@,y,@,cname,navy,cspr,97,sind,97,text,im navy in a house|0x5d09|1]]
zclass[[bobblock,person|x,@,y,@,cname,bob,cspr,80,sind,80,text,im bob outside,ry,1,memloc_trigger,0x5d18,memloc_trigger_value,1,target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback|0x5d18|0]]
zclass[[bobhouse,person|x,@,y,@,cname,bob,cspr,80,sind,80,text,im bob in a house|0x5d18|1]]
zclass[[jane,person|x,@,y,@,cname,jane,cspr,81,sind,81,text,im jane in a house]]
zclass[[teach,person|x,@,y,@,cname,teach,cspr,96,sind,96,text,im teach in a house]]
zclass[[keep,person|x,@,y,@,cname,keep,cspr,83,sind,83,text,im keep in a house]]
zclass[[lark,person|x,@,y,@,cname,lark,cspr,99,sind,99,text,im lark in a house]]
zclass[[target_with_tbox,actor|init,%target_with_tbox_init,trx,0,try,0,tx,0,ty,0,target_with_tbox_disable_callback,nop,target_with_tbox_finish_callback,nop]]
zclass[[sign,target_with_tbox,solid,simple_spr,drawlayer_50|text,,rx,.375,ry,.375,sy,-2,target_with_tbox_disable_callback,%sign_target_with_tbox_disable_callback,cname,sign,cspr,24,sind,24,trx,.125,try,.375,tx,0,ty,.25]]
zclass[[signtest,sign|x,@,y,@,text,mary had a^little lamb^little lamb^little lamb^mary had a^little lamb^whose fleece was^white as yo face]]
zclass[[signlank,sign|x,@,y,@,text,lanks house]]
zclass[[signkeep,sign|x,@,y,@,text,keeps house]]
zclass[[signnavy,sign|x,@,y,@,text,navys house]]
zclass[[signteach,sign|x,@,y,@,text,teachs house]]
zclass[[signlark,sign|x,@,y,@,text,larks house]]
zclass[[signjane,sign|x,@,y,@,text,janes house]]
zclass[[slimy_actual,box,mov,simple_spr,drawlayer_50,collidable,healthobj,actor|x,@,y,@,rx,.375,ry,.375,cspr,118,cname,slimy,sind,118,destroyed,%slimy_destroyed,statcollide,%slimy_statcollide,max_health,5;start;sind,118,speed,0,sx,0,sy,0,update,%slimy_start,duration,1,next,shake;shake;speed,0,update,%slimy_shake,duration,.25,next,jump;jump;sind,119,speed,.05,sx,0,update,%slimy_jump,duration,.25,next,start;]]
zclass[[miny_actual,simple_spr,vec,drawlayer_50,actor|x,@,y,@,cspr,116,cname,miny,sind,116]]
zclass[[spike,simple_spr,actor,drawlayer_25|sind,52,draw,~drawout;start;next,down;down;sind,52,duration,.5,next,middle1;middle1;sind,53,duration,.125,next,up;up;sind,54,duration,.25,next,middle2;middle2;sind,53,duration,.125,next,down;]]
zclass[[r1spike,spike|x,@,y,@,xf,1;start;duration,0;]]
zclass[[r2spike,spike|x,@,y,@,xf,1;start;duration,.5;]]
zclass[[l1spike,spike|x,@,y,@,xf,-1;start;duration,0;]]
zclass[[l2spike,spike|x,@,y,@,xf,-1;start;duration,.5;]]
zclass[[saveplat,box,simple_spr,actor,drawlayer_25|x,@,y,@,rx,.375,ry,.375,cname,save,cspr,10,sind,40,sw,2,sh,2,draw,~drawout,update,%saveplat_update;]]
g_fade,g_fade_table=1,zobj[[0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,0,0,0,0;2;,2,2,2,1,0,0,0,0;3;,3,3,3,3,1,1,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,0,0,0,0;6;,6,6,13,13,5,5,0,0;7;,7,7,6,13,13,5,0,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,0,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,0,0,0;13;,13,13,5,5,1,0,0,0;14;,14,14,13,4,2,2,0,0;15;,15,15,13,13,5,5,0,0;]]
function fade(threshold)
for c=0,15 do
pal(c,g_fade_table[c][1+flr(7*min(1,max(0,threshold)))],1)
end
end
zclass[[fader,actor|ecs_exclusions;actor,yes,timer,yes;]]
zclass[[fader_out,fader|start;duration,.5,destroyed,@,update,%fader_out_update]]
zclass[[fader_in,fader|start;duration,.5,update,%fader_in_update]]
zclass[[gameover_control,actor|start;duration,.75,next,ending;ending;init,%gameover_control_ending;]]
zclass[[room_bounds,box|x,@,y,@,rx,@,ry,@]]
function load_room(rind,x,y,xf)
if not does_entity_exist"fader"then
_g.fader_out(function()
zcall(poke,[[1;,0x5d01,@;2;,0x5d02,@;3;,0x5d03,@;4;,0x5d04,@;]],rind,
x*16,
y*16,
(xf+1)\2
)
g_state:load"room"
end)
end
end
zclass[[title_logo,actor,auto_outline,drawlayer_99|update,%title_logo_update,drawout,%title_logo_drawout;]]
cartdata"zeldo_rewrite"
menuitem(1,"reset save data",function()
memset(0x5e00,0,64)
extcmd"reset"
end)
zclass[[game_state,actor|ecs_exclusions;actor,yes,timer,yes;curr,room,init,%game_state_init;logo;state_init,%logo_init,update,%simple_update,draw,%logo_draw,duration,2.5,next,title;title;state_init,%title_init,update,%simple_update,draw,%title_draw;room;state_init,%room_init,update,%room_update,draw,%room_draw;gameover;state_init,%gameover_init,update,%simple_update,draw,%gameover_draw;]]
function _init()
memcpy(0x5d00,0x5e00,64)
if peek"0x5d00"==0 then
zcall(poke,[[1;,0x5d00,1;2;,0x5d01,136;3;,0x5d02,48;4;,0x5d03,48;5;,0x5d04,1;6;,0x5d08,4;7;,0x5d16,1;8;,0x5d15,1;10;,0x5d14,1;11;,0x5d13,1;12;,0x5d12,1;13;,0x5d17,1;14;,0x5d11,1;]])
end
g_si,g_fi,g_state,g_rooms=0,0,_g.game_state(),decode_map()
g_tile_animation_lookup=create_tile_animation_lookup(g_rooms[0])
end
function _update60()
g_zbtn_0,g_zbtn_2=zbtn(btn,0),zbtn(btn,2)
zcall(loop_entities,[[1;,actor,clean;2;,fader,clean;]])
register_entities()
zcall(loop_entities,[[1;,fader,tick;2;,game_state,tick;3;,fader,state;4;,game_state,state;]])
end
function _draw()
g_si,g_fi=g_slow_animation.index,g_fast_animation.index
cls()
loop_entities("game_state","draw")
fade(g_fade)
end