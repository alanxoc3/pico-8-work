g_act_arrs={}
function create_parent_actor_shared(is_create_parent,meta_and_att_str,...)
local meta,template=unpack(split(meta_and_att_str,"|"))
local template_params,id,provided,parents,pause_funcs={...},unpack(ztable(meta))
_g[id]=function(...)
local func_params,params,a={...},tabcpy(template_params),{}
if is_create_parent then
a=deli(func_params,1)
end
for i=1,provided do
add(params,func_params[i]or false,i)
end
if not a[id]then
foreach(parents,function(par)
if type(par)~="table"then
par={par}
end
a=_g[par[1]](a,unpack(par,2))
end)
tabcpy(ztable(template,unpack(params)),a)
if not a[id]then
g_act_arrs[id]=g_act_arrs[id]or{}
add(g_act_arrs[id],a)
end
a.id,a[id],a.pause=id,true,a.pause or{}
foreach(pause_funcs,function(f)
a.pause[f]=true
end)
end
call_not_nil(a,"create_init",a)
return a
end
end
function create_parent(...)create_parent_actor_shared(true,...)end
function create_actor(...)create_parent_actor_shared(false,...)end
function acts_loop(id,func_name,...)
for a in all(g_act_arrs[id])do
call_not_nil(a,func_name,a,...)
end
end
function zsfx(num,sub_num)
sfx(num,-1,sub_num*4,4)
end
function btn_helper(f,a,b)
return f(a)and f(b)and 0 or f(a)and 0xffff or f(b)and 1 or 0
end
function _g.plus(a,b)return a+b end
function _g.minus(a,b)return a-b end
function bool_to_num(condition)return condition and 0xffff or 1 end
function get(a,...)
local arr,cur_act=ztable(...),a or{}
for i=1,#arr do
cur_act=cur_act[arr[i]]
if not cur_act then
break
end
end
return cur_act
end
function approx_dist(dx,dy)
local maskx,masky=dx>>31,dy>>31
local a0,b0=(dx+maskx)^^maskx,(dy+masky)^^masky
if a0>b0 then
return a0*0.9609+b0*0.3984
end
return b0*0.9609+a0*0.3984
end
function xbtn()return btn_helper(btn,0,1)end
function ybtn()return btn_helper(btn,2,3)end
function xbtnp()return btn_helper(btnp,0,1)end
function ybtnp()return btn_helper(btnp,2,3)end
function zsgn(num)return num==0 and 0 or sgn(num)end
function round(num)return flr(num+.5)end
function rnd_one(val)return(flr_rnd"3"-1)*(val or 1)end
function ti(period,length)
return t()%period<length
end
function flr_rnd(x)
return flr(rnd(x))
end
function rnd_item(list)
return list[flr_rnd(#list)+1]
end
function tabcpy(src,dest)
dest=dest or{}
for k,v in pairs(src or{})do
if type(v)=="table"and not v.is_tabcpy_disabled then
dest[k]=tabcpy(v)
else
dest[k]=v
end
end
return dest
end
function call_not_nil(table,key,...)
if table and table[key]then
return table[key](...)
end
end
function batch_call_table(func,tbl)
foreach(tbl,function(t)func(unpack(t))end)
end
function batch_call_new(func,...)
batch_call_table(func,ztable(...))
end
function tl_node(a)
a.tl_cur=a.tl_cur or 1
if not a.tl_continued then
a.next=function()
if a.tl_loop then
a.tl_next=(a.tl_cur%#a)+1
else
a.tl_next=a.tl_cur+1
end
end
a.tl_tim,a.tl_max_time,a.tl_continued=0,nil,true
tabcpy(a[a.tl_cur]or{},a)
call_not_nil(a,"i",a)
end
if call_not_nil(a,"u",a)then a:next()end
a.tl_tim+=1/60
if a.tl_max_time and a.tl_tim>=a.tl_max_time then
a:next()
end
if a.tl_next then
local old_tl_next=a.tl_next
a.tl_cur,a.tl_continued,a.tl_next=old_tl_next,nil,nil
call_not_nil(a,"e",a)
return old_tl_next>#a or old_tl_next<1
end
end
function isorty(t)
if t then
for n=2,#t do
local i=n
while i>1 and t[i].y<t[i-1].y do
t[i],t[i-1]=t[i-1],t[i]
i=i-1
end
end
end
end
function coll_tile_help(pos,per,spd,pos_rad,per_rad,dir,a,hit_func,solid_func)
local coll_tile_bounds=function(pos,rad)
return flr(pos-rad),-flr(-(pos+rad))-1
end
local pos_min,pos_max=coll_tile_bounds(pos+spd,pos_rad)
local per_min,per_max=coll_tile_bounds(per,per_rad)
for j=per_min,per_max do
if spd<0 and solid_func(pos_min,j)then
hit_func(a,dir)
return pos_min+pos_rad+1,0
elseif spd>0 and solid_func(pos_max,j)then
hit_func(a,dir+1)
return pos_max-pos_rad,0
end
end
return pos,spd
end
g_gunvals=split("0x8000,0x8000,0x7fff,0x7fff,@1|!plus/@1/-2,!plus/@2/-2,!plus/@3/2,!plus/@4/2,13;!plus/@1/-1,!plus/@2/-1,!plus/@3/1,!plus/@4/1,1;|0,0,0,0,0,0,0;1,1,1,0,0,0,0;2,2,2,1,0,0,0;3,3,3,1,0,0,0;4,2,2,2,1,0,0;5,5,1,1,1,0,0;6,13,13,5,5,1,0;7,6,13,13,5,1,0;8,8,2,2,2,0,0;9,4,4,4,5,0,0;10,9,4,4,5,5,0;11,3,3,3,3,0,0;12,12,3,1,1,1,0;13,5,5,1,1,1,0;14,13,4,2,2,1,0;15,13,13,5,5,1,0;|fader_out;3;act,;update,|fade_time:@1;i:@2;e:@3;u:@4;tl_max_time=@1,|fader_in;3;act,;update,|timer;0;,;|timers:,;tick:@1;create_timer:@2;any_timer_active:@3;get_timer_percent:@4;|act;0;timer,;room_init,kill,clean,delete|update:@1;clean:@2;kill:@3;delete:@4;get:@5;alive:yes;i:nf;u:nf;room_init:nf;destroyed:nf;|ma_able;0;act,;|name:thing;|confined;0;act,;room_end,|room_end:nf;|loopable;0;act,;|tl_loop:yes;|pos;0;act,;|x:0;y:0;|knock;0;col,;|;|popper;0;col,;|good_character;0;col,hurtable;|bad_character;0;col,hurtable;|good_attack;0;col,;|hit:@1;|bad_attack;0;col,;|hit:@1;kill_when_hit:no;|x_bounded;0;dim,;|check_bounds_x:@1;|y_bounded;0;dim,;|check_bounds_y:@1;|vec;0;pos,;|dx:0;dy:0;vec_update:@1;|mov;0;vec,;|inertia_x:.90;inertia_y:.90;ax:0;ay:0;mov_update:@1;stop:@2;|dim;0;pos,;|rx:.375;ry:.375;|dim;0;pos,;debug_rect,|rx:.375;ry:.375;debug_rect:@1;|rel;0;act,;rel_update,|rel_actor:null;rel_x:0;rel_y:0;rel_dx:0;rel_dy:0;flippable:no;rel_update:@1;|drawable_obj;0;pos,;reset_off,|ixx:0;iyy:0;xx:0;yy:0;visible:yes;reset_off:@1;|drawable;0;drawable_obj,;d,|d:nf;|drawable_1;0;drawable_obj,;d,|drawable_2;0;drawable_obj,;d,|pre_drawable;0;drawable_obj,;d,|pre_drawable_1;0;drawable_obj,;d,|pre_drawable_2;0;drawable_obj,;d,|post_drawable;0;drawable_obj,;d,|post_drawable_1;0;drawable_obj,;d,|post_drawable_2;0;drawable_obj,;d,|above_map_drawable;0;drawable_obj,;d,|above_map_drawable_1;0;drawable_obj,;d,|spr_obj;0;vec,drawable_obj,;|sind:0;outline_color:BG_UI;sw:1;sh:1;xf:no;yf:no;|spr;0;spr_obj,;|d:@1;|knockbackable;0;mov,timer,;|knockback:@1;apply_knockback:@2;knockback_speed:0;knockback_dir:0;|hurtable;0;act,;|health:1;max_health:1;hurt_cooldown_time:60;hurt_start:nf;hurt_end:nf;damage:nf;hurt:@1;heal:@2;|anchored;1;vec,dim;|touchable:@1;hit:nf;|col;0;vec,dim;|touchable:yes;hit:nf;move_check:@1;|dx:0;dy:0|x,dx,@1,@2,@3,@4;y,dy,@1,@2,@5,@6;|tcol;0;vec,dim;|tile_solid:yes;tile_hit:nf;coll_tile:@1;|view;4;act,confined;center_view,update_view|x:0;y:0;room_crop:2;tl_loop:yes;w:@1;h:@2;follow_dim:@3;follow_act:@4;update_view:@5;center_view:@6;change_ma:@7;,;|@1,x,w,ixx;@1,y,h,iyy|deadbody_parent;0;confined,pre_drawable|d:@1;i:@2;touchable:no;rx:.25;ry:.5;sind:0;|deadbody_nobleed;4;deadbody_parent,|x:@1;y:@2;xf:@3;sind:@4;touchable:no;rx:.25;ry:.5;|deadbody;4;deadbody_parent,|x:@1;y:@2;xf:@3;sind:@4;i:@5;u:@6;touchable:no;rx:.25;ry:.5;|nurse_weapon;3;col,confined,rel,bad_attack|rel_actor:@1;x:@2;y:@3;i:@4;touchable:no;rx:.5;ry:1;tl_max_time=.16,;|bad_nurse;3;drawable,col,confined,mov,x_bounded,y_bounded,knockbackable,hurtable,spr_obj,bad_character,tcol|x:@1;y:@2;enemy_id:@3;u:@4;damage:@5;destroyed:@6;d:%nurse_draw;health:%c_enemy_health;max_health:%c_enemy_health;sh:2;iyy:-5;rx:.375;ry:.375;touchable:no;|nurse;3;drawable,col,confined,mov,x_bounded,y_bounded,spr_obj,tcol|x:@1;y:@2;enemy_id:@3;u:@4;d:%nurse_draw;sh:2;iyy:-5;rx:.375;ry:.375;touchable:no;|particle_parent;0;confined,mov,;|draw_small_circle:@1;draw_medium_circle:@2;move_up:@3;move_slow:@4;|powerup_particle;3;pre_drawable_2,particle_parent|x:@1;y:@2;color:@3;d:$draw_small_circle;i:$move_up;tl_max_time=.25,;|slow_small_ui_particle;3;above_map_drawable,particle_parent|x:@1;y:@2;color:@3;d:$draw_small_circle;i:$move_slow;tl_max_time=.25,;|slow_medium_ui_particle;3;above_map_drawable,particle_parent|x:@1;y:@2;color:@3;d:$draw_medium_circle;i:$move_slow;tl_max_time=.25,;|particle_spawner;5;dim,confined|color:8;rx:@1;ry:@2;rate:@3;chance:@4;create_func:@5;update_particles:@6;|patient_weapon;3;col,confined,rel,bad_attack|rel_actor:@1;x:@2;y:@3;i:@4;touchable:no;rx:.75;ry:.75;tl_max_time=.5,;|bad_patient;3;drawable,col,confined,mov,x_bounded,y_bounded,knockbackable,hurtable,spr_obj,bad_character,tcol|x:@1;y:@2;enemy_id:@3;u:@4;damage:@5;destroyed:@6;d:%patient_draw;health:%c_enemy_health;max_health:%c_enemy_health;sh:2;iyy:-5;rx:.375;ry:.375;touchable:no;|patient;3;drawable,col,confined,mov,x_bounded,y_bounded,spr_obj,tcol|x:@1;y:@2;enemy_id:@3;u:@4;d:@5;sind:41;sh:2;iyy:-5;rx:.375;ry:.375;touchable:no;|fist_parent;0;col,confined,rel|i:@1;touchable:no;rx:.375;ry:.75;tl_max_time=.33,;|good_fist;3;fist_parent,good_attack|rel_actor:@1;x:@2;y:@3;|bad_fist;3;fist_parent,bad_attack|pl;1;drawable,pos,confined,mov,x_bounded,y_bounded,col,spr_obj,knockbackable,hurtable,tcol;|passive_mode:@1;create_dead_body:@2;destroyed:@2;d:@3;strength:1;dir:0;is_facing_left:yes;xf:yes;health:%c_pl_health;max_health:%c_pl_health;damage:nf;increment_insanity:nf;decrement_insanity:nf;set_insanity:nf;sh:2;iyy:-5;|pl_monster;0;pl/no,|damage:@1;hurt_start:@2;increment_insanity:@3;decrement_insanity:@4;set_insanity:@5;insane_level:0;|pl_patient;0;pl/yes,|damage:@1;|police_weapon;3;col,vec,confined,rel,bad_attack,post_drawable|x:@1;y:@2;dx:@3;d:@4;kill_when_hit:yes;touchable:no;rx:.375;ry:.25;iyy:-6;tl_max_time=1,;|bad_police;3;drawable,col,confined,mov,x_bounded,y_bounded,knockbackable,hurtable,spr_obj,bad_character,tcol|x:@1;y:@2;enemy_id:@3;u:@4;damage:@5;destroyed:@6;d:@7;d:%police_draw;health:%c_enemy_health;max_health:%c_enemy_health;sh:2;iyy:-5;rx:.375;ry:.375;touchable:no;|police;3;drawable,col,confined,mov,x_bounded,y_bounded,spr_obj,tcol|x:@1;y:@2;enemy_id:@3;u:@4;d:@5;sind:224;sh:2;iyy:-5;rx:.375;ry:.375;touchable:no;|heart_particle_spawner;3;particle_spawner/.125/.125/1/3/%slow_small_ui_particle,above_map_drawable_1|x:@1;y:@2;heart_number:@3;u:@4;d:@5;color:8;|powerup_particle_spawner;5;particle_spawner/2/.125/1/1/%slow_medium_ui_particle,above_map_drawable_1|x:@1;y:@2;powerup_level:@3;color:@4;sind:@5;u:@6;d:@7|genocide_tip;2;above_map_drawable,confined|x:@1;y:@2;d:@3;when_to_show_tip:%c_when_to_show_tip;|objective_arrow;2;post_drawable_2,confined|x:@1;y:@2;u:@3;d:@4;ry:.25;radius:.2;touchable:no;smallest_dist:0;|portal;2;col,pre_drawable,confined|x:@1;y:@2;u:@3;d:@4;rx:.125;ry:.125;radius:.2;touchable:no;|pl_control;0;col,|hit:@1;teleporting:no;|pl_patient_control_fight;2;pl_patient,good_character,pl_control|x:@1;y:@2;u:@3;destroyed:@4;|pl_patient_control_passive;2;pl_patient,good_character,pl_control|pl_monster_control;2;pl_monster,good_character,pl_control|pl_monster_cpu;3;pl_monster,bad_character|touchable:no;x:@1;y:@2;enemy_id:@3;i:@4;u:@5;destroyed:@6;;|x=4,y=28,dungeon=%bad_nurse,hospital=%nurse,alive=yes;x=14,y=26,dungeon=%bad_nurse,hospital=%nurse,alive=yes;x=45,y=28,dungeon=%bad_nurse,hospital=%nurse,alive=yes;x=53,y=9,dungeon=%bad_nurse,hospital=%nurse,alive=yes;x=70,y=13,dungeon=%bad_nurse,hospital=%nurse,alive=yes;x=60,y=15,dungeon=%bad_nurse,hospital=%nurse,alive=yes;x=48,y=3,dungeon=%bad_nurse,hospital=%nurse,alive=yes;x=81,y=4,dungeon=%bad_nurse,hospital=%nurse,alive=yes;x=81,y=15,dungeon=%bad_nurse,hospital=%nurse,alive=yes;x=18,y=13,dungeon=%bad_nurse,hospital=%nurse,alive=yes;x=102,y=4,dungeon=%bad_nurse,hospital=%nurse,alive=yes;x=89,y=15,dungeon=%bad_patient,hospital=%patient,alive=yes;x=91,y=20,dungeon=%bad_police,hospital=%police,alive=yes;|x=120,y=12,bossroom=%pl_monster_cpu,alive=yes;|confined,room_end;confined,kill;confined,delete;|name:dungeon;x:0;y:0;w:108;h:32;|name:hospital;x:0;y:0;w:108;h:32;|name:bossroom;x:108;y:0;w:20;h:32;|timer,tick;act,update;act,clean;|timer,tick;act,update;mov,mov_update;good_character,move_check,@1;bad_character,move_check,@1;good_attack,move_check,@2;bad_attack,move_check,@3;pl_control,move_check,@4;tcol,coll_tile,@5;rel,rel_update;vec,vec_update;x_bounded,check_bounds_x;y_bounded,check_bounds_y;view,update_view;act,clean;|pre_drawable,d;pre_drawable_1,d;pre_drawable_2,d;|drawable,d;drawable_1,d;drawable_2,d;post_drawable,d;post_drawable_1,d;post_drawable_2,d;|above_map_drawable,d;above_map_drawable_1,d;|x=64,y=64,i=@2,u=nf,d=@1,tl_max_time=2.5;i=@3,u=@4,d=@5;i=@6,u=@7,d=@8;i=@9,u=@10,d=@11;|","|")
g_ztable_cache={}
function nf()end
function ztable(original_str,...)
local str=g_gunvals[0+original_str]
local tbl,ops=unpack(g_ztable_cache[str]or{})
if not tbl then
tbl,ops={},{}
for item in all(split(str,";"))do
local k,v=split_kv(item,":",tbl)
local val_func=function(sub_val,sub_key,sub_tbl)
return queue_operation(sub_tbl or tbl,sub_key or k,sub_val,ops)
end
local ret_val,items={},split(v,",")
for item in all(items)do
local k,v=split_kv(item,"=",ret_val)
if #items==1 then
ret_val=val_func(v)
else
ret_val[k]=val_func(v,k,ret_val)
end
end
tbl[k]=ret_val
end
g_ztable_cache[str]={tbl,ops}
end
local params={...}
foreach(params,disable_tabcpy)
foreach(ops,function(op)
local t,k,f=unpack(op)
t[k]=f(params)
end)
return tbl
end
function split_kv(list,delim,tbl)
local kvs=split(list,delim)
return kvs[#kvs-1]or #tbl+1,kvs[#kvs]
end
function queue_operation(tbl,k,v,ops)
local vlist=split(v,"/")
local will_be_table,func_op,func_name=#vlist>1
if ord(v)==33 then
will_be_table,func_name=true,deli(vlist,1)
func_op={
tbl,k,function()
return _g[sub(func_name,2)](unpack(vlist))
end
}
end
for i,x in ipairs(vlist)do
local rest,closure_tbl=sub(x,2),tbl
if will_be_table then
closure_tbl,k=vlist,i
end
if ord(x)==64 then
add(ops,{
closure_tbl,k,function(p)
return p[rest+0]
end
})
elseif ord(x)==36 then
x=function(a,...)
a[rest](a,...)
end
elseif ord(x)==37 then
x=_g[rest]
elseif ord(x)==126 then
add(ops,{
closure_tbl,k,function()
return tbl[rest]
end
})
elseif x=="yes"or x=="no"then x=x=="yes"
elseif x=="null"or x==""then x=nil
elseif x=="nf"then x=function()end
end
vlist[i]=x
end
add(ops,func_op)
if will_be_table then
return vlist
else
return vlist[1]
end
end
function disable_tabcpy(t)
if type(t)=="table"then
t.is_tabcpy_disabled=true
end
return t
end
function zspr(sind,x,y,sw,sh,...)
sw,sh=sw or 1,sh or 1
spr(sind,x-sw*4,y-sh*4,sw,sh,...)
end
function zprint(str,x,y,color,align)
if align==0 then x-=#str*2
elseif align>0 then x-=#str*4+1 end
print(str,x,y,color)
end
function zclip(x1,y1,x2,y2)
clip(x1,y1,x2+1-flr(x1),y2+1-flr(y1))
end
function zcls(col)
batch_call_new(rectfill,[[1]],col or 0)
end
function zrect(x1,y1,x2,y2)
batch_call_new(rect,
[[2]],x1,y1,x2,y2)
end
function scr_spr(a,spr_func,...)
if a and a.visible then
(spr_func or zspr)(a.sind,a.x*8+a.ixx+a.xx,a.y*8+a.iyy+a.yy,a.sw,a.sh,a.xf,a.yf,...)
end
end
function outline_helper(flip,coord,dim)
coord=coord-dim*4
if flip then
return dim*8-1+coord,-1
else
return coord,1
end
end
g_fadetable=ztable[[3]]
function fade(i)
for c=0,15 do
pal(c,g_fadetable[c+1][min(flr(i+1),7)])
end
end
create_actor([[4|5]],function(a)
g_card_fade=max(a.tl_tim/a.tl_max_time*10,g_card_fade)
end)
create_actor([[6|5]],function(a)
g_card_fade=min((a.tl_max_time-a.tl_tim)/a.tl_max_time*10,g_card_fade)
end)
create_parent([[7|8]],function(a)
local keys_to_remove={}
for k,v in pairs(a.timers)do
v.t+=1
if v.t>v.limit then
add(keys_to_remove,k)
end
end
for k in all(keys_to_remove)do
local v=a.timers[k]
a.timers[k]=nil
v.callback(a)
end
end,function(a,timer_name,limit,callback)
a.timers[timer_name]={t=0,limit=limit,callback=(callback or nf)}
end,function(a,...)
for timer_name in all{...}do
if a.timers[timer_name]~=nil then
return true
end
end
return false
end,function(a,timer_name)
local timer=a.timers[timer_name]
return timer and(timer.t/timer.limit)or 1
end)
create_parent([[9|10]],function(a)
if a.alive and tl_node(a)then
a.alive=false
end
end,function(a)
if not a.alive then
a:destroyed()
a:delete()
end
end,function(a)
a.alive=nil
end,function(a)
for k,v in pairs(g_act_arrs)do
if a[k]then del(v,a)end
end
end,get)
create_parent[[11|12]]
create_parent[[13|14]]
create_parent[[15|16]]
create_parent[[17|18]]
create_parent[[19|20]]
create_parent[[21|20]]
create_parent[[22|20]]
create_parent[[23|20]]
create_parent([[24|25]],function(a,other)
if other.bad_character then
other:damage(a)
end
end)
create_parent([[26|27]],function(a,other)
if other.good_character then
other:damage(a)
end
if a.kill_when_hit then
a:kill()
end
end)
create_parent([[28|29]],function(a)
if a.x+a.dx<g_room.x+a.rx then
a.x=g_room.x+a.rx
a.dx=0
end
if a.x+a.dx>g_room.x+g_room.w-a.rx then
a.x=g_room.x+g_room.w-a.rx
a.dx=0
end
end)
create_parent([[30|31]],function(a)
if a.y+a.dy<g_room.y+a.ry then
a.y=g_room.y+a.ry
a.dy=0
end
if a.y+a.dy>g_room.y+g_room.h-a.ry then
a.y=g_room.y+g_room.h-a.ry
a.dy=0
end
end)
create_parent([[32|33]],function(a)
a.x+=a.dx
a.y+=a.dy
end)
create_parent([[34|35]],function(a)
a.dx+=a.ax a.dy+=a.ay
a.dx*=a.inertia_x a.dy*=a.inertia_y
if a.ax==0 and abs(a.dx)<.01 then a.dx=0 end
if a.ay==0 and abs(a.dy)<.01 then a.dy=0 end
end,function(a)
a.ax,a.ay,a.dx,a.dy=0,0,0,0
end)
create_parent[[36|37]]
create_parent([[38|39]],function(a)
scr_rect(a.x-a.rx,a.y-a.ry,a.x+a.rx,a.y+a.ry,8)
end)
create_parent([[40|41]],function(a)
local a2=a.rel_actor
if a2 then
if a2.alive then
a.x,a.y=a2.x+a.rel_x,a2.y+a.rel_y
a.dx,a.dy=a2.dx+a.rel_dx,a2.dy+a.rel_dy
a.rel_x+=a.rel_dx
a.rel_y+=a.rel_dy
a.xx,a.yy=a2.xx,a2.yy
if a.flippable then
a.xf=a2.xf
end
else
a.alive=false
end
end
end)
create_parent([[42|43]],function(a)
a.xx,a.yy=0,0
end)
create_parent[[44|45]]
create_parent[[46|45]]
create_parent[[47|45]]
create_parent[[48|45]]
create_parent[[49|45]]
create_parent[[50|45]]
create_parent[[51|45]]
create_parent[[52|45]]
create_parent[[53|45]]
create_parent[[54|45]]
create_parent[[55|45]]
create_parent[[56|57]]
create_parent([[58|59]],scr_spr)
create_parent([[60|61]],function(a,direction)
if not a:any_timer_active("knockback")then
a.knockback_speed=.075
a.knockback_dir=direction
a:create_timer("knockback",4)
end
end,function(a)
a.ax=cos(a.knockback_dir)*a.knockback_speed
a.ay=sin(a.knockback_dir)*a.knockback_speed
end)
create_parent([[62|63]],function(a,damage)
damage=damage or 1
if not a:any_timer_active("hurt_cooldown")then
a.health=max(0,a.health-damage)
if a.health==0 then
a.alive=false
return
end
a:create_timer("hurt_cooldown",a.hurt_cooldown_time,a.hurt_end)
a:hurt_start()
end
end,function(a,health)
a.health=min(a.max_health,a.health+health)
end)
create_parent[[64|65]]
create_parent([[66|67]],function(a,acts)
local hit_list={}
local move_check=function(dx,dy)
local ret_val=dx+dy
local col_help=function(axis,spd_axis,a,b,pos,spd)
if spd!=0 and pos<abs(a[axis]-b[axis])then
if a.touchable and b.touchable then
local s_f=function(c)
if not c.anchored then
c[spd_axis]=(a[spd_axis]+b[spd_axis])/2
end
end
s_f(a)s_f(b)
ret_val=0
end
hit_list[b][spd_axis]=zsgn(spd)
end
end
foreach(acts,function(b)
if a!=b and(not a.anchored or not b.anchored)then
local x,y=abs(a.x+dx-b.x),abs(a.y+dy-b.y)
if x<a.rx+b.rx and y<a.ry+b.ry then
hit_list[b]=hit_list[b]or ztable[[68]]
batch_call_new(col_help,[[69]],a,b,x,dx,y,dy)
end
end
end)
return ret_val
end
a.dx,a.dy=move_check(a.dx,0),move_check(0,a.dy)
for b,d in pairs(hit_list)do
a:hit(b,d.dx,d.dy)
end
end)
create_parent([[70|71]],function(a,solid_func)
local x,dx=coll_tile_help(a.x,a.y,a.dx,a.rx,a.ry,0,a,a.tile_hit,solid_func)
local y,dy=coll_tile_help(a.y,a.x,a.dy,a.ry,a.rx,2,a,a.tile_hit,function(y,x)return solid_func(x,y)end)
if a.tile_solid then
a.x,a.y,a.dx,a.dy=x,y,dx,dy
end
end)
function update_view_helper(view,xy,wh,ii)
if not view.follow_act then return end
local follow_coord=view.follow_act[xy]
local view_coord=view[xy]
local view_dim=view[wh]
local room_dim=g_room[wh]/2-view_dim/2
local room_coord=g_room[xy]+g_room[wh]/2
local follow_dim=round(view.follow_dim*(view_dim/2))/8
if follow_coord<view_coord-follow_dim then view_coord=follow_coord+follow_dim end
if follow_coord>view_coord+follow_dim then view_coord=follow_coord-follow_dim end
if view_coord<room_coord-room_dim then view_coord=room_coord-room_dim end
if view_coord>room_coord+room_dim then view_coord=room_coord+room_dim end
if g_room[wh]<=view[wh]then view_coord=room_coord end
view[xy]=view_coord
end
function scr_pset(x,y,c)
pset(x*8,y*8,c)
end
function scr_line(x1,y1,x2,y2,col)
line(x1*8,y1*8,x2*8,y2*8,col)
end
function scr_rect(x1,y1,x2,y2,col)
rect(x1*8,y1*8,x2*8-1,y2*8-1,col)
end
function scr_rectfill(x1,y1,x2,y2,col)
rectfill(x1*8,y1*8,x2*8,y2*8,col)
end
function scr_oval(x1,y1,x2,y2,col)
oval(x1*8,y1*8,x2*8,y2*8,col)
end
function scr_ovalfill(x1,y1,x2,y2,col)
ovalfill(x1*8,y1*8,x2*8,y2*8,col)
end
function scr_map(cel_x,cel_y,sx,sy,...)
map(cel_x,cel_y,sx*8,sy*8,...)
end
function scr_circfill(x,y,r,col)
circfill(x*8,y*8,r*8,col)
end
function scr_circ(x,y,r,col)
circ(x*8,y*8,r*8,col)
end
create_actor([[72|73]],
function(a)
if a.follow_act and not a.follow_act.alive then
a.follow_act=nil
end
batch_call_new(update_view_helper,[[74]],a)
end,function(a)
if a.follow_act then
a.x,a.y=a.follow_act.x,a.follow_act.y
a.name=a.follow_act.name
end
a:update_view()
end,function(a,other)
if not other or other.ma_able then
a.follow_act=other
end
end)
create_actor([[75|76]],function(a)
local sind=a.sind
if g_room.name=="hospital"then sind+=16 end
zspr(sind,a.x*8+a.xx,a.y*8+a.yy,2,1,a.xf,false)
end)
create_actor[[77|78]]
create_actor([[79|80]],function(a)
a:create_timer("bleeding",30)
end,function(a)
if a:any_timer_active"bleeding"then
_g.powerup_particle(a.x,a.y,_g.c_color_blood)
a.xx=flr_rnd(3)-2
a.yy=flr_rnd(3)-2
end
end)
function create_cached_deadbody(enemy_id,...)
add(_g.all_deadbody_templates[g_room.name],{...})
_g.all_enemy_templates[g_room.name][enemy_id].alive=false
_g.deadbody(...)
end
function _g.nurse_draw(a)
a.sind=66
if a:any_timer_active"prepare"then
a.sind=69
elseif a:any_timer_active"attack"then
a.sind=70
if a:get_timer_percent"attack">.50 then
a.sind=71
end
elseif abs(a.dx)>.005 or abs(a.dy)>.005 then
local loop=a.tl_tim%.5/.5
if loop<.25 then a.sind=66
elseif loop<.5 then a.sind=67
elseif loop<.75 then a.sind=66
else a.sind=68
end
end
if g_room.name=="hospital"then
a.sind+=32
end
scr_spr(a)
end
create_actor([[81|82]],function(a)
a.rel_dx=zsgn(cos(a.rel_actor.dir))*.05
end)
create_actor([[83|84]],function(a)
if not a:any_timer_active("cooldown","walk","prepare","attack")then
a.dir=atan2(g_pl.x-a.x,g_pl.y-a.y)+rnd(.125)-.125/2
a:create_timer("walk",flr_rnd(10)+30,function()
a:create_timer("cooldown",flr_rnd(120),function()
a:create_timer("prepare",40,function()
_g.nurse_weapon(a,a.x,a.y)
a:create_timer("attack",10)
end)
end)
end)
end
if a:any_timer_active"hurt_cooldown"then
_g.powerup_particle(a.x,a.y+.5,_g.c_color_blood)
end
if a:any_timer_active"knockback"then
a:apply_knockback()
elseif a:any_timer_active"walk"then
a.ax=cos(a.dir)*.01
if a.ax>0 then
a.xf=false
elseif a.ax<0 then
a.xf=true
end
a.ay=sin(a.dir)*.01
else
a.ax=0
a.ay=0
end
end,function(a,other)
if other.rel_actor then
other.rel_actor:knockback(atan2(g_pl.x-a.x,g_pl.y-a.y))
if not a:any_timer_active"hurt_cooldown"then
call_not_nil(other.rel_actor,"increment_insanity",other.rel_actor)
end
end
a:hurt(g_pl.strength)
a:knockback(atan2(a.x-other.x,a.y-other.y))
end,function(a)
create_cached_deadbody(a.enemy_id,a.x,a.y,a.xf,96)
end)
create_actor([[85|86]],function(a)
if not a:any_timer_active("cooldown","walk")then
a.dir=atan2(g_pl.x-a.x,g_pl.y-a.y)+rnd(.125)-.125/2
a:create_timer("walk",flr_rnd(10)+30,function()
a:create_timer("cooldown",flr_rnd(120)+50)
end)
end
if a:any_timer_active"walk"then
a.ax=cos(a.dir)*.01
if a.ax>0 then
a.xf=false
elseif a.ax<0 then
a.xf=true
end
a.ay=sin(a.dir)*.01
else
a.ax=0
a.ay=0
end
end)
create_parent([[87|88]],function(a)
scr_circfill(a.x,a.y,.125,a.color)
end,function(a)
scr_circfill(a.x,a.y,.375,a.color)
end,function(a)
a.dx=rnd(.2)-.1
a.dy=-rnd(.2)-.1
end,function(a)
a.dx=rnd(.05)-.025
a.dy=rnd(.05)-.025
end)
create_actor[[89|90]]
create_actor[[91|92]]
create_actor[[93|94]]
create_parent([[95|96]],function(a)
for i=1,a.rate do
if flr_rnd(a.chance)==0 then
a.create_func(
a.x+rnd(a.rx*2)-a.rx,
a.y+rnd(a.ry*2)-a.ry,
a.color
)
end
end
end)
function _g.patient_draw(a)
a.sind=9
if a:any_timer_active"prepare"then
a.sind=10
elseif a:any_timer_active"charge"then
local percent=a:get_timer_percent"charge"
if percent<.2 then a.sind=11
elseif percent<.4 then a.sind=12
elseif percent<.75 then a.sind=13
else a.sind=10
end
end
if g_room.name=="hospital"then
a.sind+=32
end
scr_spr(a)
end
create_actor([[97|98]])
create_actor([[99|100]],function(a)
if not a:any_timer_active("cooldown","charge","prepare","attack")then
a.dir=atan2(g_pl.x-a.x,g_pl.y-a.y)+rnd(.125)-.125/2
_g.patient_weapon(a,a.x,a.y)
a:create_timer("charge",20,function()
a:create_timer("cooldown",flr_rnd(60)+60,function()
a:create_timer("prepare",60)
end)
end)
end
if a:any_timer_active"hurt_cooldown"then
_g.powerup_particle(a.x,a.y+.5,_g.c_color_blood)
end
if a:any_timer_active"knockback"then
a:apply_knockback()
elseif a:any_timer_active"charge"then
a.ax=cos(a.dir)*.03
a.ay=sin(a.dir)*.03
if a.ax>0 then
a.xf=false
elseif a.ax<0 then
a.xf=true
end
else
if abs(a.dx)<.01 then
a.xf=a.x-g_pl.x>0
end
a.ax=0
a.ay=0
end
end,function(a,other)
if other.rel_actor then
other.rel_actor:knockback(atan2(g_pl.x-a.x,g_pl.y-a.y))
if not a:any_timer_active"hurt_cooldown"then
call_not_nil(other.rel_actor,"increment_insanity",other.rel_actor)
end
end
a:hurt(g_pl.strength)
a:knockback(atan2(a.x-other.x,a.y-other.y))
end,function(a)
create_cached_deadbody(a.enemy_id,a.x,a.y,a.xf,14)
end)
create_actor([[101|102]],function(a)
a.xf=a.x-g_pl.x>0
if t()%5<.5 then
a.ixx=flr_rnd(3)-1
a.sind=rnd_item{41,42,43}
else
a.ixx=0
end
end,scr_spr)
create_parent([[103|104]],function(a)
a.rel_dx=cos(a.rel_actor.dir)*.03
a.rel_dy=sin(a.rel_actor.dir)*.03
end)
create_actor[[105|106]]
create_actor[[107|106]]
create_parent([[108|109]],function(a)
local sind=a.passive_mode and 80 or 64
if a.bad_character then
create_cached_deadbody(a.enemy_id,a.x,a.y,a.xf,sind)
else
_g.deadbody(a.x,a.y,a.xf,sind)
end
end,function(a)
a.sind=134
a.yy=0
if a:any_timer_active"punch"then
local percent=a:get_timer_percent"punch"
if percent>=.90 then a.sind=133
elseif percent>=.80 then a.sind=132
elseif percent>=.50 then a.sind=131
elseif percent>=.30 then a.sind=130
elseif percent>=.10 then a.sind=129
else a.sind=128
end
a.yy=sin(percent/2)*5
elseif a:any_timer_active"roll"then
local percent=a:get_timer_percent"roll"
if percent>=.90 then a.sind=140
elseif percent>=.80 then a.sind=139
elseif percent>=.50 then a.sind=138
elseif percent>=.30 then a.sind=137
else a.sind=136
end
elseif abs(a.dx)>.005 or abs(a.dy)>.005 then
local loop=(a.tl_tim%.4)/.4
if loop>=.8 then a.sind=134
elseif loop>=.5 then a.sind=142
elseif loop>=.3 then a.sind=134
else a.sind=143
end
else
local loop=a.tl_tim and(a.tl_tim%1)or 0
if loop<.25 then a.sind=141 end
end
a.xf=a.is_facing_left
if a.passive_mode then a.sind+=32 end
scr_spr(a)
end)
create_parent([[110|111]],function(a,other)
if not a:any_timer_active"roll"then
if a.insane_level<4 then a:hurt()end
a:knockback(atan2(a.x-other.x,a.y-other.y))
end
end,function(a)
a:set_insanity(4)
end,function(a)
if a.insane_level<3 then
a:set_insanity(a.insane_level+1)
end
end,function(a)
if a.insane_level>3 then
a:set_insanity(0)
elseif a.insane_level>0 then
a:set_insanity(a.insane_level-1)
end
end,function(a,level)
if level ~=a.insane_level then
a.insane_level=level
a:create_timer("insane_timeout",60*5,function()
a:decrement_insanity()
end)
end
end)
create_parent([[112|113]],function(a,other)
if not a:any_timer_active"roll"then
a:hurt(other.strength or 1)
a:knockback(atan2(a.x-other.x,a.y-other.y))
end
end)
function control_player(a,x_dir,y_dir,is_z_pressed,is_x_pressed,punch_func,insane_level)
if not a.pl then return end
if a.teleporting then
a.iyy-=.25
a.ax=0 a.ay=0
return
end
local speed_multiplier=1
if insane_level then
speed_multiplier=1+a.insane_level/10
if insane_level==4 then _g.powerup_particle(a.x,a.y+.5,_g.c_color_angry)
elseif insane_level==3 then _g.powerup_particle(a.x,a.y+.5,_g.c_color_insane_3)
elseif insane_level==2 then _g.powerup_particle(a.x,a.y+.5,_g.c_color_insane_2)
elseif insane_level==1 then _g.powerup_particle(a.x,a.y+.5,_g.c_color_insane_1)
end
elseif a:any_timer_active("hurt_cooldown")then
_g.powerup_particle(a.x,a.y+.5,_g.c_color_blood)
end
if insane_level==4 then a.stregth=2
else a.stregth=1 end
if not a:any_timer_active("cooldown","roll","punch")then
if is_z_pressed then
a:create_timer("roll",20,function()a.dx/=3 a.dy/=3 a:create_timer("cooldown",20)end)
elseif is_x_pressed then
if punch_func then
a:create_timer("punch",20,function()a:create_timer("cooldown",10)end)
punch_func(a,a.x,a.y)
end
end
end
local is_moving=x_dir ~=0 or y_dir ~=0
if a:any_timer_active"knockback"then
a:apply_knockback()
elseif a:any_timer_active"roll"then
a.ax=cos(a.dir)*.03
a.ay=sin(a.dir)*.03
elseif a:any_timer_active"punch"then
a.ax=cos(a.dir)*.005
a.ay=sin(a.dir)*.005
elseif is_moving then
if x_dir ~=0 then
a.is_facing_left=x_dir<0
end
a.dir=atan2(x_dir==0 and(a.is_facing_left and-1 or 1)or x_dir,y_dir)
local dir=atan2(x_dir,y_dir)
a.ax=cos(dir)*.015
a.ay=sin(dir)*.015
else
a.dir=atan2(a.is_facing_left and-1 or 1,0)
a.ax=0
a.ay=0
end
a.ax*=speed_multiplier
a.ay*=speed_multiplier
end
create_actor([[114|115]],function(a)
a.sind=197
scr_spr(a)
end)
create_actor([[116|117]],function(a)
local shoot_speed=.2
if not a:any_timer_active("walk","wait","aim","shoot")then
a:create_timer("walk",120+rnd(60),function()
a:create_timer("wait",flr_rnd(60)+60,function()
a:create_timer("aim",10,function()
_g.police_weapon(a.x,a.y,a.xf and-shoot_speed or shoot_speed)
a:create_timer("shoot",40,function()
end)
end)
end)
end)
end
if a:any_timer_active"hurt_cooldown"then
_g.powerup_particle(a.x,a.y+.5,_g.c_color_blood)
end
if not a:any_timer_active"shoot"then
if abs(a.dx)<.01 then
a.xf=a.x-g_pl.x>0
end
end
if a:any_timer_active"knockback"then
a:apply_knockback()
elseif a:any_timer_active"walk"then
a.dir=atan2(g_pl.x-a.x,g_pl.y-a.y)+rnd(.125)-.125/2
a.ax=0
a.ay=sin(a.dir)*.03
else
a.ax=0
a.ay=0
end
end,function(a,other)
if other.rel_actor then
other.rel_actor:knockback(atan2(g_pl.x-a.x,g_pl.y-a.y))
if not a:any_timer_active"hurt_cooldown"then
call_not_nil(other.rel_actor,"increment_insanity",other.rel_actor)
end
end
a:hurt(g_pl.strength)
a:knockback(atan2(a.x-other.x,a.y-other.y))
end,function(a)
create_cached_deadbody(a.enemy_id,a.x,a.y,a.xf,227)
end,function(a)
if a:any_timer_active"aim"then
a.sind=195
elseif a:any_timer_active"shoot"then
a.sind=196
elseif abs(a.dx)>.01 or abs(a.dy)>.01 then
local loop=a.tl_tim%.5/.5
if loop<.25 then a.sind=193
elseif loop<.5 then a.sind=192
elseif loop<.75 then a.sind=193
else a.sind=194
end
end
scr_spr(a)
end)
create_actor([[118|119]],function(a)
a.xf=t()%10>5
if t()%7<1 then
if a.xf then
a.ax=.005
else
a.ax=-.005
end
else
a.ax=0
end
local tim=t()%5
if tim<1 then a.sind=224
elseif tim<2 then a.sind=225
elseif tim<3 then a.sind=226
else a.sind=225 end
end,scr_spr)
create_actor([[120|121]],function(a)
a:update_particles()
if g_pl.health<a.heart_number then
a:kill()
end
end,function(a)
zspr(16,a.x*8,a.y*8+1)
end)
create_actor([[122|123]],function(a)
if g_pl.alive and g_pl.insane_level==a.powerup_level then
a:update_particles()
end
end,function(a)
if g_pl.alive and g_pl.insane_level==a.powerup_level then
zspr(a.sind,a.x*8,a.y*8,2,2,g_pl.is_facing_left,false)
end
end)
create_actor([[124|125]],function(a)
if g_endgame_stats.enemy_total_count-g_endgame_stats.enemy_kill_count<=a.when_to_show_tip then
scr_rectfill(.125,a.y-.5,15.75,a.y+.5,1)
local number_str=""..g_endgame_stats.enemy_kill_count.."/"..g_endgame_stats.enemy_total_count
if g_endgame_stats.enemy_kill_count==g_endgame_stats.enemy_total_count then
number_str="all"
end
zprint("killed "..number_str.." enemies",a.x*8,a.y*8-2,8,0)
end
end)
create_actor([[126|127]],function(a)
local smallest_dist
local objective
for g_ind in all{"bad_character","portal"}do
for b in all(g_act_arrs[g_ind])do
local dist=approx_dist(g_pl.x-b.x,g_pl.y-b.y)
if not smallest_dist or dist<smallest_dist then
smallest_dist=dist
objective=b
end
end
end
a.smallest_dist=smallest_dist
a.objective=objective
end,function(a)
if a.objective and a.smallest_dist>3.5 then
local dir=atan2(a.objective.x-g_pl.x,a.objective.y-g_pl.y)
dir=round(dir*16)/16
local dx=cos(dir)
local dy=sin(dir)
local offy=-.5
local color=1
local len_multiplier=1.75
if t()%.5<.25 then
len_multiplier*=1.125
end
local x1=g_pl.x+dx
local y1=offy+g_pl.y+dy
local x2=g_pl.x+dx*len_multiplier
local y2=offy+g_pl.y+dy*len_multiplier
scr_line(x1,y1,x2,y2,color)
local turn=.375
local length=.375
local x3=x2+cos(dir+turn)*length
local y3=y2+sin(dir+turn)*length
local x4=x2+cos(dir-turn)*length
local y4=y2+sin(dir-turn)*length
scr_line(x2,y2,x3,y3,color)
scr_line(x2,y2,x4,y4,color)
end
end)
create_actor([[128|129]],function(a)
if approx_dist(g_pl.x-a.x,g_pl.y-a.y)<16 then
_g.powerup_particle(a.x+rnd(.5)-.25,a.y+rnd(.5)-.25,rnd_item{1,2})
a.radius=(sin(t())*.2+.5)
end
end,function(a)
scr_ovalfill(a.x-a.radius,a.y-.2,a.x+a.radius,a.y+.2,1)
end)
create_parent([[130|131]],function(a,other)
if other.portal and not a.teleporting then
a.teleporting=true
_g.fader_out(1,nf,function()
if g_room.name=="dungeon"then
g_reset_room=reset_the_bossroom
g_reset_room()
elseif g_room.name=="bossroom"then
g_reset_room=reset_the_hospital
g_reset_room()
elseif g_room.name=="hospital"then
g_tl:next()
end
end)
end
end)
create_actor([[132|133]],function(a)
control_player(a,xbtn(),ybtn(),btn(4),btn(5),_g.good_fist)
end,function(a)
a:create_dead_body()
g_endgame_stats.deaths=g_endgame_stats.deaths+1
_g.fader_out(1,nf,g_reset_room)
end)
create_actor([[134|133]],function(a)
control_player(a,xbtn(),ybtn(),btn(4),btn(5))
end,function(a)
a:create_dead_body()
g_endgame_stats.deaths=g_endgame_stats.deaths+1
_g.fader_out(1,nf,g_reset_room)
end)
create_actor([[135|133]],function(a)
if g_debug and btnp(4)then a:set_insanity((a.insane_level+1)%5)end
control_player(a,xbtn(),ybtn(),btn(4),btn(5),_g.good_fist,a.insane_level)
end,function(a)
a:create_dead_body()
g_endgame_stats.deaths=g_endgame_stats.deaths+1
_g.fader_out(1,nf,g_reset_room)
end)
create_actor([[136|137]],function(a)
if g_endgame_stats.achievement ~="pacifist"then
a:set_insanity(3)
end
end,function(a)
if g_endgame_stats.achievement=="pacifist"then
control_player(a,flr_rnd(3)-1,flr_rnd(3)-1,flr_rnd(5)==0,false,_g.bad_fist,a.insane_level)
else
control_player(a,flr_rnd(3)-1,flr_rnd(3)-1,flr_rnd(a.insane_level+5)==0,flr_rnd(4-a.insane_level)==0,_g.bad_fist,a.insane_level)
end
end,function(a)
a:create_dead_body()
_g.portal(118,27)
end)
function get_all_enemies_for_story_mode()
local dungeon_and_hospital=ztable[[138]]
return{
dungeon=dungeon_and_hospital,
hospital=dungeon_and_hospital,
bossroom=ztable[[139]]
}
end
function hospitalify_the_map()
for x=0,107 do
for y=0,31 do
local v=mget(x,y)
if v>=1 and v<=4 then v+=4
elseif v>=17 and v<=20 then v+=4
elseif v>=33 and v<=36 then v+=4
elseif v>=49 and v<=52 then v+=4
elseif v==32 or v==46 or v==47 then v+=16
elseif v==117 then v+=1
end
mset(x,y,v)
end
end
end
function create_ui_hearts()
_g.heart_particle_spawner(6.5,1,3)
_g.heart_particle_spawner(9.5,1,2)
_g.heart_particle_spawner(8,1,1)
end
function create_ui_powerups()
_g.powerup_particle_spawner(3,1,0,_g.c_color_normal,72)
_g.powerup_particle_spawner(4,15,1,_g.c_color_insane_1,74)
_g.powerup_particle_spawner(8,15,2,_g.c_color_insane_2,76)
_g.powerup_particle_spawner(12,15,3,_g.c_color_insane_3,78)
_g.powerup_particle_spawner(13,1,4,_g.c_color_angry,104)
end
function create_all_enemies()
for i,enemy_template in pairs(_g.all_enemy_templates[g_room.name])do
if enemy_template.alive then
enemy_template[g_room.name](enemy_template.x,enemy_template.y,i)
end
end
end
function create_all_deadbodies()
for body in all(_g.all_deadbody_templates[g_room.name])do
_g.deadbody_nobleed(unpack(body))
end
end
function cleanup_confined()
batch_call_new(acts_loop,[[140]])
end
function reset_the_dungeon()
cleanup_confined()
_g.fader_in(.5,nf,nf)
g_pl=_g.pl_monster_control(94,12)
g_view=_g.view(15.25,11.5,3,g_pl)
g_room=ztable[[141]]
_g.portal(94,13)
create_all_deadbodies()
create_all_enemies()
create_ui_hearts()
create_ui_powerups()
_g.genocide_tip(8,13)
_g.objective_arrow(8,13)
end
function reset_the_hospital()
hospitalify_the_map()
cleanup_confined()
_g.fader_in(.5,nf,nf)
_g.portal(17,4)
g_pl=_g.pl_patient_control_passive(94,13)
g_view=_g.view(15.25,11.5,3,g_pl)
g_room=ztable[[142]]
create_all_deadbodies()
create_all_enemies()
create_ui_hearts()
_g.objective_arrow(8,13)
end
function reset_the_bossroom()
cleanup_confined()
_g.fader_in(.5,nf,nf)
g_pl=_g.pl_patient_control_fight(118,27)
g_view=_g.view(15.25,11.5,3,g_pl)
g_room=ztable[[143]]
_g.portal(118,30)
create_all_deadbodies()
create_all_enemies()
create_ui_hearts()
_g.objective_arrow(8,13)
end
function credits_init(a)
_g.fader_in(.5,nf,function()g_credits_enabled=true end)
g_credits_enabled=false
credits_o=0
end
function credits_update(a)
if g_credits_enabled and(btn(4)or btn(5))then
g_credits_enabled=false
_g.fader_out(.5,nf,function()
g_tl:next()
end)
end
batch_call_new(acts_loop,[[144]])
end
function credits_draw(a)
fade(g_card_fade)
zspr(200,64,16+8,8,3)
local base=48
zspr(72,16,base,2,2)
zspr(74,16,base+16,2,2)
zspr(76,16,base+32,2,2)
zspr(78,16,base+48,2,2)
zspr(104,16,base+64,2,2)
zprint("you beat "..g_endgame_stats.achievement.." mode!",16+12,base-1,13,-1)
zprint("-----------------------",16+12,base+8-1,1,-1)
zprint("kills : "..g_endgame_stats.enemy_kill_count.."/"..g_endgame_stats.enemy_total_count,16+12,base+16-1,3,-1)
zprint("deaths: "..g_endgame_stats.deaths,16+12,base+16+8-1,4,-1)
zprint("timer : "..format_time(),16+12,base+32-1,9,-1)
zprint("-----------------------",16+12,base+32+8-1,1,-1)
zprint("@alanxoc3: code/music",16+12,base+48-1,12,-1)
zprint("@denial: code/design",16+12,base+48+8-1,14,-1)
zprint("@thegreatcadet: gfx/map",16+12,base+64-1,8,-1)
end
function game_init()
local d_and_h={}_g.all_deadbody_templates={dungeon=d_and_h,bossroom={},hospital=d_and_h}
_g.all_enemy_templates=get_all_enemies_for_story_mode()
g_endgame_stats={
frames=0,
deaths=0,
achievement="pacifist",
enemy_kill_count=0,
enemy_total_count=0
}
g_reset_room=reset_the_hospital
g_reset_room()
g_pl.x=15
g_pl.y=5
end
function game_update()
g_endgame_stats.frames=g_endgame_stats.frames+1
batch_call_new(acts_loop,[[145]],g_act_arrs["wall"],g_act_arrs["bad_character"],g_act_arrs["good_character"],g_act_arrs["portal"],function(x,y)
return x>=g_room.x and x<g_room.x+g_room.w and
y>=g_room.y and y<g_room.y+g_room.h and
fget(mget(x,y),0)
end)
g_endgame_stats.enemy_kill_count=#_g.all_deadbody_templates.dungeon
g_endgame_stats.enemy_total_count=#_g.all_enemy_templates.dungeon
if g_endgame_stats.enemy_kill_count==0 then
g_endgame_stats.achievement="pacifist"
elseif g_endgame_stats.enemy_kill_count==enemy_total_count then
g_endgame_stats.achievement="genocide"
else
g_endgame_stats.achievement="unstable"
end
end
function shiftx(view)return(view.x-view.off_x-8)*8 end
function shifty(view)return(view.y-view.off_y-8)*8 end
function camera_to_view(view)camera(shiftx(view),shifty(view))end
function game_draw()
fade(g_card_fade)
local x,y=8,8
local rx=x-g_view.w/2
local ry=y-g_view.h/2
g_view.off_x=-(16-g_view.w)/2+rx
g_view.off_y=-(16-g_view.h)/2+ry
local x1,x2=rx*8,(rx+g_view.w)*8-1
local y1,y2=ry*8,(ry+g_view.h)*8-1
rect(x1-2,y1-2,x2+2,y2+2,1)
zclip(x1,y1,x2,y2)
camera_to_view(g_view)
scr_map(0,0,0,0,128,32)
batch_call_new(acts_loop,[[146]])
isorty(g_act_arrs.drawable)
batch_call_new(acts_loop,[[147]])
if g_debug then acts_loop("dim","debug_rect")end
camera()
clip()
batch_call_new(acts_loop,[[148]])
if g_debug then
print(g_endgame_stats.achievement,2,2,8)
print("time="..format_time()..",deaths="..g_endgame_stats.deaths.." kill:"..g_endgame_stats.enemy_kill_count.."/"..g_endgame_stats.enemy_total_count,2,120,8)
end
end
function format_time()
local seconds=flr(g_endgame_stats.frames/60)
local mins=flr(seconds/60)
seconds=seconds%60
mins=mins<10 and "0"..mins or mins
seconds=seconds<10 and "0"..seconds or seconds
return ""..mins..":"..seconds
end
function title_init(a)
_g.fader_in(.5,nf,function()g_title_enabled=true end)
g_title_enabled=false
title_o=0
end
function title_update(a)
if g_title_enabled and(btn(4)or btn(5))then
g_title_enabled=false
_g.fader_out(.5,nf,function()
g_tl:next()
end)
end
batch_call_new(acts_loop,[[144]])
end
function title_draw(a)
fade(g_card_fade)
zspr(72,64+cos(t()/5+.0)*45,64+sin(t()/3+.0)*45,2,2,t()%5<2.5,false)
zspr(74,64+cos(t()/5+.2)*45,64+sin(t()/3+.2)*45,2,2,false,t()%5>2.5)
zspr(76,64+cos(t()/5+.4)*45,64+sin(t()/3+.4)*45,2,2,t()%5<2.5,false)
zspr(78,64+cos(t()/5+.6)*45,64+sin(t()/3+.6)*45,2,2,t()%5>2.5,false)
zspr(104,64+cos(t()/5+.8)*45,64+sin(t()/3+.8)*45,2,2,false,t()%5<2.5)
zspr(200,64,64,8,3)
end
g_debug=false
g_card_fade=8
poke(0x5f5c,15)
poke(0x5f5d,15)
function _init()
music(0)
g_tl=ztable([[149]],logo_draw,function()end,
title_init,title_update,title_draw,
game_init,game_update,game_draw,
credits_init,credits_update,credits_draw
)
end
function _update60()
if g_debug then poke(0x5f42,15)
else poke(0x5f42,0)
end
if btnp"5"and btn"4"then g_debug=not g_debug end
tl_node(g_tl)
end
function _draw()
cls()
if g_debug then
rect(0,0,127,127,8)
end
call_not_nil(g_tl,"d",g_tl)
end
function logo_draw(a)
local logo_opacity=8+cos(a.tl_tim/a.tl_max_time)*4-4
fade(logo_opacity)
camera(logo_opacity>1 and rnd_one())
zspr(108,a.x,a.y,4,2)
fade"0"
camera()
end