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
_g={}
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
function tostring(any)
if type(any)~="table"then return tostr(any)end
local str="{"
for k,v in pairs(any)do
if str~="{"then str=str.."," end
str=str..tostring(k).."="..tostring(v)
end
return str.."}"
end
function amov_to_actor(a1,a2,spd,off_x,off_y)
off_x=off_x or 0
off_y=off_y or 0
if a1 and a2 then
amov_to_point(a1,spd,a2.x+off_x,a2.y+off_y)
end
end
function amov_to_point(a,spd,x,y)
local ang=atan2(x-a.x,y-a.y)
a.ax,a.ay=spd*cos(ang),spd*sin(ang)
end
function do_actors_intersect(a,b)
return a and b
and abs(a.x-b.x)<a.rx+b.rx
and abs(a.y-b.y)<a.ry+b.ry
end
function does_a_contain_b(a,b)
return a and b
and b.x-b.rx>=a.x-a.rx
and b.x+b.rx<=a.x+a.rx
and b.y-b.ry>=a.y-a.ry
and b.y+b.ry<=a.y+a.ry
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
g_gunvals=split("@1,@2,!plus/@3/1,@5;@1,@2,@3,@4;|0x8000,0x8000,0x7fff,0x7fff,@1|!plus/@1/-2,!plus/@2/-2,!plus/@3/2,!plus/@4/2,13;!plus/@1/-1,!plus/@2/-1,!plus/@3/1,!plus/@4/1,1;|0,0,0,0,0,0,0;1,1,1,0,0,0,0;2,2,2,1,0,0,0;3,3,3,1,0,0,0;4,2,2,2,1,0,0;5,5,1,1,1,0,0;6,13,13,5,5,1,0;7,6,13,13,5,1,0;8,8,2,2,2,0,0;9,4,4,4,5,0,0;10,9,4,4,5,5,0;11,3,3,3,3,0,0;12,12,3,1,1,1,0;13,5,5,1,1,1,0;14,13,4,2,2,1,0;15,13,13,5,5,1,0;|fader_out;3;act,;update,|fade_time:@1;i:@2;e:@3;u:@4;tl_max_time=@1,|fader_in;3;act,;update,|timer;0;,;|timers:,;tick:@1;create_timer:@2;any_timer_active:@3;get_timer_percent:@4;|act;0;timer,;room_init,kill,clean,delete|update:@1;clean:@2;kill:@3;delete:@4;get:@5;alive:yes;i:nf;u:nf;room_init:nf;destroyed:nf;|ma_able;0;act,;|name:thing;|confined;0;act,;room_end,|room_end:nf;|loopable;0;act,;|tl_loop:yes;|pos;0;act,;|x:0;y:0;|knock;0;col,;|;|popper;0;col,;|bad;0;knock,;|x_bounded;0;dim,;|check_bounds_x:@1;|y_bounded;0;dim,;|check_bounds_y:@1;|vec;0;pos,;|dx:0;dy:0;vec_update:@1;|mov;0;vec,;|inertia_x:1;inertia_y:1;ax:0;ay:0;mov_update:@1;stop:@2;|dim;0;pos,;|rx:.375;ry:.375;|dim;0;pos,;debug_rect,|rx:.375;ry:.375;debug_rect:@1;|rel;0;act,;rel_update,|rel_actor:null;rel_x:0;rel_y:0;rel_dx:0;rel_dy:0;flippable:no;rel_update:@1;|drawable_obj;0;pos,;reset_off,|ixx:0;iyy:0;xx:0;yy:0;visible:yes;reset_off:@1;|drawable;0;drawable_obj,;d,|d:nf;|drawable_1;0;drawable_obj,;d,|drawable_2;0;drawable_obj,;d,|pre_drawable;0;drawable_obj,;d,|pre_drawable_1;0;drawable_obj,;d,|pre_drawable_2;0;drawable_obj,;d,|post_drawable;0;drawable_obj,;d,|post_drawable_1;0;drawable_obj,;d,|post_drawable_2;0;drawable_obj,;d,|above_map_post_camera_drawable;0;drawable_obj,;d,|spr_obj;0;vec,drawable_obj,;|sind:0;outline_color:BG_UI;sw:1;sh:1;xf:no;yf:no;|spr;0;spr_obj,;|d:@1;|knockbackable;0;mov,timer,;|knockback:@1;apply_knockback:@2;knockback_speed:0;knockback_dir:0;|hurtable;0;act,;|health:1;max_health:1;hurt_cooldown_time:60;hurt_start:nf;hurt_end:nf;hurt:@1;heal:@2;|trig;0;vec,dim;|contains:nf;intersects:nf;not_contains_or_intersects:nf;contains_or_intersects:@1;trigger_update:@1;|anchored;1;vec,dim;|touchable:@1;hit:nf;|col;0;vec,dim;|touchable:yes;hit:nf;move_check:@1;|dx:0;dy:0|x,dx,@1,@2,@3,@4;y,dy,@1,@2,@5,@6;|tcol;0;vec,dim;|tile_solid:yes;tile_hit:nf;coll_tile:@1;|@1,31,10,7;@2,31,18,7;|view;4;act,confined;center_view,update_view|x:0;y:0;room_crop:2;tl_loop:yes;w:@1;h:@2;follow_dim:@3;follow_act:@4;update_view:@5;center_view:@6;change_ma:@7;,;|@1,x,w,ixx;@1,y,h,iyy|simple_enemy;2;drawable,col,confined,mov,x_bounded,y_bounded,knockbackable,hurtable|x:@1;y:@2;u:@3;d:@4;hit:@5;health:3;max_health:3;rx:.375;ry:.375;touchable:no;inertia_x:.90;inertia_y:.90;|angry_particle;5;pre_drawable,mov|x:@1;y:@2;beg_color:@3;end_color:@4;i:@6;d:@7;inertia_x:.90;inertia_y:.90;tl_max_time=@5,;|fist;3;col,confined,rel|rel_actor:@1;x:@2;y:@3;i:@4;d:@5;touchable:no;rx:.25;ry:.5;tl_max_time=.33,;|pl;2;drawable,pos,confined,mov,x_bounded,y_bounded,col,spr_obj,knockbackable,hurtable|x:@1;y:@2;health:3;max_health:3;insane_level:0;sh:2;sind:137;inertia_x:.90;inertia_y:.90;dir:0;is_facing_left:no;d:@3;u:@4;damage:@5;hurt_start:@6;hurt_end:@7;|x:0;y:0;w:15;h:12;|timer,tick;act,update;mov,mov_update;pl,move_check,@1;simple_enemy,move_check,@2;simple_enemy,move_check,@3;rel,rel_update;vec,vec_update;x_bounded,check_bounds_x;y_bounded,check_bounds_y;act,clean;|pre_drawable,d;pre_drawable_1,d;pre_drawable_2,d;|drawable,d;drawable_1,d;drawable_2,d;post_drawable,d;post_drawable_1,d;post_drawable_2,d;|i=@3,u=@4,d=@5;|","|")
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
function zprint(str,x,y,align,fg,bg)
if align==0 then x-=#str*2
elseif align>0 then x-=#str*4+1 end
batch_call_new(print,[[1]],str,x,y,fg,bg)
end
function zclip(x1,y1,x2,y2)
clip(x1,y1,x2+1-flr(x1),y2+1-flr(y1))
end
function zcls(col)
batch_call_new(rectfill,[[2]],col or 0)
end
function zrect(x1,y1,x2,y2)
batch_call_new(rect,
[[3]],x1,y1,x2,y2)
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
function tprint(str,x,y,c1,c2)
for i=-1,1 do
for j=-1,1 do
zprint(str,x+i,y+j,0,BG_UI,BG_UI)
end
end
zprint(str,x,y,0,c1,c2)
end
g_fadetable=ztable[[4]]
function fade(i)
for c=0,15 do
pal(c,g_fadetable[c+1][min(flr(i+1),7)])
end
end
create_actor([[5|6]],function(a)
g_card_fade=max(a.tl_tim/a.tl_max_time*10,g_card_fade)
end)
create_actor([[7|6]],function(a)
g_card_fade=min((a.tl_max_time-a.tl_tim)/a.tl_max_time*10,g_card_fade)
end)
create_parent([[8|9]],function(a)
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
create_parent([[10|11]],function(a)
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
create_parent[[12|13]]
create_parent[[14|15]]
create_parent[[16|17]]
create_parent[[18|19]]
create_parent[[20|21]]
create_parent[[22|21]]
create_parent[[23|21]]
create_parent([[24|25]],function(a)
if a.x+a.dx<g_room.x+a.rx then
a.x=g_room.x+a.rx
a.dx=0
end
if a.x+a.dx>g_room.x+g_room.w-a.rx then
a.x=g_room.x+g_room.w-a.rx
a.dx=0
end
end)
create_parent([[26|27]],function(a)
if a.y+a.dy<g_room.y+a.ry then
a.y=g_room.y+a.ry
a.dy=0
end
if a.y+a.dy>g_room.y+g_room.h-a.ry then
a.y=g_room.y+g_room.h-a.ry
a.dy=0
end
end)
create_parent([[28|29]],function(a)
a.x+=a.dx
a.y+=a.dy
end)
create_parent([[30|31]],function(a)
a.dx+=a.ax a.dy+=a.ay
a.dx*=a.inertia_x a.dy*=a.inertia_y
if a.ax==0 and abs(a.dx)<.01 then a.dx=0 end
if a.ay==0 and abs(a.dy)<.01 then a.dy=0 end
end,function(a)
a.ax,a.ay,a.dx,a.dy=0,0,0,0
end)
create_parent[[32|33]]
create_parent([[34|35]],function(a)
scr_rect(a.x-a.rx,a.y-a.ry,a.x+a.rx,a.y+a.ry,8)
end)
create_parent([[36|37]],function(a)
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
create_parent([[38|39]],function(a)
a.xx,a.yy=0,0
end)
create_parent[[40|41]]
create_parent[[42|41]]
create_parent[[43|41]]
create_parent[[44|41]]
create_parent[[45|41]]
create_parent[[46|41]]
create_parent[[47|41]]
create_parent[[48|41]]
create_parent[[49|41]]
create_parent[[50|41]]
create_parent[[51|52]]
create_parent([[53|54]],scr_spr)
create_parent([[55|56]],function(a,direction)
if not a:any_timer_active("knockback")then
a.knockback_speed=.075
a.knockback_dir=direction
a:create_timer("knockback",4)
end
end,function(a)
a.ax=cos(a.knockback_dir)*a.knockback_speed
a.ay=sin(a.knockback_dir)*a.knockback_speed
end)
create_parent([[57|58]],function(a,damage)
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
create_parent([[59|60]],function(a,b)
if does_a_contain_b(a,b)then
a:contains(b)
elseif do_actors_intersect(a,b)then
a:intersects(b)
else
a:not_contains_or_intersects(b)
end
end)
create_parent[[61|62]]
create_parent([[63|64]],function(a,acts)
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
hit_list[b]=hit_list[b]or ztable[[65]]
batch_call_new(col_help,[[66]],a,b,x,dx,y,dy)
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
create_parent([[67|68]],function(a,solid_func)
local x,dx=coll_tile_help(a.x,a.y,a.dx,a.rx,a.ry,0,a,a.tile_hit,solid_func)
local y,dy=coll_tile_help(a.y,a.x,a.dy,a.ry,a.rx,2,a,a.tile_hit,function(y,x)return solid_func(x,y)end)
if a.tile_solid then
a.x,a.y,a.dx,a.dy=x,y,dx,dy
end
end)
g_tbox_messages,g_tbox_anim,g_tbox_max_len={},0,25
function tbox_interact()
if g_tbox_active then
g_tbox_anim+=.5
g_tbox_writing=g_tbox_anim<#g_tbox_active.l1+#g_tbox_active.l2
if not g_tbox_writing then
g_tbox_anim=#g_tbox_active.l1+#g_tbox_active.l2
end
if g_tbox_writing then
end
if btnp"4"or btnp"5"and g_tbox_anim>.5 then
g_tbox_update=true
end
end
end
function tbox(str,trigger)
g_tbox_messages.trigger=trigger or nf
for i,x in pairs(split(str,"^"))do
if i%2==1 then
add(g_tbox_messages,{l1=x,l2=""})
else
g_tbox_messages[#g_tbox_messages].l2=x
end
end
g_tbox_active=g_tbox_messages[1]
end
function tbox_draw(x,y)
if g_tbox_active then
camera(-x,-y)
rectfill(0,0,96,32,0)
rect(1,1,95,31,7)
rect(6,6,25,26,7)
batch_call_new(print,[[69]],
sub(g_tbox_active.l1,1,g_tbox_anim),
sub(g_tbox_active.l2,0,max(g_tbox_anim-#g_tbox_active.l1,0))
)
if not g_tbox_writing then
spr(123,88,ti(.6,.3)and 25 or 26)
end
camera()
end
end
function tbox_clear()
g_tbox_messages,g_tbox_anim,g_tbox_active={},0,false
end
function update_view_helper(view,xy,wh,ii)
local follow_coord=view.follow_act and(view.follow_act[xy]+view.follow_act[ii]/8)or 0
local view_coord=view[xy]
local view_dim=view[wh]
local room_dim=g_cur_room[wh]/2-view_dim/2
local room_coord=g_cur_room[xy]+g_cur_room[wh]/2
local follow_dim=round(view.follow_dim*8)/8
if follow_coord<view_coord-follow_dim then view_coord=follow_coord+follow_dim end
if follow_coord>view_coord+follow_dim then view_coord=follow_coord-follow_dim end
if view_coord<room_coord-room_dim then view_coord=room_coord-room_dim end
if view_coord>room_coord+room_dim then view_coord=room_coord+room_dim end
if g_cur_room[wh]<=view[wh]then view_coord=room_coord end
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
function scr_map(cel_x,cel_y,sx,sy,...)
map(cel_x,cel_y,sx*8,sy*8,...)
end
function scr_circfill(x,y,r,col)
circfill(x*8,y*8,r*8,col)
end
function scr_circ(x,y,r,col)
circ(x*8,y*8,r*8,col)
end
create_actor([[70|71]],
function(a)
if a.follow_act and not a.follow_act.alive then
a.follow_act=nil
end
batch_call_new(update_view_helper,[[72]],a)
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
create_actor([[73|74]],function(a)
if not a:any_timer_active("cooldown","walk")then
a.dir=atan2(g_pl.x-a.x,g_pl.y-a.y)+rnd(.125)-.125/2
a:create_timer("walk",flr_rnd(10)+10,function()a:create_timer("cooldown",flr_rnd(80)+120)end)
end
if a:any_timer_active"knockback"then
a:apply_knockback()
elseif a:any_timer_active"walk"then
a.ax=cos(a.dir)*.01
a.ay=sin(a.dir)*.01
else
a.ax=0
a.ay=0
end
end,function(a)
scr_circ(a.x,a.y,.4,10)
end,function(a,other)
if other.pl and not other:any_timer_active("roll")then
other:damage(a)
a:knockback(atan2(a.x-other.x,a.y-other.y))
elseif other.fist then
a:hurt(g_pl.insane_level==4 and 2 or 1)
g_pl:knockback(atan2(g_pl.x-a.x,g_pl.y-a.y))
a:knockback(atan2(a.x-other.x,a.y-other.y))
end
end)
create_actor([[75|76]],function(a)
a.dx=rnd(.2)-.1
a.dy=-rnd(.2)-.1
end,function(a)
local color=a.beg_color
if a.tl_tim then
if a.tl_tim/a.tl_max_time>.5 then
color=a.end_color
end
scr_circfill(a.x,a.y,.125,color)
end
end)
create_actor([[77|78]],function(a)
a.rel_dx=cos(a.rel_actor.dir)*.05
a.rel_dy=sin(a.rel_actor.dir)*.05
end)
create_actor([[79|80]],function(a)
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
elseif abs(a.dx)>.001 or abs(a.dy)>.001 then
a.sind=a.tl_tim%.25>.125 and 134 or 135
end
a.xf=a.is_facing_left
scr_spr(a)
end,function(a)
if g_debug and btnp(4)then a.insane_level=(a.insane_level+1)%5 end
local speed_multiplier=1+a.insane_level/10
if a.insane_level==4 then
_g.angry_particle(a.x,a.y+.5,8,8,rnd(.25)+.25)
elseif a.insane_level==3 then
_g.angry_particle(a.x,a.y+.5,14,14,rnd(.2))
elseif a.insane_level==2 then
_g.angry_particle(a.x,a.y+.5,2,2,rnd(.2))
elseif a.insane_level==1 then
_g.angry_particle(a.x,a.y+.5,1,1,rnd(.2))
end
if not a:any_timer_active("cooldown","roll","punch")then
if btn(4)then
a:create_timer("roll",20,function()a.dx/=3 a.dy/=3 a:create_timer("cooldown",20)end)
elseif btn(5)then
a:create_timer("punch",20,function()a:create_timer("cooldown",10)end)
_g.fist(a,a.x,a.y)
end
end
local is_moving=xbtn()~=0 or ybtn()~=0
if a:any_timer_active"knockback"then
a:apply_knockback()
elseif a:any_timer_active"roll"then
a.ax=cos(a.dir)*.03
a.ay=sin(a.dir)*.03
elseif a:any_timer_active"punch"then
a.ax=cos(a.dir)*.015
a.ay=sin(a.dir)*.015
elseif is_moving then
if xbtn()~=0 then
a.is_facing_left=xbtn()<0
end
a.dir=atan2(xbtn()==0 and(a.is_facing_left and-1 or 1)or xbtn(),ybtn())
local dir=atan2(xbtn(),ybtn())
a.ax=cos(dir)*.015
a.ay=sin(dir)*.015
else
a.dir=atan2(a.is_facing_left and-1 or 1,0)
a.ax=0
a.ay=0
end
a.ax*=speed_multiplier
a.ay*=speed_multiplier
end,function(a,other)
a:hurt()
a:knockback(atan2(a.x-other.x,a.y-other.y))
end,function(a)
a.insane_level=4
end,function(a)
a.insane_level=0
end)
function game_init(a)
_g.fader_in(.5,nf,nf)
g_room=ztable[[81]]
g_pl=_g.pl(g_room.w/2,g_room.h/2)
_g.simple_enemy(3,2)
tbox"hello, how are^you?"
end
function game_update(a)
batch_call_new(acts_loop,[[82]],g_act_arrs["col"],g_act_arrs["pl"],g_act_arrs["fist"])
if g_tbox_update then
if g_tbox_writing then
g_tbox_anim=#g_tbox_active.l1+#g_tbox_active.l2
else
del(g_tbox_messages,g_tbox_active)
g_tbox_active,g_tbox_anim=g_tbox_messages[1],0
end
g_tbox_update=false
end
tbox_interact()
end
function game_draw(a)
fade(g_card_fade)
local x1,x2,y1,y2=8-g_room.w/2,8+g_room.w/2-1/8,8-g_room.h/2,8+g_room.h/2-1/8
local off_x,off_y=0,0
zclip(x1*8+off_x*8,y1*8+off_y*8,x2*8+off_x*8,y2*8+off_y*8)
zcls(1)
camera(-x1*8-off_x*8,-y1*8-off_y*8)
map(0,0,0,0,15,12)
rect(0,2,10,10,7,8)
batch_call_new(acts_loop,[[83]])
isorty(g_act_arrs.drawable)
batch_call_new(acts_loop,[[84]])
if g_debug then acts_loop("dim","debug_rect")end
clip()
camera()
tbox_draw(16,48)
local y=14.5
scr_rect(.625,y+0,1.625,y+1,8)
scr_rect(14.375,y+0,15.375,y+1,8)
scr_rect(2.125,y+.125,2.125+3.75,y+.875,1)
scr_rect(2.125+3.75,y+.375,6.125,y+.625,1)
scr_rect(6.125,y+.125,6.125+3.75,y+.875,1)
scr_rect(13.875-3.75-.25,y+.375,13.875-3.75,y+.625,1)
scr_rect(13.875-3.75,y+.125,13.875,y+.875,1)
if g_pl.health>2 then scr_rect(5.375+.5+.125,.5,5.375+1.5+.125,1.5,8)end
if g_pl.health>0 then scr_rect(5.375+2+.125,.5,5.375+3+.125,1.5,8)end
if g_pl.health>1 then scr_rect(5.375+3.5+.125,.5,5.375+4.5+.125,1.5,8)end
end
g_debug=false
g_card_fade=8
poke(0x5f5c,15)
poke(0x5f5d,15)
function _init()
music(0,3000)
g_tl=ztable([[85]],logo_draw,function()sfx"63" end,
game_init,game_update,game_draw
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