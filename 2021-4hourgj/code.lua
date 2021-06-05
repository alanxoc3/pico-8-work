g_gunvals_raw="|!plus/@1/-2,!plus/@2/-2,!plus/@3/2,!plus/@4/2,13;!plus/@1/-1,!plus/@2/-1,!plus/@3/1,!plus/@4/1,1;|@1,@2,!plus/@3/1,@5;@1,@2,@3,@4;|0x8000,0x8000,0x7fff,0x7fff,@1|0,0,0,0,0,0,0;1,1,1,0,0,0,0;2,2,2,1,0,0,0;3,3,3,1,0,0,0;4,2,2,2,1,0,0;5,5,1,1,1,0,0;6,13,13,5,5,1,0;7,6,13,13,5,1,0;8,8,2,2,2,0,0;9,4,4,4,5,0,0;10,9,4,4,5,5,0;11,3,3,3,3,0,0;12,12,3,1,1,1,0;13,5,5,1,1,1,0;14,13,4,2,2,1,0;15,13,13,5,5,1,0;|fader_out;3;act,;update,|fade_time:@1;i:@2;e:@3;u:@4;tl_max_time=@1,|fader_in;3;act,;update,|act;0;,;room_init,pause_init,pause_update,pause_end,kill,clean,delete|alive:yes;stun_countdown:0;i:nf;u:nf;update:@1;clean:@2;kill:@3;delete:@4;room_init:nf;create_init:nf;pause_init:nf;pause_update:nf;pause_end:nf;destroyed:nf;get:@5;|ma_able;0;act,;|name:thing;|confined;0;act,;room_end,|room_end:nf;|loopable;0;act,;|tl_loop:yes;|pos;0;act,;|x:0;y:0;|move_pause;0;act,;update,move,vec_update,tick|;|dim;0;pos,;|rx:.375;ry:.375;|knock;0;col,;|popper;0;col,;|bad;0;knock,;|kill_too_high;0;pos,|check_height:@1;|bounded;0;act,;|check_bounds:@1;x_check_bounds:@2;y_check_bounds:@3;|x_bounded;0;bounded,;|check_bounds:$x_check_bounds;|y_bounded;0;bounded,;|check_bounds:$y_check_bounds;|timed;0;act,;|t:0;tick:@1;|vec;0;pos,;|dx:0;dy:0;vec_update:@1;|mov;0;vec,;|ix:1;iy:1;ax:0;ay:0;move:@1;stop:@2;|dim;0;pos,;debug_rect,|rx:.375;ry:.375;debug_rect:@1;|rel;0;act,;rel_update,|rel_actor:null;rel_x:0;rel_y:0;rel_dx:0;rel_dy:0;flippable:no;rel_update:@1;|drawable_obj;0;pos,;reset_off,|ixx:0;iyy:0;xx:0;yy:0;visible:yes;reset_off:@1;|drawable;0;drawable_obj,;d,|d:nf;|drawable_1;0;drawable_obj,;d,|drawable_2;0;drawable_obj,;d,|pre_drawable;0;drawable_obj,;d,|pre_drawable_1;0;drawable_obj,;d,|pre_drawable_2;0;drawable_obj,;d,|post_drawable;0;drawable_obj,;d,|post_drawable_1;0;drawable_obj,;d,|post_drawable_2;0;drawable_obj,;d,|above_map_post_camera_drawable;0;drawable_obj,;d,|spr_obj;0;vec,drawable_obj,;|sind:0;outline_color:BG_UI;sw:1;sh:1;xf:no;yf:no;draw_spr:@1;draw_out:@2;draw_both:@3;|spr;0;spr_obj,;|d:@1;|knockable;0;mov,;|knockback:@1;|stunnable;0;mov,drawable_obj;|stun_update:@1;|hurtable;0;act,;|health:1;max_health:1;health_visible:yes;hurt:@1;heal:@2;|brang_hurtable;0;hurtable,;|anim;0;spr,timed;|sinds:,;anim_loc:1;anim_off:0;anim_len:1;anim_spd:0;anim_sind:null;anim_update:@1;|trig;0;vec,dim;|contains:nf;intersects:nf;not_contains_or_intersects:nf;contains_or_intersects:@1;trigger_update:@1;|anchored;1;vec,dim;|touchable:@1;hit:nf;|col;0;vec,dim;|touchable:yes;hit:nf;move_check:@1;|dx:0;dy:0|x,dx,@1,@2,@3,@4;y,dy,@1,@2,@5,@6;|tcol;0;vec,dim;|tile_solid:yes;tile_hit:nf;coll_tile:@1;|interactable;0;spr,anchored/yes,confined,ma_able;|interactable_trigger:nf;trig_x:0;trig_y:0;trig_rx:.75;trig_ry:.75;trig:null;i:@1;interactable_init:@1;|nnpc;0;drawable,danceable,interactable,ma_able;|rx:.5;ry:.5;iyy:-2;u:%look_at_pl|bashable;0;rel,knockable,col;|bash_dx:1;rel_bash_dx:1;hit:@1;bash:@1;|item;0;drawable,rel,confined,spr_obj;|being_held:yes;destroyed:@1;|pokeable;0;rel,drawable_obj,item;|i:@1;u:@2;e:@3;poke_init:@1;poke_update:@2;poke_end:@3;poke_update_reverse:@4;poke:20;poke_dist:20;poke_energy:0;|shop_item;0;drawable,interactable,ma_able;update,|costable:yes;interactable_trigger:@1;rx:.5;ry:.5;iyy:-3;trig_x:0;trig_y:.125;trig_rx:.5;trig_ry:.625;mem_loc:BOGUS_SPOT;cost:99|mem_dep;0;act,;|room_init:@1;mem_loc:BOGUS_SPOT;mem_loc_expect:yes;|pl;3;drawable,spr,mov,tcol,col,confined,bounded|x:@1;y:@2;xf:no;ix:.90;iy:.98;touching_ground:no;jump_speed:.5;sind:6;ay:.01;u:@4;d:@5;|view;4;act,confined;center_view,update_view|x:0;y:0;room_crop:2;tl_loop:yes;w:@1;h:@2;follow_dim:@3;follow_act:@4;update_view:@5;center_view:@6;change_ma:@7;,;|@1,x,w,ixx;@1,y,h,iyy|i=@3,u=@4,d=@5;|x:0;y:0;w:16;h:16;|act,update;drawable_obj,reset_off;mov,move;pl,move_check,@1;tcol,coll_tile,@2;rel,rel_update;vec,vec_update;kill_too_high,check_height;bounded,check_bounds;anim,anim_update;timed,tick;view,update_view;|act,clean|pre_drawable,d;pre_drawable_1,d;pre_drawable_2,d;|drawable,d;drawable_1,d;drawable_2,d;post_drawable,d;post_drawable_1,d;post_drawable_2,d;|"
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
g_gunvals=split(g_gunvals_raw,"|")
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
g_out_cache=ztable[[1]]
function zspr(sind,x,y,sw,sh,...)
sw,sh=sw or 1,sh or 1
spr(sind,x-sw*4,y-sh*4,sw,sh,...)
end
function scr_spr(a,spr_func,...)
if a and a.visible then
(spr_func or zspr)(a.sind,a.x*8+a.ixx+a.xx,a.y*8+a.iyy+a.yy,a.sw,a.sh,a.xf,a.yf,...)
end
end
function scr_spr_out(a)scr_spr(a,spr_out,a.outline_color)end
function scr_spr_and_out(...)
foreach({...},scr_spr_out)
foreach({...},scr_spr)
end
function zrect(x1,y1,x2,y2)
batch_call_new(rect,
[[2]],x1,y1,x2,y2)
end
function outline_helper(flip,coord,dim)
coord=coord-dim*4
if flip then
return dim*8-1+coord,-1
else
return coord,1
end
end
function spr_out(sind,x,y,sw,sh,xf,yf,col)
local ox,x_mult=outline_helper(xf,x,sw)
local oy,y_mult=outline_helper(yf,y,sh)
local out_tbl=g_out_cache[sind]
if out_tbl then
for i=1,#out_tbl,4 do
rectfill(
ox+x_mult*out_tbl[i],
oy+y_mult*out_tbl[i+1],
ox+x_mult*out_tbl[i+2],
oy+y_mult*out_tbl[i+3],
col)
end
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
function zprint(str,x,y,align,fg,bg)
if align==0 then x-=#str*2
elseif align>0 then x-=#str*4+1 end
batch_call_new(print,[[3]],str,x,y,fg,bg)
end
function zclip(x1,y1,x2,y2)
clip(x1,y1,x2+1-flr(x1),y2+1-flr(y1))
end
function zcls(col)
batch_call_new(rectfill,[[4]],col or 0)
end
g_fadetable=ztable[[5]]
function fade(i)
for c=0,15 do
pal(c,g_fadetable[c+1][min(flr(i+1),7)])
end
end
create_actor([[6|7]],function(a)
g_card_fade=max(a.tl_tim/a.tl_max_time*10,g_card_fade)
end)
create_actor([[8|7]],function(a)
g_card_fade=min((a.tl_max_time-a.tl_tim)/a.tl_max_time*10,g_card_fade)
end)
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
create_parent([[9|10]],function(a)
if a.alive and a.stun_countdown<=0 then
if tl_node(a)then
a.alive=false
end
elseif a.stun_countdown>0 then
a.stun_countdown-=1
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
create_parent[[21|22]]
create_parent[[23|20]]
create_parent[[24|20]]
create_parent[[25|20]]
create_parent([[26|27]],function(a)
if a.y<g_main_view.y-g_main_view.h/2-8 then
a:kill()
end
end)
create_parent([[28|29]],function(a)
a:x_check_bounds()
a:y_check_bounds()
end,function(a)
if a.x+a.dx<g_cur_room.x+.5 then
a.x=g_cur_room.x+.5
a.dx=0
end
if a.x+a.dx>g_cur_room.x+g_cur_room.w-.5 then
a.x=g_cur_room.x+g_cur_room.w-.5
a.dx=0
end
end,function(a)
if a.y+a.dy<g_cur_room.y+.5 then
a.y=g_cur_room.y+.5
a.dy=0
end
if a.y+a.dy>g_cur_room.y+g_cur_room.h-.5 then
a.y=g_cur_room.y+g_cur_room.h-.5
a.dy=0
end
end)
create_parent[[30|31]]
create_parent[[32|33]]
create_parent([[34|35]],function(a)
a.t+=1
end)
create_parent([[36|37]],function(a)
a.x+=a.dx
a.y+=a.dy
end)
create_parent([[38|39]],function(a)
a.dx+=a.ax a.dy+=a.ay
a.dx*=a.ix a.dy*=a.iy
if a.ax==0 and abs(a.dx)<.01 then a.dx=0 end
if a.ay==0 and abs(a.dy)<.01 then a.dy=0 end
end,function(a)
a.ax,a.ay,a.dx,a.dy=0,0,0,0
end)
create_parent([[40|41]],function(a)
scr_rect(a.x-a.rx,a.y-a.ry,a.x+a.rx,a.y+a.ry,8)
end)
create_parent([[42|43]],function(a)
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
create_parent([[44|45]],function(a)
a.xx,a.yy=0,0
end)
create_parent[[46|47]]
create_parent[[48|47]]
create_parent[[49|47]]
create_parent[[50|47]]
create_parent[[51|47]]
create_parent[[52|47]]
create_parent[[53|47]]
create_parent[[54|47]]
create_parent[[55|47]]
create_parent[[56|47]]
create_parent([[57|58]],scr_spr,scr_out,scr_spr_and_out
)
create_parent([[59|60]],scr_spr_and_out)
create_parent([[61|62]],function(a,speed,xdir,ydir)
a.dx=xdir*speed
a.dy=ydir*speed
end)
create_parent([[63|64]],function(a)
if a.stun_countdown>0 then
a.ay,a.ax=0,0
a.yy=rnd_one()
a.outline_color=2
else
a.outline_color=1
end
end)
create_parent([[65|66]],function(a,damage,stun_val)
if a.stun_countdown<=0 then
a.stun_countdown=stun_val
a.health=max(0,a.health-damage)
if a.health==0 then
a.alive=false
end
end
end,function(a,health)
a.health=min(a.max_health,a.health+health)
end)
create_parent[[67|20]]
create_parent([[68|69]],function(a)
if a.anim_sind then
a.sind=a.anim_sind
else
if a.t%a.anim_spd==0 then
a.anim_off+=1
a.anim_off%=a.anim_len
end
a.sind=a.sinds[a.anim_loc+a.anim_off]or 0xffff
end
end)
create_parent([[70|71]],function(a,b)
if does_a_contain_b(a,b)then
a:contains(b)
elseif do_actors_intersect(a,b)then
a:intersects(b)
else
a:not_contains_or_intersects(b)
end
end)
create_parent[[72|73]]
create_parent([[74|75]],function(a,acts)
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
hit_list[b]=hit_list[b]or ztable[[76]]
batch_call_new(col_help,[[77]],a,b,x,dx,y,dy)
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
create_parent([[78|79]],function(a,solid_func)
local x,dx=coll_tile_help(a.x,a.y,a.dx,a.rx,a.ry,0,a,a.tile_hit,solid_func)
local y,dy=coll_tile_help(a.y,a.x,a.dy,a.ry,a.rx,2,a,a.tile_hit,function(y,x)return solid_func(x,y)end)
if a.tile_solid then
a.x,a.y,a.dx,a.dy=x,y,dx,dy
end
end)
create_parent([[80|81]],function(a)
a.trig=_g.gen_trigger_block(a,a.trig_x,a.trig_y,a.trig_rx,a.trig_ry,nf,function(trig,other)
if npc_able_to_interact(a,other)then
change_cur_ma(a)
if able_to_interact(a,other)then
a:interactable_trigger()
end
else
if get_cur_ma()==a then
change_cur_ma()
end
end
end)
end)
create_parent[[82|83]]
create_parent([[84|85]],function(a,o)
if o!=a.rel_actor then
call_not_nil(o,"knockback",o,a.bash_dx,bool_to_num(a.xf),0)
change_cur_ma(o)
if a.rel_actor then
call_not_nil(a.rel_actor,"knockback",a.rel_actor,-a.rel_bash_dx,bool_to_num(a.xf),0)
end
end
end
)
create_parent([[86|87]],function(a)
if a==a.rel_actor.item then a.rel_actor.item=nil end
end)
create_parent([[88|89]],function(a)
a.xf=a.rel_actor.xf
a.ixx=a.xf and a.poke_ixx or-a.poke_ixx
use_energy(a.poke_energy)
end,function(a)
a.rel_dx=bool_to_num(a.xf)*a.poke_dist/a.tl_max_time/FPS
pause_energy()
end,function(a)
a.rel_dx,a.rel_x=0,a.xf and-a.poke_dist or a.poke_dist
end,function(a)
a.rel_dx=-bool_to_num(a.xf)*a.poke_dist/a.tl_max_time/FPS/2
end)
create_parent([[90|91]],function(a)
if remove_money(a.cost)then
a:kill()
_g.item_show(g_pl,a.sind,a.mem_loc)
pause"chest"
stop_music"1"
else
zsfx(2,6)
end
end)
create_parent([[92|93]],function(a)
if zdget(a.mem_loc)==a.mem_loc_expect then
a:delete()
end
end)
create_actor([[94|95]],function(a)
a.ax=.02*xbtn()
if xbtn()>0 then a.xf=false end
if xbtn()<0 then a.xf=true end
if btnp(4)then
a.dy=-a.jump_speed
end
end)
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
create_actor([[96|97]],
function(a)
if a.follow_act and not a.follow_act.alive then
a.follow_act=nil
end
batch_call_new(update_view_helper,[[98]],a)
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
g_debug=false
g_card_fade=8
poke(0x5f5c,15)
poke(0x5f5d,15)
menuitem(1,"restart",function()
extcmd"reset"
end)
g_level_coins=0
g_level_max_coins=0
g_stats={
time_start=0,
coins=0,
max_coins=0,
deaths=0,
shots=0,
}
function _init()
music(0,3000)
g_tl=ztable([[99]],logo_draw,function()sfx"63" end,
game_init,game_update,game_draw
)
end
function game_init(a)
_g.fader_in(.5,nf,nf)
g_main_view=_g.view(16,16,0,bucket)
g_pl=_g.pl(3,3)
g_cur_room=tabcpy(ztable[[100]])
end
function game_update(a)
batch_call_new(
acts_loop,[[101]],g_act_arrs["col"],
function(x,y)
return x>=g_cur_room.x and x<g_cur_room.x+g_cur_room.w and
y>=g_cur_room.y and y<g_cur_room.y+g_cur_room.h and
fget(mget(x,y),6)
end
)
batch_call_new(acts_loop,[[102]])
end
function game_draw(a)
fade(g_card_fade)
map_draw(g_main_view,8,8)
end
function logo_draw(a)
local logo_opacity=8+cos(a.tl_tim/a.tl_max_time)*4-4
fade(logo_opacity)
camera(logo_opacity>1 and rnd_one())
zspr(108,a.x,a.y,4,2)
fade"0"
camera()
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
function shiftx(view)
return(view.x-view.off_x-8)*8
end
function shifty(view)
return(view.y-view.off_y-8)*8
end
function camera_to_view(view)
camera(shiftx(view),shifty(view))
end
function map_draw(view,x,y)
if view then
local rx=x-view.w/2
local ry=y-view.h/2
view.off_x=-(16-view.w)/2+rx
view.off_y=-(16-view.h)/2+ry
local x1,x2=rx*8+4,(rx+view.w)*8-5
local y1,y2=ry*8+4,(ry+view.h)*8-5
camera_to_view(view)
zclip(x1,y1,x2,y2)
zcls(g_cur_room.c)
scr_map(g_cur_room.x,g_cur_room.y,g_cur_room.x,g_cur_room.y,g_cur_room.w,g_cur_room.h)
batch_call_new(acts_loop,[[103]])
isorty(g_act_arrs.drawable)
batch_call_new(acts_loop,[[104]])
if g_debug then
acts_loop("dim","debug_rect")
end
clip()
camera()
if g_debug then
end
end
end