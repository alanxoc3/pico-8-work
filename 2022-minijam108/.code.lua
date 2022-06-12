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
_g=zobj([[actor_load,@,actor_loadlogic,@,actor_state,@,actor_is_alive,@,actor_kill,@,actor_clean,@,timer_reset_timer,@,timer_end_timer,@,timer_get_elapsed_percent,@,timer_is_active,@,timer_tick,@,pos_dist_point,@,vec_update,@,mov_update,@,mov_towards_point,@,tile_sprite_draw,@,possible_move_obj_update,@,possible_move_small_obj_update,@,selected_move_update,@,selected_move_draw,@,test_init,@,test_update,@,test_draw,@,game_init,@,game_update,@,game_draw,@,card_draw,@,card_normal_update,@,pre_card_select_init,@,card_select_init,@,card_select_update,@,move_select_init,@,move_select_update,@,fader_out_update,@,fader_in_update,@,logo_init,@,logo_draw,@]],function(a,stateName)
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
a.dx*=DEFAULT_INERTIA a.dy*=DEFAULT_INERTIA
if ax==0 and abs(a.dx)<MIN_SPEED then a.dx=0 end
if ay==0 and abs(a.dy)<MIN_SPEED then a.dy=0 end
end,function(a,x,y)
a.ang=atan2(x-a.x,y-a.y)
end,function(a)
spr(a.sind,scr_x(a.x)-a.sx,scr_y(a.y)-a.sy,a.sw,a.sh)
end,function(a)
if a.gamestate.curr ~="move_select"then
a:kill()
end
end,function(a)
if a.gamestate.itemind ~=a.itemind or a.gamestate.curr ~="card_select"then
a:kill()
end
end,function(a)
if g_level_state.curr ~="move_select"then
a:kill()
end
end,function(a)
local coord=g_level_state.moves[g_level_state.moves_ind]
rect(scr_x(coord.x)-10,scr_y(coord.y)-10,scr_x(coord.x)+10,scr_y(coord.y)+10,1)
end,function(a)a.color+=1 end,function(a)a.x+=xbtn()a.y+=ybtn()end,function(a)circfill(a.x,a.y,2,a.color)end,function()
g_level=0
g_level_state=_g.level_state()
g_grid=set_grid(g_level)
_g.fader_in()
_g.test_obj(64,64)
end,function()
zcall(loop_entities,[[1;,timer,tick;2;,actor,state;3;,mov,mov_update;4;,vec,vec_update;]])
end,function()
rectfill(0,0,127,127,12)
g_offx,g_offy=64,53
draw_tiles()
loop_entities("drawlayer_50","draw")
if g_debug then
rect(0,0,127,127,8)
end
end,function(a)
local offy=0
if a.selected then
offy=-2
spr(104,a.x,a.y+offy-1,2,2)
spr(104,a.x,a.y+offy,2,2)
spr(16,a.x+4,a.y+16)
elseif g_level_state.curr!="card_select"then
offy=13
end
spr(a.sind,a.x,a.y+offy,2,2)
end,function(a)
if g_level_state.curr!="card_select"and g_level_state.curr!="move_select"then
a:kill()
end
end,function(a)
a.items={
_g.card(35,64,false),
_g.card(35+21,66,true),
_g.card(35+21+21,70,false)
}
end,function(a)
local moves=get_move_coordinates(a.items[a.itemind].sind)
for m in all(moves)do
_g[m.type_small](a,a.itemind,m.x,m.y)
end
end,function(a)
local prev_ind=a.itemind
if xbtnp()~=0 then
a.itemind=mid(1,a.itemind+xbtnp(),3)
end
if a.itemind ~=prev_ind then
local moves=get_move_coordinates(a.items[a.itemind].sind)
for m in all(moves)do
_g[m.type_small](a,a.itemind,m.x,m.y)
end
end
for i=1,#a.items do
a.items[i].selected=i==a.itemind
end
if btnp"4"then
a:load"move_select"
end
end,function(a)
a.moves=get_move_coordinates(a.items[a.itemind].sind)
a.moves_ind=1
_g.selected_move()
for m in all(a.moves)do
_g[m.type](a,a.itemind,m.x,m.y)
end
end,function(a)
if btnp(5)then
a:load"card_select"
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
function xbtnp()return zbtn(btnp,0)end
function ybtnp()return zbtn(btnp,2)end
zclass[[actor,timer|load,%actor_load,loadlogic,%actor_loadlogic,state,%actor_state,kill,%actor_kill,clean,%actor_clean,is_alive,%actor_is_alive,alive,yes,duration,null,curr,start,next,null,isnew,yes,init,nop,update,nop,destroyed,nop;]]
zclass[[drawlayer_50|]]
zclass[[timer|timers;,;start_timer,%timer_reset_timer,end_timer,%timer_end_timer,is_active,%timer_is_active,get_elapsed_percent,%timer_get_elapsed_percent,tick,%timer_tick,]]
zclass[[pos|x,0,y,0,dist_point,%pos_dist_point]]
zclass[[vec,pos|dx,0,dy,0,vec_update,%vec_update]]
zclass[[mov,vec|ang,0,speed,0,mov_update,%mov_update,towards_point,%mov_towards_point]]
function scr_x(x)
local midr=7/2*13
return x*13+g_offx-midr+13/2-1
end
function scr_y(y)
local midr=7/2*13
return y*13+g_offy-midr+13/2-1
end
zclass[[tile_sprite,pos|sx,8,sy,8,sw,2,sh,2,draw,%tile_sprite_draw]]
zclass[[hermit,tile_sprite,drawlayer_50|x,@,y,@,sy,11,sx,9,sind,1]]
zclass[[sword,tile_sprite,drawlayer_50|x,@,y,@,sy,16,sx,6,sw,2,sh,3,sind,128]]
zclass[[enemy|]]
zclass[[snake,tile_sprite,enemy,drawlayer_50|x,@,y,@,sx,3,sy,8,sw,1,sh,2,sind,196]]
zclass[[pos_move,tile_sprite,actor,drawlayer_50|sind,140,sx,4,sy,4,sw,1,sh,1,gamestate,@,itemind,@,x,@,y,@,update,%possible_move_obj_update;]]
zclass[[pos_sword,tile_sprite,actor,drawlayer_50|sind,141,sx,4,sy,4,sw,1,sh,1,gamestate,@,itemind,@,x,@,y,@,update,%possible_move_obj_update;]]
zclass[[pos_attack,tile_sprite,actor,drawlayer_50|sind,141,sx,4,sy,4,sw,1,sh,1,gamestate,@,itemind,@,x,@,y,@,update,%possible_move_obj_update;]]
zclass[[pos_move_small,tile_sprite,actor,drawlayer_50|sind,171,sx,4,sy,4,sw,1,sh,1,gamestate,@,itemind,@,x,@,y,@,update,%possible_move_small_obj_update;]]
zclass[[pos_sword_small,tile_sprite,actor,drawlayer_50|sind,155,sx,4,sy,4,sw,1,sh,1,gamestate,@,itemind,@,x,@,y,@,update,%possible_move_small_obj_update;]]
zclass[[selected_move,actor,drawlayer_50|update,%selected_move_update,draw,%selected_move_draw]]
zclass[[test_obj,actor,drawlayer_50|x,@,y,@,color,7,init,%test_init,update,%test_update,draw,%test_draw;]]
function round(num)return flr(num+.5)end
function print_vert_wobble(text,x,y,col,off,wob)
for i=1,#text do
print("\^w"..sub(text,i,i).."\^-w",x+wob*((i+off+t())\1%2),y+i*7,col)
end
end
function draw_tiles()
local tlx,tly=g_offx-46,g_offy-46
rectfill(tlx,tly,tlx+90,tly+90,15)
print_vert_wobble("stabby crabby",tlx-14,tly-6,7,1,1)
print_vert_wobble("level "..g_level,tlx+99,tly-6+7*3,7,1,1)
local amp=cos(.9)*.4+.8
local amp1=cos(.25+.9)*.4+.8
local amp2=cos(.5+.9)*.4+.8
local amp3=cos(.75+.9)*.4+.8
local width=91
local mult=sgn(sin(t()/7))*2+round(cos(t()/3))
local inc=.05
color(15)
line()for i=0,1,inc do line(tlx+i*width,cos(i*mult)*amp+tly+1)end
line()for i=0,1,inc do line(tlx+i*width,-cos(i*mult)*amp1+tly+90)end
line()for i=0,1,inc do line(cos(i*mult)*amp2+tlx+1,tly+i*width)end
line()for i=0,1,inc do line(-cos(i*mult)*amp3+tlx+90,tly+i*width)end
local midr=7/2*13
for ind,tile in pairs(g_grid)do
local x,y=unpack_grid_index(ind)
if tile.active then
local sind=37
if(y*7+x)%2==0 then sind=39 end
spr(sind,scr_x(x)-6,scr_y(y)-6,2,2)
end
end
color(7)
line()for i=0,1,inc do line(tlx+i*width,cos(i*mult)*amp+tly-1)end
line()for i=0,1,inc do line(tlx+i*width,cos(i*mult)*amp+tly)end
line()for i=0,1,inc do line(tlx+i*width,-cos(i*mult)*amp1+tly+91)end
line()for i=0,1,inc do line(tlx+i*width,-cos(i*mult)*amp1+tly+92)end
line()for i=0,1,inc do line(cos(i*mult)*amp2+tlx-1,tly+i*width)end
line()for i=0,1,inc do line(cos(i*mult)*amp2+tlx,tly+i*width)end
line()for i=0,1,inc do line(-cos(i*mult)*amp3+tlx+91,tly+i*width)end
line()for i=0,1,inc do line(-cos(i*mult)*amp3+tlx+92,tly+i*width)end
end
function set_grid(level)
local mapx,mapy=level%16,level\16
local grid={}
for y=0,6 do
for x=0,6 do
local objind=mget(mapx*8+x,mapy*8+y)
local spot={active=true}
if objind==240 then
spot.entity=_g.hermit(x,y)
g_pl=spot.entity
elseif objind==246 then
spot.entity=_g.sword(x,y)
g_sword=spot.entity
elseif objind==242 then
spot.entity=_g.snake(x,y)
end
grid[y*7+x]=spot
end
end
return grid
end
function unpack_grid_index(index)
return index%7,index\7
end
zclass[[card,actor,vec,drawlayer_50|x,@,sind,@,selected,@,y,141,draw,%card_draw;start;duration,.25,next,normal,dy,-2;normal;dy,0,update,%card_normal_update;ending;update,nop,duration,.25,dy,2;]]
zclass[[level_state,actor|itemind,2,curr,pre_card_select;items;,;pre_card_select;init,%pre_card_select_init,duration,0,next,card_select;card_select;init,%card_select_init,update,%card_select_update,next,move_select;move_select;init,%move_select_init,update,%move_select_update;player_update;init,nop,nop,next,enemy_update;enemy_update;init,nop,nop,next,card_select;]]
function find_on_grid(predicate)
local l={}
for y=0,6 do
for x=0,6 do
if predicate(g_grid[y*7+x])then
add(l,{x=x,y=y})
end
end
end
return l
end
function find_sword_on_grid()
return find_on_grid(function(spot)
return spot.entity==g_sword
end)[1]
end
function find_pl_on_grid()
return find_on_grid(function(spot)
return spot.entity==g_pl
end)[1]
end
function is_spot_valid(x,y)
local spot=g_grid[y*7+x]
return x>=0 and x<=6 and y>=0 and y<=6 and spot.active
end
function is_spot_empty(x,y)
local spot=g_grid[y*7+x]
return is_spot_valid(x,y)and spot.entity==nil
end
function is_spot_movable(x,y)
local spot=g_grid[y*7+x]
return is_spot_valid(x,y)and spot.entity and spot.entity.id=="sword"
end
function is_spot_attackable(x,y)
local spot=g_grid[y*7+x]
return is_spot_valid(x,y)and spot.entity and spot.entity.parents.enemy
end
function add_spot(list,x,y,type,type_small)
add(list,{x=x,y=y,type=type,type_small=type_small})
end
function add_spot_if_movable(list,x,y,...)
if is_spot_empty(x,y)or is_spot_movable(x,y)then
add_spot(list,x,y,...)
end
end
function add_spot_if_attackable(list,x,y,...)
if is_spot_empty(x,y)or is_spot_attackable(x,y)then
add_spot(list,x,y,...)
end
end
function get_move_coordinates(move_type)
local pc=find_pl_on_grid()
local sc=find_sword_on_grid()
local spots={}
if move_type==64 then
add_spot(spots,sc.x,sc.y,"pos_sword","pos_sword_small")
elseif move_type==66 then
add_spot_if_attackable(spots,pc.x+1,pc.y,"pos_sword","pos_sword_small")
add_spot_if_attackable(spots,pc.x-1,pc.y,"pos_sword","pos_sword_small")
add_spot_if_attackable(spots,pc.x,pc.y+1,"pos_sword","pos_sword_small")
add_spot_if_attackable(spots,pc.x,pc.y-1,"pos_sword","pos_sword_small")
add_spot_if_attackable(spots,pc.x-1,pc.y-1,"pos_sword","pos_sword_small")
add_spot_if_attackable(spots,pc.x-1,pc.y+1,"pos_sword","pos_sword_small")
add_spot_if_attackable(spots,pc.x+1,pc.y+1,"pos_sword","pos_sword_small")
add_spot_if_attackable(spots,pc.x+1,pc.y-1,"pos_sword","pos_sword_small")
elseif move_type==70 then
add_spot_if_movable(spots,pc.x+1,pc.y,"pos_move","pos_move_small")
add_spot_if_movable(spots,pc.x-1,pc.y,"pos_move","pos_move_small")
add_spot_if_movable(spots,pc.x,pc.y+1,"pos_move","pos_move_small")
add_spot_if_movable(spots,pc.x,pc.y-1,"pos_move","pos_move_small")
add_spot_if_movable(spots,pc.x-1,pc.y-1,"pos_move","pos_move_small")
add_spot_if_movable(spots,pc.x-1,pc.y+1,"pos_move","pos_move_small")
add_spot_if_movable(spots,pc.x+1,pc.y+1,"pos_move","pos_move_small")
add_spot_if_movable(spots,pc.x+1,pc.y-1,"pos_move","pos_move_small")
end
return spots
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
zclass[[game_state,actor|ecs_exclusions;actor,true;curr,game;logo;init,%logo_init,update,nop,draw,%logo_draw,duration,2.5,next,game;game;init,%game_init,update,%game_update,draw,%game_draw;]]
function _init()
g_tl=_g.game_state()
end
function _update60()
if btn(4)and btnp(5)then g_debug=not g_debug end
zcall(loop_entities,[[1;,actor,clean;2;,fader,clean;]])
register_entities()
zcall(loop_entities,[[1;,fader,tick;2;,game_state,tick;3;,fader,state;4;,game_state,state;]])
end
function _draw()
cls()
loop_entities("game_state","draw")
fade(g_fade)
end