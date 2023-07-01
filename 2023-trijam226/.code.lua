_g,g_ztable_cache,g_gunvals={},{},split("0x8000,0x8000,0x7fff,0x7fff,@1|!plus/@1/-2,!plus/@2/-2,!plus/@3/2,!plus/@4/2,13;!plus/@1/-1,!plus/@2/-1,!plus/@3/1,!plus/@4/1,1;|0,0,0,0,0,0,0;1,1,1,0,0,0,0;2,2,2,1,0,0,0;3,3,3,1,0,0,0;4,2,2,2,1,0,0;5,5,1,1,1,0,0;6,13,13,5,5,1,0;7,6,13,13,5,1,0;8,8,2,2,2,0,0;9,4,4,4,5,0,0;10,9,4,4,5,5,0;11,3,3,3,3,0,0;12,12,3,1,1,1,0;13,5,5,1,1,1,0;14,13,4,2,2,1,0;15,13,13,5,5,1,0;|fader_out;3;act,;update,|fade_time:@1;i:@2;e:@3;u:@4;tl_max_time=@1,|fader_in;3;act,;update,|timer;0;,;|timers:,;tick:@1;create_timer:@2;any_timer_active:@3;get_timer_percent:@4;|act;0;timer,;room_init,kill,clean,delete|update:@1;clean:@2;kill:@3;delete:@4;get:@5;disabled:,;alive:yes;i:nf;u:nf;room_init:nf;destroyed:nf;|ma_able;0;act,;|name:thing;|confined;0;act,;room_end,|room_end:nf;|loopable;0;act,;|tl_loop:yes;|pos;0;act,;|x:0;y:0;|knock;0;col,;|;|popper;0;col,;|good_character;0;col,hurtable;|bad_character;0;col,hurtable;|good_attack;0;col,;|hit:@1;|bad_attack;0;col,;|hit:@1;kill_when_hit:no;|x_bounded;0;dim,;|check_bounds_x:@1;|y_bounded;0;dim,;|check_bounds_y:@1;|vec;0;pos,;|dx:0;dy:0;vec_update:@1;|mov;0;vec,;|inertia_x:.90;inertia_y:.90;ax:0;ay:0;mov_update:@1;stop:@2;|dim;0;pos,;|rx:.375;ry:.375;|rel;0;act,;rel_update,|rel_actor:null;rel_x:0;rel_y:0;rel_dx:0;rel_dy:0;flippable:no;rel_update:@1;|drawable_obj;0;pos,;reset_off,|ixx:0;iyy:0;xx:0;yy:0;visible:yes;reset_off:@1;|drawable;0;drawable_obj,;d,|d:nf;|drawable_1;0;drawable_obj,;d,|drawable_2;0;drawable_obj,;d,|captionable;0;drawable,pos;|d:nf;draw_caption:@1;caption_text:null;|pre_drawable;0;drawable_obj,;d,|pre_drawable_1;0;drawable_obj,;d,|pre_drawable_2;0;drawable_obj,;d,|post_drawable;0;drawable_obj,;d,|post_drawable_1;0;drawable_obj,;d,|post_drawable_2;0;drawable_obj,;d,|above_map_drawable;0;drawable_obj,;d,|above_map_drawable_1;0;drawable_obj,;d,|spr_obj;0;vec,drawable_obj,;|sind:0;outline_color:BG_UI;sw:1;sh:1;xf:no;yf:no;|spr;0;spr_obj,;|d:@1;|knockbackable;0;mov,timer,;|knockback:@1;apply_knockback:@2;knockback_speed:0;knockback_dir:0;|hurtable;0;act,;|health:1;max_health:1;hurt_cooldown_time:60;hurt_start:nf;hurt_end:nf;damage:nf;hurt:@1;heal:@2;|anchored;1;vec,dim;|touchable:@1;hit:nf;|col;0;vec,dim;|touchable:yes;hit:nf;move_check:@1;|dx:0;dy:0|x,dx,@1,@2,@3,@4;y,dy,@1,@2,@5,@6;|tcol;0;vec,dim;|tile_solid:yes;tile_hit:nf;coll_tile:@1;|view;4;act,confined;center_view,update_view|x:0;y:0;room_crop:2;tl_loop:yes;w:@1;h:@2;follow_dim:@3;follow_act:@4;update_view:@5;center_view:@6;change_ma:@7;,;|@1,x,w,ixx;@1,y,h,iyy|deadbody_parent;0;confined,pre_drawable|d:@1;i:@2;touchable:no;rx:.25;ry:.5;sind:0;|deadbody_nobleed;4;deadbody_parent,|x:@1;y:@2;xf:@3;sind:@4;touchable:no;rx:.25;ry:.5;|deadbody;4;deadbody_parent,|x:@1;y:@2;xf:@3;sind:@4;i:@5;u:@6;touchable:no;rx:.25;ry:.5;|nurse_weapon;3;col,confined,rel,bad_attack|rel_actor:@1;x:@2;y:@3;i:@4;touchable:no;rx:.5;ry:1;tl_max_time=.16,;|bad_nurse;3;drawable,col,confined,mov,x_bounded,y_bounded,knockbackable,hurtable,spr_obj,bad_character,tcol|sind:5;x:@1;y:@2;enemy_id:@3;u:@4;damage:@5;destroyed:@6;d:%nurse_draw;health:6;max_health:6;sh:2;iyy:-5;rx:.375;ry:.375;touchable:no;|nurse;3;captionable,drawable,col,confined,mov,x_bounded,y_bounded,spr_obj,tcol|sind:98;x:@1;y:@2;enemy_id:@3;u:@4;d:%nurse_draw;sh:2;iyy:-5;rx:.375;ry:.375;touchable:no;|particle_parent;0;confined,mov,;|draw_small_circle:@1;draw_medium_circle:@2;move_up:@3;move_slow:@4;|powerup_particle;3;pre_drawable_2,particle_parent|x:@1;y:@2;color:@3;d:$draw_small_circle;i:$move_up;tl_max_time=.25,;|slow_small_ui_particle;3;above_map_drawable,particle_parent|x:@1;y:@2;color:@3;d:$draw_small_circle;i:$move_slow;tl_max_time=.25,;|slow_medium_ui_particle;3;above_map_drawable,particle_parent|x:@1;y:@2;color:@3;d:$draw_medium_circle;i:$move_slow;tl_max_time=.25,;|particle_spawner;5;dim,confined|color:8;rx:@1;ry:@2;rate:@3;chance:@4;create_func:@5;update_particles:@6;|patient_weapon;3;col,confined,rel,bad_attack|rel_actor:@1;x:@2;y:@3;i:@4;touchable:no;rx:.75;ry:.75;tl_max_time=.5,;|bad_patient;3;drawable,col,confined,mov,x_bounded,y_bounded,knockbackable,hurtable,spr_obj,bad_character,tcol|sind:224;x:@1;y:@2;enemy_id:@3;u:@4;damage:@5;destroyed:@6;d:%patient_draw;health:5;max_health:5;sh:2;iyy:-5;rx:.375;ry:.375;touchable:no;|patient;3;captionable,drawable,col,confined,mov,x_bounded,y_bounded,spr_obj,tcol|sind:41;x:@1;y:@2;enemy_id:@3;u:@4;d:@5;sind:41;sh:2;iyy:-5;rx:.375;ry:.375;touchable:no;|fist_parent;0;col,confined,rel|i:@1;touchable:no;rx:.375;ry:.75;tl_max_time=.33,;|good_fist;3;fist_parent,good_attack|rel_actor:@1;x:@2;y:@3;|bad_fist;3;fist_parent,bad_attack|pl;1;drawable,pos,confined,mov,x_bounded,y_bounded,col,spr_obj,knockbackable,hurtable,tcol;|hurt_cooldown_time:90;passive_mode:@1;create_dead_body:@2;destroyed:@2;d:@3;strength:1;dir:0;is_facing_left:yes;xf:yes;health:2;max_health:2;bullet:2;reload:2;hasten:2;damage:nf;increment_strength:nf;decrement_strength:nf;set_strength:nf;sh:2;iyy:-5;|pl_monster;0;pl/no,|damage:@1;hurt_start:@2;hurt_end:@3;increment_strength:@4;decrement_strength:@5;set_strength:@6;strength:1;|pl_patient;0;pl/yes,|damage:@1;|bullet_bad;4;police_weapon,bad_attack|x:@1;y:@2;dx:@3;dy:@4;sind:198;col:8|bullet_good;4;police_weapon,good_attack|x:@1;y:@2;dx:@3;dy:@4;sind:199;col:9;rx:.125;ry:.125;|police_weapon;0;col,vec,confined,rel,post_drawable,tcol|d:@1;tile_hit:@2;destroyed:@3;kill_when_hit:yes;touchable:no;rx:.375;ry:.25;iyy:-6;tl_max_time=1,;|bad_police;3;drawable,col,confined,mov,x_bounded,y_bounded,knockbackable,hurtable,spr_obj,bad_character,tcol|sind:192;x:@1;y:@2;enemy_id:@3;u:@4;damage:@5;destroyed:@6;d:@7;d:%police_draw;health:4;max_health:4;sh:2;iyy:-5;rx:.375;ry:.375;touchable:no;|police;3;captionable,drawable,col,confined,mov,x_bounded,y_bounded,spr_obj,tcol|x:@1;y:@2;enemy_id:@3;u:@4;d:@5;sind:224;sh:2;iyy:-5;rx:.375;ry:.375;touchable:no;|heart_particle_spawner;3;particle_spawner/.125/.125/1/3/%slow_small_ui_particle,above_map_drawable_1|x:@1;y:@2;heart_number:@3;u:@4;d:@5;color:8;|powerup_particle_spawner;5;particle_spawner/2/.125/1/1/%slow_medium_ui_particle,above_map_drawable_1|x:@1;y:@2;powerup_level:@3;color:@4;sind:@5;u:@6;d:@7|statsels;0;above_map_drawable,confined|ry:.25;sel:0;radius:.2;touchable:no;i:@1;d:@2;u:@3;modstat:@4;|objective_arrow;2;post_drawable_2,confined|x:@1;y:@2;u:@3;d:@4;ry:.25;radius:.2;touchable:no;smallest_dist:0;|portal;2;col,pre_drawable,confined|x:@1;y:@2;u:@3;d:@4;rx:.125;ry:.125;radius:.2;touchable:no;|portal_spawner;0;confined,|u:@1;|pl_control;0;col,|hit:@1;teleporting:no;|pl_patient_control_fight;2;pl_patient,good_character,pl_control|x:@1;y:@2;u:@3;destroyed:@4;|pl_patient_control_passive;2;pl_patient,good_character,pl_control|pl_monster_control;2;pl_monster,good_character,pl_control|pl_monster_cpu;3;pl_monster,bad_character|health:4;max_health:4;touchable:no;x:@1;y:@2;enemy_id:@3;i:@4;u:@5;destroyed:@6;;|x=5,y=5,dungeon=%bad_police,alive=yes;x=5,y=5,dungeon=%bad_nurse,alive=yes;x=5,y=5,dungeon=%bad_patient,alive=yes;|x=126,y=8,bossroom=%pl_monster_cpu,alive=yes;|confined,delete;|name:dungeon;x:0;y:0;w:32;h:24;|timer,tick;act,update;act,clean;|timer,tick;act,update;mov,mov_update;good_character,move_check,@1;bad_character,move_check,@1;good_attack,move_check,@2;bad_attack,move_check,@3;pl_control,move_check,@4;tcol,coll_tile,@5;rel,rel_update;vec,vec_update;x_bounded,check_bounds_x;y_bounded,check_bounds_y;view,update_view;act,clean;|pre_drawable,d;pre_drawable_1,d;pre_drawable_2,d;|drawable,d;drawable_1,d;drawable_2,d;post_drawable,d;post_drawable_1,d;post_drawable_2,d;captionable,draw_caption;|above_map_drawable,d;above_map_drawable_1,d;|tl_loop:yes;i=@6,u=@7,d=@8;i=@9,u=@10,d=@11;|","|")
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
if not a.disabled[func_name]then
call_not_nil(a,func_name,a,...)
end
end
end
function nf()end
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
if spd<0 and solid_func(a,pos_min,j)then
hit_func(a,dir)
return pos_min+pos_rad+1,0
elseif spd>0 and solid_func(a,pos_max,j)then
hit_func(a,dir+1)
return pos_max-pos_rad,0
end
end
return pos,spd
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
create_parent([[40|41]],function(a)
a.xx,a.yy=0,0
end)
create_parent[[42|43]]
create_parent[[44|43]]
create_parent[[45|43]]
create_parent([[46|47]],function(a)
if a.caption_text and approx_dist(g_pl.x-a.x,g_pl.y-a.y)<1 then
zprint(a.caption_text,a.x*8,(a.y-2.5)*8+1,1,0)
zprint(a.caption_text,a.x*8,(a.y-2.5)*8-1,1,0)
zprint(a.caption_text,a.x*8-1,(a.y-2.5)*8,1,0)
zprint(a.caption_text,a.x*8+1,(a.y-2.5)*8,1,0)
zprint(a.caption_text,a.x*8,(a.y-2.5)*8,7,0)
end
end)
create_parent[[48|43]]
create_parent[[49|43]]
create_parent[[50|43]]
create_parent[[51|43]]
create_parent[[52|43]]
create_parent[[53|43]]
create_parent[[54|43]]
create_parent[[55|43]]
create_parent[[56|57]]
create_parent([[58|59]],scr_spr)
create_parent([[60|61]],function(a,direction)
if not a:any_timer_active("knockback")then
a.knockback_speed=.075
a.knockback_dir=direction
a:create_timer("knockback",1.5)
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
local y,dy=coll_tile_help(a.y,a.x,a.dy,a.ry,a.rx,2,a,a.tile_hit,function(a,y,x)return solid_func(a,x,y)end)
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
zspr(sind,a.x*8+a.xx,a.y*8+a.yy,2,1,a.xf,false)
end)
create_actor[[77|78]]
create_actor([[79|80]],function(a)
a:create_timer("bleeding",30)
sfx(16)
end,function(a)
if a:any_timer_active"bleeding"then
_g.powerup_particle(a.x,a.y,8)
a.xx=flr_rnd(3)-2
a.yy=flr_rnd(3)-2
end
end)
function create_cached_deadbody(enemy_id,...)
add(_g.all_deadbody_templates[g_room.name],{...})
_g.deadbody(...)
end
function _g.nurse_draw(a)
a.sind=5
a.sw=1
if a:any_timer_active"prepare"then
a.sind=37
a.sw=2
elseif a:any_timer_active"attack"then
a.sw=2
a.sind=39
if a:get_timer_percent"attack">.90 then a.sind=45
elseif a:get_timer_percent"attack">.70 then a.sind=43
elseif a:get_timer_percent"attack">.50 then a.sind=41
elseif a:get_timer_percent"attack">.20 then a.sind=39
end
elseif abs(a.dx)>.005 or abs(a.dy)>.005 then
local loop=a.tl_tim%.5/.5
if loop<.25 then a.sind=5
elseif loop<.5 then a.sind=6
elseif loop<.75 then a.sind=5
else a.sind=7
end
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
_g.powerup_particle(a.x,a.y+.5,8)
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
local had_timer=a:any_timer_active"hurt_cooldown"
a:hurt(g_pl.strength)
a:knockback(atan2(a.x-other.x,a.y-other.y))
if other.rel_actor then
other.rel_actor:knockback(atan2(g_pl.x-a.x,g_pl.y-a.y))
if not had_timer then
call_not_nil(other.rel_actor,"increment_strength",other.rel_actor)
end
end
end,function(a)
create_cached_deadbody(a.enemy_id,a.x,a.y,a.xf,80)
end)
create_actor([[85|86]],function(a)
if not a:any_timer_active("cooldown","walk")then
a.dir=atan2(g_pl.x-a.x,g_pl.y-a.y)+rnd(.125)-.125/2
a:create_timer("walk",flr_rnd(10)+30,function()
a:create_timer("cooldown",flr_rnd(120)+50)
end)
end
if g_endgame_stats.enemy_kill_count>0 then
a.caption_text="you monster!"
else
a.caption_text="you're healed!"
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
a.sind=224
a.sw=1
if a:any_timer_active"prepare"then
a.sw=2
a.sind=226
elseif a:any_timer_active"charge"then
a.sw=2
local percent=a:get_timer_percent"charge"
if percent<.2 then a.sind=228
elseif percent<.4 then a.sind=230
elseif percent<.75 then a.sind=232
else a.sind=226
end
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
_g.powerup_particle(a.x,a.y+.5,8)
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
local had_timer=a:any_timer_active"hurt_cooldown"
a:hurt(g_pl.strength)
a:knockback(atan2(a.x-other.x,a.y-other.y))
if other.rel_actor then
other.rel_actor:knockback(atan2(g_pl.x-a.x,g_pl.y-a.y))
if not had_timer then
call_not_nil(other.rel_actor,"increment_strength",other.rel_actor)
end
end
end,function(a)
create_cached_deadbody(a.enemy_id,a.x,a.y,a.xf,215)
end)
create_actor([[101|102]],function(a)
a.xf=a.x-g_pl.x>0
if t()%5<.5 then
a.ixx=flr_rnd(3)-1
a.sind=rnd_item{41,42,43}
else
a.ixx=0
end
if g_endgame_stats.enemy_kill_count>0 then
a.caption_text="don't kill me too!"
else
a.caption_text="play with me!"
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
_g.deadbody(a.x,a.y,a.xf,sind)
end,function(a)
a.sind=128
a.yy=0
a.sw=1
if a:any_timer_active"punch"then
local percent=a:get_timer_percent"punch"
if percent>=.90 then a.sind=166
elseif percent>=.80 then a.sind=165
elseif percent>=.50 then a.sind=164
elseif percent>=.30 then a.sind=163
elseif percent>=.10 then a.sind=162
else a.sind=128
end
a.yy=sin(percent/2)*5
elseif a:any_timer_active"roll"then
a.sw=2
local percent=a:get_timer_percent"roll"
if percent>=.90 then a.sind=142
elseif percent>=.80 then a.sind=140
elseif percent>=.70 then a.sind=138
elseif percent>=.50 then a.sind=136
elseif percent>=.30 then a.sind=134
elseif percent>=.20 then a.sind=132
else a.sind=130
end
elseif abs(a.dx)>.005 or abs(a.dy)>.005 then
local loop=(a.tl_tim%.4)/.4
if loop>=.8 then a.sind=128
elseif loop>=.5 then a.sind=160
elseif loop>=.3 then a.sind=128
else a.sind=161
end
else
local loop=a.tl_tim and(a.tl_tim%1)or 0
if loop<.25 then a.sind=129 end
end
a.xf=a.is_facing_left
if a.passive_mode then a.sind+=32 end
scr_spr(a)
end)
create_parent([[110|111]],function(a,other)
if not a:any_timer_active"roll"then
a:hurt()
a:knockback(atan2(a.x-other.x,a.y-other.y))
end
end,function(a)a:set_strength(1)
end,function(a)a:set_strength(1)
end,function(a)
end,function(a)
end,function(a,level)
end)
create_parent([[112|113]],function(a,other)
if not a:any_timer_active"roll"then
if not a:any_timer_active"hurt_cooldown"then
if other.rel_actor then
other.rel_actor:increment_strength()
end
end
a:hurt()
a:knockback(atan2(a.x-other.x,a.y-other.y))
end
end)
function control_player(a,x_dir,y_dir,is_z_pressed,is_x_pressed,punch_func)
if not a.pl then return end
if g_stats and g_stats.stats then
a.bullet=g_stats.stats[SBULLET]
if a.max_health and g_stats.stats[SHEARTS]~=a.max_health then
a.max_health=g_stats.stats[SHEARTS]
a.health=g_stats.stats[SHEARTS]
end
a.reload=g_stats.stats[SRELOAD]
a.hasten=g_stats.stats[SHASTEN]
end
if a.teleporting then
a.iyy-=.25
a.ax=0 a.ay=0
return
end
local speed_multiplier=1
if a:any_timer_active("hurt_cooldown")then
_g.powerup_particle(a.x,a.y+.5,8)
end
if is_z_pressed and not a:any_timer_active("cooldown","roll")then
a:create_timer("roll",20,function()a.dx/=3 a.dy/=3 a:create_timer("cooldown",60/a.hasten)end)
end
if not a:any_timer_active("shotcooldown")then
if punch_func then
a:create_timer("shotcooldown",(4-a.reload)*15)
punch_func(a,a.x,a.y)
for i=-(a.bullet-1)/2,(a.bullet-1)/2 do
local ang_off=i*.125/2
if g_objective_arrow and g_objective_arrow.objective then
local obj=g_objective_arrow.objective
local dir=atan2(obj.x-a.x,obj.y-a.y)+ang_off
local dx,dy=.2*cos(dir),.2*sin(dir)
_g.bullet_good(a.x,a.y,dx,dy)
end
end
end
end
local is_moving=x_dir ~=0 or y_dir ~=0
if a:any_timer_active"knockback"then
a:apply_knockback()
elseif a:any_timer_active"roll"then
a.ax=cos(a.dir)*(.025+(a.hasten-1)*.005)
a.ay=sin(a.dir)*(.025+(a.hasten-1)*.005)
elseif a:any_timer_active"punch"then
a.ax=cos(a.dir)*.005
a.ay=sin(a.dir)*.005
elseif is_moving then
if x_dir ~=0 then
a.is_facing_left=x_dir<0
end
a.dir=atan2(x_dir==0 and(a.is_facing_left and-1 or 1)or x_dir,y_dir)
local dir=atan2(x_dir,y_dir)
a.ax=cos(dir)*(.010+(a.hasten-1)*.005)
a.ay=sin(dir)*(.010+(a.hasten-1)*.005)
else
a.dir=atan2(a.is_facing_left and-1 or 1,0)
a.ax=0
a.ay=0
end
a.ax*=speed_multiplier
a.ay*=speed_multiplier
end
create_actor([[114|115]])
create_actor([[116|117]])
create_actor([[118|119]],function(a)
a.flipped=not a.flipped
a.xf=a.dx<0
scr_spr(a)
end,function(a)
a.alive=false
end,function(a)
_g.powerup_particle(a.x,a.y,a.col)
_g.powerup_particle(a.x,a.y,a.col)
_g.powerup_particle(a.x,a.y,a.col)
_g.powerup_particle(a.x,a.y,a.col)
_g.powerup_particle(a.x,a.y,a.col)
_g.powerup_particle(a.x,a.y,a.col)
end)
create_actor([[120|121]],function(a)
local shoot_speed=.2
if not a:any_timer_active("walk","wait","aim","shoot")then
a:create_timer("walk",30+rnd(60),function()
a:create_timer("wait",flr_rnd(20)+10,function()
a:create_timer("aim",10,function()
_g.bullet_bad(a.x,a.y,a.xf and-shoot_speed or shoot_speed,0)
a:create_timer("aim",10,function()_g.bullet_bad(a.x,a.y-1,a.xf and-shoot_speed or shoot_speed,0)end)
a:create_timer("shoot",40,nf)
end)
end)
end)
end
if a:any_timer_active"hurt_cooldown"then
_g.powerup_particle(a.x,a.y+.5,8)
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
local had_timer=a:any_timer_active"hurt_cooldown"
a:hurt(g_pl.strength)
a:knockback(atan2(a.x-other.x,a.y-other.y))
if other.rel_actor then
other.rel_actor:knockback(atan2(g_pl.x-a.x,g_pl.y-a.y))
if not had_timer then
call_not_nil(other.rel_actor,"increment_strength",other.rel_actor)
end
end
end,function(a)
create_cached_deadbody(a.enemy_id,a.x,a.y,a.xf,213)
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
create_actor([[122|123]],function(a)
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
if g_endgame_stats.enemy_kill_count>0 then
a.caption_text="killer, thriller!"
else
a.caption_text="abc, 123, you & me!"
end
local tim=t()%5
if tim<1 then a.sind=224
elseif tim<2 then a.sind=225
elseif tim<3 then a.sind=226
else a.sind=225 end
end,scr_spr)
create_actor([[124|125]],function(a)
if g_pl.health<a.heart_number then
a.hidden=true
else
a:update_particles()
a.hidden=false
end
end,function(a)
if not a.hidden then
zspr(16,a.x*8,a.y*8+1)
end
end)
create_actor([[126|127]],function(a)
if g_pl.alive and g_pl.strength==a.powerup_level then
a:update_particles()
end
end,function(a)
if g_pl.alive and g_pl.strength==a.powerup_level then
zspr(a.sind,a.x*8,a.y*8,2,2,g_pl.is_facing_left,false)
end
end)
SBULLET=0
SHEARTS=1
SRELOAD=2
SHASTEN=3
create_actor([[128|129]],function(a)
a.stats={
[SBULLET]=2,
[SHEARTS]=2,
[SRELOAD]=2,
[SHASTEN]=2,
}
end,function(a)
if a.stats then
for i=0,3 do
local col=i==a.sel and 3 or 2
if i==a.sel then
rectfill(0,98+8*i-1,127,98+8*i+7-2,1)
end
rectfill(a.stats[i]*8+31+19+8,98+8*i-1,
a.stats[i]*8+37+19+8,98+8*i+7-2,col)
end
zprint("bullet 1 2 3",64,98+8*0,13,0)
zprint("hearts 1 2 3",64,98+8*1,13,0)
zprint("reload 1 2 3",64,98+8*2,13,0)
zprint("hasten 1 2 3",64,98+8*3,13,0)
end
end,function(a)
if not a:any_timer_active("cooldown")then
a:create_timer("cooldown",5*60+flr_rnd(5)*60,function()
a.sel=flr_rnd(4)
a:modstat(a.sel,1-flr_rnd(3))
end)
end
end,function(a,s,d)
local curr=a.stats[s]
local new=mid(1,3,curr+d)
if new ~=curr then
a.stats[s]=new
for i=1,3 do
local ind=(s+i)%4
local nn=mid(1,3,a.stats[ind]-d)
if nn ~=a.stats[ind]then
a.stats[ind]=nn
break
end
end
end
end)
create_actor([[130|131]],function(a)
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
if a.objective then
local dir=atan2(a.objective.x-g_pl.x,a.objective.y-g_pl.y)
dir=round(dir*16)/16
local dx=cos(dir)
local dy=sin(dir)
local offy=-.5
local color=1
local len_multiplier=1.75
local x1=g_pl.x+dx
local y1=offy+g_pl.y+dy
local x2=g_pl.x+dx*len_multiplier
local y2=offy+g_pl.y+dy*len_multiplier
zspr(8,x2*8,y2*8,2,2)
local turn=.375
local length=.375
local x3=x2+cos(dir+turn)*length
local y3=y2+sin(dir+turn)*length
local x4=x2+cos(dir-turn)*length
local y4=y2+sin(dir-turn)*length
end
end)
create_actor([[132|133]],function(a)
if not a:any_timer_active("spawn","die")then
a:create_timer("spawn",40,function()
local baddie=rnd_item{_g.bad_nurse,_g.bad_police,_g.bad_patient}
baddie(a.x,a.y,false)
a:create_timer("die",15,function()
a.alive=false
end)
end)
end
if a:any_timer_active("spawn")then
a.radius=.2+a:get_timer_percent"spawn"*.6
elseif a:any_timer_active("die")then
a.radius=.8-a:get_timer_percent"die"*.6
end
_g.powerup_particle(a.x+rnd(.5)-.25,a.y+rnd(.5)-.25,rnd_item{1,2})
end,function(a)
scr_ovalfill(a.x-a.radius,a.y-.2,a.x+a.radius,a.y+.2,1)
end)
create_actor([[134|135]],function(a)
if not a:any_timer_active("cooldown")then
a:create_timer("cooldown",5*60,function()
_g.portal(flr_rnd(g_room.w-4)+2,flr_rnd(g_room.h-4)+2)
end)
end
end)
create_parent([[136|137]],function(a,other)
if other.portal and not a.teleporting then
end
end)
create_actor([[138|139]],function(a)
control_player(a,xbtn(),ybtn(),btn(4)or btn(5),btn(4)or btn(5))
end,function(a)
a:create_dead_body()
g_endgame_stats.deaths=g_endgame_stats.deaths+1
_g.fader_out(1,nf,g_reset_room)
end)
create_actor([[140|139]],function(a)
control_player(a,xbtn(),ybtn(),btn(4)or btn(5),btn(4)or btn(5))
end,function(a)
a:create_dead_body()
g_endgame_stats.deaths=g_endgame_stats.deaths+1
_g.fader_out(1,nf,g_reset_room)
end)
create_actor([[141|139]],function(a)
control_player(a,xbtn(),ybtn(),btn(4)or btn(5),btn(4)or btn(5),_g.good_fist)
end,function(a)
a:create_dead_body()
g_endgame_stats.deaths=g_endgame_stats.deaths+1
_g.fader_out(1,nf,g_reset_room)
end)
create_actor([[142|143]],function(a)
a:set_strength(3)
end,function(a)
local x=zsgn(g_pl.x-a.x)
local y=zsgn(g_pl.y-a.y)
control_player(a
,x
,y
,flr_rnd(80)==0
,flr_rnd(20)==0
,_g.bad_fist
,a.strength
)
end,function(a)
a:create_dead_body()
end)
function get_all_enemies_for_story_mode()
local dungeon_and_hospital=tabcpy(ztable[[144]])
return{
dungeon=dungeon_and_hospital,
hospital=dungeon_and_hospital,
bossroom=tabcpy(ztable[[145]])
}
end
function create_ui_hearts()
_g.heart_particle_spawner(1.5,11,1)
_g.heart_particle_spawner(3,11,2)
_g.heart_particle_spawner(4.5,11,3)
end
function create_all_enemies()
end
function create_all_deadbodies()
for body in all(_g.all_deadbody_templates[g_room.name])do
_g.deadbody_nobleed(unpack(body))
end
end
function reset_the_dungeon()
batch_call_new(acts_loop,[[146]])
_g.portal_spawner()
_g.fader_in(.5,nf,nf)
g_room=ztable[[147]]
g_pl=_g.pl_monster_control(g_room.w-3.5,g_room.h-3.5)
g_view=_g.view(15.25,11.5,3,g_pl)
create_all_deadbodies()
create_all_enemies()
create_ui_hearts()
g_objective_arrow=_g.objective_arrow(8,13)
g_stats=_g.statsels()
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
g_tl.tl_next=2
end)
end
batch_call_new(acts_loop,[[148]])
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
local diagnosis
if g_endgame_stats.frames<60 then
diagnosis="hyperactive"
elseif g_endgame_stats.enemy_kill_count==0 then
diagnosis="healthy"
elseif g_endgame_stats.enemy_kill_count==g_endgame_stats.enemy_total_count then
if g_endgame_stats.deaths==0 then
if g_endgame_stats.frames<180 then
diagnosis="possessed"
else
diagnosis="obsessive"
end
else
diagnosis="insane"
end
else
diagnosis="unstable"
end
zprint("diagnosis: "..diagnosis,16+12,base-1,13,-1)
zprint("- - - - - - - - - - - - - - - - - - - - - - -",16+12,base+8-1,1,-1)
zprint("kills : "..g_endgame_stats.enemy_kill_count.."/"..g_endgame_stats.enemy_total_count,16+12,base+16-1,3,-1)
zprint("deaths: "..g_endgame_stats.deaths,16+12,base+16+8-1,4,-1)
zprint("time  : "..format_time(),16+12,base+32-1,9,-1)
zprint("- - - - - - - - - - - - - - - - - - - - - - -",16+12,base+32+8-1,1,-1)
zprint("@alanxoc3: code/music",16+12,base+48-1,12,-1)
zprint("@denial: code/design",16+12,base+48+8-1,14,-1)
zprint("@thegreatcadet: gfx/map",16+12,base+64-1,8,-1)
end
function disable_offscreen_bad_characters()
for a in all(g_act_arrs.bad_character)do
local dist=approx_dist(a.x-g_pl.x,a.y-g_pl.y)
if dist>14 then
a.disabled.update=true
if dist>17 then a.disabled.d=true end
else
a.disabled.update=nil
a.disabled.d=nil
end
end
end
function game_init()
reload(0x2000,0x2000,0x1000)
local d_and_h={}_g.all_deadbody_templates={dungeon=d_and_h,bossroom={},hospital=d_and_h}
g_endgame_stats={
frames=0,
deaths=0,
enemy_kill_count=0,
enemy_total_count=0
}
g_reset_room=reset_the_dungeon
g_reset_room()
end
function game_update()
g_endgame_stats.frames=min(7200,g_endgame_stats.frames+1/60)
batch_call_new(acts_loop,[[149]],g_act_arrs["wall"],g_act_arrs["bad_character"],g_act_arrs["good_character"],g_act_arrs["portal"],function(a,x,y)
return x>=g_room.x and x<g_room.x+g_room.w and
y>=g_room.y and y<g_room.y+g_room.h and
(fget(mget(x,y),0)or(a.bad_character or a.captionable)and fget(mget(x,y),1))
end)
if t()%.5==0 then disable_offscreen_bad_characters()end
end
function shiftx(view)return(view.x-view.off_x-8)*8 end
function shifty(view)return(view.y-view.off_y-8)*8 end
function camera_to_view(view)camera(shiftx(view),shifty(view))end
function game_draw()
fade(g_card_fade)
local x,y=8,6
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
batch_call_new(acts_loop,[[150]])
isorty(g_act_arrs.drawable)
batch_call_new(acts_loop,[[151]])
camera()
clip()
batch_call_new(acts_loop,[[152]])
end
function format_time()
local seconds=flr(g_endgame_stats.frames)
local mins=flr(seconds/60)
local hours=flr(mins/60)
seconds=seconds%60
mins=mins<10 and "0"..mins or mins
hours=hours<10 and "0"..hours or hours
return ""..hours..":"..mins..":"..seconds
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
batch_call_new(acts_loop,[[148]])
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
g_card_fade=8
poke(0x5f5c,15)
poke(0x5f5d,15)
function _init()
music(0,3000)
g_tl=ztable([[153]],logo_draw,function()end,
title_init,title_update,title_draw,
game_init,game_update,game_draw,
credits_init,credits_update,credits_draw
)
end
function _update60()
tl_node(g_tl)
end
function _draw()
cls()
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