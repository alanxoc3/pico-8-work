g_obj_map=split[[bedpillow,bedbot_l,pot,house231,navyblock,signlank,signkeep,signnavy,signteach,signlark,signjane,house224,house225,house226,house227,house228,house229,navyhouse,bobblock,bobhouse,bedbot_r,teach,jane,lark,r1spike,r2spike,l1spike,l2spike,saveplat,woodtbl,greytbl,soupbucket,slimy,miny,woodcrate,quack,blockade,keep_brang,keep_shield,keep_sling,keep_mask,limeboss,nil,nil,nil,nil,nil,nil,coin_1,coin_2,coin_3,coin_4,coin_5,coin_6,coin_7,coin_8,coin_9,coin_10,coin_11,coin_12,coin_13,coin_14,coin_15,coin_16,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]]
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
local byte,is_tile,layer,ind,offx,offy,is_place=0,true,room.tiles_1,0,0,0
while byte ~=255 do
byte=peek_inc()
if byte>=248 and byte<=253 then
is_place,is_tile=nil
end
if byte==248 then is_tile=true layer=room.tiles_1
elseif byte==249 then is_tile=true layer=room.tiles_2
elseif byte==250 then offx=0 offy=0
elseif byte==251 then offx=.5 offy=0
elseif byte==252 then offx=0 offy=.5
elseif byte==253 then offx=.5 offy=.5
elseif byte==254 then is_place=true
elseif byte<128 then ind=byte
elseif byte<255 then
local p1=0x7f & byte
if is_tile then
if is_place then
layer[p1]=ind+128
else
local p2=0x7f & peek_inc()
for yy=p1\12,p2\12 do
for xx=p1%12,p2%12 do
layer[yy*12+xx]=ind+128
end
end
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
function create_coin(memloc)
return function(x,y)
if peek(memloc)==0 then
_g.coin(x,y,memloc)
end
end
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
_g=zobj([[actor_load,@,actor_loadlogic,@,actor_state,@,actor_is_alive,@,actor_kill,@,actor_clean,@,animation_init,@,auto_outline_draw,@,timer_reset_timer,@,timer_end_timer,@,timer_get_elapsed_percent,@,timer_is_active,@,timer_tick,@,box_touching,@,box_outside,@,box_inside,@,box_side,@,box_abside,@,box_getdelta,@,pos_dist_point,@,vec_update_x,@,vec_update_y,@,vec_mov_towards_point,@,mov_update,@,mov_towards_point,@,explode_draw,@,standard_explosion,@,set_x_delta,@,set_y_delta,@,adjust_deltas_for_solids,@,adjust_deltas_for_tiles,@,set_x_delta2,@,set_y_delta2,@,adjust_deltas_for_screen,@,healthobj_hurt,@,healthobj_stun,@,healthobj_health_update,@,inventory_open_update,@,inventory_update,@,inventory_start_update,@,inventory_normal_init,@,inventory_draw,@,simple_spr_draw,@,anchor_update_anchor,@,targettouch_update_target,@,coin_pl_collide_func,@,coin_1,@,coin_2,@,coin_3,@,coin_4,@,coin_5,@,coin_6,@,coin_7,@,coin_8,@,coin_9,@,coin_10,@,coin_11,@,coin_12,@,coin_13,@,coin_14,@,coin_15,@,coin_16,@,propel_func,@,interact,@,held_to_throw_beg,@,held_to_throw_update,@,held_to_throw_ending_init,@,item_throwing_update,@,quack_thrown_destroyed,@,bomb_destroyed,@,mask_init,@,mask_end,@,pellet_update,@,pellet_draw,@,bow_ending_init,@,sword_item_hit_func,@,banjo_start_init,@,banjo_ending_init,@,brang_drawout,@,brang_start_init,@,brang_start_update,@,brang_normal_update,@,brang_ending_init,@,brang_ending_update,@,bomb_pl_hit,@,item_horizontal_start_init,@,item_horizontal_normal_init,@,item_horizontal_ending_init,@,maskcheck_func,@,pushable_push,@,pushable_update_push,@,pl_update,@,pl_drawout,@,card_table_cache,@,coin_count_start,@,coin_count_normal,@,coin_coint_draw,@,energybar_draw,@,stat_idle,@,rstat_update,@,rstat_get,@,stat_normal,@,stat_draw,@,tbox_init,@,tbox_update,@,tbox_draw,@,fairy_update,@,fairy_draw,@,spawn_walls,@,pot_callback_touch,@,house_init,@,person_target_with_tbox_disable_callback,@,person_target_with_tbox_finish_callback,@,lime_callback,@,limestatue_destroyed,@,teach_gettext,@,keep_gettext,@,class_with_target_init,@,target_with_tbox_gettext,@,target_with_tbox_target_func,@,sign_target_with_tbox_disable_callback,@,quack_change_dir,@,quack_pl_collide_func,@,enemy_pl_collide_func_batch,@,slimy_parent_statcollide,@,slobs_shotgun_init,@,slobs_calc_next,@,slimy_boss_idle_update,@,slimy_boss_spin_update,@,slimy_boss_stateless_update,@,slimy_boss_jump_init,@,slimy_boss_idle_init,@,slimyboss_destroyed,@,slimyboss_jump,@,slimyboss_init,@,slimy_ball_update,@,minion_to_miny,@,slimy_minion_pl_collide,@,slimy_minion_update,@,slimy,@,slimy_destroyed,@,miny,@,slimy_propel,@,slimy_stun_callback,@,slimy_stunstate,@,slimy_pl_collide_func,@,slimy_start,@,slimy_bounce,@,slimy_jump_init,@,spike_pl_collide_func,@,blockade_close_init,@,blockade_open_init,@,saveplat_update,@,fader_out_update,@,fader_in_update,@,logo_init,@,logo_draw,@,gameover_update,@,gameover_init,@,gameover_draw,@,room_init,@,room_update,@,room_draw,@,title_init,@,simple_update,@,title_draw,@,title_logo_update,@,title_logo_drawout,@,game_state_init,@]],function(a,stateName)
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
end,function(a)if not a.alive then a:destroyed()deregister_entity(a)end end,function(a)
a.index+=1
a.index%=60
end,function(a)
local ox,oy=%0x5f28,%0x5f2a
local injured=a:is_active"injured"
local stunned=a:is_active"stunned"
local yoff=((does_entity_exist"banjo"and a.should_dance or stunned)and sin(g_fi/5)or 0)+sin(a:get_elapsed_percent"jumpanim"/2)*8+sin(a:get_elapsed_percent"stunned_jump"/2)*5+sin(a:get_elapsed_percent"injured"/2)*5
local xoff=0
camera(ox-xoff,oy-yoff)
draw_outline(1,function()a:drawout()end)
if stunned then gray_fade(1)end
if injured then red_fade(1)end
a:drawout()
pal()
camera(ox,oy)
end,function(a,timer_name,duration,callback)
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
end,function(a,x,y,speed)
local ang=atan2(x-a.x,y-a.y)
local dist=a:dist_point(x,y)
local new_speed=speed>dist and dist or speed
a.dx=new_speed*cos(ang)
a.dy=new_speed*sin(ang)
end,function(a)
local ax,ay=a.speed*cos(a.ang),a.speed*sin(a.ang)
a.dx+=ax a.dy+=ay
a.dx*=.80 a.dy*=.80
if ax==0 and abs(a.dx)<.01 then a.dx=0 end
if ay==0 and abs(a.dy)<.01 then a.dy=0 end
a.speed=0
end,function(a,x,y)
a.ang=atan2(x-a.x,y-a.y)
end,function(a)
for i=0,a.len-1 do
scr_zrect(a.x+sin(a:get_elapsed_percent"start"/2)*cos(i/a.len+.125),a.y+sin(a:get_elapsed_percent"start"/2)*sin(i/a.len+.125),i%a.mod*.125+.125,i%a.mod*.125+.125,1)
end
end,function(a)
sfx(3,3,8,4)
_g.explode(a.x,a.y,4,1,nop)
end,function(a,b)a.dx,_=a:getdelta(b,a.dx,0)end,function(a,b)_,a.dy=a:getdelta(b,0,a.dy)end,function(a,setdelta,list)
foreach(list,function(b)
if a ~=b then
setdelta(a,b)
end
end)
end,function(a,setdelta,room)
for tx=max(flr(a.x-a.rx)-1,0),min(ceil(a.x+a.rx),12-1)do
for ty=flr(a.y-a.ry)-1,ceil(a.y+a.ry)do
local sind=get_solid_tile(room,ty*12+tx)
if sind then
local rx,ry=.5,.5
if not fget(sind,1)or fget(sind,1)and a.should_collide_below then
if fget(sind,2)then rx,ry=.375,.375 end
if fget(sind,3)then rx,ry=.375,.625 end
setdelta(a,{x=tx+.5,y=ty+.5,rx=rx,ry=ry})
end
end
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
end,function(a,amount,callback)
if not a.invincible and not does_entity_exist"fader"and a:is_alive()and a:maskcheck()and not a:is_active"injured"and not a:is_active"injured_cooldown"then
a:end_timer"stunned"
a:end_timer"stunned_cooldown"
a:start_timer("injured",.25,function()
if a.health<=0 then
a:kill()
else
a:start_timer("injured_cooldown",.25)
end
end)
callback=callback or nop
callback()
a.health=max(0,min((a.health or a.max_health)-amount,a.max_health))
end
end,function(a,length,callback)
if(a:maskcheck()and not a:is_active"stunned"and not a:is_active"stunned_cooldown")then
a:stun_callback()
callback=callback or nop
callback()
a:start_timer("stunned_jump",.25)
a:start_timer("stunned",.25+length,function()
a:start_timer("stunned_cooldown",.25)
end)
end
end,function(a)
a.health=a.health or a.max_health
a.display_health=a.display_health or a.health/a.max_health
local diff=a.health/a.max_health-a.display_health
a.display_health+=zsgn(diff)*min(abs(diff),.05)
end,function(a)
a.cachedir+=zbtn(btnp,0)
end,function(a)
if does_entity_exist"tbox"or not btn"5"or does_entity_exist"fader"then
a:load()
sfx(3,3,8,4)
else
local dir=zbtn(btnp,0)+a.cachedir
a.cachedir=0
for i=peek"0x5d08"+dir,5+zsgn(dir)*4,dir do
if peek(a[i].mem_loc)~=0 then
poke(0x5d08,i)
sfx(3,3,4,4)
return
end
end
end
end,function(a)
if not does_entity_exist"tbox"and not does_entity_exist"fader"and btn"5"then
a:load()
sfx(3,3,0,4)
end
end,function(a)
poke(0x5d08,5)
end,function(a)
for i,item in ipairs(a)do
local exist=peek(item.mem_loc)~=0
local current=peek"0x5d08"==i
draw_card(a.x+item.x,current and 9 or a.y+item.y,item.w,4.5,0,0,function()
if exist then
spr(item.sind,item.sxo)
end
end,nop)
end
end,function(a)
if a.visible then
local xf=a.xf
if a.should_dance and does_entity_exist"banjo"then
end
zspr(a.sind,a.x*8+a.sx+(a.shaking and sin(t()*4)or 0),a.y*8+a.sy,a.sw,a.sh,xf,a.yf)
end
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
end,function(a,pl)
poke(0x5d0d,peek"0x5d0d"+1)
poke(a.memloc,1)
a:kill()
end,create_coin"0x5d20",create_coin"0x5d21",create_coin"0x5d22",create_coin"0x5d23",create_coin"0x5d24",create_coin"0x5d25",create_coin"0x5d26",create_coin"0x5d27",create_coin"0x5d28",create_coin"0x5d29",create_coin"0x5d2a",create_coin"0x5d2b",create_coin"0x5d2c",create_coin"0x5d2d",create_coin"0x5d2e",create_coin"0x5d2f",function(a)
a.speed=a.propel_speed
end,function(...)
local obj=g_rstat_right:get()
if obj and obj:is_alive()then
if obj.id=="pot"then
obj:kill()
return _g.pot_held(obj,...)
elseif obj.id=="quack"then
obj:kill()
return _g.quack_held(obj,...)
end
end
end,function(a)
if a.fromobj then
a.x,a.y=a.fromobj.x,a.fromobj.y
else
a.x,a.y=a.anchoring.x,a.anchoring.y
end
end,function(a)
a:vec_mov_towards_point(a.anchoring.x,a.anchoring.y-.5,.15)
end,function(a)
a.item_thrown(a.anchoring.x,a.anchoring.y,a.anchoring.xf,.06+a.anchoring.speed,atan2(a.anchoring.xf,0))
end,function(a)
a.sy=sin(a:get_elapsed_percent"start"/4+.25)*7
a:propel()
end,function(a)
_g.quack(a.x,a.y)
end,function(a)
_g.explode(a.x,a.y,8,2,nop)
_g.bomb_explode(a.x,a.y)
end,function()sfx(3,3,0,4)end,function()sfx(3,3,8,4)end,function(a)
if a.dx==0 then a:kill()end
end,function(a)
draw_tail(a.x,a.y-.25,a.dx,0,3)
pset(a.x*8,a.y*8-2,4)
end,function(a)
_g.item_horizontal_ending_init(a)
_g.pellet(a.anchoring.x,a.anchoring.y,a.xf*.25,a.xf)
end,function(a)
a:kill()
end,function(a)
sfx(5,0)
sfx(6,1)
sfx(7,2)
end,function(a)
sfx(5,-2)
sfx(6,-2)
sfx(7,-2)
if(g_rstat_right:get()or{}).id=="saveplat"and a:get_elapsed_percent"min_play"and a:get_elapsed_percent"min_play">=1 then
zcall(poke,[[1;,0x5d02,@;2;,0x5d03,@;3;,0x5d04,@;4;,0x5d08,5;]],a.anchoring.x*16,
a.anchoring.y*16,
(a.anchoring.xf+1)\2
)
memcpy(0x5e00,0x5d00,64)
poke(0x5d08,1)
_g.tbox("96^great banjo playing.^saving complete!",nop)
end
end,function(a)
zspr(a.sind,a.x*8+a.sx,a.y*8+a.sy,1,1,cos(g_fi/5),sin(g_fi/5))
end,function(a)
_g.mask_init()
a.x,a.y=a.anchoring.x,a.anchoring.y
a.ang=atan2(a.xf,0)
end,function(a)
a.speed=.05
end,function(a)
a.speed=0
if g_zbtn_0|g_zbtn_2 ~=0 then
a.ang,a.speed=atan2(g_zbtn_0,g_zbtn_2),.0375
end
end,function(a)
a.end_x,a.end_y=a.x,a.y
_g.mask_end()
end,function(a)
local percent=a:get_elapsed_percent"ending"
a.x=a.end_x+(a.anchoring.x-a.end_x)*percent
a.y=a.end_y+(a.anchoring.y-a.end_y)*percent
end,function(a,pl)
pl:hurt"5"
end,function(a)sfx(3,3,0,4)a.offdx=a.xf*a.offspeed end,function(a)a.offx=abs(a.offx*8)\1/8*sgn(a.offx)end,function(a)sfx(3,3,8,4)a:normal_init()a.offdx=-a.xf*a.offspeed end,function(a,override)
return override or not a.item or a.item.id ~="mask"
end,function(a,ang,duration,override)
a:start_timer("push",duration)
a.push_ang=ang
end,function(a)
if a:is_active"push"then
a.ang,a.speed=a.push_ang,(1-a:get_elapsed_percent"pushed")*.025
end
end,function(a)
a:start_timer("isma",0)
local item=a.item
if not item.alive then item=a.default_item end
if a:is_active"injured"or a:is_active"stunned"or btn"5"or does_entity_exist"tbox"or does_entity_exist"fader"or(item.gradual_energy>0 and a.is_energy_cooling_down)or not btn"4"then
item:kill()
elseif not a:is_active"injured"and not a:is_active"stunned"and not a.is_energy_cooling_down and item.is_default and btn"4"then
local item_func=a.item_funcs[peek"0x5d08"]
if item_func then
item=item_func(a,a.xf)or item
a.target_energy+=item.initial_energy
end
end
a.speed=0
if not a:inside(g_room_bounds)then
a:push(atan2(a:abside(g_room_bounds)),5,true)
end
if not a:is_active"injured"and not a:is_active"stunned"and not does_entity_exist"fader"and not does_entity_exist"tbox"and not btn"5"then
if g_zbtn_0|g_zbtn_2 ~=0 then
a.ang,a.speed=atan2(g_zbtn_0,g_zbtn_2),.025*item.speed_multiplier
if not item.block_direction and cos(a.ang)~=0 then
a.xf=sgn(cos(a.ang))
end
end
end
if not a:is_active"injured"and not a:is_active"stunned"then
a.target_energy=max(0,a.target_energy+item.gradual_energy)
end
if a.target_energy==0 then a.is_energy_cooling_down=false
elseif a.target_energy>=1 then a.is_energy_cooling_down=true
end
local diff=a.target_energy-a.energy
a.energy+=zsgn(diff)*min(abs(diff),.03125)
a.item=item
end,function(a)
local xoff=0
local yoff=0
local xf=a.xf
local top=91
if does_entity_exist"shield"or does_entity_exist"sword"or does_entity_exist"bow"then
top=92
elseif does_entity_exist"brang"then
top=95
elseif does_entity_exist"banjo"then
top=g_fi%4<2 and 92 or 95
elseif does_entity_exist"held_to_throw"then
top=a.item:is_alive()and 93 or 94
end
zspr(a.dx|a.dy ~=0 and 88+t()*12%3 or 88,a.x*8+xoff,a.y*8-2+yoff,1,1,xf)
zspr(top,a.x*8+xoff,a.y*8-2+yoff,1,1,xf)
if a.item.visible then
zspr(a.item.sind,a.item.x*8+xoff,yoff+a.item.y*8+a.item.sy,1,1,xf)
end
end,zobj[[1;,1,0,-1,0,13;2;,0,1,0,-1,13;3;,2,1,-2,-1,1;4;,1,2,-1,-2,1;]],function(a)
if peek"0x5d0d" ~=0 then a:load()end
end,function(a)
if peek"0x5d0d"==0 then a:load()end
end,function(a)
draw_card(64,a.y,9,5,0,0,function()
spr(22,1,0)
zprinttbox(tostr(peek"0x5d0d"),12,2,0,7,5)
end,nop)
end,function(a)
local is_cooldown=g_pl.is_energy_cooling_down and g_pl.energy>=g_pl.target_energy
local fg=is_cooldown and 13 or 11
local bg=is_cooldown and 5 or 3
local yoff=a.y
draw_card(64,yoff,46,4.5,0,0,function()
zcall(draw_bar,[[1;,2,1,89,5,@,0,@,@,13]],1-g_pl.energy,
fg,bg)
end,nop)
end,function(a)
a.obj=nil
if a.next_obj and a.next_obj:is_alive()then
a.obj=a.next_obj
a.next_obj=nil
a:load()
end
end,function(a)
local buffer,cur_obj,new_lvl,new_obj,should_exit=g_zclass_entities[a.entity_type],a:get(),-1
for obj in all(buffer)do
if obj:is_active"isma"and obj:is_alive()and(obj.ma_level>new_lvl or obj==cur_obj and obj.ma_level>=new_lvl)then
new_obj,new_lvl=obj,obj.ma_level
end
end
a.next_obj=new_obj
end,function(a)
return a.curr=="normal"and a.obj and a.obj:is_alive()and a.obj
end,function(a)
if a.next_obj ~=a.obj then
a:load()
end
end,function(a)
local obj=a.obj
if obj then
local has_health=obj.parents and obj.parents.healthobj
draw_card(a.x,a.y+1,17.5,has_health and 9 or 6,2,4,function()
local xxo=11.5-11.5*a.align-1
spr(obj.cspr,xxo,-2,1,1,a.align<0)
local xyo=15.5+15.5*a.align
if obj.cname then zprinttbox(obj.cname,xyo,-1,a.align,7,5)end
if has_health then
draw_bar(15-a.align*15-1,7,15+a.align*15-1,11,obj.display_health,-1,8,2,13)
pset(-1,7,1)
pset(29,7,1)
end
end,nop)
end
end,function(a)
a.texts=split(a.rawtext,"^")
a.sind=deli(a.texts,1)
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
draw_card(64,a.y,46,10,2.5,5,
function()
zcall(zprinttbox,[[1;,@,0,-2,-1,7,5;2;,@,0,6,-1,7,5;]],a.line_1 or "",a.line_2 or "")
if a.done then
zspr(38,86,9+g_si%2)
end
end,nop)
draw_card(118,a.y,6,6,2,2,
function()
spr(a.sind,0,0,1,1,true)
end,nop)
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
if not _g.sign_target_with_tbox_disable_callback()then
a:start_timer("isma",0)
end
end,function(a)
_g.spawn_walls(a)
zcall(_g.target,[[1;,.125,.125,0,.5,@,@,nop;]],a,function()
zcall(poke,[[1;,0x5d05,@;2;,0x5d06,@;3;,0x5d07,@;]],peek"0x5d01",
a.x*16,
(a.y+1.5)*16
)
load_room(a.room,4,5,g_pl.xf)
end)
end,function(a)
a.xf=sgn(g_pl.x-a.x)
return _g.sign_target_with_tbox_disable_callback()
end,function(a)
poke(a.memloc_trigger,a.memloc_trigger_value)
load_room(%0x5d01,g_pl.x,g_pl.y,g_pl.xf)
end,function(a)
a:kill()
deregister_entity(a.target)
_g.limestatue(a.x,a.y,a.xf)
for i=0,7 do
_g.explode(a.x+cos(i/8)*3,a.y+sin(i/8)*3,4,1,function()
_g.slobs_enter_ball(a.x,a.y,i/8)
end)
end
end,function(a)
music"21"
_g.slobs(a.x,a.y)
end,function(a)
if peek"0x5d10"==0 then
return "96^the almighty power of^music is now yours!^take this banjo.",function()
poke(0x5d10,1)
end
else
return "96^try playing the banjo^on a save platform.",nop
end
end,function(a)
if peek(a.memloc)~=0 then
return "83^visit my 3 cousins^for more deals.",nop
elseif peek"0x5d0d">=4 then
return "83^thanks for the coins.^have this "..a.item_name..".",function()
poke(a.memloc,1)
poke(0x5d0d,peek"0x5d0d"-4)
end
else
return "83^4 coins will buy you^something good.",nop
end
end,function(a)
a.target=_g.target(a.trx,a.try,a.tx,a.ty,a,
function()a:callback_touch()end,
function()a:callback_outside()end
)
end,function(a)
return a.text,function()
a:target_with_tbox_finish_callback()
end
end,function(a)
if not a:target_with_tbox_disable_callback()then
a:start_timer("isma",0)
if should_interact()then
_g.tbox(a:gettext())
end
end
end,function()
return does_entity_exist"fader"or peek"0x5d08" ~=5 or not g_pl.item.is_default
end,function(a)
a.ang=rnd(2)-1
a.xf=sgn(cos(a.ang))
end,function(a,pl)
if not _g.sign_target_with_tbox_disable_callback()then
a:start_timer("isma",0)
end
end,function(a,others)
foreach(others,function(other)
if not a:outside(other)then
a:pl_collide_func(other)
end
end)
end,function(a,items)
if not a.collide_disabled then
foreach(items,function(item)
if item ~=a and not a:outside(item)and item:is_alive()then
local did_hit=false
if item.damage then
a:hurt(item.damage,function()
a.should_regen=true
did_hit=true
end)
elseif item.should_stun then
a:stun(3,function()
did_hit=true
end)
end
if did_hit then
a:start_timer("isma",2)
item:item_hit_func()
end
if item.should_push or did_hit then
if item.should_use_xf then
a:push(atan2(item.xf,item.y-a.y),.05)
else
local abx,aby=a:abside(item)
a:push(atan2(abx,aby),.05)
end
end
end
end)
end
end,function(a)
a.sind=98
for i=0,7 do
local ang=i/8+a.minion_ang_offset
if a.minions[i+1]and a.minions[i+1]:is_alive()then
_g.slimy_boss_ball(a,a.x,a.y,ang,1-2*flr_rnd"2")
else
_g.slimy_boss_ball_small(a,a.x,a.y,ang,1-2*flr_rnd"2")
end
end
end,function(a)
if a.jump_num>=3 then
a.jump_num=0
a.next="shotgun_jump"
else
a.jump_num+=1
a.next="jump"
end
end,function(a)
if a.health<=4 then
a.minion_ang_offset-=.01*a.xf
a.minion_target_rad=1.25-sin(a:get_elapsed_percent"idle"/2)*.75
end
end,function(a)
a.minion_ang_offset-=.02*a.xf
a.minion_target_rad=1.25-sin(a:get_elapsed_percent"spin"/2)*1
end,function(a)
a:start_timer("isma",0)
for i=0,7 do
local ang=i/8+a.minion_ang_offset
local cur_minion=a.minions[i+1]
if a.should_regen and a.health and(a.health>0)and(not cur_minion or not cur_minion:is_alive())then
a.minions[i+1]=_g.slimy_boss_minion_2(a,a.x,a.y,ang,1-2*flr_rnd"2")
end
end
a.should_regen=false
for i=0,7 do
local cur_minion=a.minions[i+1]
if cur_minion and cur_minion:is_alive()then
a.minions[i+1].minion_ang=i/8+a.minion_ang_offset
end
end
if a:is_active"stunned"then
a:load"stunstate"
end
end,function(a)
if not a.moving_away and a:dist_point(g_pl.x,g_pl.y)<2.5 then
a.ang=atan2(5.5-a.x,4.5-a.y)
a.moving_away=true
else
a.ang=a.target_ang
a.moving_away=false
end
a:start_timer("jumpanim",a.jump.duration)
end,function(a)
if not a.minion or not a.minion:is_alive()then
end
end,function(a)
for i=0,7 do
_g.slobs_exit_ball(a.x,a.y,i/8)
end
music"16"
_g.explode(a.x,a.y,4,1,function()
foreach(g_zclass_entities["slimy_boss_fight"],function(b)
b:kill()
end)
end)
_g.limebeat(a.x,a.y)
end,function(a)
_g.slimy_propel(a)
a.minion_ang_offset-=.02*a.xf
end,function(a)
for inst in all(g_zclass_entities.blockade)do
inst:load"open"
end
_g.slimy_start(a)
end,function(a)
if a.minion_rad<a.minion_target_rad then a.minion_rad+=.15 end
if a.minion_rad>a.minion_target_rad then a.minion_rad-=.15 end
a.x=a.start_x+cos(a.minion_ang)*a.minion_rad
a.y=a.start_y+sin(a.minion_ang)*a.minion_rad
end,function(a)
_g.miny_actual(a.x,a.y,0,0)
end,function(a,pl)
_g.slimy_pl_collide_func(a.anchoring,pl)
end,function(a)
if a.anchoring:is_active"shotgun"then
a.collide_disabled=true
a.visible=false
a.invincible=true
else
a.collide_disabled=false
a.visible=true
a.invincible=false
end
if not a:is_active"stunned"and a.minion_rad<a.anchoring.minion_target_rad then a.minion_rad+=.125 end
if a.minion_rad>a.anchoring.minion_target_rad then a.minion_rad-=.125 end
if a.anchoring:is_active"jumpanim"and not a:is_active"jumpanim"then
a:start_timer("jumpanim",a.anchoring.jump.duration)
end
a.offx=cos(a.minion_ang)*a.minion_rad
a.offy=sin(a.minion_ang)*a.minion_rad
if not a.anchoring:is_alive()then
a:kill()
end
end,function(x,y)_g.slimy_actual(x,y,0,0)end,function(a)
_g.miny_actual(a.x,a.y+.125,0,0)
_g.miny_actual(a.x,a.y-.125,0,0)
end,function(x,y)
_g.miny_actual(x,y,0,0)
end,function(a)
a.speed=a.jumpspeed
end,function(a)
a:load"stunstate"
end,function(a)
if not a:is_active"stunned"then
a:load()
end
end,function(a,pl)
if not a.collide_disabled then
a:start_timer("isma",2)
if not does_entity_exist"mask"then
pl:push(atan2(pl.x-a.x,pl.y-a.y),.1)
end
if a:is_active"jump"then
else
end
end
end,function(a)
a.xf=sgn(g_pl.x-a.x)
a.target_ang=atan2(g_pl.x-a.x,g_pl.y-a.y)
end,function(a)
if a.sind==a.idle.sind then
a.sind=a.jump.sind
else
a.sind=a.idle.sind
end
end,function(a)
a.ang=a.target_ang
a:start_timer("jumpanim",a.jump.duration)
end,function(a,pl)
pl:hurt(1)
end,function(a)
if a.wall then deregister_entity(a.wall)a.wall=nil end
end,function(a)
if not a.wall then a.wall=_g.wall(a,0,0,.375,.375)end
end,function(a)
if not a:outside(g_pl)and peek"0x5d08"==1 then
a:start_timer("isma",.01)
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
end,function()
zcall(loop_entities,[[1;,timer,tick;2;,actor,state;3;,vec,vec_update_x;4;,vec,vec_update_y;]])
end,function(state)
game_over_sind,game_over_text=unpack(rnd_item(zobj[[1;,32,quack quack.;2;,68,and play with me.;3;,9,to save hi-roll.;4;,81,in time for dinner.;5;,83,and make me rich.;6;,96,the banjo awaits you.;7;,99,for your fans.;8;,118,splat splat boing.;]]))
_g.tbox(game_over_sind.."^come back lank!^"..game_over_text,function(a)
_g.fader_out(function()g_state:load"room" end)
end)
poke(0x5f43,0)
music"-1"
g_music_ind=-1
load_save_state()
end,function(state)
zcall(loop_entities,[[1;,drawlayer_99,draw;]])
end,function(state)
local r=g_rooms[peek"0x5d01"]
local mus=flr(r.music/2)*8+(r.music%2)*5
poke(0x5f43,0)
if g_music_ind ~=mus then
g_music_ind=mus
music(mus,0,7)
end
g_room_bounds=_g.room_bounds(r.w/2,r.h/2,r.w/2-.375,r.h/2-.375)
g_pl=_g.pl(
peek"0x5d02"/16,
peek"0x5d03"/16,
peek"0x5d04"*2-1,
peek"0x5d0b",
peek"0x5d0c",
_g.inventory()
)
g_fairy=_g.fairy(g_pl.x,g_pl.y-.125)
g_rstat_left,g_rstat_right=_g.rstat(1,36,"ma_left"),_g.rstat(-1,93,"ma_right")
_g.energybar(g_pl)
_g.coin_count()
foreach(r.objects,function(obj_template)
_g[g_obj_map[obj_template.index]](obj_template.x+.5,obj_template.y+.5)
end)
end,function(state)
if g_debug and btnp"5"and g_pl and g_pl:is_alive()then
zcall(poke,[[1;,0x5d02,@;2;,0x5d03,@;3;,0x5d04,@;]],g_pl.x*16,
g_pl.y*16,
(g_pl.xf+1)\2
)
memcpy(0x5e00,0x5d00,64)
end
zcall(loop_entities,[[pls,@,solids,@,room,@,statitems,@,smaller_slimes,@;1;,timer,tick;2;,actor,state;3;,pushable,update_push;4;,mov,mov_update;5;,enemy,pl_collide_func_batch,~pls;6;,collidable,adjust_deltas_for_solids,%set_x_delta,~solids;7;,collidable,adjust_deltas_for_tiles,%set_x_delta,~room;8;,collidable,adjust_deltas_for_screen,%set_x_delta2;9;,vec,vec_update_x;10;,collidable,adjust_deltas_for_solids,%set_y_delta,~solids;11;,collidable,adjust_deltas_for_tiles,%set_y_delta,~room;12;,collidable,adjust_deltas_for_screen,%set_y_delta2;13;,vec,vec_update_y;14;,smaller_slimes,statcollide,~smaller_slimes;15;,smaller_slimes,statcollide,~statitems;16;,slobs,statcollide,~statitems;17;,slimy_boss_minion_2,statcollide,~statitems;18;,anchor,update_anchor;19;,target,update_target,~pls;20;,rstat,buffer_update;21;,healthobj,health_update;]],g_zclass_entities.pl,g_zclass_entities.solid,g_rooms[peek"0x5d01"],g_zclass_entities.statitem,g_zclass_entities.smaller_slimes)
poke(0x5d0b,g_pl.health)
poke(0x5d0c,g_pl.max_health)
if not does_entity_exist"fader"and(not g_pl:inside(g_room_bounds)or peek"0x5d0b"<=0)then
local abx,aby=g_pl:abside(g_room_bounds)
local nri=peek"0x5d01"+aby*16+abx
if peek"0x5d01">223 then
load_room(peek"0x5d05",peek"0x5d06"/16,peek"0x5d07"/16,g_pl.xf)
elseif g_rooms[nri]then
if abx ~=0 then load_room(nri,6-abx*6+1.25*abx,g_pl.y,abx)
else load_room(nri,g_pl.x,5-aby*5+1.25*aby+.25,g_pl.xf)
end
else
zcall(load_room,[[1;,135,6,5,@;]],g_pl.xf)
end
end
if does_entity_exist"mask"then
poke(0x5f40,0x0f)
else
poke(0x5f40,0x00)
end
end,function(state)
isorty(g_zclass_entities["drawlayer_50"])
draw_room(g_rooms[peek"0x5d01"],64,64,function()
zcall(loop_entities,[[1;,drawlayer_25,draw;2;,drawlayer_50,draw;3;,drawlayer_75,draw;]])
if g_debug then
for inst in all(g_zclass_entities["box"])do
scr_zrect(inst.x,inst.y,inst.rx,inst.ry,8)
end
end
end,function()
zcall(loop_entities,[[1;,drawlayer_90,draw;2;,drawlayer_95,draw;3;,drawlayer_99,draw;]])
end)
end,function()
_g.title_logo()
end,function()
if does_entity_exist"fader"then return end
zcall(loop_entities,[[1;,timer,tick;2;,actor,state;3;,vec,vec_update_x;4;,vec,vec_update_y;]])
end,function()
draw_room(g_rooms[136],64,64,nop,nop)
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
sfx(-1,3)
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
function should_interact()
return btn"4"and not btn"5"and not does_entity_exist"tbox"
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
zclass[[actor,timer|load,%actor_load,loadlogic,%actor_loadlogic,state,%actor_state,kill,%actor_kill,clean,%actor_clean,is_alive,%actor_is_alive,alive,yes,duration,null,curr,start,next,null,isnew,yes,init,nop,stateless_update,nop,update,nop,destroyed,nop;]]
zclass[[drawlayer_25|]]
zclass[[drawlayer_50|]]
zclass[[drawlayer_75|]]
zclass[[drawlayer_90|]]
zclass[[drawlayer_95|]]
zclass[[drawlayer_99|]]
zclass[[animation,actor|index,0,init,%animation_init;start;duration,@,next,start]]
zclass[[auto_outline,timer|draw,%auto_outline_draw,outline_color,1]]
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
zclass[[timer|timers;,;start_timer,%timer_reset_timer,end_timer,%timer_end_timer,is_active,%timer_is_active,get_elapsed_percent,%timer_get_elapsed_percent,tick,%timer_tick,]]
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
zclass[[vec,pos|dx,0,dy,0,vec_update_x,%vec_update_x,vec_update_y,%vec_update_y,vec_mov_towards_point,%vec_mov_towards_point]]
zclass[[mov,vec|ang,0,speed,0,mov_update,%mov_update,towards_point,%mov_towards_point]]
zclass[[explode,actor,drawlayer_50|x,@,y,@,len,@,mod,@,destroyed,@,draw,%explode_draw;start;duration,.25;]]
function get_solid_tile(room,index)
local t2=room.tiles_2[index]
if t2 then return fget(t2,0)and t2 end
t2=room.tiles_1[index]
return fget(t2,0)and t2
end
zclass[[collidable,box,vec|calc_deltas,%calc_deltas,should_collide_below,yes,should_collide_with_screen_edge,yes,adjust_deltas_for_solids,%adjust_deltas_for_solids,adjust_deltas_for_tiles,%adjust_deltas_for_tiles,adjust_deltas_for_screen,%adjust_deltas_for_screen]]
zclass[[healthobj,maskcheck|max_health,1,invincible,no,stun_callback,nop,hurt,%healthobj_hurt,stun,%healthobj_stun,health_update,%healthobj_health_update]]
zclass[[inventory,actor,vec,drawlayer_90|ind,5,x,64,y,-9,draw,%inventory_draw;defaults;dy,0,init,nop,update,nop;start;next,open,update,%inventory_start_update;open;next,normal,dy,2,duration,.1,update,%inventory_open_update,cachedir,0;normal;next,close,update,%inventory_update,init,%inventory_normal_init;close;next,start,dy,-2,duration,.1;1;mem_loc,0x5d10,sxo,0,x,-41,y,0,w,4.5,sind,1;2;mem_loc,0x5d11,sxo,0,x,-31,y,0,w,4.5,sind,5;3;mem_loc,0x5d12,sxo,0,x,-21,y,0,w,4.5,sind,7;4;mem_loc,0x5d13,sxo,0,x,-11,y,0,w,4.5,sind,2;5;mem_loc,0x5d00,sxo,2,x,0,y,0,w,6,sind,0;6;mem_loc,0x5d14,sxo,0,x,12,y,0,w,4.5,sind,6;7;mem_loc,0x5d15,sxo,0,x,22,y,0,w,4.5,sind,4;8;mem_loc,0x5d16,sxo,-1,x,32,y,0,w,4.5,sind,3;9;mem_loc,0x5d17,sxo,0,x,42,y,0,w,4.5,sind,8;]]
zclass[[solid,box|]]
zclass[[wall,solid,anchor|anchoring,@,offx,@,offy,@,rx,@,ry,@]]
zclass[[simple_spr,auto_outline,pos|drawout,%simple_spr_draw,visible,yes,should_dance,no,sind,0,sw,1,sh,1,xf,1,yf,1,sx,0,sy,0]]
zclass[[anchor,pos|update_anchor,%anchor_update_anchor;offx,0,offy,0,offdx,0,offdy,0,anchoring;,]]
zclass[[target,anchor,box|rx,@,ry,@,offx,@,offy,@,anchoring,@,callback_touch,@,callback_outside,@,update_target,%targettouch_update_target]]
zclass[[coin,actor,enemy,simple_spr,drawlayer_50|x,@,y,@,memloc,@,rx,.125,ry,.125,sind,36,draw,~drawout,pl_collide_func,%coin_pl_collide_func]]
zclass[[propel,vec|propel,%propel_func,propel_speed,0]]
zclass[[statitem,box|]]
zclass[[held_to_throw,vec,actor|visible,yes,block_direction,no,speed_multiplier,.5,initial_energy,.125,gradual_energy,0,sy,-2,item_thrown,nop,sy,-2;defaults;init,nop,update,%held_to_throw_update;start;init,%held_to_throw_beg,duration,.1,next,normal;normal;offy,-.5;ending;visible,no,init,%held_to_throw_ending_init,duration,.16;]]
zclass[[pot_held,held_to_throw|fromobj,@,anchoring,@,xf,@,sind,49,item_thrown,%pot_thrown,sy,-3]]
zclass[[quack_held,held_to_throw|fromobj,@,anchoring,@,xf,@,sind,32,item_thrown,%quack_thrown,sy,-4]]
zclass[[bomb_held,held_to_throw|anchoring,@,xf,@,sind,5,item_thrown,%bomb,initial_energy,1,sy,-3]]
zclass[[item_throwing,propel,mov,box,simple_spr,drawlayer_50,actor|rx,.25,ry,.25;start;duration,.15,update,%item_throwing_update;]]
zclass[[bomb,item_throwing|x,@,y,@,xf,@,propel_speed,@,ang,@,should_collide_below,no,sind,5,destroyed,%bomb_destroyed;]]
zclass[[pot_thrown,item_throwing,statitem|x,@,y,@,xf,@,propel_speed,@,ang,@,sind,49,destroyed,%standard_explosion,should_stun,yes,should_use_xf,yes,item_hit_func,nop,should_push,yes;]]
zclass[[quack_thrown,item_throwing|x,@,y,@,xf,@,propel_speed,@,ang,@,sind,32,destroyed,%quack_thrown_destroyed;]]
zclass[[item_horizontal,anchor|offspeed,0,normal_init,%item_horizontal_normal_init;start;init,%item_horizontal_start_init,duration,.08,next,normal;normal;init,%item_horizontal_normal_init,offdx,0;ending;init,%item_horizontal_ending_init,duration,.08;]]
zclass[[mask,anchor,actor|anchoring,@,xf,@,visible,yes,block_direction,no,speed_multiplier,1,initial_energy,.375,gradual_energy,0,offy,.2,sy,-2,sind,3;defaults;init,nop;start;init,%mask_init,offdy,-.0625,duration,.08,next,normal;normal;offy,-.125,offdy,0;ending;init,%mask_end,offdy,.0625,duration,.08;]]
zclass[[bow,item_horizontal,actor|anchoring,@,xf,@,visible,yes,block_direction,yes,speed_multiplier,.5,initial_energy,.25,gradual_energy,0,sy,-1,offspeed,.105,sind,7;ending;init,%bow_ending_init,duration,.08;]]
zclass[[pellet,vec,collidable,actor,drawlayer_50,statitem|x,@,y,@,dx,@,xf,@,damage,1,pushspeed,.375,should_use_xf,yes,item_hit_func,~kill,should_collide_below,no,rx,.25,ry,.25,destroyed,%standard_explosion,draw,%pellet_draw;start;update,%pellet_update,duration,.5;]]
zclass[[shield,item_horizontal,actor,statitem|anchoring,@,xf,@,rx,.375,ry,.375,pushspeed,.25,should_use_xf,yes,item_hit_func,nop,should_push,yes,plpushspeed,0,visible,yes,block_direction,yes,speed_multiplier,.5,initial_energy,.125,gradual_energy,0,sy,-1,offspeed,.105,sind,6;start;should_stun,yes;normal;should_stun,no;]]
zclass[[sword,item_horizontal,actor,statitem|anchoring,@,xf,@,rx,.375,ry,.25,pushspeed,.25,should_use_xf,yes,item_hit_func,%sword_item_hit_func,plpushspeed,.125,visible,yes,block_direction,yes,speed_multiplier,.5,initial_energy,.125,gradual_energy,0,sy,0,offspeed,.125,sind,2;start;damage,1;normal;damage,1;]]
zclass[[banjo,anchor,actor|anchoring,@,xf,@,visible,yes,block_direction,no,speed_multiplier,.5,initial_energy,.125,gradual_energy,0,offy,0,sy,-3,sind,1;defaults;init,nop;start;init,%banjo_start_init,offdy,.125,duration,.03,next,min_play;min_play;offdy,0,duration,2,next,normal;normal;next,ending;ending;init,%banjo_ending_init,offdy,-.125,duration,.03;]]
zclass[[brang,collidable,simple_spr,drawlayer_50,mov,actor,statitem|anchoring,@,xf,@,rx,.25,ry,.25,should_push,no,pushspeed,.25,should_use_xf,no,item_hit_func,~kill,should_stun,yes,visible,no,block_direction,yes,speed_multiplier,0,initial_energy,.125,gradual_energy,0,should_collide_below,no,offspeed,.125,drawout,%brang_drawout,sind,4;defaults;init,nop;start;init,%brang_start_init,update,%brang_start_update,duration,.125,next,normal;normal;update,%brang_normal_update,next,ending;ending;init,%brang_ending_init,update,%brang_ending_update,duration,.125,adjust_deltas_for_solids,nop,adjust_deltas_for_tiles,nop;final;update,nop,alive,no;]]
zclass[[bomb_explode,enemy,box,actor,statitem|x,@,y,@,rx,1,ry,1,damage,3,pushspeed,.25,should_use_xf,no,item_hit_func,nop,pl_collide_func,%bomb_pl_hit;start;duration,.25;]]
zclass[[maskcheck|maskcheck,%maskcheck_func]]
zclass[[pushable,mov|push_ang,0,push,%pushable_push,update_push,%pushable_update_push]]
zclass[[pl,ma_left,pushable,actor,mov,collidable,auto_outline,healthobj,drawlayer_50|cname,lank,cspr,103,x,@,y,@,xf,@,health,@,max_health,@,inventory,@,rx,.375,ry,.375,should_collide_with_screen_edge,no,should_dance,yes,update,%pl_update,energy,0,is_energy_cooling_down,no,target_energy,0,destroyed,%standard_explosion,drawout,%pl_drawout;item_funcs;1,%banjo,2,%bomb_held,3,%bow,4,%sword,5,%interact,6,%shield,7,%brang,8,%mask;default_item;visible,no,is_default,yes,block_direction,no,speed_multiplier,1,alive,yes,gradual_energy,-.0078125,initial_energy,0,kill,nop;item,~default_item;]]
function draw_bar(x1,y1,x2,y2,percent,align,fg,bg,og)
local bar_off=x2-x1-min(percent,1)*(x2-x1)
if align==0 then bar_off/=2 end
rectfill(x1,y1,x1,y2,og)
rectfill(x2,y1,x2,y2,og)
if percent>0 then
local xx=ceil(x1+(align>=0 and bar_off or 0))
local yy=flr(x2-(align<=0 and bar_off or 0))
rectfill(xx,y1,yy,y2,fg)
rectfill(xx,y2,yy,y2,bg)
end
end
function draw_card(x,y,rx,ry,coffx,coffy,card_func,post_card_func)
camera()
local x1,x2,y1,y2=x-rx,x+rx-1,y-ry,y+ry-1
local cam_x,cam_y=x1+coffx,y1+coffy
zcall_tbl(function(xx1,yy1,xx2,yy2,col)
rectfill(x1+xx1,y1+yy1,x2+xx2,y2+yy2,col)
end,_g.card_table_cache)
clip(x1+2,y1+2,x2-x1-3,y2-y1-3)
zcamera(cam_x,cam_y,card_func)
clip()
pset(x1+2,y1+2,1)pset(x1+2,y2-2,1)
pset(x2-2,y1+2,1)pset(x2-2,y2-2,1)
zcamera(cam_x,cam_y,post_card_func)
end
zclass[[coin_count,vec,actor,drawlayer_90|y,142,draw,%coin_coint_draw;defaults;dy,0,update,nop;start;next,open,update,%coin_count_start;open;next,normal,dy,-2,duration,.2;normal;next,close,update,%coin_count_normal;close;next,start,dy,2,duration,.2;]]
zclass[[energybar,vec,actor,drawlayer_99|obj,@,y,20,draw,%energybar_draw;]]
zclass[[ma_left|ma_level,0]]
zclass[[ma_right|ma_level,0]]
zclass[[ma_battle,ma_right|ma_level,0]]
zclass[[ma_boss,ma_right|ma_level,1]]
zclass[[ma_interact,ma_right|ma_level,2]]
zclass[[rstat,vec,actor,drawlayer_95|align,@,x,@,entity_type,@,y,141,draw,%stat_draw,buffer_update,%rstat_update,get,%rstat_get;defaults;dy,0,update,nop;start;next,open,update,%stat_idle;open;next,normal,dy,-2,duration,.2;normal;next,close,update,%stat_normal;close;next,start,dy,2,duration,.2;]]
zclass[[tbox,vec,actor,drawlayer_99|rawtext,@,destroyed,@,y,142,cur_text_index,1,anim,0,line_1,,line_2,,update,%tbox_update,draw,%tbox_draw;texts;,;defaults;init,nop,update,nop;start;dy,-2,duration,.2,next,normal,init,%tbox_init;normal;dy,0,anim,0,done,no,update,%tbox_update;ending;dy,2,duration,.2;]]
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
zclass[[woodcrate,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.25,draw,~drawout,sind,35]]
zclass[[pot,solid,class_with_target,drawlayer_50,ma_interact,simple_spr|x,@,y,@,cspr,49,cname,pot,sind,49,rx,.375,ry,.375,trx,.5,try,.125,callback_touch,%pot_callback_touch]]
zclass[[bedbot_l,actor,simple_spr,drawlayer_50|x,@,y,@,sind,55,init,%spawn_walls;walls;1;,~,0,.25,.75,.25;walls;2;,~,0.5625,0,0.1875,.25;walls;3;,~,-.625,-.5,.25,1;]]
zclass[[bedbot_r,actor,simple_spr,drawlayer_50|x,@,y,@,sind,55,init,%spawn_walls;walls;1;,~,0,.25,.75,.25;walls;2;,~,-0.5625,0,0.1875,.25;walls;3;,~,.625,-.5,.25,1;]]
zclass[[bedpillow,simple_spr,drawlayer_25|x,@,y,@,sind,39]]
zclass[[house,actor,simple_spr,drawlayer_50|cspr,174,sind,174,sw,2,sh,2,init,%house_init;walls;1;,~,.75,.5,.25,.375;walls;2;,~,-.75,.5,.25,.375;walls;3;,~,0,.25,.5,.125;]]
zclass[[house231,house|x,@,y,@,xf,-1,room,231]]
zclass[[house224,house|x,@,y,@,room,224]]
zclass[[house225,house|x,@,y,@,xf,-1,room,225]]
zclass[[house226,house|x,@,y,@,room,226]]
zclass[[house227,house|x,@,y,@,room,227]]
zclass[[house228,house|x,@,y,@,room,228]]
zclass[[house229,house|x,@,y,@,xf,-1,room,229]]
zclass[[person,actor,solid,target_with_tbox,simple_spr,drawlayer_50|sy,-2,should_dance,yes,rx,.375,ry,.375,trx,.5,try,.5,target_with_tbox_disable_callback,%person_target_with_tbox_disable_callback]]
zclass[[navyblock,person|x,@,y,@,cname,navy,cspr,97,sind,97,text,97^my sister has been in^the forest all day.^please ask her to^come back home.,rx,.375,ry,1,memloc_trigger,0x5d09,memloc_trigger_value,1,target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback|0x5d09|0]]
zclass[[navyhouse,person|x,@,y,@,cname,navy,cspr,97,sind,97,text,im navy in a house|0x5d09|1]]
zclass[[limeboss,person|x,@,y,@,cname,lime,cspr,101,sind,101,text,101^my brother sent you^right?^he must be really^worried about me.^i can come home now.^^...^^wait! what is that?,rx,.375,ry,.375,target_with_tbox_finish_callback,%lime_callback|0x5d0e|0]]
zclass[[limebeat,person|x,@,y,@,cname,lime,cspr,98,sind,98,text,98^ouchies. thanks for^saving my life.^now i will go home.,target_with_tbox_disable_callback,%sign_target_with_tbox_disable_callback,rx,.375,ry,.375,memloc_trigger,0x5d0e,memloc_trigger_value,1,target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback]]
zclass[[slobs_enter_ball,actor,simple_spr,drawlayer_75|x,@,y,@,minion_ang,@,start_x,~x,start_y,~y,sind,106,update,%slimy_ball_update,minion_target_rad,.5,minion_rad,3,max_health,1;start;duration,.25;]]
zclass[[limestatue,actor,simple_spr,drawlayer_50|x,@,y,@,xf,@,sind,101,sy,-2,shaking,yes,destroyed,%limestatue_destroyed;start;duration,.5;]]
zclass[[bobblock,solid,person|x,@,y,@,xf,-1,cname,bob,cspr,80,sind,80,text,80^hi lank. i am hungry.^^i mean i am fixing^the road.,ry,1,memloc_trigger,0x5d0a,memloc_trigger_value,1,target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback|0x5d0a|0]]
zclass[[bobhouse,person|x,@,y,@,cname,bob,cspr,80,sind,80,text,80^this is some tasty^duck soup.|0x5d0a|1]]
zclass[[jane,person|x,@,y,@,cname,jane,cspr,81,sind,81,text,81^what should i make my^hubby for lunch?]]
zclass[[teach,person|x,@,y,@,cname,teach,cspr,96,sind,96,gettext,%teach_gettext]]
zclass[[lark,person|x,@,y,@,cname,lark,cspr,99,sind,99,text,99^im lark in a house]]
zclass[[keep_parent,person|x,@,y,@,cname,keep,cspr,83,sind,83,gettext,%keep_gettext]]
zclass[[keep_brang,keep_parent|x,@,y,@,item_name,boomerang,memloc,0x5d15]]
zclass[[keep_shield,keep_parent|x,@,y,@,item_name,shield,memloc,0x5d14]]
zclass[[keep_sling,keep_parent|x,@,y,@,item_name,slingshot,memloc,0x5d12]]
zclass[[keep_mask,keep_parent|x,@,y,@,item_name,scary mask,memloc,0x5d16]]
zclass[[class_with_target,actor|trx,0,try,0,tx,0,ty,0,init,%class_with_target_init,callback_touch,nop,callback_outside,nop]]
zclass[[target_with_tbox,class_with_target,ma_interact|text,,gettext,%target_with_tbox_gettext,callback_touch,%target_with_tbox_target_func,target_with_tbox_disable_callback,nop,target_with_tbox_finish_callback,nop]]
zclass[[sign,target_with_tbox,solid,simple_spr,drawlayer_50|rx,.375,ry,.375,sy,-2,target_with_tbox_disable_callback,%sign_target_with_tbox_disable_callback,cname,sign,cspr,24,sind,24,trx,.125,try,.375,tx,0,ty,.25]]
zclass[[signtest,sign|x,@,y,@,text,24^mary had a^little lamb^little lamb^little lamb^mary had a^little lamb^whose fleece was^white as yo face]]
zclass[[signlank,sign|x,@,y,@,text,24^lanks house]]
zclass[[signkeep,sign|x,@,y,@,text,24^keeps house]]
zclass[[signnavy,sign|x,@,y,@,text,24^navys house]]
zclass[[signteach,sign|x,@,y,@,text,24^teachs house]]
zclass[[signlark,sign|x,@,y,@,text,24^larks house]]
zclass[[signjane,sign|x,@,y,@,text,24^janes house]]
zclass[[enemy,box|pl_collide_func_batch,%enemy_pl_collide_func_batch,pl_collide_func,nop]]
zclass[[quack,propel,ma_interact,actor,collidable,mov,enemy,simple_spr,drawlayer_50|x,@,y,@,rx,.25,ry,.25,should_dance,yes,sy,-2,propel_speed,.0125,pl_collide_func,%quack_pl_collide_func,sind,32,cspr,32,cname,quack;start;init,%quack_change_dir,update,~propel,duration,1,next,start;]]
zclass[[slimy_parent,pushable,actor,healthobj,enemy,simple_spr|should_push,yes,should_dance,yes,statcollide,%slimy_parent_statcollide]]
zclass[[slimy_boss_fight|]]
zclass[[slobs,slimy_parent,ma_boss,collidable,drawlayer_50|x,@,y,@,cspr,120,cname,slobs,sind,120,destroyed,%slimyboss_destroyed;jump_num,0,should_regen,yes,moving_away,yes,did_spin,no,rx,.5,ry,.5,sy,-1,pl_collide_func,%slimy_pl_collide_func,stun_callback,%slimy_stun_callback,minion_ang_offset,.125,max_health,8;minions;,;defaults;shaking,no,init,nop,update,nop,minion_target_rad,1.25,sind,120,collide_disabled,no,visible,yes,invincible,no;start;next,realstart,duration,0;realstart;init,%slimyboss_init,duration,.25,next,idle,stateless_update,%slimy_boss_stateless_update;stunstate;update,%slimy_stunstate,next,idle;idle;init,%slimy_boss_idle_init,update,%slimy_boss_idle_update,duration,.75,next,idle_face;idle_face;sind,121,update,%slimy_start,duration,.0625,next,bounce;bounce;init,%slobs_calc_next,duration,.0625;jump;jumpspeed,.025,sind,121,init,%slimy_boss_jump_init,update,%slimyboss_jump,duration,.25,next,idle;shotgun_jump;invincible,yes,minion_target_rad,.5,jumpspeed,.025,sind,121,init,%slimy_boss_jump_init,duration,.25,next,shotgun;shotgun;invincible,yes,minion_target_rad,.5,init,%slobs_shotgun_init,duration,.75,next,shotgun_jump_2,shaking,yes;shotgun_jump_2;invincible,yes,minion_target_rad,.5,jumpspeed,.025,sind,121,init,%slimy_boss_jump_init,duration,.25,next,idle;]]
zclass[[slobs_exit_ball,actor,simple_spr,drawlayer_75|x,@,y,@,minion_ang,@,start_x,~x,start_y,~y,sind,106,update,%slimy_ball_update,destroyed,%standard_explosion,minion_target_rad,3,minion_rad,.5,max_health,1;start;duration,.25;]]
zclass[[slimy_boss_ball,slimy_parent,slimy_boss_fight,drawlayer_75|anchoring,@,x,@,y,@,minion_ang,@,xf,@,sind,105,minion_rad,.25,start_x,~x,start_y,~y,update,%slimy_ball_update,pl_collide_func,%slimy_minion_pl_collide,rx,.5,ry,.5,max_health,1;start;minion_target_rad,3,duration,.5,next,compress;compress;minion_target_rad,.25,duration,.25;]]
zclass[[slimy_boss_ball_small,slimy_parent,slimy_boss_fight,drawlayer_75|anchoring,@,x,@,y,@,minion_ang,@,xf,@,sind,106,minion_rad,.25,start_x,~x,start_y,~y,update,%slimy_ball_update,pl_collide_func,%slimy_minion_pl_collide,rx,.25,ry,.25,max_health,1;start;minion_target_rad,3,duration,.5,next,compress;compress;minion_target_rad,.25,duration,.25;]]
zclass[[slimy_boss_minion_2,slimy_parent,anchor,slimy_boss_fight,drawlayer_75|anchoring,@,x,@,y,@,minion_ang,@,xf,@,sind,104,minion_rad,0,respawn_wait,4,update,%slimy_minion_update,pl_collide_func,%slimy_minion_pl_collide,rx,.25,ry,.25,max_health,1;]]
zclass[[smaller_slimes|]]
zclass[[slimy_actual,slimy_parent,ma_battle,collidable,smaller_slimes,drawlayer_50|x,@,y,@,dx,@,dy,@,idle_sind,118,jump_sind,119,cspr,~idle_sind,cname,slimy,sind,~idle_sind,destroyed,%slimy_destroyed,rx,.375,ry,.375,max_health,2,pl_collide_func,%slimy_pl_collide_func,stun_callback,%slimy_stun_callback,curr,idle;defaults;init,nop,update,nop;stunstate;next,idle,update,%slimy_stunstate;idle;next,bounce_1,update,%slimy_start,sind,~idle_sind,duration,.5;bounce_1;next,bounce_2,duration,.0625,sind,~jump_sind;bounce_2;next,jump,duration,.0625,sind,~idle_sind;jump;next,idle,init,%slimy_jump_init,jumpspeed,.025,update,%slimy_propel,duration,.25,sind,~jump_sind;]]
zclass[[miny_actual,slimy_parent,ma_battle,collidable,smaller_slimes,drawlayer_50|x,@,y,@,dx,@,dy,@,idle_sind,116,jump_sind,117,cspr,~idle_sind,cname,miny,sind,~idle_sind,destroyed,%standard_explosion,rx,.25,ry,.25,max_health,1,pl_collide_func,%slimy_pl_collide_func,stun_callback,%slimy_stun_callback,curr,idle;defaults;init,nop,update,nop;stunstate;next,idle,update,%slimy_stunstate;idle;next,bounce_1,update,%slimy_start,sind,~idle_sind,duration,.5;bounce_1;next,bounce_2,duration,.0625,sind,~jump_sind;bounce_2;next,jump,duration,.0625,sind,~idle_sind;jump;next,idle,init,%slimy_jump_init,jumpspeed,.025,update,%slimy_propel,duration,.25,sind,~jump_sind;]]
zclass[[spike,enemy,simple_spr,actor,drawlayer_25|sind,52,rx,.25,ry,.25,sy,0,draw,~drawout;defaults;pl_collide_func,nop;start;next,down;down;next,middle1,sind,52,duration,.9;middle1;next,up,sind,53,duration,.05;up;next,middle2,sind,54,pl_collide_func,%spike_pl_collide_func,duration,.25;middle2;next,down,sind,53,duration,.05;]]
zclass[[blockade,simple_spr,actor,drawlayer_25|x,@,y,@,draw,~drawout,curr,closed;close;next,closed,sind,26,init,%blockade_close_init,duration,.05;closed;next,open,sind,25;open;next,opened,sind,26,init,%blockade_open_init,duration,.05;opened;next,close,sind,27;]]
zclass[[r1spike,spike|x,@,y,@,xf,1;start;duration,0;]]
zclass[[r2spike,spike|x,@,y,@,xf,1;start;duration,.625;]]
zclass[[l1spike,spike|x,@,y,@,xf,-1;start;duration,0;]]
zclass[[l2spike,spike|x,@,y,@,xf,-1;start;duration,.625;]]
zclass[[saveplat,ma_interact,box,simple_spr,actor,drawlayer_25|x,@,y,@,rx,.375,ry,.375,cname,save,cspr,10,sind,40,sw,2,sh,2,draw,~drawout,update,%saveplat_update;]]
g_fade,g_fade_table=1,zobj[[0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,0,0,0,0;2;,2,2,2,1,0,0,0,0;3;,3,3,3,3,1,1,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,0,0,0,0;6;,6,6,13,13,5,5,0,0;7;,7,7,6,13,13,5,0,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,0,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,0,0,0;13;,13,13,5,5,1,0,0,0;14;,14,14,13,4,2,2,0,0;15;,15,15,13,13,5,5,0,0;]]
g_fade_table_gray=zobj[[0;,0,0;1;,1,1;2;,2,5;3;,3,13;4;,4,13;5;,5,5;6;,6,6;7;,7,7;8;,8,13;9;,9,6;10;,10,7;11;,11,7;12;,12,7;13;,13,13;14;,14,6;15;,15,6;]]
g_fade_table_red=zobj[[0;,0,0;1;,1,2;2;,2,2;3;,3,8;4;,4,4;5;,5,2;6;,6,4;7;,7,8;8;,8,8;9;,9,14;10;,10,14;11;,11,8;12;,12,7;13;,13,4;14;,14,8;15;,15,14;]]
function fade(threshold)
for c=0,15 do
pal(c,g_fade_table[c][1+flr(7*min(1,max(0,threshold)))],1)
end
end
function gray_fade(threshold)
for c=0,15 do
pal(c,g_fade_table_gray[c][1+threshold])
end
end
function shade_fade()
for c=0,15 do
pal(c,13)
end
end
function red_fade(threshold)
for c=0,15 do
pal(c,g_fade_table_red[c][1+threshold])
end
end
zclass[[fader,actor|ecs_exclusions;actor,yes,timer,yes;]]
zclass[[fader_out,fader|start;duration,.5,destroyed,@,update,%fader_out_update]]
zclass[[fader_in,fader|start;duration,.5,update,%fader_in_update]]
zclass[[room_bounds,box|x,@,y,@,rx,@,ry,@]]
function load_room(rind,x,y,xf)
if not does_entity_exist"fader"then
_g.fader_out(function()
if peek"0x5d0b"<=0 then
g_state:load"gameover"
else
zcall(poke,[[1;,0x5d01,@;2;,0x5d02,@;3;,0x5d03,@;4;,0x5d04,@;]],rind,
x*16,
y*16,
(xf+1)\2
)
g_state:load"room"
end
end)
end
end
zclass[[title_logo,actor,auto_outline,drawlayer_99|update,%title_logo_update,drawout,%title_logo_drawout;]]
cartdata"zeldo_rewrite"
menuitem(1,"reset save data",function()
memset(0x5e00,0,64)
extcmd"reset"
end)
zclass[[game_state,actor|ecs_exclusions;actor,yes,timer,yes;curr,room,init,%game_state_init;logo;state_init,%logo_init,update,%simple_update,draw,%logo_draw,duration,2.5,next,title;title;state_init,%title_init,update,%simple_update,draw,%title_draw;room;state_init,%room_init,update,%room_update,draw,%room_draw;gameover;state_init,%gameover_init,update,%gameover_update,draw,%gameover_draw;]]
function load_save_state()
memcpy(0x5d00,0x5e00,64)
if peek"0x5d00"==0 then
zcall(poke,[[1;,0x5d00,1;2;,0x5d01,224;3;,0x5d02,24;4;,0x5d03,34;5;,0x5d05,121;6;,0x5d06,96;7;,0x5d07,72;8;,0x5d04,1;9;,0x5d08,5;10;,0x5d0b,10;11;,0x5d0c,10;12;,0x5d13,1;]])
end
end
function _init()
load_save_state()
poke2(0x5f5c,6)
g_si,g_fi,g_state,g_rooms=0,0,_g.game_state(),decode_map()
g_tile_animation_lookup=create_tile_animation_lookup(g_rooms[0])
end
function _update60()
g_zbtn_0,g_zbtn_2=zbtn(btn,0),zbtn(btn,2)
if btn(4)and btnp(5)then g_debug=not g_debug end
zcall(loop_entities,[[1;,actor,clean;2;,fader,clean;]])
register_entities()
zcall(loop_entities,[[1;,fader,tick;2;,game_state,tick;3;,fader,state;4;,game_state,state;]])
end
function _draw()
g_si,g_fi=g_slow_animation.index,g_fast_animation.index
cls()
loop_entities("game_state","draw")
fade(g_fade)
camera()
rect(0,0,127,127,8)
end