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
_g=zobj([[actor_load,@,actor_loadlogic,@,actor_state,@,actor_is_alive,@,actor_kill,@,actor_clean,@,timer_reset_timer,@,timer_end_timer,@,timer_get_elapsed_percent,@,timer_is_active,@,timer_tick,@,pos_dist_point,@,vec_update,@,mov_update,@,mov_towards_point,@,tile_entity_to_target,@,tile_sprite_draw,@,hermit_destroyed,@,hermit_update,@,sword_draw_debug,@,possible_move_obj_update,@,possible_move_small_obj_update,@,selected_move_update,@,selected_move_draw,@,enemy_init,@,enemy_check_collision,@,enemy_update,@,snake_setsind2,@,snake_get_path,@,frog_setsind2,@,frog_get_path,@,seagull_setsind2,@,seagull_get_path,@,fox_setsind2,@,fox_get_path,@,level_state_init,@,pre_card_select_init,@,card_select_init,@,card_select_update,@,move_select_init,@,move_select_update,@,player_update_init,@,player_update_update,@,baddie_update_init,@,baddie_update_update,@,game_init,@,game_update,@,game_draw,@,card_draw,@,card_normal_update,@,status_text_draw,@,status_text_update,@,fader_out_update,@,fader_in_update,@,logo_init,@,logo_draw,@,game_state_init,@]],function(a,stateName)
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
a.dx*=.80 a.dy*=.80
if ax==0 and abs(a.dx)<.01 then a.dx=0 end
if ay==0 and abs(a.dy)<.01 then a.dy=0 end
end,function(a,x,y)
a.ang=atan2(x-a.x,y-a.y)
end,function(a)
local xdiff,ydiff=a.target_x-a.x,a.target_y-a.y
if abs(xdiff)<.25 and abs(ydiff)<.25 then
a.x=a.target_x
a.y=a.target_y
a.speed=0
else
a.ang=atan2(xdiff,ydiff)
a.speed=.05
end
end,function(a)
if a.sind then
spr(a.sind,scr_x(a.x)-g_spr_info[a.sind][3],scr_y(a.y)-g_spr_info[a.sind][4],g_spr_info[a.sind][1],g_spr_info[a.sind][2])
end
end,function(a)
g_sword.target_x=-100
g_sword.target_y=-100
g_sword:kill()
end,function(a)
local xdiff=g_sword.target_x-a.target_x
local ydiff=g_sword.target_y-a.target_y
if xdiff==0 and ydiff<0 then a.sind=0
elseif xdiff==0 and ydiff>0 then a.sind=2
elseif ydiff==0 and xdiff<0 then a.sind=4
elseif ydiff==0 and xdiff>0 then a.sind=36
elseif xdiff>0 and ydiff>0 then a.sind=67
elseif xdiff>0 and ydiff<0 then a.sind=64
elseif xdiff<0 and ydiff>0 then a.sind=70
elseif xdiff<0 and ydiff<0 then a.sind=73
end
end,function(a)
circ(scr_x(a.target_x),scr_y(a.target_y),11,7)
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
for m in all(g_level_state.moves)do
spr(m.sind,scr_x(m.x)-3,scr_y(m.y)-3)
end
local m=g_level_state.moves[g_level_state.moves_ind]
spr(m.sel_sind,scr_x(m.x)-5,scr_y(m.y)-5,2,2)
end,function(a)
a.sind=rnd_item(a.possible_sinds)
end,function(a)
if a.target_x==g_sword.target_x and a.target_y==g_sword.target_y then
a:kill()
elseif a.target_x==g_pl.target_x and a.target_y==g_pl.target_y then
g_pl:kill()
end
end,function(a)
if a.speed>0 then
a.sind=a:setsind2(zsgn(cos(a.ang)),zsgn(sin(a.ang)))or a.sind
end
end,function(a,dx,dy)
if dx<0 then return 42
elseif dx>0 then return 46
elseif dy<0 then return 40
elseif dy>0 then return 44
end
end,function(a)
local path={{x=a.target_x,y=a.target_y}}
local possible_spots={}
for i=0,3 do
local x,y=round(cos(i/4))+a.target_x,round(sin(i/4))+a.target_y
if is_spot_empty(x,y)and not is_spot_puddle(x,y)and not is_spot_on_sword(x,y)then
add(possible_spots,{x=x,y=y})
end
end
if #possible_spots>0 then
local xdiff,ydiff=abs(g_pl.target_x-a.target_x),abs(g_pl.target_y-a.target_y)
if xdiff<=1 and ydiff<=1 then
local smartest=get_smartest_direction(possible_spots,a.target_x,a.target_y)
if smartest then
add(path,smartest)
end
else
add(path,rnd_item(possible_spots))
end
end
return path
end,function(a,dx,dy)
if dx<0 then return 230
elseif dx>0 then return 76
elseif dy<0 then return 78
elseif dy>0 then return 232
end
end,function(a)
local path={{x=a.target_x,y=a.target_y}}
local possible_spots={}
for i=0,3 do
local x,y=round(cos(i/4))*2+a.target_x,round(sin(i/4))*2+a.target_y
if is_spot_empty(x,y)and not is_spot_puddle(x,y)and not is_spot_on_sword(x,y)then
add(possible_spots,{x=x,y=y})
end
end
local smartest=get_smartest_direction(possible_spots,a.target_x,a.target_y)
if smartest then
add(path,smartest)
end
return path
end,function(a,dx,dy)
if dx<0 and dy<0 then return 10
elseif dx<0 and dy>0 then return 12
elseif dx>0 and dy<0 then return 08
elseif dy>0 and dy>0 then return 14
end
end,function(a)
local path={{x=a.target_x,y=a.target_y}}
local possible_spots={}
for i=0,3 do
local ang=.125+i/4
local x,y=round(cos(ang))+a.target_x,round(sin(ang))+a.target_y
if is_spot_empty(x,y)and not is_spot_on_sword(x,y)then
add(possible_spots,{x=x,y=y})
end
end
local smartest=get_smartest_direction(possible_spots,a.target_x,a.target_y)
if smartest then
add(path,smartest)
end
return path
end,function(a,dx,dy)
if dx<0 and dy<0 then return 224
elseif dx<0 and dy>0 then return 226
elseif dx>0 and dy<0 then return 200
elseif dy>0 and dy>0 then return 228
elseif dx==0 and dy<0 then return 192
elseif dx==0 and dy>0 then return 196
elseif dx<0 and dy==0 then return 194
elseif dy>0 and dy==0 then return 198
end
end,function(a)
local path={{x=a.target_x,y=a.target_y}}
local possible_spots={}
for i=0,7 do
local local_path={}
local xdir,ydir=zsgn(cos(i/8)),zsgn(sin(i/8))
local is_good=false
local cur_x,cur_y=a.target_x,a.target_y
while true do
cur_x+=xdir cur_y+=ydir
if is_spot_puddle(cur_x,cur_y)or not is_spot_empty(cur_x,cur_y)then break
elseif is_spot_on_sword(cur_x,cur_y)then
is_good=false
break
end
add(local_path,{x=cur_x,y=cur_y})
is_good=true
end
if is_good and #local_path>0 then
add(possible_spots,{x=local_path[1].x,y=local_path[1].y,remaining=local_path})
end
end
printh(#possible_spots)
local smartest=get_smartest_direction(possible_spots,a.target_x,a.target_y)
if smartest then
for spot in all(smartest.remaining)do
add(path,spot)
end
end
return path
end,function(a)
a.item_inds={get_random_card_ind(),get_random_card_ind(),get_random_card_ind()}
end,function(a)
if is_level_win()then
a:kill()
_g.fader_out(function()
g_level+=1
g_tl:load"game"
end)
elseif is_level_lose()then
a:kill()
_g.fader_out(function()
g_tl:load"game"
end)
else
a:load"card_select"
a.items={}
for i=1,#a.item_inds do
add(a.items,_g.card(35+(i-1)*21,a.item_inds[i],false))
end
a.items[a.itemind].selected=true
end
end,function(a)
local moves=get_move_coordinates(a.items[a.itemind].sind)
for m in all(moves)do
_g.pos_preview(a,a.itemind,m.x,m.y,m.sind,m.sel_sind)
end
end,function(a)
local prev_ind=a.itemind
if xbtnp()~=0 then
a.itemind=mid(1,a.itemind+xbtnp(),3)
end
if a.itemind ~=prev_ind then
local moves=get_move_coordinates(a.items[a.itemind].sind)
for m in all(moves)do
_g.pos_preview(a,a.itemind,m.x,m.y,m.sind,m.sel_sind)
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
end,function(a)
local cur_move_x=a.moves[a.moves_ind].x
local cur_move_y=a.moves[a.moves_ind].y
local next_ind=a.moves_ind
if xbtnp()~=0 then next_ind=move_select_update_helper(a.moves,a.moves_ind,xbtnp(),cur_move_x,cur_move_y,"x","y")
elseif ybtnp()~=0 then next_ind=move_select_update_helper(a.moves,a.moves_ind,ybtnp(),cur_move_y,cur_move_x,"y","x")
end
a.moves_ind=next_ind
if btnp(5)then
a:load"card_select"
elseif btnp(4)then
a:load"player_update"
end
end,function(a)
_g.status_text("hermit turn","player_update")
local m=a.moves[a.moves_ind]
a.path=m.gen_path(m.x,m.y)
a.reset_turn_timer=true
a.item_inds[a.itemind]=get_random_card_ind()
end,function(a)
if a.timers.player_update.elapsed and a.timers.player_update.elapsed>.5 and a.reset_turn_timer then
a.reset_turn_timer=false
local spot=deli(a.path,1)
if spot.func then spot.func()end
g_pl.target_x,g_pl.target_y,g_sword.target_x,g_sword.target_y=spot.x,spot.y,spot.sx,spot.sy
a:start_timer("turn_tick",spot.duration or.25,function()
if #a.path>0 then
a.reset_turn_timer=true
else
a.reset_turn_timer=false
a:load"baddie_update"
end
end)
end
end,function(a)
_g.status_text("baddie turn","baddie_update")
a.reset_turn_timer=true
a.visited_baddies={}
a.baddie=get_next_baddie(a.visited_baddies)
if a.baddie then
a.visited_baddies[a.baddie]=true
a.path=a.baddie:get_path()
end
end,function(a)
if a.timers.baddie_update.elapsed and a.timers.baddie_update.elapsed>.5 and a.reset_turn_timer then
if a.baddie then
a.reset_turn_timer=false
local spot=deli(a.path,1)
a.baddie.target_x,a.baddie.target_y=spot.x,spot.y
a:start_timer("turn_tick",.25,function()
if #a.path>0 then
a.reset_turn_timer=true
else
local next_baddie=get_next_baddie(a.visited_baddies)
if next_baddie then
a.baddie=next_baddie
a.visited_baddies[a.baddie]=true
a.path=a.baddie:get_path()
a.reset_turn_timer=true
else
a.reset_turn_timer=false
a:load"pre_card_select"
end
end
end)
else
a.reset_turn_timer=false
a:load"pre_card_select"
end
end
end,function()
g_level_state=_g.level_state()
g_grid=set_grid(g_level)
end,function()
zcall(loop_entities,[[1;,timer,tick;2;,actor,state;3;,enemy,check_collision;4;,tile_entity,to_target;5;,hermit,to_target;6;,mov,mov_update;7;,vec,vec_update;]])
update_grid()
end,function()
rectfill(0,0,127,127,12)
g_offx,g_offy=64,53
draw_tiles()
loop_entities("drawlayer_25","draw")
loop_entities("drawlayer_30","draw")
loop_entities("drawlayer_50","draw")
if g_debug then
rect(0,0,127,127,8)
end
end,function(a)
local offy=0
local func=function()
spr(a.sind,a.x,a.y+offy-2,2,2)
end
if a.selected then
draw_outline(7,func)
spr(141,a.x+4,a.y+16)
elseif g_level_state.curr!="card_select"then
offy=13
end
func()
end,function(a)
if g_level_state.curr!="card_select"and g_level_state.curr!="move_select"then
a:kill()
end
end,function(a)
print("\^w"..a.text.."\^-w",a.x-#a.text*4,a.y,7)
end,function(a)
if g_level_state.curr ~=a.checkstate then
a:kill()
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
end,function(state)
clean_all_entities"game_state"
_g.fader_in()
state:state_init()
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
function rnd_item(list)
return list[flr_rnd(#list)+1]
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
function zsgn(num)return num==0 and 0 or sgn(num)end
function approx_dist(dx,dy)
local maskx,masky=dx>>31,dy>>31
local a0,b0=(dx+maskx)^^maskx,(dy+masky)^^masky
if a0>b0 then
return a0*0.9609+b0*0.3984
end
return b0*0.9609+a0*0.3984
end
zclass[[actor,timer|load,%actor_load,loadlogic,%actor_loadlogic,state,%actor_state,kill,%actor_kill,clean,%actor_clean,is_alive,%actor_is_alive,alive,yes,duration,null,curr,start,next,null,isnew,yes,init,nop,update,nop,destroyed,nop;]]
zclass[[drawlayer_25|]]
zclass[[drawlayer_30|]]
zclass[[drawlayer_50|]]
g_spr_info=zobj[[0;,2,4,8,21;2;,2,4,6,10;4;,4,2,21,6;36;,4,2,10,9;64;,3,3,7,17;67;,3,3,6,7;70;,3,3,16,6;73;,3,3,17,16;142;,1,1,3,3;143;,1,1,3,3;138;,2,2,0,0;170;,2,2,0,0;40;,2,2,6,8;42;,2,2,6,8;44;,2,2,6,8;46;,2,2,6,8;08;,2,2,6,8;10;,2,2,6,8;12;,2,2,6,8;14;,2,2,6,8;224;,2,2,6,8;226;,2,2,6,8;200;,2,2,6,8;228;,2,2,6,8;192;,2,2,6,8;196;,2,2,6,8;194;,2,2,6,8;198;,2,2,6,8;230;,2,2,6,8;76;,2,2,6,8;78;,2,2,6,8;232;,2,2,6,8;168;,2,2,6,6;]]
function draw_outline(color,drawfunc)
for c=1,15 do pal(c,color)end
local ox,oy=%0x5f28,%0x5f2a
for y=-1,1 do for x=-1,1 do
camera(ox+x,oy+y)drawfunc()
end end
camera(ox,oy)
pal()
end
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
zclass[[tile_entity,mov,actor|to_target,%tile_entity_to_target,target_x,null,target_y,null,draw,%tile_sprite_draw]]
zclass[[puddle,actor,drawlayer_25|x,@,y,@,sind,168,target_x,~x,target_y,~y,draw,%tile_sprite_draw]]
zclass[[hermit,mov,actor,drawlayer_50|x,@,y,@,target_x,~x,target_y,~y,to_target,%tile_entity_to_target,draw,%tile_sprite_draw,destroyed,%hermit_destroyed,update,%hermit_update]]
zclass[[sword,actor,drawlayer_50|target_x,@,target_y,@,draw,%sword_draw_debug]]
zclass[[pos_preview,actor,drawlayer_50|gamestate,@,itemind,@,x,@,y,@,sind,@,sel_sind,@,update,%possible_move_small_obj_update,draw,%tile_sprite_draw]]
zclass[[selected_move,actor,drawlayer_50|update,%selected_move_update,draw,%selected_move_draw]]
zclass[[enemy|get_path,nil,init,%enemy_init,update,%enemy_update,check_collision,%enemy_check_collision]]
zclass[[snake,tile_entity,enemy,drawlayer_30|x,@,y,@,target_x,~x,target_y,~y,get_path,%snake_get_path,setsind2,%snake_setsind2;possible_sinds;,42,46,40,44;]]
zclass[[frog,tile_entity,enemy,drawlayer_30|x,@,y,@,target_x,~x,target_y,~y,get_path,%frog_get_path,setsind2,%frog_setsind2;possible_sinds;,230,76,78,232;]]
zclass[[seagull,tile_entity,enemy,drawlayer_30|x,@,y,@,target_x,~x,target_y,~y,get_path,%seagull_get_path,setsind2,%seagull_setsind2;possible_sinds;,10,12,8,14;]]
function get_smartest_direction(possible_spots,x,y)
local smallest_ang_diff=10
local selected_spot
local ideal_ang=atan2(g_pl.target_x-x,g_pl.target_y-y)
for i=1,#possible_spots do
local spot=possible_spots[i]
local ang=atan2(spot.x-x,spot.y-y)
if abs(ideal_ang-ang)<smallest_ang_diff then
printh(""..ideal_ang.." || "..ang)
smallest_ang_diff=abs(ideal_ang-ang)
selected_spot=i
end
end
if selected_spot then
return possible_spots[selected_spot]
end
end
zclass[[fox,tile_entity,enemy,drawlayer_30|x,@,y,@,target_x,~x,target_y,~y,get_path,%fox_get_path,setsind2,%fox_setsind2;possible_sinds;,224,226,200,228,192,196,194,198;]]
zclass[[level_state,actor|itemind,2,items;,;start;init,%level_state_init,update,nop,duration,0,next,pre_card_select;pre_card_select;init,%pre_card_select_init;card_select;init,%card_select_init,update,%card_select_update;move_select;init,%move_select_init,update,%move_select_update;player_update;init,%player_update_init,update,%player_update_update;baddie_update;init,%baddie_update_init,update,%baddie_update_update;]]
function get_random_card_ind()
return rnd_item{128,130,134,136,160,164,166}
end
function is_level_win()return not get_next_baddie{}end
function is_level_lose()return not g_pl:is_alive()end
function move_select_update_helper(moves,ind,btnpress,default,axis,default_key,axis_key)
local smallest_diff,smallest_axis_diff=16,16
for i=1,#moves do
local m=moves[i]
local diff,axis_diff=m[default_key]-default,m[axis_key]-axis
if zsgn(diff)==btnpress then
if abs(axis_diff)<abs(smallest_axis_diff)then
smallest_diff,smallest_axis_diff,ind=diff,axis_diff,i
elseif abs(axis_diff)==abs(smallest_axis_diff)and abs(diff)<abs(smallest_diff)then
smallest_diff,smallest_axis_diff,ind=diff,axis_diff,i
elseif abs(axis_diff)==abs(smallest_axis_diff)and abs(diff)==abs(smallest_diff)and axis_diff<smallest_axis_diff then
smallest_diff,smallest_axis_diff,ind=diff,axis_diff,i
end
end
end
return ind
end
function get_next_baddie(visited_baddies)
local bad_coords=find_on_grid(function(spot)
return spot.entity and spot.entity.parents.enemy and not visited_baddies[spot.entity]
end)
if #bad_coords>0 then
local coord=bad_coords[1]
return g_grid[coord.y*7+coord.x].entity
end
end
function get_move_coordinates(move_type)
local pc={x=g_pl.target_x,y=g_pl.target_y}
local sc={x=g_sword.target_x,y=g_sword.target_y}
local spots={}
if move_type==128 then
add_spot(spots,pc.x,pc.y,142,156,path_spin)
elseif move_type==130 then
add_spot_if_attackable(spots,pc.x+1,pc.y,142,156,path_slice)
add_spot_if_attackable(spots,pc.x-1,pc.y,142,156,path_slice)
add_spot_if_attackable(spots,pc.x,pc.y+1,142,156,path_slice)
add_spot_if_attackable(spots,pc.x,pc.y-1,142,156,path_slice)
add_spot_if_attackable(spots,pc.x-1,pc.y-1,142,156,path_slice)
add_spot_if_attackable(spots,pc.x-1,pc.y+1,142,156,path_slice)
add_spot_if_attackable(spots,pc.x+1,pc.y+1,142,156,path_slice)
add_spot_if_attackable(spots,pc.x+1,pc.y-1,142,156,path_slice)
elseif move_type==134 then
add_spot_if_movable(spots,pc.x+1,pc.y,143,158,path_move)
add_spot_if_movable(spots,pc.x-1,pc.y,143,158,path_move)
add_spot_if_movable(spots,pc.x,pc.y+1,143,158,path_move)
add_spot_if_movable(spots,pc.x,pc.y-1,143,158,path_move)
add_spot_if_movable(spots,pc.x-1,pc.y-1,143,158,path_move)
add_spot_if_movable(spots,pc.x-1,pc.y+1,143,158,path_move)
add_spot_if_movable(spots,pc.x+1,pc.y+1,143,158,path_move)
add_spot_if_movable(spots,pc.x+1,pc.y-1,143,158,path_move)
elseif move_type==136 then
for ang=0,8 do
local xdir,ydir=zsgn(cos(ang/8)),zsgn(sin(ang/8))
local sxdir,sydir=sc.x-pc.x,sc.y-pc.y
local cur_x,cur_y=pc.x,pc.y
local is_good=false
while true do
cur_x+=xdir
cur_y+=ydir
if not is_spot_valid(cur_x,cur_y)or is_spot_puddle(cur_x,cur_y)then
break
elseif not is_spot_empty(cur_x,cur_y)and not(sxdir==xdir and sydir==ydir)then
is_good=false
break
end
is_good=true
end
if is_good then
add_spot(spots,cur_x-xdir,cur_y-ydir,143,158,path_charge)
end
end
elseif move_type==160 then
local coords=find_on_grid(function(spot)
return spot.entity and spot.entity.parents.enemy
end)
for coord in all(coords)do
if not is_spot_puddle(coord.x,coord.y)then
add_spot(spots,coord.x,coord.y,143,158,path_swap)
end
end
elseif move_type==164 then
elseif move_type==166 then
add_spot_if_movable(spots,pc.x+2,pc.y,143,158,path_move)
add_spot_if_movable(spots,pc.x-2,pc.y,143,158,path_move)
add_spot_if_movable(spots,pc.x,pc.y+2,143,158,path_move)
add_spot_if_movable(spots,pc.x,pc.y-2,143,158,path_move)
add_spot_if_movable(spots,pc.x-2,pc.y-2,143,158,path_move)
add_spot_if_movable(spots,pc.x-2,pc.y+2,143,158,path_move)
add_spot_if_movable(spots,pc.x+2,pc.y+2,143,158,path_move)
add_spot_if_movable(spots,pc.x+2,pc.y-2,143,158,path_move)
end
if #spots==0 then
add_spot(spots,pc.x,pc.y,143,158,function()return{{x=pc.x,y=pc.y,sx=sc.x,sy=sc.y}}end)
end
return spots
end
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
function is_spot_valid(x,y)
local spot=g_grid[y*7+x]
return x>=0 and x<=6 and y>=0 and y<=6 and spot.active
end
function is_spot_empty(x,y)
local spot=g_grid[y*7+x]
return is_spot_valid(x,y)and spot.entity==nil
end
function is_spot_on_sword(x,y)
return x==g_sword.target_x and y==g_sword.target_y
end
function is_spot_on_player(x,y)
return x==g_pl.target_x and y==g_pl.target_y
end
function is_spot_puddle(x,y)
local spot=g_grid[y*7+x]
return is_spot_valid(x,y)and spot.puddle
end
function is_spot_movable(x,y)
local spot=g_grid[y*7+x]
return is_spot_valid(x,y)and spot.entity and spot.entity.id=="sword"
end
function is_spot_attackable(x,y)
local spot=g_grid[y*7+x]
return is_spot_valid(x,y)and spot.entity and spot.entity.parents.enemy
end
function add_spot(list,x,y,sind,sel_sind,gen_path)
add(list,{x=x,y=y,sind=sind,sel_sind=sel_sind,gen_path=gen_path})
end
function add_spot_if_movable(list,x,y,...)
if not is_spot_puddle(x,y)and(is_spot_empty(x,y)or is_spot_movable(x,y))then
add_spot(list,x,y,...)
end
end
function add_spot_if_attackable(list,x,y,...)
if x==g_sword.target_x and y==g_sword.target_y then
return
end
if is_spot_empty(x,y)or is_spot_attackable(x,y)then
add_spot(list,x,y,...)
end
end
function path_move(x,y)
local plx,ply=g_pl.target_x,g_pl.target_y
local swx,swy=g_sword.target_x,g_sword.target_y
local xdiff,ydiff=swx-plx,swy-ply
local path={{x=plx,y=ply,sx=swx,sy=swy}}
add(path,{x=x,y=y,sx=x+xdiff,sy=y+ydiff})
return path
end
function path_charge(x,y)
local plx,ply=g_pl.target_x,g_pl.target_y
local swx,swy=g_sword.target_x,g_sword.target_y
local xdiff,ydiff=swx-plx,swy-ply
local path={{x=plx,y=ply,sx=swx,sy=swy}}
local xdir,ydir=zsgn(x-plx),zsgn(y-ply)
local cur_x,cur_y=plx,ply
while true do
cur_x+=xdir
cur_y+=ydir
add(path,{x=cur_x,y=cur_y,sx=cur_x+xdiff,sy=cur_y+ydiff})
if cur_x==x and cur_y==y then
break
end
end
return path
end
function path_swap(x,y)
local plx,ply=g_pl.target_x,g_pl.target_y
local swx,swy=g_sword.target_x,g_sword.target_y
local xdiff,ydiff=swx-plx,swy-ply
local path={{x=plx,y=ply,sx=swx,sy=swy}}
add(path,{x=x,y=y,sx=x+xdiff,sy=y+ydiff,func=function()
printh("TEST")
local entity=g_grid[y*7+x].entity
printh(entity.id)
printh(g_pl.target_x)
entity.target_x=g_pl.target_x
entity.target_y=g_pl.target_y
end})
return path
end
function path_spin(x,y)
local plx,ply=g_pl.target_x,g_pl.target_y
local swx,swy=g_sword.target_x,g_sword.target_y
local xdiff,ydiff=swx-plx,swy-ply
local initial_ang=atan2(xdiff,ydiff)
local path={{x=plx,y=ply,sx=swx,sy=swy}}
for i=1,8 do
local spin_x=zsgn(cos(initial_ang-i/8))
local spin_y=zsgn(sin(initial_ang-i/8))
add(path,{x=plx,y=ply,sx=plx+spin_x,sy=ply+spin_y,duration=.125})
end
return path
end
function path_slice(x,y)
local plx,ply=g_pl.target_x,g_pl.target_y
local swx,swy=g_sword.target_x,g_sword.target_y
return{
{x=plx,y=ply,sx=swx,sy=swy},
{x=plx,y=ply,sx=x,sy=y}
}
end
g_level=0
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
print_vert_wobble("level "..(g_level+1),tlx+99,tly-6+7*3,7,1,1)
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
local sind=138
if(y*7+x)%2==0 then sind=170 end
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
if objind==112 then
g_pl=_g.hermit(x,y)
elseif objind==113 then
g_sword=_g.sword(x,y)
elseif objind==114 then
spot.puddle=_g.puddle(x,y)
elseif objind==115 then
spot.entity=_g.snake(x,y)
elseif objind==116 then
spot.entity=_g.seagull(x,y)
elseif objind==117 then
spot.entity=_g.fox(x,y)
elseif objind==118 then
spot.entity=_g.frog(x,y)
end
grid[y*7+x]=spot
end
end
return grid
end
function update_grid()
for y=0,6 do
for x=0,6 do
local spot=g_grid[y*7+x]
spot.entity=nil
end
end
for te in all(g_zclass_entities.tile_entity)do
local spot=g_grid[te.target_y*7+te.target_x]
if spot.active then
spot.entity=te
end
end
end
function unpack_grid_index(index)
return index%7,index\7
end
zclass[[card,actor,vec,drawlayer_50|x,@,sind,@,selected,@,y,141,draw,%card_draw;start;duration,.25,next,normal,dy,-2;normal;dy,0,update,%card_normal_update;ending;update,nop,duration,.25,dy,2;]]
zclass[[status_text,actor,vec,drawlayer_50|text,@,checkstate,@,x,64,y,146,draw,%status_text_draw;start;duration,.25,next,normal,dy,-2;normal;dy,0,update,%status_text_update;ending;update,nop,duration,.25,dy,2;]]
g_fade,g_fade_table=1,zobj[[0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,0,0,0,0;2;,2,2,2,1,0,0,0,0;3;,3,3,3,3,1,1,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,0,0,0,0;6;,6,6,13,13,5,5,0,0;7;,7,7,6,13,13,5,0,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,0,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,0,0,0;13;,13,13,5,5,1,0,0,0;14;,14,14,13,4,2,2,0,0;15;,15,15,13,13,5,5,0,0;]]
function fade(threshold)
for c=0,15 do
pal(c,g_fade_table[c][1+flr(7*min(1,max(0,threshold)))],1)
end
end
zclass[[fader,actor|ecs_exclusions;actor,yes,timer,yes;]]
zclass[[fader_out,fader|start;duration,.5,destroyed,@,update,%fader_out_update]]
zclass[[fader_in,fader|start;duration,.5,update,%fader_in_update]]
zclass[[game_state,actor|ecs_exclusions;actor,true;init,%game_state_init,curr,game;logo;state_init,%logo_init,update,nop,draw,%logo_draw,duration,2.5,next,game;game;state_init,%game_init,update,%game_update,draw,%game_draw;]]
function _init()
g_tl=_g.game_state()
end
function _update60()
if btn(4)and btnp(5)then g_debug=not g_debug end
zcall(loop_entities,[[1;,actor,clean;2;,fader,clean;]])
register_entities()
zcall(loop_entities,[[1;,fader,tick;2;,game_state,tick;3;,fader,state;4;,game_state,state;]])
if btn(5)and xbtnp()~=0 then
g_level+=xbtnp()
_g.fader_out(function()
g_tl:load"game"
end)
end
end
function _draw()
cls()
loop_entities("game_state","draw")
fade(g_fade)
end