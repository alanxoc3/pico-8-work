function decode_map()
local rooms,cur_loc={},0x2000
local peek_inc=function()
cur_loc+=1
return peek(cur_loc-1)
end
while peek(cur_loc)~=255 do
local room,room_ind=zobj"tiles_1;,;tiles_2;,;objects;,;w,12,h,10,color,0,music,0",peek_inc()
if room_ind>223 then room.w,room.h=8,6 end
room.color=0x0f & peek(cur_loc)
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
add(room.objects,{index=ind,x=p1%12+offx,y=p1\12+offy})
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
_g=zobj([[actor_load,@,actor_state,@,actor_kill,@,actor_clean,@,actor_deregistered,@,fader_out_update,@,fader_in_update,@,animation_init,@,timer_start_timer,@,timer_stop_timer,@,timer_play_timer,@,timer_delete_timer,@,timer_get_elapsed,@,timer_get_elapsed_percent,@,timer_tick,@,game_init,@,game_update,@,game_draw,@,gameover_control_update,@,gameover_init,@,gameover_update,@,gameover_draw,@,logo_init,@,logo_draw,@,title_init,@,title_update,@,title_draw,@,title_logo_update,@,title_logo_draw,@,game_state_init,@]],function(a,stateName)
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
end,function()
end,function()
loop_entities("actor","state")
end,function()
loop_entities("outlayer_99","drawout")
loop_entities("drawlayer_99","draw")
end,function(a)
if btnp(4)or btnp(5)then
_g.fader_out(.5,function()g_state:load"title" end)
a:load"ending"
end
end,function(state)
_g.gameover_control()
state.game_over_sind,state.game_over_text=unpack(rnd_item(zobj[[1;,32,"quack quack";2;,68,"and play with me";3;,70,"to save hi-roll";4;,81,"in time for dinner";5;,83,"and make me rich";6;,96,"the banjo awaits you";7;,99,"for your fans";8;,118,"splat splat boing";]]))
end,function()
loop_entities("actor","state")
end,function(state)
camera(-8*8,-8*8)
zsprb(state.game_over_sind,0,g_i%2,1,1,true,false,1)
zcall(zprintgui,[[1;,"game over",0,-17,8,2,1;2;,"come back lank",0,12,10,4,1;3;,@,0,22,7,5,1]],state.game_over_text)
camera()
end,function()sfx(63,0)end,function(a)
g_fade=cos(a:get_elapsed_percent"state")+1
camera(g_fade>.5 and rnd_one())
zspr(108,64,64,4,2)
camera()
end,function()
_g.title_logo()
end,function()
loop_entities("actor","state")
end,function()
draw_room(g_rooms[8*16+8],64,64,nop,nop)
loop_entities("outlayer_99","drawout")
loop_entities("drawlayer_99","draw")
end,function(a)
if btnp(4)or btnp(5)then
_g.fader_out(.5,function()g_state:load"gameover" end)
a:load"ending"
end
end,function(a)
camera(-8*8,-8*8)
for i=-2,2 do
zsprb(45+i,i*10,cos((g_i+i)/4)/2+1+a.title_y,1,2)
end
zprintgui("not the story of",0,a.title_y-17,10,4,1)
if g_i%2==0 then
zprintgui("🅾️ or ❎ to play  ",0,a.title_y+12,7,5,1)
end
camera()
end,function(state)
clean_all_entities"game_state"
_g.fader_in".5"
g_animation=_g.animation".5"
state:state_init()
end)
function zspr_helper(func,sind,x,y,sw,sh,...)
sw,sh=sw or 1,sh or 1
x,y=x-sw*4,y-sh*4
func(sind,x,y,sw,sh,...)
end
function spro(sind,x,y,...)
for c=1,15 do pal(c,1)end
for i=0,8 do spr(sind,x+i%3-1,y+i\3-1,...)end
pal()
end
function sprb(...)spro(...)spr(...)end
function zspr(...)zspr_helper(spr,...)end
function zspro(...)zspr_helper(spro,...)end
function zsprb(...)zspr_helper(sprb,...)end
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
function btn_helper(f,a,b)return f(a)and f(b)and 0 or f(a)and 0xffff or f(b)and 1 or 0 end
function xbtn()return btn_helper(btn,0,1)end
function ybtn()return btn_helper(btn,2,3)end
function zprint(str,x,y,align,color)
if align==0 then x-=#str*2
elseif align>0 then x-=#str*4+1 end
print(str,x,y,color)
end
function zprinttbox(str,x,y,align,fg,bg)
zprint(str,x,y+1,0,bg)
zprint(str,x,y,0,fg)
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
foreach(zobjc(text,...),function(params)
func(unpack(params))
end)
end
zclass[[actor,timer|load,%actor_load,state,%actor_state,kill,%actor_kill,clean,%actor_clean,alive,yes,duration,null,curr,start,next,null,init,nop,update,nop,destroyed,nop,deregistered,%actor_deregistered;]]
zclass[[drawlayer_50|]]
zclass[[drawlayer_99|]]
zclass[[outlayer_50|drawout,nop]]
zclass[[fader_out,actor|start;duration,@,destroyed,@,update,%fader_out_update]]
zclass[[fader_in,actor|start;duration,@,update,%fader_in_update]]
zclass[[animation,actor|index,0,init,%animation_init;start;duration,@,next,start]]
zclass[[timer|timers;,;start_timer,%timer_start_timer,stop_timer,%timer_stop_timer,play_timer,%timer_play_timer,delete_timer,%timer_delete_timer,get_elapsed,%timer_get_elapsed,get_elapsed_percent,%timer_get_elapsed_percent,tick,%timer_tick,]]
function draw_room(room,center_x,center_y,post_tile_func,post_card_func)
local x1,y1=center_x-room.w*8\2,center_y-room.h*8\2
local pw,ph=room.w*8-1,room.h*8-1
local x2,y2=x1+pw,y1+ph
clip(x1+4,y1+4,pw-7,ph-7)
rectfill(x1,y1,x2,y2,room.color)
for tiles in all{room.tiles_1,room.tiles_2}do
for location,index in pairs(tiles)do
local x,y=location%12,location\12
spr(lookup_tile_animation(index),x1+x*8,y1+y*8)
end
end
post_tile_func(x1,y1)
clip()
for i,color in pairs{1,13,1,0}do
i=4-i
rect(x1+i,y1+i,x2-i,y2-i,color)
i+=1
pset(x1+i,y1+i,color)pset(x1+i,y2-i,color)
pset(x2-i,y1+i,color)pset(x2-i,y2-i,color)
end
post_card_func(x1,y1)
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
zclass[[gameover_control,actor|start;update,nop,duration,.5,next,normal;normal;update,%gameover_control_update;ending;update,nop;]]
g_fade_table=zobj[[0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,0,0,0,0;2;,2,2,2,1,0,0,0,0;3;,3,3,3,3,1,1,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,0,0,0,0;6;,6,6,13,13,5,5,0,0;7;,7,7,6,13,13,5,0,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,0,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,0,0,0;13;,13,13,5,5,1,0,0,0;14;,14,14,13,4,2,2,0,0;15;,15,15,13,13,5,5,0,0;]]
function fade(threshold)
for c=0,15 do
pal(c,g_fade_table[c][1+flr(7*min(1,max(0,threshold)))],1)
end
end
zclass[[title_logo,actor,drawlayer_99|update,%title_logo_update_normal,draw,%title_logo_draw,title_y,0;start;update,nop,duration,.5,next,normal;normal;update,%title_logo_update;ending;update,nop;]]
cartdata"zeldo_rewrite"
menuitem(2,"reset save data",function()
memset(0x5e00,0,64)
extcmd"reset"
end)
zclass[[game_state,actor|ecs_exclusions;actor,true;curr,title,init,%game_state_init;logo;state_init,%logo_init,update,nop,draw,%logo_draw,duration,2.5,next,title;title;state_init,%title_init,update,%title_update,draw,%title_draw;game;state_init,%game_init,update,%game_update,draw,%game_draw;gameover;state_init,%gameover_init,update,%gameover_update,draw,%gameover_draw;]]
function _init()
memset(0x5d00,0,64)
g_state,g_rooms=_g.game_state(),decode_map()
g_tile_animation_lookup=create_tile_animation_lookup(g_rooms[0])
end
function _update60()
loop_entities("actor","clean")
register_entities()
loop_entities("timer","tick")
loop_entities("game_state","state")
end
function _draw()
g_i=g_animation.index
cls()
loop_entities("game_state","draw")
fade(g_fade)
end