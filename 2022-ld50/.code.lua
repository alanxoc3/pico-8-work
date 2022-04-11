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
_g=zobj([[actor_load,@,actor_state,@,actor_kill,@,actor_clean,@,fader_out_update,@,fader_in_update,@,timer_start_timer,@,timer_stop_timer,@,timer_play_timer,@,timer_delete_timer,@,timer_get_elapsed,@,timer_get_elapsed_percent,@,timer_tick,@,vec_update,@,acc_update,@,mov_update,@,anchor_pos_update_anchor,@,collision_init,@,collision_follow_anchoring,@,check_collision,@,model_update,@,model_draw,@,model_collide,@,model_hit,@,model_explode,@,vanishing_shape_draw,@,line_particle_update,@,line_particle_draw,@,view_init,@,view_update,@,view_match_following,@,missile_destroyed,@,missile_hit,@,missile_pop_init,@,model_health_bar_hit,@,planet_destroyed,@,planet_evac,@,zipper_init,@,zipper_destroyed,@,chaser_init,@,chaser_update,@,chaser_hit,@,gravity_tug,@,twinkle_draw,@,star_view_match_following,@,pl_update,@,pl_hit,@,pl_alert_destroy,@,pl_alert_update,@,pl_alert_draw,@,alert_radar_register,@,bar_update_starting,@,bar_update_dying,@,bar_update,@,bar_draw,@,level_select_init,@,level_select_update,@,level_entrance_outline_update,@,level_entrance_init,@,level_entrance_draw,@,level_entrance_hit,@,level_1_init,@,level_2_init,@,level_3_init,@,level_4_init,@,level_5_init,@,level_6_init,@,level_7_init,@,level_8_init,@,logo_init,@,logo_draw,@,level_select_draw,@,level_draw,@,stats_displayer_draw,@,game_checker_update,@,retry_init,@,retry_update,@,retry_draw,@,win_init,@,win_update,@,win_draw,@,level_update,@,spawn_init,@]],function(a,stateName)
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
end
end)
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
local base_model={}
if a.prev_draw_ang==a.ang and a.prev_draw_x==a.x and a.prev_draw_y==a.y then
base_model=a.prev_base_model
else
foreach(a.shapes,function(shape)
local points=translate_points(a.x,a.y,a.ang,shape)
add(base_model,{shape=shape,points=points})
end)
a.prev_base_model=base_model
a.prev_draw_ang,a.prev_draw_x,a.prev_draw_y=a.ang,a.x,a.y
end
foreach(base_model,function(m)
if m.shape.bg_color>=0 then
scr_draw_polygon(m.points,m.shape.bg_color)
end
end)
memcpy(0x5600,0x5f44,8)
srand(t()*4\1)
foreach(base_model,function(m)
line_loop(m.points,m.shape.fg_color,m.shape.wobble_enabled and scr_wobble_line or scr_line)
end)
memcpy(0x5f44,0x5600,8)
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
a.health=max(0,a.health-(b.damage or 0))
if a.health<=0 then a:explode()end
end
end,function(a,duration)
if a.alive then
if a.explode_sfx then sfx(a.explode_sfx,3)end
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
if a.following then
a.x=a.following.x
a.y=a.following.y
end
end,function(a)
a.zoom_factor=max(12,a.zoom_factor-.1)
end,function(a)
if a.following then
local x,y=a.following.x-a.x,a.following.y-a.y
local dir=atan2(x,y)
local dist=approx_dist(x,y)
a.dx=cos(dir)*dist*.25
a.dy=sin(dir)*dist*.25
end
end,function(a)
_g.missile_pop(a.x,a.y)
end,function(a,b,dx,dy)
a:kill()
end,function(a)
a:model_update()
a:explode(.2)
end,function(a,other,...)
local prev_health=a.health
_g.model_hit(a,other,...)
if prev_health ~=a.health and(not a.health_bar or not a.health_bar.alive)then
a.health_bar=_g.bar(a,function()SCREEN_SHAKE=true return a.health/a.max_health end,5,a.health_bar_min,a.health_bar_min+1,.5)
end
end,function(a)
g_view.following=a
end,function(a)
_g.zipper(a.x,a.y,rnd())
end,function()g_zipper_count+=1 end,function(a)a:explode()end,function(a)
a.ang=atan2(a.target.x-a.x,a.target.y-a.y)
end,function(a)
if a.target then
local ang=atan2(a.target.x-a.x,a.target.y-a.y)
a.d_ang=sgn(ang-a.ang%1)*.01
a.speed=.004*.75
else
a.d_ang=.01
a.speed=0
end
end,function(a,b,dx,dy)
_g.model_health_bar_hit(a,b,dx,dy)
if b.id=="missile"then a.target=g_pl end
end,function(a,obj_list)
foreach(obj_list,function(obj)
if a.id==obj then return end
local x,y=a.x-obj.x,a.y-obj.y
local ang=atan2(x,y)
local dist=min(approx_dist(x,y),a.tug_constant)
obj.dx+=cos(ang)*dist
obj.dy+=sin(ang)*dist
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
a.shoot_percent=min(1,a.shoot_percent+.01)
if a.shoot_percent==1 then
a.shoot_enabled=true
end
if(btn"5"or btn"4")and a.missile_ready then
a.shoot_percent=max(0,a.shoot_percent-.125)
_g.missile(a.x+cos(a.ang)*.8,a.y+sin(a.ang)*.8,a.dx,a.dy,a.ang)
a.missile_ready=false
a:start_timer("missile_cooldown",0.15,function()a.missile_ready=true end)
if a.shoot_percent==0 then a.shoot_enabled=false end
end
if ybtn()>0 then
a.speed=-.00875*.75
elseif ybtn()<0 then
a.speed=.01*.75
else
a.speed=0
end
if btn"5"or btn"4"or ybtn()~=0 then
G_SHOULD_PAUSE_BEAT=false
end
a.d_ang=-xbtn()*.01
end,function(a,b,dx,dy)
if b.parents["team_blue"]then
if b.id=="zipper"then return end
a.dx+=dx
a.dy+=dy
else
a:explode()
if b.id=="chaser"then b:explode()end
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
local x2,y2=x1+cos(a.ang)*min(1,dist/minimize*scale),y1+sin(a.ang)*min(1,dist/minimize*scale)
line(zoomx(x1),zoomy(y1),zoomx(x2),zoomy(y2),a.pointing_to.alert_color or 7)
end
end,function(a,others)
foreach(others,function(other)
if not a.alerts[other]then
a.alerts[other]=_g.pl_alert(a,a.anchoring,other)
end
end)
end,function(a)
a.rmin=a:get_elapsed_percent"state"*a.initial_rmin
a.rmax=a:get_elapsed_percent"state"*a.initial_rmax
end,function(a)
a.rmin=a.initial_rmin-a:get_elapsed_percent"state"*a.initial_rmin
a.rmax=a.initial_rmax-a:get_elapsed_percent"state"*a.initial_rmax
end,function(a)
local prev_percent=a.percent
a.percent=a.percent_func()
if not a.anchoring.alive then a:load"dying"
elseif prev_percent ~=a.percent then a:load"run" end
end,function(a)
fillp(0b0111101111011110)
zcircfill(a.x,a.y,a.rmin,a.fg)
fillp()
local rad=(a.rmax-a.rmin)*a.percent+a.rmin
circ(zoomx(a.x),zoomy(a.y),zoom(rad),a.fg)
circ(zoomx(a.x),zoomy(a.y),zoom(rad)-1,0)
end,function()
local yoff=8
music(0,1000,7)
clean_all_entities()
g_pl=_g.pl(0,yoff)
g_view=_g.view(g_pl)
local star_view=_g.star_view(g_pl)
for i=1,50 do
_g.twinkle(rnd(256),rnd(256),rnd(),g_view,star_view)
end
_g.fader_in(1)
_g.alert_radar(g_pl)
g_title_screen_coord=40
g_title_screen_dim=g_title_screen_coord*2
create_level_selector(18,yoff+0,1,"lvl "..1,"mouse",_g.MOUSE)
create_level_selector(21,yoff+-12,2,"lvl "..2,"cat",_g.CAT)
create_level_selector(12,yoff+-21,3,"lvl "..3,"pig",_g.PIG)
create_level_selector(0,yoff+-18,4,"lvl "..4,"bear",_g.BEAR)
create_level_selector(-12,yoff+-21,5,"lvl "..5,"rhino",_g.RHINO)
create_level_selector(-21,yoff+-12,6,"lvl "..6,"croc",_g.CROC)
create_level_selector(-18,yoff+0,7,"lvl "..7,"dragon",_g.DRAGON)
create_level_selector(0,yoff+12,8,"the","credits",_g.CREDITS)
create_text("rewob",0,yoff-3,_g.drawable_model_post_temp)
_g.drawable_model_post_temp(0,yoff,_g.STARTING_CIRCLE)
if G_DEATH_COUNT>0 then
create_text(get_wob_text(),0,yoff+3,_g.drawable_model_post_temp)
else
create_text("by amorg",0,yoff+3,_g.drawable_model_post_temp)
end
end,function()
loop_zobjs("actor","state")
loop_zobjs("view","match_following")
loop_zobjs("star_view","match_following")
loop_zobjs("view","collide",g_zclass_entities["level_entrance"])
loop_zobjs("missile","collide",g_zclass_entities["level_entrance"])
loop_zobjs("level_entrance","collide",g_zclass_entities["pl"])
loop_zobjs("pl","collide",g_zclass_entities["level_entrance"])
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
if not a.following.alive then a:explode()end
end,function(a)
_g.level_entrance_outline(a,a.x,a.y,a.outline_model)
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
end,function()
level_init_shared(1,"lvl 1","mouse",32,0,0,9)
local planet=_g.planet(15,0,_g.MOUSE)
_g.asteroid(26,0)
_g.black_hole(-20,0)
_g.spawner(_g.chaser,planet,4,4,0,0)
end,function()
level_init_shared(2,"lvl 2","cat",24,0,0,12)
local planet=_g.planet(0,-25,_g.CAT)
_g.black_hole(0,22)
_g.spawner(_g.chaser,planet,4,16,.83,.83)
_g.spawner(_g.chaser,planet,12,16,.67,.67)
end,function()
level_init_shared(3,"lvl 3","pig",16,0,7,13)
local planet=_g.planet(0,0,_g.PIG)
_g.black_hole(-50,0)
_g.black_hole(50,0)
_g.asteroid(20,0)
_g.spawner(_g.chaser,planet,4,8,.75,.75)
_g.spawner(_g.chaser,planet,8,8,.25,.25)
end,function()
level_init_shared(4,"lvl 4","bear",8,10,0,11)
local planet=_g.planet(20,0,_g.BEAR)
_g.asteroid(17,-18)
_g.asteroid(17,20)
_g.spawner(_g.chaser,planet,5,5,-.125,.125)
_g.black_hole(-22,0)
end,function()
level_init_shared(5,"lvl 5","rhino",40,-10,-10,14)
local planet=_g.planet(-18,-18,_g.RHINO)
_g.asteroid(0,0)
_g.asteroid(5,5)
_g.asteroid(10,10)
_g.spawner(_g.chaser,planet,7,7,0-.1,0+.1)
_g.spawner(_g.chaser,planet,11.5,7,.75-.1,.75+.1)
_g.black_hole(-80,40)
_g.black_hole(40,-80)
_g.black_hole(89,44)
_g.black_hole(44,89)
end,function()
level_init_shared(6,"lvl 6","croc",44,0,-9,12)
local planet=_g.planet(0,-25,_g.CROC)
_g.asteroid(25,0)
_g.asteroid(-25,0)
_g.asteroid(15,15)
_g.asteroid(-15,15)
_g.asteroid(22,8)
_g.asteroid(-22,8)
_g.spawner(_g.chaser,planet,4,2,.5,1)
_g.black_hole(0,20)
end,function()
level_init_shared(7,"lvl 7","dragon",36,0,-9,11)
local planet=_g.planet(0,0,_g.DRAGON)
_g.asteroid(cos(.25)*35,sin(.25)*35)
_g.asteroid(cos(.25+1/3)*35,sin(.25+1/3)*35)
_g.asteroid(cos(.25+2/3)*35,sin(.25+2/3)*35)
_g.spawner(_g.chaser,planet,5,5,.25+0/3-.1,.25+0/3+.1)
_g.black_hole(cos(.75)*58,sin(.75)*58)
_g.black_hole(cos(.75+1/3)*58,sin(.75+1/3)*58)
_g.black_hole(cos(.75+2/3)*58,sin(.75+2/3)*58)
end,function()
inc_level(1)
level_init_shared(8,"the","credits",48,0,0)
create_text("you win",0,-4.5)
create_text(get_wob_text(),0,4.5)
create_text("code,amorg,denial",0,-12)
create_text("gfx,tigerwolf,greatcadet",-12,0)
create_text("sfx,amorg,greatcadet",12,0)
create_text("made for,ludum dare,50",0,12)
_g.spawner(_g.chaser,{x=0,y=0},5,20,.125,.125)
_g.spawner(_g.chaser,{x=0,y=0},10,20,.375,.375)
_g.spawner(_g.chaser,{x=0,y=0},15,20,.625,.625)
_g.spawner(_g.chaser,{x=0,y=0},20,20,.875,.875)
_g.asteroid(-10,-10)
_g.asteroid(-10,10)
_g.asteroid(10,10)
_g.asteroid(10,-10)
end,function()music(-1)sfx(63,0)end,function(a)
local logo_opacity=cos(a:get_elapsed_percent"state")+1
fade(logo_opacity)
camera(logo_opacity>.5 and rnd_one())
zspr(108,64,64,4,2)
fade"0"
camera()
end,function()
loop_zobjs_in_view(g_view,"drawlayer_03","draw")
loop_zobjs_in_view(g_view,"drawlayer_10","draw")
loop_zobjs_in_view(g_view,"drawlayer_20","draw")
loop_zobjs_in_view(g_view,"drawlayer_30","draw")
loop_zobjs_in_view(g_view,"drawlayer_40","draw")
end,function()
circ(zoomx(0),zoomy(0),zoom(LEVEL_VIEW_RADIUS),1)
_g.level_select_draw()
end,function(a)
if g_zipper_goal then
print(""..g_zipper_count.."/"..g_zipper_goal,4,4,11)
end
end,function(a)
if g_zipper_goal and g_zipper_count>=g_zipper_goal then
if #g_zclass_entities["planet"]==0 then
music(-1)a:kill()
_g.fader_out(1,function()
g_game_state:load"win"
end)
end
elseif g_zipper_goal and #g_zclass_entities["planet"]==0 then
music(-1)a:kill()
_g.fader_out(1,function()
g_game_state:load"retry"
end)
elseif not a.pl.alive then
a:kill()music(-1)
sfx(24,3)
_g.fader_out(1,function()
g_game_state:load"retry"
end)
end
end,function(a)
music(4,nil,1)
clean_all_entities()
G_DEATH_COUNT=max(0,min(999,G_DEATH_COUNT+1))
_g.fader_in(1)
g_view=_g.view()
create_text(get_wob_text(),0,0)
g_game_state:start_timer("retry",1,function()
_g.fader_out(1,function()
g_game_state:load(G_CUR_LEVEL)
end)
end)
end,function(a)
loop_zobjs("actor","state")
loop_zobjs("model","model_update")
end,function(a)
loop_zobjs("drawlayer_40","draw")
end,function(a)
music(5,nil,1)
clean_all_entities()
_g.fader_in(1)g_view=_g.view()
if G_LEVEL==G_CUR_LEVEL then
inc_level(1)
end
create_text("win",0,0)
g_game_state:start_timer("win",1,function()
_g.fader_out(1,function()
g_game_state:load"level_select"
end)
end)
end,function(a)
loop_zobjs("actor","state")
loop_zobjs("model","model_update")
end,function(a)
loop_zobjs("drawlayer_40","draw")
end,function()
if g_zipper_goal and g_zipper_count>=g_zipper_goal then
if g_zclass_entities["planet"]and #g_zclass_entities["planet"]==1 then
g_view.following=g_zclass_entities["planet"][1]
end
end
loop_zobjs("actor","state")
loop_zobjs("view","match_following")
loop_zobjs("star_view","match_following")
loop_zobjs("missile","collide",g_zclass_entities["teammate"])
loop_zobjs("missile","collide",g_zclass_entities["black_hole"])
loop_zobjs("teammate","collide",g_zclass_entities["missile"])
loop_zobjs("teammate","collide",g_zclass_entities["teammate"])
loop_zobjs("teammate","collide",g_zclass_entities["black_hole"])
loop_zobjs("alert_radar","register",g_zclass_entities["planet"])
loop_zobjs("alert_radar","register",g_zclass_entities["asteroid"])
loop_zobjs("alert_radar","register",g_zclass_entities["view"])
loop_zobjs("alert_radar","register",g_zclass_entities["black_hole"])
loop_zobjs("view","collide",g_zclass_entities["black_hole"])
loop_zobjs("view","collide",g_zclass_entities["planet"])
loop_zobjs("view","collide",g_zclass_entities["asteroid"])
loop_zobjs("view","collide",g_zclass_entities["chaser"])
loop_zobjs("view","collide",g_zclass_entities["zipper"])
loop_zobjs("alert_radar","register",g_zclass_entities["chaser"])
loop_zobjs("alert_radar","register",g_zclass_entities["black_hole"])
loop_zobjs("collision_circ","follow_anchoring")
loop_zobjs("mov","mov_update")
loop_zobjs("acc","acc_update")
loop_zobjs("gravity","tug",g_zclass_entities["gravity"])
loop_zobjs("gravity","tug",g_zclass_entities["chaser"])
loop_zobjs("gravity","tug",g_zclass_entities["pl"])
loop_zobjs("gravity","tug",g_zclass_entities["missile"])
loop_zobjs("gravity","tug",g_zclass_entities["asteroid"])
loop_zobjs("vec","vec_update")
loop_zobjs("anchor_pos","update_anchor")
loop_zobjs("model","model_update")
check_level_bounds()
end,function(a)
local ang=rnd(a.max_ang-a.min_ang)+a.min_ang
local x,y=cos(ang)*(LEVEL_RADIUS+7),sin(ang)*(LEVEL_RADIUS+7)
a.spawn_func(x,y,a.target)
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
function scr_wobble_line(x1,y1,x2,y2,color)
wobble_line(zoomx(x1),zoomy(y1),zoomx(x2),zoomy(y2),color)
end
function scr_line(x1,y1,x2,y2,color)
line(zoomx(x1),zoomy(y1),zoomx(x2),zoomy(y2),color)
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
zclass[[drawlayer_03|]]
zclass[[drawlayer_10|]]
zclass[[drawlayer_20|]]
zclass[[drawlayer_30|]]
zclass[[drawlayer_40|]]
zclass[[fader_out,actor|start;duration,@,destroyed,@,update,%fader_out_update]]
zclass[[fader_in,actor|start;duration,@,update,%fader_in_update]]
zclass[[timer|timers;,;start_timer,%timer_start_timer,stop_timer,%timer_stop_timer,play_timer,%timer_play_timer,delete_timer,%timer_delete_timer,get_elapsed,%timer_get_elapsed,get_elapsed_percent,%timer_get_elapsed_percent,tick,%timer_tick,]]
zclass[[pos|x,0,y,0]]
zclass[[vec,pos|dx,0,dy,0,vec_update,%vec_update]]
zclass[[acc,vec|inertia_x,.95,inertia_y,.95,ax,0,ay,0,acc_update,%acc_update]]
zclass[[mov,acc|ang,0,speed,0,d_ang,0,mov_update,%mov_update]]
zclass[[anchor_pos,pos|anchoring;x,0,y,0;update_anchor,%anchor_pos_update_anchor]]
zclass[[collision_circ,vec,actor|anchoring,@,offset_x,@,offset_y,@,radius,@,inertia_x,1,inertia_y,1,follow_anchoring,%collision_follow_anchoring,check_collision,%check_collision,init,%collision_init,]]
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
zclass[[vanishing_shape,vec,actor,drawlayer_10|x,@,y,@,dx,@,dy,@,points,@,color,@,draw,%vanishing_shape_draw;start;duration,.25;]]
zclass[[line_particle,vec,actor,drawlayer_40|ang,@,x,@,y,@,x1,@,y1,@,x2,@,y2,@,color,@,dx,@,dy,@,draw,%line_particle_draw,update,%line_particle_update;start;duration,.5;]]
zclass[[view,model|following,@,model,%VIEW_COLLISION_CIRC,scale,5,zoom_factor,16,init,%view_init,match_following,%view_match_following;start;duration,2,next,run;run;init,nop,update,%view_update;]]
zclass[[missile,model,drawlayer_20|x,@,y,@,dx,@,dy,@,ang,@,model,%MISSILE,speed,0.05,damage,1,inertia_x,1,inertia_y,1,destroyed,%missile_destroyed,hit,%missile_hit;start;duration,2;]]
zclass[[missile_pop,model,drawlayer_20|x,@,y,@,model,%MISSILE_POP,init,%missile_pop_init]]
zclass[[teammate|]]
zclass[[team_red,teammate|]]
zclass[[team_blue,teammate|]]
zclass[[team_none,teammate|]]
zclass[[model_health_bar,model|hit,%model_health_bar_hit,health_bar_min,1,health_color,1]]
zclass[[planet,gravity,model_health_bar,drawlayer_20,team_blue|x,@,y,@,model,@,spawn_delay,4,spawn_rate,4,health_bar_min,1.7,alert_color,11,health_bar_color,5,max_health,75,health,~max_health,explode_sfx,24,destroyed,%planet_destroyed,damage,10000,d_ang,.001;start;duration,~spawn_delay,next,evac;evac;init,%planet_evac,duration,~spawn_rate,next,evac,tug,~gravity_tug;]]
zclass[[asteroid,model_health_bar,drawlayer_20,team_blue|x,@,y,@,model,%ASTEROID,max_health,50,health,~max_health,health_bar_min,1.7,health_bar_color,5,alert_color,13,explode_sfx,27,damage,10000,d_ang,.001;]]
zclass[[zipper,model,drawlayer_20,team_blue|x,@,y,@,ang,@,destroyed,~explode,model,%ZIPPER;start;init,%zipper_init,duration,1,next,zip;zip;init,nop,speed,.05,duration,1;]]
zclass[[chaser,model_health_bar,drawlayer_20,team_red|x,@,y,@,target,@,alert_color,8,health_bar_min,1.2,health_bar_color,5,max_health,5,health,~max_health,explode_sfx,27,damage,25,model,%CHASER,init,%chaser_init,update,%chaser_update,hit,%chaser_hit;]]
zclass[[gravity,model|tug_constant,.0004,gravity_tug,%gravity_tug;]]
zclass[[black_hole,gravity,drawlayer_20|x,@,y,@,alert_color,2,d_ang,.1,damage,10000,tug_constant,.0004,model,%BLACK_HOLE;start;duration,1.5,tug,nop,next,run;run;tug,~gravity_tug;]]
zclass[[twinkle,drawlayer_10|x,@,y,@,twinkle_offset,@,view,@,star_view,@,draw,%twinkle_draw]]
zclass[[star_view,vec|following,@,match_following,%star_view_match_following]]
zclass[[pl,actor,model,drawlayer_20,team_blue|x,@,y,@,missile_ready,yes,model,%PLAYER_SPACESHIP,shoot_percent,1,shoot_enabled,yes,hit,%pl_hit,collision_func,%good_collision_circ;start;duration,1.5,next,run;run;update,%pl_update,]]
zclass[[pl_alert,anchor_pos,actor,drawlayer_30|alert_radar,@,anchoring,@,pointing_to,@,model,%PLAYER_ALERT,update,%pl_alert_update,dist,0,scale,1,destroyed,%pl_alert_destroy,draw,%pl_alert_draw;start;duration,1,next,normal;normal;,;dying;duration,.25,update,nop,next,wait;wait;duration,1,draw,nop]]
zclass[[alert_radar,anchor_pos|alerts;,;anchoring,@,model,%ALERT_RADAR_CIRC,register,%alert_radar_register,update,%alert_radar_update,draw,%pl_alert_draw,]]
zclass[[bar,actor,anchor_pos,drawlayer_03|anchoring,@,percent_func,@,fg,@,initial_rmin,@,initial_rmax,@,timeout,@,rmin,0,rmax,0,draw,%bar_draw,percent,1;start;duration,.1,update,%bar_update_starting,next,run;run;duration,~timeout,next,dying,update,%bar_update;dying;duration,.1,update,%bar_update_dying;]]
function zcircfill(x,y,rad,col)circfill(zoomx(x),zoomy(y),zoom(rad),col)end
zclass[[drawable_model_post,model,drawlayer_40|x,@,y,@,model,@]]
zclass[[drawable_model_post_temp,model,drawlayer_40|x,@,y,@,model,@;start;duration,1.5,next,dying;dying;init,%model_explode;]]
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
function create_level_selector(x,y,level,txt1,txt2,model)
if G_LEVEL==level then
create_text(txt1,x,y-2.5)
create_text(txt2,x,y+2.5)
_g.level_entrance(x,y,model,level,_g.LEVEL_NEXT,9)
elseif G_LEVEL>level then
create_text(txt1,x,y-2.5)
create_text(txt2,x,y+2.5)
_g.level_entrance(x,y,model,level,_g.LEVEL_DONE,11)
end
end
zclass[[level_entrance_outline,model,drawlayer_10|following,@,x,@,y,@,model,@,update,%level_entrance_outline_update]]
zclass[[level_entrance,model,drawlayer_10|x,@,y,@,model,@,next_game_state,@,outline_model,@,alert_color,@,circ_radius,1.5,init,%level_entrance_init,draw,%level_entrance_draw,d_ang,.001,hit,%level_entrance_hit]]
g_fade_table=zobj[[0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,1,1,0,0;2;,2,2,2,2,1,1,0,0;3;,3,3,3,3,1,1,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,1,1,0,0;6;,6,6,13,13,5,5,0,0;7;,7,7,6,13,13,5,0,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,0,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,1,0,0;13;,13,13,5,5,1,1,0,0;14;,14,14,13,4,2,2,0,0;15;,15,15,13,13,5,5,0,0;]]
function fade(threshold)
for c=0,15 do
pal(c,g_fade_table[c][1+flr(7*min(1,max(0,threshold)))])
end
end
SCREEN_SHAKE=false
menuitem(1,"reset save data",function()
memset(0x5e00,0,64)
extcmd"reset"
end)
zclass[[game_state,actor|ecs_exclusions;actor,true;curr,logo;logo;init,%logo_init,update,%logo_update,draw,%logo_draw,duration,2.5,next,level_select;level_select;init,%level_select_init,update,%level_select_update,draw,%level_select_draw;1;init,%level_1_init,update,%level_update,draw,%level_draw;2;init,%level_2_init,update,%level_update,draw,%level_draw;3;init,%level_3_init,update,%level_update,draw,%level_draw;4;init,%level_4_init,update,%level_update,draw,%level_draw;5;init,%level_5_init,update,%level_update,draw,%level_draw;6;init,%level_6_init,update,%level_update,draw,%level_draw;7;init,%level_7_init,update,%level_update,draw,%level_draw;8;init,%level_8_init,update,%level_update,draw,%level_draw;retry;init,%retry_init,update,%retry_update,draw,%retry_draw;win;init,%win_init,update,%win_update,draw,%win_draw;]]
function _init()
memset(0x5e00,0,64)
cartdata"rewob"
G_DEATH_COUNT=dget(4)
G_LEVEL=dget(5)
G_CUR_LEVEL=nil
g_game_state=_g.game_state()
g_fade=0
end
function _update60()
G_SHOULD_PAUSE_BEAT=true
loop_zobjs("actor","clean")
register_zobjs()
loop_zobjs("timer","tick")
loop_zobjs("game_state","state")
dset(4,G_DEATH_COUNT)
inc_level(0)dset(5,G_LEVEL)
sfx(G_SHOULD_PAUSE_BEAT and 62 or-1,2)
end
function _draw()
camera(SCREEN_SHAKE and rnd_one()or 0,SCREEN_SHAKE and rnd_one()or 0)
cls()
fade(g_fade)
loop_zobjs("game_state","draw")
SCREEN_SHAKE=false
end
LEVEL_RADIUS=26
LEVEL_VIEW_RADIUS=LEVEL_RADIUS-2
function check_level_bounds()
if approx_dist(g_pl.x,g_pl.y)>LEVEL_RADIUS and(not CHECK_LEVEL_BOUND_FADER or not CHECK_LEVEL_BOUND_FADER.alive)then
CHECK_LEVEL_BOUND_FADER=_g.fader_out(1,function()
g_game_state:load"level_select"
end)
end
end
zclass[[stats_displayer,drawlayer_40|draw,%stats_displayer_draw]]
zclass[[game_checker,actor|pl,@,update,%game_checker_update]]
function get_wob_text()
return "wob "..G_DEATH_COUNT\1
end
function inc_level(inc)
G_LEVEL=max(1,min((G_LEVEL+inc)\1,9))
end
zclass[[spawner,actor|spawn_func,@,target,@,spawn_delay,@,spawn_rate,@,min_ang,@,max_ang,@;start;duration,~spawn_delay,next,spawn;spawn;init,%spawn_init,duration,~spawn_rate,next,spawn;]]
function level_init_shared(level_num,txt1,txt2,music_index,pl_x,pl_y,zipper_goal)
G_CUR_LEVEL=level_num
music(music_index,1000,7)
clean_all_entities()
g_pl=_g.pl(pl_x,pl_y)
g_view=_g.view(g_pl)
local star_view=_g.star_view(g_pl)
for i=1,50 do
_g.twinkle(rnd(256),rnd(256),rnd(),g_view,star_view)
end
create_text(txt1,pl_x,pl_y-3,_g.drawable_model_post_temp)
_g.drawable_model_post_temp(pl_x,pl_y,_g.STARTING_CIRCLE,1)
create_text(txt2,pl_x,pl_y+3,_g.drawable_model_post_temp)
_g.fader_in(1)
_g.alert_radar(g_pl)
g_zipper_count=0
g_zipper_goal=zipper_goal
_g.game_checker(g_pl)
_g.stats_displayer()
end