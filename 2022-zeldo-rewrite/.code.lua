g_obj_map=split[[bed,signtest,pot,housetest,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]]
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
room.music=0xf0 & peek_inc()>>>4
local byte,is_fill,is_tile,layer,ind,offx,offy=0,false,true,room.tiles_1,0,0,0
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
local meta,template=unpack(split(meta_and_att_str,"|"))
local parents=split(meta)
local class=deli(parents,1)
g_zclass_constructors[class]=function(inst,done,...)
foreach(parents,function(parent)
if not done[parent]then g_zclass_constructors[parent](inst,done)end
end)
done[class]=true
inst.parents[class]=true
add(g_zclass_new_entities,{class,inst})
return zobj_set(inst,template,...)
end
_g[class]=function(...)return g_zclass_constructors[class]({id=class,parents={},ecs_exclusions={}},{},...)end
end
function register_entities()
while #g_zclass_new_entities>0 do
local class,inst=unpack(deli(g_zclass_new_entities))
g_zclass_entities[class]=g_zclass_entities[class]or{}
if not inst.ecs_exclusions[class]then add(g_zclass_entities[class],inst)end
end
end
function deregister_entity(inst,...)
call_not_nil(inst,"deregistered",inst,...)
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
return g_zclass_entities[entity_name]and #g_zclass_entities[entity_name]>0
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
_g=zobj([[actor_load,@,actor_state,@,actor_kill,@,actor_clean,@,actor_deregistered,@,fader_out_update,@,fader_in_update,@,animation_init,@,auto_outline_drawout,@,timer_start_timer,@,timer_stop_timer,@,timer_play_timer,@,timer_delete_timer,@,timer_get_elapsed,@,timer_get_elapsed_percent,@,timer_tick,@,box_touching,@,box_outside,@,box_inside,@,box_side,@,box_abside,@,box_getdelta,@,pos_dist_point,@,vec_update,@,mov_update,@,mov_towards_point,@,explode_draw,@,calc_deltas,@,adjust_deltas_for_solids,@,adjust_deltas_for_tiles,@,inventory_start_init,@,inventory_start_update,@,inventory_press_update,@,inventory_draw,@,anchor_update_anchor,@,targettouch_update_target,@,pl_init,@,pl_update,@,pl_draw,@,stat_draw,@,tbox_init,@,tbox_update,@,tbox_draw,@,fairy_update,@,fairy_draw,@,house_init,@,house_draw,@,sign_init,@,sign_draw,@,gameover_control_update,@,gameover_init,@,gameover_draw,@,logo_init,@,logo_draw,@,room_init,@,room_update,@,room_draw,@,title_init,@,simple_update,@,title_draw,@,title_logo_update,@,title_logo_draw,@,game_state_init,@]],function(a,stateName)
if stateName then
a.next,a.duration=nil
for k,v in pairs(a[stateName])do a[k]=v end
a.curr=stateName
a:stop_timer("state",a.duration,a.duration and function()a:load(a.next)end)
else
a:kill()
end
end,function(a)
if a:get_elapsed"state"==nil then a:load(a.curr)end
if a:get_elapsed"state"==false then a:play_timer"state" a:init()end
a:update()
end,function(a)a.alive=nil end,function(a)if not a.alive then deregister_entity(a)end end,function(a)a:kill()a:destroyed()end,function(a)
g_fade=a:get_elapsed_percent"state"
end,function(a)
g_fade=1-a:get_elapsed_percent"state"
end,function(a)
a.index+=1
a.index%=60
end,function(a)
draw_outline(1,function()a:draw()end)
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
return timer and(timer.elapsed or 0)/timer.duration
end,function(a)
local finished_timers={}
for name,timer in pairs(a.timers)do
if timer.elapsed and timer.elapsed<timer.duration then
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
local percent=a:get_elapsed"state"*4
for i=0,3 do
scr_zrect(a.x+percent*cos(i/4+.125),a.y+percent*sin(i/4+.125),.125,.125,1)
end
end,function(a,b)
local box={x=b.x-a.dx,y=b.y-a.dy,rx=b.rx,ry=b.ry}
return a:getdelta(box,a.dx,a.dy)
end,function(a,list)
local junk
foreach(list,function(b)
local box={x=b.x-a.dx,y=b.y-a.dy,rx=b.rx,ry=b.ry}
a.dx,a.dy=a:getdelta(box,a.dx,a.dy)
end)
end,function(a,room)
for tx=flr(a.x-a.rx)-1,ceil(a.x+a.rx)do
for ty=flr(a.y-a.ry)-1,ceil(a.y+a.ry)do
if is_solid_tile(room,tx,ty)then
a.dx,a.dy=a:calc_deltas{x=tx+.5,y=ty+.5,rx=.5,ry=.5}
end
end
end
end,function(a)
if zdget_value"8" ~=4 then
a.stat=_g.stat(0,64,{cspr=a[zdget_value"8"+1].sind})
else
a.stat=nil
end
end,function(a)
if not does_entity_exist"tbox"and btn"5"then
call_not_nil(a.stat,"load",a.stat,"ending")
zdset(8,4)
a:load"press"
end
end,function(a)
zdset(8,mid(0,2,zdget_value"8"%3+zbtn(btnp,0))+mid(0,2,zdget_value"8"\3+zbtn(btnp,2))*3)
if does_entity_exist"tbox"or not btn"5"then
a:load"start"
end
end,function(a)
for item in all(a)do
local drawfunc=item.index==4 and function()a.pl:draw()end or function()
zspr(item.sind,a.pl.x*8+item.xoff,a.pl.y*8+item.yoff,1,1,a.pl.xf)
end
draw_outline(item.index==zdget_value"8"and 2 or 1,drawfunc)
drawfunc()
end
end,function(a)
a.x,a.y=a.anchoring.x+a.offx,a.anchoring.y+a.offy
end,function(target,objs)
foreach(objs,function(a)
if target:outside(a)then
target:callback_outside(a)
else
target:callback_touch(a)
end
end)
end,function(a)_g.stat(-1,9,a)end,function(a)
if not does_entity_exist"tbox"and not btn(5)and zbtn(btn,0)|zbtn(btn,2)~=0 then
a.ang,a.speed=atan2(zbtn(btn,0),zbtn(btn,2)),.025
if cos(a.ang)~=0 then
a.xf=cos(a.ang)<0
end
else
a.speed=0
end
a.sind=a.sinds[a.dx|a.dy ~=0 and t()*12%3\1+1 or 1]
end,function(a)
zspr(a.sind,a.x*8,a.y*8-2,1,1,a.xf)
zspr(91,a.x*8,a.y*8-2,1,1,a.xf)
end,function(a)
local obj=a.obj
if align ~=0 then
zcamera(a.x+2,a.y,function()
local xyo=-8*a.align-1
if obj.cname then zprinttbox(obj.cname,xyo,-10,a.align,7,5)end
if obj.health and obj.max_health then
draw_bar(xyo,-2,xyo-35*a.align,1,obj.health/obj.max_health,-1,11,3)
zprinttbox(flr(obj.health).."/"..obj.max_health,xyo,4,a.align,7,5)
end
end)
end
local offx=a.align>0 and does_entity_exist"tbox"and-1 or 0
local offy=does_entity_exist"tbox"and 0 or-cos(g_i/4)*a.align
draw_card(a.x+offx,a.y+offy,6,8,2,4,function()
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
zspr(38,44,16+g_i%2)
end
end)
end,function(a)
local b=a.rel_actor
local dir=t()\10%2==0 and 1 or-1
local offx,offy=b.x+dir*cos(t()*.75),b.y+sin(t()*.75)-.25
a:towards_point(offx,offy)
a.speed=a:dist_point(offx,offy)*.013
end,function(a)
for i=-2,2 do
local m=.125*sgn(i)
scr_line(a.x+abs(i)\2*m,a.y+i%2*m,a.x-a.dx*6,a.y-a.dy*6,1)
end
scr_pset(a.x,a.y,12)
end,function(a)
zcall(_g.wall,[[a,@;1;,~a,.75,.5,.25,.75;2;,~a,-.75,.5,.25,.75;3;,~a,0,0,.75,.25;]],a)
zcall(_g.target,[[1;,.125,.375,0,.5,@,@,nop;]],a,function()
_g.fader_out(function()
zcall(zdset,[[1;,5,@;2;,6,@;3;,7,@;4;,1,@;5;,2,64;6;,3,80;7;,4,@;]],zdget_value"1",
a.x*16,
(a.y+1.5)*16,
a.room,
g_pl.xf and 1 or 0
)
g_state:load"room"
end)
end)
end,function(a)
zspr(a.cspr,a.x*8,a.y*8,2,2)
end,function(a)
_g.target(.125,.5,0,.25,a,function()
if not a.stat then a.stat=_g.stat(1,119,a)end
if btnp"4"and not does_entity_exist"tbox"then
_g.tbox(a.text)
end
end,function()
if a.stat then a.stat:load"ending" a.stat=nil end
end)
end,function(a)
zspr(a.cspr,a.x*8,a.y*8)
end,function(a)
if btnp(4)or btnp(5)then
_g.fader_out(function()g_state:load"title" end)
a:load"ending"
end
end,function(state)
_g.gameover_control()
state.game_over_sind,state.game_over_text=unpack(rnd_item(zobj[[1;,32,quack quack;2;,68,and play with me;3;,70,to save hi-roll;4;,81,in time for dinner;5;,83,and make me rich;6;,96,the banjo awaits you;7;,99,for your fans;8;,118,splat splat boing;]]))
end,function(state)
zcamera(64,64,function()
zsprb(state.game_over_sind,0,g_i%2,1,1,true,false,1)
zcall(zprintgui,[[1;,game over,0,-17,8,2,1;2;,come back lank,0,12,10,4,1;3;,@,0,22,7,5,1]],state.game_over_text)
end)
end,function()sfx(63,0)end,function(a)
g_fade=cos(a:get_elapsed_percent"state")+1
camera(g_fade>.5 and rnd_one())
zspr(108,64,64,4,2)
camera()
end,function(state)
local r=g_rooms[zdget_value"1"]
g_room_bounds=_g.room_bounds(r.w/2,r.h/2+.25,r.w/2+.125,r.h/2+.125)
g_pl=_g.pl(zdget_value"2"/16,zdget_value"3"/16,zdget"4")
local abx,aby=g_pl:abside(g_room_bounds)
g_fairy=_g.fairy(g_pl,g_pl.x+abx*1.25,g_pl.y+aby*1.25)
_g.inventory(g_pl)
foreach(r.objects,function(obj_template)
_g[g_obj_map[obj_template.index]](obj_template.x+.5,obj_template.y+.5)
end)
end,function(state)
if does_entity_exist"fader"then return end
zcall(loop_entities,[[1;,timer,tick;2;,actor,state;3;,mov,mov_update;4;,collidable,adjust_deltas_for_solids,@;5;,collidable,adjust_deltas_for_tiles,@;6;,vec,vec_update;7;,anchor,update_anchor;8;,target,update_target,@;]],g_zclass_entities.solid,g_rooms[zdget_value"1"],g_zclass_entities.pl)
if not g_pl:inside(g_room_bounds)then
_g.fader_out(function()
local abx,aby=g_pl:abside(g_room_bounds)
local nri=zdget_value"1"+aby*16+abx
local nr=g_rooms[nri]
local pl_x,pl_y,pl_xf
if zdget_value"1">223 then
pl_x,pl_y,pl_xf=zdget_value"6"/16,zdget_value"7"/16,g_pl.xf
nri=zdget_value"5"
elseif nr then
local helper=function(x,w)return w/2-x*w/2+1.25*x end
if abx ~=0 then pl_x,pl_y,pl_xf=helper(abx,nr.w),g_pl.y,abx<0
else pl_y,pl_x,pl_xf=helper(aby,nr.h)+.25,g_pl.x,g_pl.xf end
else
pl_x,pl_y,pl_xf=6,5,g_pl.xf
nri=151
end
zcall(zdset,[[1;,1,@;2;,2,@;3;,3,@;4;,4,@;]],nri,
pl_x*16,
pl_y*16,
pl_xf and 1 or 0
)
state:load"room"
end)
end
end,function(state)
draw_room(g_rooms[zdget_value"1"],64,57,function()
loop_entities("outlayer_50","drawout")
loop_entities("drawlayer_50","draw")
zcall(loop_entities,[[1;,outlayer_50,drawout;2;,drawlayer_50,draw;3;,drawlayer_60,draw;4;,drawlayer_70,draw;5;,drawlayer_75,draw;]])
end,function()
zcall(loop_entities,[[1;,outlayer_99,drawout;2;,drawlayer_90,draw;3;,drawlayer_95,draw;4;,drawlayer_99,draw;]])
end)
zcall(draw_bar,[[1;,18,6,109,11,@,0,8,2]],g_pl.energy)
end,function()
_g.title_logo()
end,function()
if does_entity_exist"fader"then return end
zcall(loop_entities,[[1;,timer,tick;2;,actor,state;]])
end,function()
draw_room(g_rooms[8*16+8],64,57,nop,nop)
zcall(loop_entities,[[1;,outlayer_99,drawout;2;,drawlayer_99,draw;]])
zcall(zprinttbox,[[1;,code/sfx:  @alanxoc3  ,64,104,0,7,5;2;,tile/spr:  @greatcadet,64,114,0,7,5;3;,amorg games presents,64,6,0,7,5;]])
end,function(a)
if btnp"4"or btnp"5"then
_g.fader_out(function()g_state:load"room" end)
end
end,function(a)
for i=-2,2 do
zspr(45+i,i*10+64,57+cos((g_i+i)/4)/2,1,2)
end
zcall(zprinttbox,[[1;,not the story of,64,39,0,10,4;]])
if g_i%2==0 then
zcall(zprinttbox,[[1;,🅾️ or ❎ to play  ,64,68,0,7,5;]])
end
end,function(state)
clean_all_entities"game_state"
_g.fader_in()
g_animation=_g.animation".5"
state:state_init()
end)
function nop()end
function flr_rnd(x)
return flr(rnd(x))
end
function rnd_item(list)
return list[flr_rnd(#list)+1]
end
function rnd_one(val)
return rnd_item{-1,0,1}
end
function zbtn(f,a)return f(a)and f(a+1)and 0 or f(a)and-1 or f(a+1)and 1 or 0 end
function zspr(sind,x,y,sw,sh,...)
sw,sh=sw or 1,sh or 1
x,y=x-sw*4,y-sh*4
spr(sind,x,y,sw,sh,...)
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
function zprintgui(str,x,y,fg,bg,out)
for yy=-1,2 do
for xx=-1,1 do
zprint(str,x+xx,y+yy,0,out)
end
end
zprinttbox(str,x,y,0,fg,bg)
end
function zcall(func,text,...)
foreach(zobj(text,...),function(params)
func(unpack(params))
end)
end
function zrect(x,y,rx,ry,color)rect(x-rx,y-ry,x+rx-1,y+ry-1,color)end
function scr_help_four(func,x1,y1,x2,y2,color)func(8*x1,8*y1,8*x2,8*y2,color)end
function scr_line(...)scr_help_four(line,...)end
function scr_zrect(...)scr_help_four(zrect,...)end
function scr_pset(x,y,color)pset(8*x,8*y,color)end
function zdget_value(ind)return peek(0x5d00+ind)end
function zdget(ind)return zdget_value(ind)>0 end
function zdset(ind,val)return poke(0x5d00+ind,val or 1)end
zclass[[actor,timer|load,%actor_load,state,%actor_state,kill,%actor_kill,clean,%actor_clean,alive,yes,duration,null,curr,start,next,null,init,nop,update,nop,destroyed,nop,deregistered,%actor_deregistered;]]
zclass[[drawlayer_50|]]
zclass[[drawlayer_60|]]
zclass[[drawlayer_70|]]
zclass[[drawlayer_90|]]
zclass[[drawlayer_95|]]
zclass[[drawlayer_99|]]
zclass[[outlayer_50|]]
zclass[[outlayer_99|]]
zclass[[fader,actor|ecs_exclusions;actor,yes,timer,yes;]]
zclass[[fader_out,fader|start;duration,.5,destroyed,@,update,%fader_out_update]]
zclass[[fader_in,fader|start;duration,.5,update,%fader_in_update]]
zclass[[animation,actor|index,0,init,%animation_init;start;duration,@,next,start]]
zclass[[auto_outline|drawout,%auto_outline_drawout]]
function draw_outline(color,drawfunc)
for c=1,15 do pal(c,color)end
local ox,oy=%0x5f28,%0x5f2a
for i=0,8 do
camera(ox+i%3-1,oy+i\3-1)drawfunc()
end
camera(ox,oy)
pal()
end
zclass[[timer|timers;,;start_timer,%timer_start_timer,stop_timer,%timer_stop_timer,play_timer,%timer_play_timer,delete_timer,%timer_delete_timer,get_elapsed,%timer_get_elapsed,get_elapsed_percent,%timer_get_elapsed_percent,tick,%timer_tick,]]
function draw_room(room,center_x,center_y,post_tile_func,post_card_func)
local x1,y1=center_x-room.w*8\2,center_y-room.h*8\2
draw_card(center_x,center_y,room.w*4-2,room.h*4-2,-2,-2,function()
rectfill(0,0,127,127,room.color)
for tiles in all{room.tiles_1,room.tiles_2}do
for location,index in pairs(tiles)do
local x,y=location%12,location\12
spr(lookup_tile_animation(index),x*8,y*8)
end
end
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
return anim and anim[g_i%#anim+1]or sind
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
zclass[[explode,actor,drawlayer_50|x,@,y,@,draw,%explode_draw;start;duration,.25;]]
function is_solid_tile(room,x,y)
if x>=0 and x<12 then
local t2=room.tiles_2[y*12+x]
if t2 then return fget(t2,0)end
return fget(room.tiles_1[y*12+x],0)
end
end
zclass[[collidable,box,vec|calc_deltas,%calc_deltas,adjust_deltas_for_solids,%adjust_deltas_for_solids,adjust_deltas_for_tiles,%adjust_deltas_for_tiles]]
zclass[[inventory,actor,drawlayer_90|pl,@;start;init,%inventory_start_init,update,%inventory_start_update,draw,nop;press;init,nop,update,%inventory_press_update,draw,%inventory_draw;1;mem_loc,6,index,0,name,brang,xoff,-7,yoff,-9,sind,4;2;mem_loc,10,index,1,name,mask,xoff,0,yoff,-11,sind,3;3;mem_loc,7,index,2,name,bomb,xoff,7,yoff,-9,sind,5;4;mem_loc,8,index,3,name,shield,xoff,-8,yoff,-3,sind,6;5;index,4;6;mem_loc,9,index,5,name,bow,xoff,9,yoff,-2,sind,7;7;mem_loc,12,index,6,name,banjo,xoff,-7,yoff,4,sind,1;8;mem_loc,11,index,7,name,sword,xoff,0,yoff,6,sind,2;9;mem_loc,5,index,8,name,bow,xoff,7,yoff,5,sind,0;]]
zclass[[solid,box|]]
zclass[[wall,solid,anchor|anchoring,@,offx,@,offy,@,rx,@,ry,@]]
zclass[[anchor,pos|update_anchor,%anchor_update_anchor;offx,0,offy,0,anchoring;,]]
zclass[[target,anchor,box|rx,@,ry,@,offx,@,offy,@,anchoring,@,callback_touch,@,callback_outside,@,update_target,%targettouch_update_target]]
zclass[[pot]]
zclass[[bed]]
zclass[[pl,actor,mov,collidable,auto_outline,drawlayer_50,outlayer_50|cname,lank,cspr,103,health,10,max_health,10,x,@,y,@,xf,@,sind,88,rx,.375,ry,.375,init,%pl_init,update,%pl_update,energy,0,draw,%pl_draw;sinds;,88,89,90]]
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
zclass[[stat,vec,actor,drawlayer_95|align,@,x,@,obj,@,y,138,draw,%stat_draw,max_health,10,health,5;start;dy,-2,duration,.2,next,normal;normal;dy,0;ending;dy,2,duration,.2;]]
zclass[[tbox,vec,actor,drawlayer_99|rawtext,@,y,138,cur_text_index,1,anim,0,line_1,,line_2,,update,%tbox_update,draw,%tbox_draw;texts;,;start;dy,-2,duration,.2,next,normal,update,nop,init,%tbox_init;normal;dy,0,anim,0,done,no,update,%tbox_update,init,nop;ending;dy,2,update,nop,duration,.2,init,nop;]]
zclass[[fairy,actor,mov,drawlayer_70|rel_actor,@,x,@,y,@,update,%fairy_update,draw,%fairy_draw]]
zclass[[house,actor,auto_outline,drawlayer_60,outlayer_50|cspr,174,room,231,init,%house_init,draw,%house_draw]]
zclass[[housetest,house|x,@,y,@]]
zclass[[sign,actor,solid,auto_outline,drawlayer_50,outlayer_50|text,,rx,.375,ry,.375,cname,sign,cspr,171,init,%sign_init,draw,%sign_draw]]
zclass[[signtest,sign|x,@,y,@,text,mary had a^little lamb^little lamb^little lamb^mary had a^little lamb^whose fleece was^white as yo face]]
zclass[[gameover_control,actor|start;update,nop,duration,.5,next,normal;normal;update,%gameover_control_update;ending;update,nop;]]
g_fade_table=zobj[[0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,0,0,0,0;2;,2,2,2,1,0,0,0,0;3;,3,3,3,3,1,1,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,0,0,0,0;6;,6,6,13,13,5,5,0,0;7;,7,7,6,13,13,5,0,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,0,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,0,0,0;13;,13,13,5,5,1,0,0,0;14;,14,14,13,4,2,2,0,0;15;,15,15,13,13,5,5,0,0;]]
function fade(threshold)
for c=0,15 do
pal(c,g_fade_table[c][1+flr(7*min(1,max(0,threshold)))],1)
end
end
zclass[[room_bounds,box|x,@,y,@,rx,@,ry,@]]
zclass[[title_logo,actor,auto_outline,drawlayer_99,outlayer_99|update,%title_logo_update,draw,%title_logo_draw;]]
cartdata"zeldo_rewrite"
menuitem(1,"reset save data",function()
memset(0x5e00,0,64)
extcmd"reset"
end)
zclass[[game_state,actor|ecs_exclusions;actor,yes,timer,yes;curr,room,init,%game_state_init,logo;state_init,%logo_init,update,%simple_update,draw,%logo_draw,duration,2.5,next,title;title;state_init,%title_init,update,%simple_update,draw,%title_draw;room;state_init,%room_init,update,%room_update,draw,%room_draw;gameover;state_init,%gameover_init,update,%simple_update,draw,%gameover_draw;]]
function _init()
memcpy(0x5d00,0x5e00,64)
if not zdget"0"then
zcall(zdset,[[1;,0,1;2;,1,136;3;,2,48;4;,3,48;5;,4,1;6;,8,4;]])
end
poke2(0x5f5c,0x0808)
g_state,g_rooms=_g.game_state(),decode_map()
g_tile_animation_lookup=create_tile_animation_lookup(g_rooms[0])
end
function _update60()
zcall(loop_entities,[[1;,actor,clean;2;,fader,clean;]])
register_entities()
zcall(loop_entities,[[1;,fader,tick;2;,game_state,tick;3;,fader,state;4;,game_state,state;]])
end
function _draw()
g_i=g_animation.index
cls()
loop_entities("game_state","draw")
fade(g_fade)
end