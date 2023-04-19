g_obj_map=split"bedpillow,bedbot_l,pot,house231,navyblock,signlank,signkeep,signnavy,signteach,signlark,signjane,house224,house225,house226,house227,house228,house229,navyhouse,bobblock,bobhouse,bedbot_r,teach,jane,lark,r1spike,r2spike,l1spike,l2spike,saveplat,woodtbl,greytbl,soupbucket,slimy,miny,woodcrate,quack,blockade,keep_brang,keep_shield,keep_sling,keep_mask,limeboss,nil,nil,nil,nil,nil,nil,coin_1,coin_2,coin_3,coin_4,coin_5,coin_6,coin_7,coin_8,coin_9,coin_10,coin_11,coin_12,coin_13,coin_14,coin_15,coin_16,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil"
function decode_map()
local rooms,cur_loc={},0x2000
local peek_inc=function()
cur_loc+=1
return@(cur_loc-1)
end
while@cur_loc ~=255 do
local room,room_ind=zobj"tiles_1;,;tiles_2;,;objects;,;w,12,h,10,color,0,music,0",peek_inc()
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
elseif val=="~" then return table
elseif ord(val)==126 then return table[sub(val,2)]
elseif val=="@" then return deli(parameters,1)
elseif val=="yes" or val=="no" then return val=="yes"
elseif val=="null" or val=="" then return
elseif val=="nop" then return nop
end return val
end
function zobj_set(table,str,...)
local params,statements,dest={...},split(str,";"),table
foreach(statements,function(statement)
local tokens=split(statement)
if #tokens>1 then
if tokens[1]=="" then
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
_g=G_TABLE_INITIALIZATION
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
return btn"4" and not btn"5" and not does_entity_exist"tbox"
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
zclass"actor,timer|load,%actor_load,loadlogic,%actor_loadlogic,state,%actor_state,kill,%actor_kill,clean,%actor_clean,is_alive,%actor_is_alive,alive,yes,duration,null,curr,start,next,null,isnew,yes,init,nop,stateless_update,nop,update,nop,destroyed,nop;"
zclass"drawlayer_25|"
zclass"drawlayer_50|"
zclass"drawlayer_75|"
zclass"drawlayer_90|"
zclass"drawlayer_95|"
zclass"drawlayer_99|"
zclass"animation,actor|index,0,init,%animation_init;start;duration,@,next,start"
zclass"auto_outline,timer|draw,%auto_outline_draw,outline_color,1"
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
zclass"timer|timers;,;start_timer,%timer_reset_timer,end_timer,%timer_end_timer,is_active,%timer_is_active,get_elapsed_percent,%timer_get_elapsed_percent,tick,%timer_tick,"
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
zclass"box,pos|rx,0,ry,0,touching,%box_touching,inside,%box_inside,outside,%box_outside,side,%box_side,abside,%box_abside,getdelta,%box_getdelta"
function zsgn(num)
return num==0 and 0 or sgn(num)
end
function get_delta_axis(dx,x,rx,tdx,tdrx)
local xp=(x-tdx)/tdrx
return abs(xp)-rx/tdrx<1 and tdx+sgn(xp)*(rx+tdrx)-(x-dx)or dx
end
zclass"pos|x,0,y,0,dist_point,%pos_dist_point"
zclass"vec,pos|dx,0,dy,0,vec_update_x,%vec_update_x,vec_update_y,%vec_update_y,vec_mov_towards_point,%vec_mov_towards_point"
zclass"mov,vec|ang,0,speed,0,mov_update,%mov_update,towards_point,%mov_towards_point"
zclass"explode,actor,drawlayer_50|x,@,y,@,len,@,mod,@,destroyed,@,draw,%explode_draw;start;duration,.25;"
function get_solid_tile(room,index)
local t2=room.tiles_2[index]
if t2 then return fget(t2,0)and t2 end
t2=room.tiles_1[index]
return fget(t2,0)and t2
end
zclass"collidable,box,vec|calc_deltas,%calc_deltas,should_collide_below,yes,should_collide_with_screen_edge,yes,adjust_deltas_for_solids,%adjust_deltas_for_solids,adjust_deltas_for_tiles,%adjust_deltas_for_tiles,adjust_deltas_for_screen,%adjust_deltas_for_screen"
zclass"healthobj,maskcheck|max_health,1,invincible,no,stun_callback,nop,hurt,%healthobj_hurt,stun,%healthobj_stun,health_update,%healthobj_health_update"
zclass"inventory,actor,vec,drawlayer_90|ind,5,x,64,y,-9,draw,%inventory_draw;defaults;dy,0,init,nop,update,nop;start;next,open,update,%inventory_start_update;open;next,normal,dy,2,duration,.1,update,%inventory_open_update,cachedir,0;normal;next,close,update,%inventory_update,init,%inventory_normal_init;close;next,start,dy,-2,duration,.1;1;mem_loc,0x5d10,sxo,0,x,-41,y,0,w,4.5,sind,1;2;mem_loc,0x5d11,sxo,0,x,-31,y,0,w,4.5,sind,5;3;mem_loc,0x5d12,sxo,0,x,-21,y,0,w,4.5,sind,7;4;mem_loc,0x5d13,sxo,0,x,-11,y,0,w,4.5,sind,2;5;mem_loc,0x5d00,sxo,2,x,0,y,0,w,6,sind,0;6;mem_loc,0x5d14,sxo,0,x,12,y,0,w,4.5,sind,6;7;mem_loc,0x5d15,sxo,0,x,22,y,0,w,4.5,sind,4;8;mem_loc,0x5d16,sxo,-1,x,32,y,0,w,4.5,sind,3;9;mem_loc,0x5d17,sxo,0,x,42,y,0,w,4.5,sind,8;"
zclass"solid,box|"
zclass"wall,solid,anchor|anchoring,@,offx,@,offy,@,rx,@,ry,@"
zclass"simple_spr,auto_outline,pos|drawout,%simple_spr_draw,visible,yes,should_dance,no,sind,0,sw,1,sh,1,xf,1,yf,1,sx,0,sy,0"
zclass"anchor,pos|update_anchor,%anchor_update_anchor;offx,0,offy,0,offdx,0,offdy,0,anchoring;,"
zclass"target,anchor,box|rx,@,ry,@,offx,@,offy,@,anchoring,@,callback_touch,@,callback_outside,@,update_target,%targettouch_update_target"
zclass"coin,actor,enemy,simple_spr,drawlayer_50|x,@,y,@,memloc,@,rx,.125,ry,.125,sind,36,draw,~drawout,pl_collide_func,%coin_pl_collide_func"
zclass"propel,vec|propel,%propel_func,propel_speed,0"
zclass"statitem,box|"
zclass"held_to_throw,vec,actor|visible,yes,block_direction,no,speed_multiplier,.5,initial_energy,.125,gradual_energy,0,sy,-2,item_thrown,nop,sy,-2;defaults;init,nop,update,%held_to_throw_update;start;init,%held_to_throw_beg,duration,.1,next,normal;normal;offy,-.5;ending;visible,no,init,%held_to_throw_ending_init,duration,.16;"
zclass"pot_held,held_to_throw|fromobj,@,anchoring,@,xf,@,sind,49,item_thrown,%pot_thrown,sy,-3"
zclass"quack_held,held_to_throw|fromobj,@,anchoring,@,xf,@,sind,32,item_thrown,%quack_thrown,sy,-4"
zclass"bomb_held,held_to_throw|anchoring,@,xf,@,sind,5,item_thrown,%bomb,initial_energy,1,sy,-3"
zclass"item_throwing,propel,mov,box,simple_spr,drawlayer_50,actor|rx,.25,ry,.25;start;duration,.15,update,%item_throwing_update;"
zclass"bomb,item_throwing|x,@,y,@,xf,@,propel_speed,@,ang,@,should_collide_below,no,sind,5,destroyed,%bomb_destroyed;"
zclass"pot_thrown,item_throwing,statitem|x,@,y,@,xf,@,propel_speed,@,ang,@,sind,49,destroyed,%standard_explosion,should_stun,yes,should_use_xf,yes,item_hit_func,nop,should_push,yes;"
zclass"quack_thrown,item_throwing|x,@,y,@,xf,@,propel_speed,@,ang,@,sind,32,destroyed,%quack_thrown_destroyed;"
zclass"item_horizontal,anchor|offspeed,0,normal_init,%item_horizontal_normal_init;start;init,%item_horizontal_start_init,duration,.08,next,normal;normal;init,%item_horizontal_normal_init,offdx,0;ending;init,%item_horizontal_ending_init,duration,.08;"
zclass"mask,anchor,actor|anchoring,@,xf,@,visible,yes,block_direction,no,speed_multiplier,1,initial_energy,.375,gradual_energy,0,offy,.2,sy,-2,sind,3;defaults;init,nop;start;init,%mask_init,offdy,-.0625,duration,.08,next,normal;normal;offy,-.125,offdy,0;ending;init,%mask_end,offdy,.0625,duration,.08;"
zclass"bow,item_horizontal,actor|anchoring,@,xf,@,visible,yes,block_direction,yes,speed_multiplier,.5,initial_energy,.25,gradual_energy,0,sy,-1,offspeed,.105,sind,7;ending;init,%bow_ending_init,duration,.08;"
zclass"pellet,vec,collidable,actor,drawlayer_50,statitem|x,@,y,@,dx,@,xf,@,damage,1,pushspeed,.375,should_use_xf,yes,item_hit_func,~kill,should_collide_below,no,rx,.25,ry,.25,destroyed,%standard_explosion,draw,%pellet_draw;start;update,%pellet_update,duration,.5;"
zclass"shield,item_horizontal,actor,statitem|anchoring,@,xf,@,rx,.375,ry,.375,pushspeed,.25,should_use_xf,yes,item_hit_func,nop,should_push,yes,plpushspeed,0,visible,yes,block_direction,yes,speed_multiplier,.5,initial_energy,.125,gradual_energy,0,sy,-1,offspeed,.105,sind,6;start;should_stun,yes;normal;should_stun,no;"
zclass"sword,item_horizontal,actor,statitem|anchoring,@,xf,@,rx,.375,ry,.25,pushspeed,.25,should_use_xf,yes,item_hit_func,%sword_item_hit_func,plpushspeed,.125,visible,yes,block_direction,yes,speed_multiplier,.5,initial_energy,.125,gradual_energy,0,sy,0,offspeed,.125,sind,2;start;damage,1;normal;damage,1;"
zclass"banjo,anchor,actor|anchoring,@,xf,@,visible,yes,block_direction,no,speed_multiplier,.5,initial_energy,.125,gradual_energy,0,offy,0,sy,-3,sind,1;defaults;init,nop;start;init,%banjo_start_init,offdy,.125,duration,.03,next,min_play;min_play;offdy,0,duration,2,next,normal;normal;next,ending;ending;init,%banjo_ending_init,offdy,-.125,duration,.03;"
zclass"brang,collidable,simple_spr,drawlayer_50,mov,actor,statitem|anchoring,@,xf,@,rx,.25,ry,.25,should_push,no,pushspeed,.25,should_use_xf,no,item_hit_func,~kill,should_stun,yes,visible,no,block_direction,yes,speed_multiplier,0,initial_energy,.125,gradual_energy,0,should_collide_below,no,offspeed,.125,drawout,%brang_drawout,sind,4;defaults;init,nop;start;init,%brang_start_init,update,%brang_start_update,duration,.125,next,normal;normal;update,%brang_normal_update,next,ending;ending;init,%brang_ending_init,update,%brang_ending_update,duration,.125,adjust_deltas_for_solids,nop,adjust_deltas_for_tiles,nop;final;update,nop,alive,no;"
zclass"bomb_explode,enemy,box,actor,statitem|x,@,y,@,rx,1,ry,1,damage,3,pushspeed,.25,should_use_xf,no,item_hit_func,nop,pl_collide_func,%bomb_pl_hit;start;duration,.25;"
zclass"maskcheck|maskcheck,%maskcheck_func"
zclass"pushable,mov|push_ang,0,push,%pushable_push,update_push,%pushable_update_push"
zclass"pl,ma_left,pushable,actor,mov,collidable,auto_outline,healthobj,drawlayer_50|cname,lank,cspr,103,x,@,y,@,xf,@,health,@,max_health,@,inventory,@,rx,.375,ry,.375,should_collide_with_screen_edge,no,should_dance,yes,update,%pl_update,energy,0,is_energy_cooling_down,no,target_energy,0,destroyed,%standard_explosion,drawout,%pl_drawout;item_funcs;1,%banjo,2,%bomb_held,3,%bow,4,%sword,5,%interact,6,%shield,7,%brang,8,%mask;default_item;visible,no,is_default,yes,block_direction,no,speed_multiplier,1,alive,yes,gradual_energy,-.0078125,initial_energy,0,kill,nop;item,~default_item;"
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
zclass"coin_count,vec,actor,drawlayer_90|y,142,draw,%coin_coint_draw;defaults;dy,0,update,nop;start;next,open,update,%coin_count_start;open;next,normal,dy,-2,duration,.2;normal;next,close,update,%coin_count_normal;close;next,start,dy,2,duration,.2;"
zclass"energybar,vec,actor,drawlayer_99|obj,@,y,20,draw,%energybar_draw;"
zclass"ma_left|ma_level,0"
zclass"ma_right|ma_level,0"
zclass"ma_battle,ma_right|ma_level,0"
zclass"ma_boss,ma_right|ma_level,1"
zclass"ma_interact,ma_right|ma_level,2"
zclass"rstat,vec,actor,drawlayer_95|align,@,x,@,entity_type,@,y,141,draw,%stat_draw,buffer_update,%rstat_update,get,%rstat_get;defaults;dy,0,update,nop;start;next,open,update,%stat_idle;open;next,normal,dy,-2,duration,.2;normal;next,close,update,%stat_normal;close;next,start,dy,2,duration,.2;"
zclass"tbox,vec,actor,drawlayer_99|rawtext,@,destroyed,@,y,142,cur_text_index,1,anim,0,line_1,,line_2,,update,%tbox_update,draw,%tbox_draw;texts;,;defaults;init,nop,update,nop;start;dy,-2,duration,.2,next,normal,init,%tbox_init;normal;dy,0,anim,0,done,no,update,%tbox_update;ending;dy,2,duration,.2;"
zclass"fairy,actor,mov,drawlayer_50|x,@,y,@,update,%fairy_update,draw,%fairy_draw"
function draw_tail(x,y,dx,dy,mult)
for i=-2,2 do
local m=.125*sgn(i)
scr_line(x+abs(i)\2*m,y+i%2*m,x-dx*mult,y-dy*mult,1)
end
end
zclass"woodtbl,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.375,draw,~drawout,sind,16"
zclass"greytbl,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.375,draw,~drawout,sind,17"
zclass"soupbucket,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.375,draw,~drawout,sind,18"
zclass"woodcrate,solid,drawlayer_50,simple_spr|x,@,y,@,rx,.375,ry,.25,draw,~drawout,sind,35"
zclass"pot,solid,class_with_target,drawlayer_50,ma_interact,simple_spr|x,@,y,@,cspr,49,cname,pot,sind,49,rx,.375,ry,.375,trx,.5,try,.125,callback_touch,%pot_callback_touch"
zclass"bedbot_l,actor,simple_spr,drawlayer_50|x,@,y,@,sind,55,init,%spawn_walls;walls;1;,~,0,.25,.75,.25;walls;2;,~,0.5625,0,0.1875,.25;walls;3;,~,-.625,-.5,.25,1;"
zclass"bedbot_r,actor,simple_spr,drawlayer_50|x,@,y,@,sind,55,init,%spawn_walls;walls;1;,~,0,.25,.75,.25;walls;2;,~,-0.5625,0,0.1875,.25;walls;3;,~,.625,-.5,.25,1;"
zclass"bedpillow,simple_spr,drawlayer_25|x,@,y,@,sind,39"
zclass"house,actor,simple_spr,drawlayer_50|cspr,174,sind,174,sw,2,sh,2,init,%house_init;walls;1;,~,.75,.5,.25,.375;walls;2;,~,-.75,.5,.25,.375;walls;3;,~,0,.25,.5,.125;"
zclass"house231,house|x,@,y,@,xf,-1,room,231"
zclass"house224,house|x,@,y,@,room,224"
zclass"house225,house|x,@,y,@,xf,-1,room,225"
zclass"house226,house|x,@,y,@,room,226"
zclass"house227,house|x,@,y,@,room,227"
zclass"house228,house|x,@,y,@,room,228"
zclass"house229,house|x,@,y,@,xf,-1,room,229"
zclass"person,actor,solid,target_with_tbox,simple_spr,drawlayer_50|sy,-2,should_dance,yes,rx,.375,ry,.375,trx,.5,try,.5,target_with_tbox_disable_callback,%person_target_with_tbox_disable_callback"
zclass"navyblock,person|x,@,y,@,cname,navy,cspr,97,sind,97,text,97^my sister has been in^the forest all day.^please ask her to^come back home.,rx,.375,ry,1,memloc_trigger,0x5d09,memloc_trigger_value,1,target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback|0x5d09|0"
zclass"navyhouse,person|x,@,y,@,cname,navy,cspr,97,sind,97,text,im navy in a house|0x5d09|1"
zclass"limeboss,person|x,@,y,@,cname,lime,cspr,101,sind,101,text,101^my brother sent you^right?^he must be really^worried about me.^i can come home now.^^...^^wait! what is that?,rx,.375,ry,.375,target_with_tbox_finish_callback,%lime_callback|0x5d0e|0"
zclass"limebeat,person|x,@,y,@,cname,lime,cspr,98,sind,98,text,98^ouchies. thanks for^saving my life.^now i will go home.,target_with_tbox_disable_callback,%sign_target_with_tbox_disable_callback,rx,.375,ry,.375,memloc_trigger,0x5d0e,memloc_trigger_value,1,target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback"
zclass"slobs_enter_ball,actor,simple_spr,drawlayer_75|x,@,y,@,minion_ang,@,start_x,~x,start_y,~y,sind,106,update,%slimy_ball_update,minion_target_rad,.5,minion_rad,3,max_health,1;start;duration,.25;"
zclass"limestatue,actor,simple_spr,drawlayer_50|x,@,y,@,xf,@,sind,101,sy,-2,shaking,yes,destroyed,%limestatue_destroyed;start;duration,.5;"
zclass"bobblock,solid,person|x,@,y,@,xf,-1,cname,bob,cspr,80,sind,80,text,80^hi lank. i am hungry.^^i mean i am fixing^the road.,ry,1,memloc_trigger,0x5d0a,memloc_trigger_value,1,target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback|0x5d0a|0"
zclass"bobhouse,person|x,@,y,@,cname,bob,cspr,80,sind,80,text,80^this is some tasty^duck soup.|0x5d0a|1"
zclass"jane,person|x,@,y,@,cname,jane,cspr,81,sind,81,text,81^what should i make my^hubby for lunch?"
zclass"teach,person|x,@,y,@,cname,teach,cspr,96,sind,96,gettext,%teach_gettext"
zclass"lark,person|x,@,y,@,cname,lark,cspr,99,sind,99,text,99^im lark in a house"
zclass"keep_parent,person|x,@,y,@,cname,keep,cspr,83,sind,83,gettext,%keep_gettext"
zclass"keep_brang,keep_parent|x,@,y,@,item_name,boomerang,memloc,0x5d15"
zclass"keep_shield,keep_parent|x,@,y,@,item_name,shield,memloc,0x5d14"
zclass"keep_sling,keep_parent|x,@,y,@,item_name,slingshot,memloc,0x5d12"
zclass"keep_mask,keep_parent|x,@,y,@,item_name,scary mask,memloc,0x5d16"
zclass"class_with_target,actor|trx,0,try,0,tx,0,ty,0,init,%class_with_target_init,callback_touch,nop,callback_outside,nop"
zclass"target_with_tbox,class_with_target,ma_interact|text,,gettext,%target_with_tbox_gettext,callback_touch,%target_with_tbox_target_func,target_with_tbox_disable_callback,nop,target_with_tbox_finish_callback,nop"
zclass"sign,target_with_tbox,solid,simple_spr,drawlayer_50|rx,.375,ry,.375,sy,-2,target_with_tbox_disable_callback,%sign_target_with_tbox_disable_callback,cname,sign,cspr,24,sind,24,trx,.125,try,.375,tx,0,ty,.25"
zclass"signtest,sign|x,@,y,@,text,24^mary had a^little lamb^little lamb^little lamb^mary had a^little lamb^whose fleece was^white as yo face"
zclass"signlank,sign|x,@,y,@,text,24^lanks house"
zclass"signkeep,sign|x,@,y,@,text,24^keeps house"
zclass"signnavy,sign|x,@,y,@,text,24^navys house"
zclass"signteach,sign|x,@,y,@,text,24^teachs house"
zclass"signlark,sign|x,@,y,@,text,24^larks house"
zclass"signjane,sign|x,@,y,@,text,24^janes house"
zclass"enemy,box|pl_collide_func_batch,%enemy_pl_collide_func_batch,pl_collide_func,nop"
zclass"quack,propel,ma_interact,actor,collidable,mov,enemy,simple_spr,drawlayer_50|x,@,y,@,rx,.25,ry,.25,should_dance,yes,sy,-2,propel_speed,.0125,pl_collide_func,%quack_pl_collide_func,sind,32,cspr,32,cname,quack;start;init,%quack_change_dir,update,~propel,duration,1,next,start;"
zclass"slimy_parent,pushable,actor,healthobj,enemy,simple_spr|should_push,yes,should_dance,yes,statcollide,%slimy_parent_statcollide"
zclass"slimy_boss_fight|"
zclass"slobs,slimy_parent,ma_boss,collidable,drawlayer_50|x,@,y,@,cspr,120,cname,slobs,sind,120,destroyed,%slimyboss_destroyed;jump_num,0,should_regen,yes,moving_away,yes,did_spin,no,rx,.5,ry,.5,sy,-1,pl_collide_func,%slimy_pl_collide_func,stun_callback,%slimy_stun_callback,minion_ang_offset,.125,max_health,8;minions;,;defaults;shaking,no,init,nop,update,nop,minion_target_rad,1.25,sind,120,collide_disabled,no,visible,yes,invincible,no;start;next,realstart,duration,0;realstart;init,%slimyboss_init,duration,.25,next,idle,stateless_update,%slimy_boss_stateless_update;stunstate;update,%slimy_stunstate,next,idle;idle;init,%slimy_boss_idle_init,update,%slimy_boss_idle_update,duration,.75,next,idle_face;idle_face;sind,121,update,%slimy_start,duration,.0625,next,bounce;bounce;init,%slobs_calc_next,duration,.0625;jump;jumpspeed,.025,sind,121,init,%slimy_boss_jump_init,update,%slimyboss_jump,duration,.25,next,idle;shotgun_jump;invincible,yes,minion_target_rad,.5,jumpspeed,.025,sind,121,init,%slimy_boss_jump_init,duration,.25,next,shotgun;shotgun;invincible,yes,minion_target_rad,.5,init,%slobs_shotgun_init,duration,.75,next,shotgun_jump_2,shaking,yes;shotgun_jump_2;invincible,yes,minion_target_rad,.5,jumpspeed,.025,sind,121,init,%slimy_boss_jump_init,duration,.25,next,idle;"
zclass"slobs_exit_ball,actor,simple_spr,drawlayer_75|x,@,y,@,minion_ang,@,start_x,~x,start_y,~y,sind,106,update,%slimy_ball_update,destroyed,%standard_explosion,minion_target_rad,3,minion_rad,.5,max_health,1;start;duration,.25;"
zclass"slimy_boss_ball,slimy_parent,slimy_boss_fight,drawlayer_75|anchoring,@,x,@,y,@,minion_ang,@,xf,@,sind,105,minion_rad,.25,start_x,~x,start_y,~y,update,%slimy_ball_update,pl_collide_func,%slimy_minion_pl_collide,rx,.5,ry,.5,max_health,1;start;minion_target_rad,3,duration,.5,next,compress;compress;minion_target_rad,.25,duration,.25;"
zclass"slimy_boss_ball_small,slimy_parent,slimy_boss_fight,drawlayer_75|anchoring,@,x,@,y,@,minion_ang,@,xf,@,sind,106,minion_rad,.25,start_x,~x,start_y,~y,update,%slimy_ball_update,pl_collide_func,%slimy_minion_pl_collide,rx,.25,ry,.25,max_health,1;start;minion_target_rad,3,duration,.5,next,compress;compress;minion_target_rad,.25,duration,.25;"
zclass"slimy_boss_minion_2,slimy_parent,anchor,slimy_boss_fight,drawlayer_75|anchoring,@,x,@,y,@,minion_ang,@,xf,@,sind,104,minion_rad,0,respawn_wait,4,update,%slimy_minion_update,pl_collide_func,%slimy_minion_pl_collide,rx,.25,ry,.25,max_health,1;"
zclass"smaller_slimes|"
zclass"slimy_actual,slimy_parent,ma_battle,collidable,smaller_slimes,drawlayer_50|x,@,y,@,dx,@,dy,@,idle_sind,118,jump_sind,119,cspr,~idle_sind,cname,slimy,sind,~idle_sind,destroyed,%slimy_destroyed,rx,.375,ry,.375,max_health,2,pl_collide_func,%slimy_pl_collide_func,stun_callback,%slimy_stun_callback,curr,idle;defaults;init,nop,update,nop;stunstate;next,idle,update,%slimy_stunstate;idle;next,bounce_1,update,%slimy_start,sind,~idle_sind,duration,.5;bounce_1;next,bounce_2,duration,.0625,sind,~jump_sind;bounce_2;next,jump,duration,.0625,sind,~idle_sind;jump;next,idle,init,%slimy_jump_init,jumpspeed,.025,update,%slimy_propel,duration,.25,sind,~jump_sind;"
zclass"miny_actual,slimy_parent,ma_battle,collidable,smaller_slimes,drawlayer_50|x,@,y,@,dx,@,dy,@,idle_sind,116,jump_sind,117,cspr,~idle_sind,cname,miny,sind,~idle_sind,destroyed,%standard_explosion,rx,.25,ry,.25,max_health,1,pl_collide_func,%slimy_pl_collide_func,stun_callback,%slimy_stun_callback,curr,idle;defaults;init,nop,update,nop;stunstate;next,idle,update,%slimy_stunstate;idle;next,bounce_1,update,%slimy_start,sind,~idle_sind,duration,.5;bounce_1;next,bounce_2,duration,.0625,sind,~jump_sind;bounce_2;next,jump,duration,.0625,sind,~idle_sind;jump;next,idle,init,%slimy_jump_init,jumpspeed,.025,update,%slimy_propel,duration,.25,sind,~jump_sind;"
zclass"spike,enemy,simple_spr,actor,drawlayer_25|sind,52,rx,.25,ry,.25,sy,0,draw,~drawout;defaults;pl_collide_func,nop;start;next,down;down;next,middle1,sind,52,duration,.9;middle1;next,up,sind,53,duration,.05;up;next,middle2,sind,54,pl_collide_func,%spike_pl_collide_func,duration,.25;middle2;next,down,sind,53,duration,.05;"
zclass"blockade,simple_spr,actor,drawlayer_25|x,@,y,@,draw,~drawout,curr,closed;close;next,closed,sind,26,init,%blockade_close_init,duration,.05;closed;next,open,sind,25;open;next,opened,sind,26,init,%blockade_open_init,duration,.05;opened;next,close,sind,27;"
zclass"r1spike,spike|x,@,y,@,xf,1;start;duration,0;"
zclass"r2spike,spike|x,@,y,@,xf,1;start;duration,.625;"
zclass"l1spike,spike|x,@,y,@,xf,-1;start;duration,0;"
zclass"l2spike,spike|x,@,y,@,xf,-1;start;duration,.625;"
zclass"saveplat,ma_interact,box,simple_spr,actor,drawlayer_25|x,@,y,@,rx,.375,ry,.375,cname,save,cspr,10,sind,40,sw,2,sh,2,draw,~drawout,update,%saveplat_update;"
g_fade,g_fade_table=1,zobj"0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,0,0,0,0;2;,2,2,2,1,0,0,0,0;3;,3,3,3,3,1,1,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,0,0,0,0;6;,6,6,13,13,5,5,0,0;7;,7,7,6,13,13,5,0,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,0,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,0,0,0;13;,13,13,5,5,1,0,0,0;14;,14,14,13,4,2,2,0,0;15;,15,15,13,13,5,5,0,0;"
g_fade_table_gray=zobj"0;,0,0;1;,1,1;2;,2,5;3;,3,13;4;,4,13;5;,5,5;6;,6,6;7;,7,7;8;,8,13;9;,9,6;10;,10,7;11;,11,7;12;,12,7;13;,13,13;14;,14,6;15;,15,6;"
g_fade_table_red=zobj"0;,0,0;1;,1,2;2;,2,2;3;,3,8;4;,4,4;5;,5,2;6;,6,4;7;,7,8;8;,8,8;9;,9,14;10;,10,14;11;,11,8;12;,12,7;13;,13,4;14;,14,8;15;,15,14;"
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
zclass"fader,actor|ecs_exclusions;actor,yes,timer,yes;"
zclass"fader_out,fader|start;duration,.5,destroyed,@,update,%fader_out_update"
zclass"fader_in,fader|start;duration,.5,update,%fader_in_update"
zclass"room_bounds,box|x,@,y,@,rx,@,ry,@"
function load_room(rind,x,y,xf)
if not does_entity_exist"fader" then
_g.fader_out(function()
if peek"0x5d0b"<=0 then
g_state:load"gameover"
else
zcall(poke,"1;,0x5d01,@;2;,0x5d02,@;3;,0x5d03,@;4;,0x5d04,@;",rind,
x*16,
y*16,
(xf+1)\2
)
g_state:load"room"
end
end)
end
end
zclass"title_logo,actor,auto_outline,drawlayer_99|update,%title_logo_update,drawout,%title_logo_drawout;"
cartdata"zeldo_rewrite"
menuitem(1,"reset save data",function()
memset(0x5e00,0,64)
extcmd"reset"
end)
zclass"game_state,actor|ecs_exclusions;actor,yes,timer,yes;curr,room,init,%game_state_init;logo;state_init,%logo_init,update,%simple_update,draw,%logo_draw,duration,2.5,next,title;title;state_init,%title_init,update,%simple_update,draw,%title_draw;room;state_init,%room_init,update,%room_update,draw,%room_draw;gameover;state_init,%gameover_init,update,%gameover_update,draw,%gameover_draw;"
function load_save_state()
memcpy(0x5d00,0x5e00,64)
if peek"0x5d00"==0 then
zcall(poke,"1;,0x5d00,1;2;,0x5d01,224;3;,0x5d02,24;4;,0x5d03,34;5;,0x5d05,121;6;,0x5d06,96;7;,0x5d07,72;8;,0x5d04,1;9;,0x5d08,5;10;,0x5d0b,10;11;,0x5d0c,10;12;,0x5d13,1;")
end
end
function init()
load_save_state()
poke2(0x5f5c,6)
g_si,g_fi,g_state,g_rooms=0,0,_g.game_state(),decode_map()
g_tile_animation_lookup=create_tile_animation_lookup(g_rooms[0])
end
function update60()
g_zbtn_0,g_zbtn_2=zbtn(btn,0),zbtn(btn,2)
zcall(loop_entities,"1;,actor,clean;2;,fader,clean;")
register_entities()
zcall(loop_entities,"1;,fader,tick;2;,game_state,tick;3;,fader,state;4;,game_state,state;")
end
function draw()
g_si,g_fi=g_slow_animation.index,g_fast_animation.index
cls()
loop_entities("game_state","draw")
fade(g_fade)
end