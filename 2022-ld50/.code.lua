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
function register_zobjs()
while #g_zclass_new_entities>0 do
local class,inst=unpack(deli(g_zclass_new_entities))
g_zclass_entities[class]=g_zclass_entities[class]or{}
if not inst.ecs_exclusions[class]then add(g_zclass_entities[class],inst)end
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
_g=zobj([[actor_load,@,actor_state,@,actor_kill,@,actor_clean,@,fader_out_update,@,fader_in_update,@,timer_start_timer,@,timer_stop_timer,@,timer_play_timer,@,timer_delete_timer,@,timer_get_elapsed,@,timer_get_elapsed_percent,@,timer_tick,@,vec_update,@,acc_update,@,mov_update,@,anchor_pos_update_anchor,@,collision_init,@,collision_follow_anchoring,@,check_collision,@,collision_draw_debug,@,model_update,@,model_draw,@,model_collide,@,model_hit,@,model_explode,@,vanishing_shape_draw,@,line_particle_update,@,line_particle_draw,@,view_update,@,view_hit,@,view_match_following,@,missile_init,@,missile_destroyed,@,missile_hit,@,missile_pop_init,@,planet_evac,@,chaser_update,@,chaser_hit,@,black_hole_tug,@,twinkle_draw,@,star_view_match_following,@,pl_update,@,pl_hit,@,pl_alert_destroy,@,pl_alert_update,@,pl_alert_draw,@,alert_radar_register,@,level_bear_init,@,level_bear_update,@,level_cat_init,@,level_cat_update,@,spawn_init,@,level_mouse_init,@,level_mouse_update,@,level_pig_init,@,level_pig_update,@,level_pig_draw,@,level_select_init,@,level_select_update,@,level_entrance_draw,@,level_entrance_hit,@,logo_init,@,logo_draw,@,level_select_draw,@,level_draw,@,title_screen_draw,@,game_checker_update,@,retry_init,@,retry_update,@,retry_draw,@,win_init,@,win_update,@,win_draw,@]],function(a,stateName)
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
end,function(a)a.alive=nil end,function(a)
if not a.alive then
a:destroyed()
deregister_zobj(a)
end
end,function(a)
g_fade=a:get_elapsed_percent"state"
end,function(a)
g_fade=1-a:get_elapsed_percent"state"
end,function(...)
_g.timer_stop_timer(...)
_g.timer_play_timer(...)
end,function(a,timer_name,duration,callback)
a.timers[timer_name]={elapsed=false,duration=duration or 32767,callback=callback or function()end}
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
end,function(a)
a.x+=a.dx
a.y+=a.dy
end,function(a)
a.dx+=a.ax a.dy+=a.ay
a.dx*=a.inertia_x a.dy*=a.inertia_y
if a.ax==0 and abs(a.dx)<.00001 then a.dx=0 end
if a.ay==0 and abs(a.dy)<.00001 then a.dy=0 end
end,function(a)
a.ang+=a.d_ang
a.ax=a.speed*cos(a.ang)
a.ay=a.speed*sin(a.ang)
end,function(a)
a.x=a.anchoring.x
a.y=a.anchoring.y
end,function(a)
add(a.anchoring.collision_circs,a)
a:follow_anchoring()
end,function(a)
local b=a.anchoring
local off_magnitude=approx_dist(a.offset_x,a.offset_y)
local off_ang_new=atan2(a.offset_x,a.offset_y)+b.ang+b.d_ang
a.alive,a.dx,a.dy,a.x,a.y=b.alive,b.dx,b.dy,b.x+off_magnitude*cos(off_ang_new),b.y+off_magnitude*sin(off_ang_new)
end,function(a,others)
foreach(others,function(other)
if a==other then return end
local dist=dist_between_circles(a,other)
if dist<0 then
local ang=atan2(other.x-a.x,other.y-a.y)
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
if a.model ~=a.previous_model then
a.radius=a.model.radius
a.collisions=a.model.collisions
a.shapes=a.model.shapes
foreach(a.collision_circs,_g.actor_kill)
a.collision_circs={}
foreach(a.collisions or{},function(collision)
a.collision_func(a,collision.x,collision.y,collision.radius)
end)
a.previous_model=a.model
end
end,function(a)
local modelpoints={}
foreach(a.shapes,function(shape)
local points=translate_points(a.x,a.y,a.ang,shape)
foreach(points,function(point)point.x=zoomx(point.x)point.y=zoomy(point.y)end)
draw_polygon(points,shape.bg_color)
add(modelpoints,{c=shape.fg_color,points=points,wobble_enabled=shape.wobble_enabled})
end)
srand(t()*4\1)
foreach(modelpoints,function(points)
line_loop(points.points,points.c,points.wobble_enabled and wobble_line or line)
end)
if g_debug and a.radius then
circ(zoomx(a.x),zoomy(a.y),a.radius*g_view.zoom_factor,2)
end
end,function(a,other_list)
if #a.collision_circs>0 then
foreach(other_list,function(other)
if a.radius+other.radius>0 then
local x,y=other.x-a.x,other.y-a.y
local minimum_dist=a.radius+other.radius
if approx_dist(x,y)<minimum_dist then
foreach(a.collision_circs,function(b)
b:check_collision(other.collision_circs)
end)
end
end
end)
end
end,function(a,b,dx,dy)
if a.health and a.health>0 then
a.health-=b.damage or 0
if a.health<=0 then a:explode()end
end
end,function(a,duration)
if a.alive then
a:kill()
foreach(a.shapes,function(shape)
local points=translate_points(a.x,a.y,a.ang,shape)
line_loop(points,shape.fg_color,function(x1,y1,x2,y2,color)
local midx,midy=(x2-x1)/2+x1,(y2-y1)/2+y1
x1,y1=x1-midx,y1-midy
x2,y2=x2-midx,y2-midy
local particle=_g.line_particle(atan2(midx-a.x,midy-a.y),midx,midy,x1,y1,x2,y2,color,a.dx,a.dy)
if duration then particle.start.duration=duration end
end)
_g.vanishing_shape(a.x,a.y,a.dx,a.dy,points,shape.bg_color)
end)
end
end,function(a)
local percent=a:get_elapsed_percent"state"
local points={}
foreach(a.points,function(p)
local dx,dy=a.x-p.x,a.y-p.y
local dist=approx_dist(dx,dy)
local ang=atan2(dx,dy)
local x,y=dist*cos(ang)*percent,dist*sin(ang)*percent
add(points,{x=zoomx(p.x+x),y=zoomy(p.y+y)})
end)
draw_polygon(points,a.color)
end,function(a)
a.dx+=cos(a.ang)*.005
a.dy+=sin(a.ang)*.005
end,function(a)
local percent=1-a:get_elapsed_percent"state"
line(zoomx(a.x+a.x1*percent),zoomy(a.y+a.y1*percent),zoomx(a.x+a.x2*percent),zoomy(a.y+a.y2*percent),a.color)
end,function(a)
if not a.zooming then
a.zoom_factor=min(16,a.zoom_factor+.1)
end
a.zooming=false
end,function(a,other)
a.zoom_factor=max(12,a.zoom_factor-.1)
a.zooming=true
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
sfx(23,3)
end,function(a)
_g.missile_pop(a.x,a.y)
end,function(a,b,dx,dy)
a:kill()
end,function(a)
a:model_update()
a:explode(.2)
end,function(a)
_g.zipper(a.x,a.y,a.ang)
a.done_ships+=1
if a.done_ships==a.total_ships then a.next="done" end
end,function(a)
if not a.target or not a.target.alive then
a.target=g_zclass_entities["team_blue"][1]
end
if a.target then
local ang=atan2(a.target.x-a.x,a.target.y-a.y)
a.d_ang=sgn(ang-a.ang%1)*.01
a.speed=.004
else
a.speed=0
end
end,function(a,b,dx,dy)
_g.model_hit(a,b,dx,dy)
if b.id=="missile"then a.target=g_pl end
end,function(a,obj_list)
foreach(obj_list,function(obj)
if a==obj then return end
local ang=atan2(a.x-obj.x,a.y-obj.y)
obj.dx+=cos(ang)*.0004
obj.dy+=sin(ang)*.0004
end)
end,function(a)
local factor=a.view.zoom_factor/16
local x=((-a.star_view.x+a.x)%192)*factor-192/2*factor+64
local y=((-a.star_view.y+a.y)%192)*factor-192/2*factor+64
pset(x,y,sin(time()/10+a.twinkle_offset)>0.5 and 6 or 5)
end,function(a)
if a.following then
a.dx=a.following.dx
a.dy=a.following.dy
end
end,function(a)
if btn"4"and a.missile_ready then
_g.missile(a.x+cos(a.ang)*.8,a.y+sin(a.ang)*.8,a.dx,a.dy,a.ang)
a.missile_ready=false
a:start_timer("missile_cooldown",0.1,function()a.missile_ready=true end)
end
if ybtn()>0 then
a.speed=-.005
elseif ybtn()<0 then
a.speed=.01
else
a.speed=0
end
a.d_ang=-xbtn()*.01
end,function(a,b,dx,dy)
if b.parents["team_blue"]then
if b.id=="zipper"then return end
a.dx+=dx
a.dy+=dy
else
a:explode()
end
end,function(a)
a.alert_radar.alerts[a.pointing_to]=nil
end,function(a)
if a.anchoring.alive and a.pointing_to.alive then
local x,y=a.pointing_to.x-a.anchoring.x,a.pointing_to.y-a.anchoring.y
a.ang=atan2(x,y)
a.dist=dist_between_circles(a.pointing_to,a.anchoring)
else
if a.curr=="normal"then a:load"dying" end
end
end,function(a)
local dist=max(1,a.dist/2)
local scale=1
if a.curr=="dying"then
scale=1-a:get_elapsed_percent[[state]]
end
if dist>2 then
local minimize=12
local x1,y1=a.x+cos(a.ang)*1.5,a.y+sin(a.ang)*1.5
local x2,y2=x1+cos(a.ang)*dist/minimize*scale,y1+sin(a.ang)*dist/minimize*scale
line(zoomx(x1),zoomy(y1),zoomx(x2),zoomy(y2),a.pointing_to.alert_color or 7)
end
end,function(a,others)
foreach(others,function(other)
if not a.alerts[other]then
a.alerts[other]=_g.pl_alert(a,a.anchoring,other)
end
end)
end,function()
music(8,1000,7)
clean_all_entities()
end,function()
end,function()
music(24,1000,7)
clean_all_entities()
end,function()
end,function(a)
printh("here")
local ang=rnd()
local x,y=cos(ang)*20,sin(ang)*20
_g.chaser(x,y,a.planet)
a.chasers_spawned+=1
if a.chasers_spawned==9 then a.next="done_spawning" end
end,function()
music(32,1000,7)
clean_all_entities()
g_pl=_g.pl(0,0)
g_view=_g.view(g_pl)
local star_view=_g.star_view(g_pl)
for i=1,50 do
_g.twinkle(rnd(256),rnd(256),rnd(),g_view,star_view)
end
create_level_focus_points()
create_text("lvl",0,-3,_g.drawable_model_post_temp)
_g.drawable_model_post_temp(0,0,_g.STARTING_CIRCLE,1)
create_text("mouse",0,3,_g.drawable_model_post_temp)
_g.fader_in(1)
_g.alert_radar(g_pl)
local planet=_g.planet(0,-22,10,_g.MOUSE)
_g.mouse_level_state(planet)
_g.chaser(0,2,planet)
_g.black_hole(0,22)
_g.game_checker(g_pl,planet,"level_mouse_retry","win_mouse")
end,function()
loop_zobjs("actor","state")
loop_zobjs("view","match_following")
loop_zobjs("star_view","match_following")
loop_zobjs("missile","collide",g_zclass_entities["teammate"])
loop_zobjs("teammate","collide",g_zclass_entities["teammate"])
loop_zobjs("alert_radar","register",g_zclass_entities["planet"])
loop_zobjs("alert_radar","register",g_zclass_entities["view"])
loop_zobjs("alert_radar","register",g_zclass_entities["black_hole"])
loop_zobjs("focus_point","collide",g_zclass_entities["view"])
loop_zobjs("alert_radar","register",g_zclass_entities["chaser"])
loop_zobjs("alert_radar","register",g_zclass_entities["black_hole"])
loop_zobjs("black_hole","tug",g_zclass_entities["teammate"])
loop_zobjs("collision_circ","follow_anchoring")
loop_zobjs("mov","mov_update")
loop_zobjs("acc","acc_update")
loop_zobjs("vec","vec_update")
loop_zobjs("anchor_pos","update_anchor")
loop_zobjs("model","model_update")
check_level_bounds()
end,function()
music(16,1000,7)
clean_all_entities()
end,function()
end,function()
end,function()
local win=G_LEVEL_BEAR_WIN and G_LEVEL_MOUSE_WIN and G_LEVEL_CAT_WIN and G_LEVEL_PIG_WIN
music(0,1000,7)
clean_all_entities()
g_pl=_g.pl(0,0)
g_view=_g.view(g_pl)
local star_view=_g.star_view(g_pl)
for i=1,50 do
_g.twinkle(rnd(256),rnd(256),rnd(),g_view,star_view)
end
_g.fader_in(1)
_g.alert_radar(g_pl)
g_title_screen_coord=30
g_title_screen_dim=g_title_screen_coord*2
if win then
create_text("rewob",0,-3,_g.drawable_model_post)
_g.drawable_model_post(0,0,_g.STARTING_CIRCLE)
create_text("credits",0,3,_g.drawable_model_post)
else
create_text("rewob",0,-3,_g.drawable_model_post_temp)
_g.drawable_model_post_temp(0,0,_g.STARTING_CIRCLE)
create_text("ldjam50",0,3,_g.drawable_model_post_temp)
end
if not G_LEVEL_CAT_WIN then create_text("lvl",-12,-2.5)create_text("cat",-12,2.5)_g.level_entrance(-12,0,_g.LEVEL_LEFT,"level_cat")
else _g.focus_point(-12,0)create_text("cat,dead",-12,0)end
if not G_LEVEL_PIG_WIN then create_text("lvl",12,-2.5)create_text("pig",12,2.5)_g.level_entrance(12,0,_g.LEVEL_RIGHT,"level_pig")
else _g.focus_point(12,0)create_text("pig,dead",12,0)end
if not G_LEVEL_MOUSE_WIN then create_text("lvl",0,9.5)create_text("mouse",0,14.5)_g.level_entrance(0,12,_g.LEVEL_DOWN,"level_mouse")
else _g.focus_point(0,12)create_text("mouse,dead",0,12)end
if not G_LEVEL_BEAR_WIN then create_text("lvl",0,-14.5)create_text("bear",0,-9.5)_g.level_entrance(0,-12,_g.LEVEL_UP,"level_bear")
else _g.focus_point(0,-12)create_text("bear,dead",0,-12)end
if win then
create_text("code,amorg,denial",-12,-12)
create_text("gfx,tigerwolf,greatcadet",12,-12)_g.focus_point(12,-12)
create_text("sfx,amorg,greatcadet",-12,12)
create_text("made,with,pico8",12,12)
end
end,function()
loop_zobjs("actor","state")
loop_zobjs("view","match_following")
loop_zobjs("star_view","match_following")
loop_zobjs("level_entrance","collide",g_zclass_entities["view"])
loop_zobjs("level_entrance","collide",g_zclass_entities["pl"])
loop_zobjs("focus_point","collide",g_zclass_entities["view"])
loop_zobjs("alert_radar","register",g_zclass_entities["level_entrance"])
loop_zobjs("collision_circ","follow_anchoring")
loop_zobjs("mov","mov_update")
loop_zobjs("acc","acc_update")
loop_zobjs("vec","vec_update")
loop_zobjs("anchor_pos","update_anchor")
loop_zobjs("model","model_update")
if g_pl.x>g_title_screen_coord then g_pl.x-=g_title_screen_dim-1 g_view.x-=g_title_screen_dim-1 end
if g_pl.y>g_title_screen_coord then g_pl.y-=g_title_screen_dim-1 g_view.y-=g_title_screen_dim-1 end
if g_pl.x<-g_title_screen_coord then g_pl.x+=g_title_screen_dim-1 g_view.x+=g_title_screen_dim-1 end
if g_pl.y<-g_title_screen_coord then g_pl.y+=g_title_screen_dim-1 g_view.y+=g_title_screen_dim-1 end
end,function(a)
_g.model_draw(a)
end,function(a,other)
if other.id=="pl"then
a:explode()
music(-1)
sfx(22,3)
_g.fader_out(1,function()
g_game_state:load(a.next_game_state)
end)
end
end,function()music(-1)sfx"63" end,function(a)
local logo_opacity=cos(a:get_elapsed_percent"state")+1
fade(logo_opacity)
camera(logo_opacity>.5 and rnd_one())
zspr(108,64,64,4,2)
fade"0"
camera()
end,function()
loop_zobjs_in_view(g_view,"drawable_pre","draw")
loop_zobjs_in_view(g_view,"drawable","draw")
loop_zobjs_in_view(g_view,"drawable_post","draw")
end,function()
circ(zoomx(0),zoomy(0),zoom(LEVEL_RADIUS-1),1)
_g.level_select_draw()
end,function()
loop_zobjs_in_view(g_view,"drawable_pre","draw")
loop_zobjs_in_view(g_view,"drawable","draw")
loop_zobjs_in_view(g_view,"drawable_post","draw")
end,function(a)
if a.planet.done_ships>=a.planet.total_ships and g_zclass_entities["zipper"]and #g_zclass_entities["zipper"]==0 then
a:kill()
music(-1)sfx(24,3)
_g.fader_out(1,function()g_game_state:load(a.win_level)end)
elseif not a.pl.alive or not a.planet.alive then
a:kill()
music(-1)sfx(24,3)
_g.fader_out(1,function()g_game_state:load(a.retry_level)end)
end
end,function(a)
music(4,nil,1)
clean_all_entities()
G_DEATH_COUNT=min(100,G_DEATH_COUNT+1)
_g.fader_in(1)
g_view=_g.view()
local txt="???"
if G_DEATH_COUNT==1 then txt="wob"
elseif G_DEATH_COUNT==2 then txt="wob,again"
elseif G_DEATH_COUNT==3 then txt="wob,again?"
elseif G_DEATH_COUNT<100 and G_DEATH_COUNT>=3 then
if G_DEATH_COUNT%10==0 then
txt="rewob,"..(G_DEATH_COUNT\10)
else
txt="wob,"..G_DEATH_COUNT
end
end
create_text(txt,0,0)
g_game_state:start_timer("retry",1,function()
_g.fader_out(1,function()
if g_game_state.curr=="level_mouse_retry"then g_game_state:load("level_mouse")
elseif g_game_state.curr=="level_cat_retry"then g_game_state:load("level_cat")
elseif g_game_state.curr=="level_bear_retry"then g_game_state:load("level_bear")
elseif g_game_state.curr=="level_pig_retry"then g_game_state:load("level_pig")
end
end)
end)
end,function(a)
loop_zobjs("actor","state")
loop_zobjs("model","model_update")
end,function(a)
loop_zobjs("drawable_post","draw")
end,function(a)
music(4,nil,1)
clean_all_entities()
_g.fader_in(1)g_view=_g.view()
if a.curr=="win_bear"then G_LEVEL_BEAR_WIN=true
elseif a.curr=="win_mouse"then G_LEVEL_MOUSE_WIN=true
elseif a.curr=="win_cat"then G_LEVEL_CAT_WIN=true
elseif a.curr=="win_pig"then G_LEVEL_PIG_WIN=true
end
create_text("win",0,0)
g_game_state:start_timer("win",1,function()
_g.fader_out(1,function()
g_game_state:load("level_select")
end)
end)
end,function(a)
loop_zobjs("actor","state")
loop_zobjs("model","model_update")
end,function(a)
loop_zobjs("drawable_post","draw")
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
for i=1,#points,1 do
local k,v=i,points[i]
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
function scr_wobble_line(x1,y1,x3,y3,color)
wobble_line(zoomx(x1),zoomy(y1),zoomx(x2),zoomy(y2),color)
end
function scr_draw_polygon(old_points,color)
local points={}
foreach(old_points,function(p)
add(points,{x=zoomx(p.x),y=zoomy(p.y)})
end)
draw_polygon(points,color)
end
function zoom(num)return num*g_view.zoom_factor end
function zoomx(x)return zoom(x-g_view.x)+64 end
function zoomy(y)return zoom(y-g_view.y)+64 end
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
function clean_all_entities(...)
local objs={}
local exclusions={game_state=true}
foreach({...},function(exclusion)exclusions[exclusion]=true end)
for class,entities in pairs(g_zclass_entities)do
for entity in all(entities)do
objs[entity]=entity.id
end
end
for obj,id in pairs(objs)do
if not exclusions[id]then
if obj.parents.actor then
obj:kill()
obj:clean()
end
deregister_zobj(obj)
end
end
end
zclass[[drawable|]]
zclass[[drawable_pre|]]
zclass[[drawable_post|]]
zclass[[fader_out,actor|start;duration,@,destroyed,@,update,%fader_out_update]]
zclass[[fader_in,actor|start;duration,@,update,%fader_in_update]]
zclass[[timer|timers;,;start_timer,%timer_start_timer,stop_timer,%timer_stop_timer,play_timer,%timer_play_timer,delete_timer,%timer_delete_timer,get_elapsed,%timer_get_elapsed,get_elapsed_percent,%timer_get_elapsed_percent,tick,%timer_tick,]]
zclass[[pos|x,0,y,0]]
zclass[[vec,pos|dx,0,dy,0,vec_update,%vec_update]]
zclass[[acc,vec|inertia_x,.95,inertia_y,.95,ax,0,ay,0,acc_update,%acc_update]]
zclass[[mov,acc|ang,0,speed,0,d_ang,0,mov_update,%mov_update]]
zclass[[anchor_pos,pos|anchoring;x,0,y,0;update_anchor,%anchor_pos_update_anchor]]
zclass[[collision_circ,vec,actor,drawable|anchoring,@,offset_x,@,offset_y,@,radius,@,inertia_x,1,inertia_y,1,follow_anchoring,%collision_follow_anchoring,check_collision,%check_collision,init,%collision_init,draw,%collision_draw_debug]]
function dist_between_circles(a,b)
local x,y=b.x-a.x,b.y-a.y
local minimum_dist=a.radius+b.radius
return approx_dist(x,y)-minimum_dist
end
zclass[[bad_collision_circ,collision_circ|anchoring,@,offset_x,@,offset_y,@,radius,@]]
zclass[[good_collision_circ,collision_circ|anchoring,@,offset_x,@,offset_y,@,radius,@]]
zclass[[model,mov,actor|shapes;,;collisions;,;collision_circs;,;radius,0,hit,%model_hit,scale,1,collision_func,%bad_collision_circ,draw,%model_draw,explode,%model_explode,collide,%model_collide,model_update,%model_update]]
function line_loop(points,color,linefunc)
for i=1,#points-1,1 do
local p1,p2=points[i],points[i+1]
linefunc(p1.x,p1.y,p2.x,p2.y,color)
end
end
function parse_model(template_str,scale,xoffset,yoffset)
scale=scale or 1
xoffset=xoffset or 0
yoffset=yoffset or 0
local template=zobj(template_str)
local shapes={}
foreach(template.lines or{},function(line_components)
local shape={fg_color=line_components[1],bg_color=line_components[2],wobble_enabled=line_components[3]}
for i=4,#line_components/2\1*2,2 do
local x,y=line_components[i],line_components[i+1]
add(shape,{x=(x+xoffset)*scale,y=(y+yoffset)*scale})
end
add(shapes,shape)
end)
local radius=0
local collisions={}
foreach(template.collisions or{},function(collision)
local x=(collision[1]+xoffset)*scale
local y=(collision[2]+yoffset)*scale
local local_radius=abs(collision[3]*scale)
radius=max(radius,approx_dist(x,y)+local_radius)
add(collisions,{x=x,y=y,radius=local_radius})
end)
return{radius=radius,shapes=shapes,collisions=collisions}
end
function translate_points(x,y,dir,shape)
local points={}
foreach(shape,function(p)
local ang=atan2(p.x,p.y)
local mag=approx_dist(p.x,p.y)
add(points,{x=x+cos(ang+dir)*mag,y=y+sin(ang+dir)*mag})
end)
return points
end
zclass[[vanishing_shape,vec,actor,drawable_pre|x,@,y,@,dx,@,dy,@,points,@,color,@,draw,%vanishing_shape_draw;start;duration,.25;]]
zclass[[line_particle,vec,actor,drawable_post|ang,@,x,@,y,@,x1,@,y1,@,x2,@,y2,@,color,@,dx,@,dy,@,draw,%line_particle_draw,update,%line_particle_update;start;duration,.5;]]
zclass[[view,model|following,@,model,%VIEW_COLLISION_CIRC,scale,5,zoom_factor,16,zooming,false,update,%view_update,hit,%view_hit,match_following,%view_match_following]]
zclass[[missile,model,drawable|x,@,y,@,dx,@,dy,@,ang,@,model,%MISSILE,speed,0.05,damage,1,inertia_x,1,inertia_y,1,destroyed,%missile_destroyed,init,%missile_init,hit,%missile_hit;start;duration,2;]]
zclass[[missile_pop,model,drawable|x,@,y,@,model,%MISSILE_POP,init,%missile_pop_init]]
zclass[[teammate|]]
zclass[[team_red,teammate|]]
zclass[[team_blue,teammate|]]
zclass[[team_none,teammate|]]
zclass[[planet,model,drawable,team_blue|x,@,y,@,total_ships,@,model,@,done_ships,0,max_health,100,health,100,damage,10000,d_ang,.001;start;duration,10,next,evac;evac;init,%planet_evac,duration,9.5,next,evac;done;,;]]
zclass[[zipper,model,drawable,team_blue|x,@,y,@,ang,@,model,%ZIPPER;start;duration,1,next,zip;zip;speed,.05,duration,1;]]
zclass[[chaser,model,drawable,team_red|x,@,y,@,target,@,alert_color,8,max_health,20,health,20,damage,30,scale,2,model,%CHASER,update,%chaser_update,hit,%chaser_hit;]]
zclass[[black_hole,model,drawable,team_none|x,@,y,@,alert_color,1,d_ang,.1,damage,10000,model,%BLACK_HOLE;start;duration,2,tug,nop,next,run;run;tug,%black_hole_tug;]]
zclass[[twinkle,drawable_pre|x,@,y,@,twinkle_offset,@,view,@,star_view,@,draw,%twinkle_draw]]
zclass[[star_view,vec|following,@,match_following,%star_view_match_following]]
zclass[[pl,actor,model,drawable,team_blue|x,@,y,@,missile_ready,yes,model,%PLAYER_SPACESHIP,update,%pl_update,hit,%pl_hit,collision_func,%good_collision_circ,]]
zclass[[pl_alert,anchor_pos,actor,drawable|alert_radar,@,anchoring,@,pointing_to,@,model,%PLAYER_ALERT,update,%pl_alert_update,dist,0,scale,1,destroyed,%pl_alert_destroy,draw,%pl_alert_draw;start;duration,1,next,normal;normal;,;dying;duration,.25,update,nop,next,wait;wait;duration,1,draw,nop]]
zclass[[alert_radar,anchor_pos|alerts;,;anchoring,@,model,%ALERT_RADAR_CIRC,register,%alert_radar_register,update,%alert_radar_update,draw,%pl_alert_draw,]]
zclass[[mouse_level_state,actor|planet,@,chasers_spawned,0;start;duration,10,next,spawn;spawn;init,%spawn_init,duration,8,next,spawn;done_spawning;,;]]
zclass[[drawable_model_post,model,drawable_post|x,@,y,@,model,@]]
zclass[[drawable_model_post_temp,model,drawable_post|x,@,y,@,model,@;start;duration,1.5,next,dying;dying;init,%model_explode;]]
function create_text(original_text,original_x,y,func,...)
func=func or _g.drawable_model_post
local l=split(original_text,",",false)
local params={...}
y=y-#l/2+.5
foreach(l,function(text)
local x=original_x
local new_text=""
for i=1,#text,1 do
local letter=sub(text,i,i)
if g_font[letter]then
new_text=new_text..letter
end
end
x=x-#new_text/2+.5
for i=1,#new_text,1 do
local letter=sub(text,i,i)
func(x,y,g_font[letter],unpack(params))
x+=1
end
y+=1
end)
end
function loop_zobjs_in_view(view,class,method_name,...)
for inst in all(g_zclass_entities[class])do
if inst.parents.model and dist_between_circles(view,inst)<0 or not inst.parents.model then
call_not_nil(inst,method_name,inst,...)
end
end
end
zclass[[level_entrance,model,drawable_pre|x,@,y,@,model,@,next_game_state,@,circ_radius,1.5,alert_color,9,draw,%level_entrance_draw,d_ang,.001,hit,%level_entrance_hit]]
zclass[[focus_point,model|model,%FOCUS_POINT,x,@,y,@,radius,1]]
g_fade_table=zobj[[0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,0,0,0,0;2;,2,2,2,2,1,0,0,0;3;,3,3,3,3,1,0,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,1,1,0,0;6;,6,6,13,13,5,5,1,0;7;,7,7,6,13,13,5,1,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,5,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,1,1,0;13;,13,13,5,5,1,1,1,0;14;,14,14,13,4,2,2,1,0;15;,15,15,13,13,5,5,1,0;]]
function fade(threshold)
for c=0,15 do
pal(c,g_fade_table[c][1+flr(7*min(1,max(0,threshold)))])
end
end
G_DEATH_COUNT=0
G_LEVEL_BEAR_WIN=false
G_LEVEL_MOUSE_WIN=false
G_LEVEL_CAT_WIN=false
G_LEVEL_PIG_WIN=false
zclass[[game_state,actor|ecs_exclusions;actor,true;curr,level_mouse;logo;init,%logo_init,update,%logo_update,draw,%logo_draw,duration,2.5,next,level_select;level_select;init,%level_select_init,update,%level_select_update,draw,%level_select_draw;level_bear;init,%level_bear_init,update,%level_bear_update,draw,%level_draw;level_mouse;init,%level_mouse_init,update,%level_mouse_update,draw,%level_draw;level_cat;init,%level_cat_init,update,%level_cat_update,draw,%level_draw;level_pig;init,%level_pig_init,update,%level_pig_update,draw,%level_draw;level_bear_retry;init,%retry_init,update,%retry_update,draw,%retry_draw;level_mouse_retry;init,%retry_init,update,%retry_update,draw,%retry_draw;level_cat_retry;init,%retry_init,update,%retry_update,draw,%retry_draw;level_pig_retry;init,%retry_init,update,%retry_update,draw,%retry_draw;win_bear;init,%win_init,update,%win_update,draw,%win_draw;win_mouse;init,%win_init,update,%win_update,draw,%win_draw;win_cat;init,%win_init,update,%win_update,draw,%win_draw;win_pig;init,%win_init,update,%win_update,draw,%win_draw;]]
function _init()
g_game_state=_g.game_state()
g_fade=0
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
fade(g_fade)
loop_zobjs("game_state","draw")
if g_debug then rect(0,0,127,127,8)end
end
LEVEL_RADIUS=25
function check_level_bounds()
if approx_dist(g_pl.x,g_pl.y)>LEVEL_RADIUS and(not CHECK_LEVEL_BOUND_FADER or not CHECK_LEVEL_BOUND_FADER.alive)then
CHECK_LEVEL_BOUND_FADER=_g.fader_out(1,function()
g_game_state:load"level_select"
end)
end
end
function create_level_focus_points()
local num=LEVEL_RADIUS \ 2
for i=0,num-1 do
_g.focus_point(cos(i/num)*LEVEL_RADIUS,sin(i/num)*LEVEL_RADIUS)
end
end
zclass[[game_checker,actor|pl,@,planet,@,retry_level,@,win_level,@,update,%game_checker_update]]