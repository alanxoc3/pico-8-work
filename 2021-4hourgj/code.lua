g_gunvals_raw="|!plus/@1/-2,!plus/@2/-2,!plus/@3/2,!plus/@4/2,13;!plus/@1/-1,!plus/@2/-1,!plus/@3/1,!plus/@4/1,1;|@1,@2,!plus/@3/1,@5;@1,@2,@3,@4;|0x8000,0x8000,0x7fff,0x7fff,@1|0,0,0,0,0,0,0;1,1,1,0,0,0,0;2,2,2,1,0,0,0;3,3,3,1,0,0,0;4,2,2,2,1,0,0;5,5,1,1,1,0,0;6,13,13,5,5,1,0;7,6,13,13,5,1,0;8,8,2,2,2,0,0;9,4,4,4,5,0,0;10,9,4,4,5,5,0;11,3,3,3,3,0,0;12,12,3,1,1,1,0;13,5,5,1,1,1,0;14,13,4,2,2,1,0;15,13,13,5,5,1,0;|balloon;0;confined,col,knock,drawable,spr|balloon:yes;touchable:no;popped:no;pop:@1;|simpleballoon;2;balloon,|x:@1;y:@2;dy:-.05;destroyed:@3;sh:2;iyy:6;i:@4;tl_max_time=10,;|bubble;2;balloon,mov|x:@1;y:@2;sind:46;destroyed:@3;i:@6;u=@5,;i=@4,u=nf,tl_max_time=10,;|coin_bubble;2;balloon,mov|x:@1;y:@2;sind:42;destroyed:@3;i:@6;u=@5,;i=@4,u=nf,tl_max_time=10,;|clown_bubble;2;balloon,bad,mov|x:@1;y:@2;sind:44;destroyed:@3;i:@6;u=@5,;i=@4,u=nf,tl_max_time=10,;|fader_out;3;act,;update,|fade_time:@1;i:@2;e:@3;u:@4;tl_max_time=@1,|fader_in;3;act,;update,|x:0;y:0;w:12;h:@1;|spike_counter_left:0;spike_counter_right:0;plat_counter_left:0;plat_counter_right:0;plat_counter_middle:0;lvl:@1;room:@2;buffer:@3;infinite:@4;infinite_buffer:@5;generate:@6;|wallspike;4;drawable,confined,spr,bad,kill_too_high|x:@1;y:@2;sind:@3;xf:@4;rx:.25;touchable:no;i:@5;|minispike;4;drawable,confined,spr,bad,kill_too_high|x:@1;y:@2;sind:@3;xf:@4;ry:.25;iyy:-2;touchable:no;|boulder_spawner;4;confined,pos,dim,above_map_post_camera_drawable|x:@1;y:@2;sind:@3;xf:@4;u:@5;d:@6;|boulder;4;confined,bad,pos,drawable,spr,vec|x:@1;y:@2;sind:@3;xf:@4;dy:.2;rx:.25;ry:.25;touchable:no;tl_max_time=10,;|coin;2;confined,vec,drawable,spr,mov,col,kill_too_high|touchable:no;sind:41;x:@1;y:@2;rx:.25;ry:.25;destroyed:@3;obtain:@4;|danger_spawner;3;confined,pos,dim,above_map_post_camera_drawable|x:@1;y:@2;spawn_func:@3;u:@4;d:@5;|nice_spawner;3;confined,pos,dim,above_map_post_camera_drawable|next_lvl_control;1;above_map_post_camera_drawable,confined|bucket_control:@1;u:@2;d:@3;able_to_go_to_next_level:no;|1:well come;2:rock well;3:bub wells;4:not well;|cur_level_status;0;above_map_post_camera_drawable,vec,|d:@1;x:64;y:1;tl_max_time=1.5,;tl_max_time=1,dy=-1;|falling_clown;3;mov,drawable,spr|x:@1;y:@2;sind:30;ay:.015;tl_max_time=5,;|clown_hold_balloon;1;dim,col,mov,rel,bad|touchable:no;rel_actor:@1;rel_y:1;destroyed:@2;|clownballoon;2;confined,col,knock,drawable,spr,vec,mov|balloon:yes;x:@1;y:@2;ry:.5;iyy:4;ix:.99;iy:.99;sind:38;sh:2;touchable:no;i:@3;u:@4;destroyed:@5;pop:@6;|clown_spawner;0;confined,col,knock,drawable,spr,vec,mov|tl_loop:yes;fall_count:3;i=nf,u=nf,wait_state=yes,tl_max_time=6,;i=@1,u=@2,wait_state=no,;|title_control;0;pos,above_map_post_camera_drawable|d:@1;tl_max_time=.5,;u=@2,;|act;0;,;room_init,pause_init,pause_update,pause_end,kill,clean,delete|alive:yes;stun_countdown:0;i:nf;u:nf;update:@1;clean:@2;kill:@3;delete:@4;room_init:nf;create_init:nf;pause_init:nf;pause_update:nf;pause_end:nf;destroyed:nf;get:@5;|ma_able;0;act,;|name:thing;|confined;0;act,;room_end,|room_end:nf;|loopable;0;act,;|tl_loop:yes;|pos;0;act,;|x:0;y:0;|move_pause;0;act,;update,move,vec_update,tick|;|dim;0;pos,;|rx:.375;ry:.375;|knock;0;col,;|popper;0;col,;|bad;0;knock,;|kill_too_high;0;pos,|check_height:@1;|bounded;0;act,;|check_bounds:nf;|x_bounded;0;bounded,;|check_bounds:@1;|y_bounded;0;bounded,;|timed;0;act,;|t:0;tick:@1;|vec;0;pos,;|dx:0;dy:0;vec_update:@1;|mov;0;vec,;|ix:1;iy:1;ax:0;ay:0;move:@1;stop:@2;|rel;0;act,;rel_update,|rel_actor:null;rel_x:0;rel_y:0;rel_dx:0;rel_dy:0;flippable:no;rel_update:@1;|drawable_obj;0;pos,;reset_off,|ixx:0;iyy:0;xx:0;yy:0;visible:yes;reset_off:@1;|drawable;0;drawable_obj,;d,|d:nf;|drawable_1;0;drawable_obj,;d,|drawable_2;0;drawable_obj,;d,|pre_drawable;0;drawable_obj,;d,|pre_drawable_1;0;drawable_obj,;d,|pre_drawable_2;0;drawable_obj,;d,|post_drawable;0;drawable_obj,;d,|post_drawable_1;0;drawable_obj,;d,|post_drawable_2;0;drawable_obj,;d,|above_map_post_camera_drawable;0;drawable_obj,;d,|spr_obj;0;vec,drawable_obj,;|sind:0;outline_color:BG_UI;sw:1;sh:1;xf:no;yf:no;draw_spr:@1;draw_out:@2;draw_both:@3;|spr;0;spr_obj,;|d:@1;|knockable;0;mov,;|knockback:@1;|stunnable;0;mov,drawable_obj;|stun_update:@1;|hurtable;0;act,;|health:1;max_health:1;health_visible:yes;hurt:@1;heal:@2;|brang_hurtable;0;hurtable,;|anim;0;spr,timed;|sinds:,;anim_loc:1;anim_off:0;anim_len:1;anim_spd:0;anim_sind:null;anim_update:@1;|trig;0;vec,dim;|contains:nf;intersects:nf;not_contains_or_intersects:nf;contains_or_intersects:@1;trigger_update:@1;|anchored;1;vec,dim;|touchable:@1;hit:nf;|col;0;vec,dim;|touchable:yes;hit:nf;move_check:@1;|dx:0;dy:0|x,dx,@1,@2,@3,@4;y,dy,@1,@2,@5,@6;|tcol;0;vec,dim;|tile_solid:yes;tile_hit:nf;coll_tile:@1;|interactable;0;spr,anchored/yes,confined,ma_able;|interactable_trigger:nf;trig_x:0;trig_y:0;trig_rx:.75;trig_ry:.75;trig:null;i:@1;interactable_init:@1;|nnpc;0;drawable,danceable,interactable,ma_able;|rx:.5;ry:.5;iyy:-2;u:%look_at_pl|bashable;0;rel,knockable,col;|bash_dx:1;rel_bash_dx:1;hit:@1;bash:@1;|item;0;drawable,rel,confined,spr_obj;|being_held:yes;destroyed:@1;|pokeable;0;rel,drawable_obj,item;|i:@1;u:@2;e:@3;poke_init:@1;poke_update:@2;poke_end:@3;poke_update_reverse:@4;poke:20;poke_dist:20;poke_energy:0;|shop_item;0;drawable,interactable,ma_able;update,|costable:yes;interactable_trigger:@1;rx:.5;ry:.5;iyy:-3;trig_x:0;trig_y:.125;trig_rx:.5;trig_ry:.625;mem_loc:BOGUS_SPOT;cost:99|mem_dep;0;act,;|room_init:@1;mem_loc:BOGUS_SPOT;mem_loc_expect:yes;|view;4;act,confined;center_view,update_view|x:0;y:0;room_crop:2;tl_loop:yes;w:@1;h:@2;follow_dim:@3;follow_act:@4;update_view:@5;center_view:@6;change_ma:@7;,;|@1,x,w,ixx;@1,y,h,iyy|rope;2;post_drawable,rel,x_bounded,confined|rel_actor:@1;control:@2;sind:1;rel_y:-.625;d:@3;|bucket_parent;0;post_drawable,spr,spr_obj,dim,x_bounded,rel,tcol,col,popper,confined|sw:2;sh:2;tile_solid:no;touchable:no;ang:.75;xf:no;sind:32;eject_player_out_of_bucket:@2;tile_hit:$eject_player_out_of_bucket;bucket_update:@1;hit:@3;|bucket;3;bucket_parent,|x:@1;y:@2;rel_actor:@3;pl_in_bucket:yes;ang_speed:.001;entry_time:0;tl_max_time=.625,;u=@4,;|bucket_control;2;drawable_obj,vec,confined|x:@1;y:@2;sw:2;sh:2;pivot_x:@1;pivot_y:30;sind:34;i:@3;u:@4;destroyed:@5;|confined,room_end;confined,kill;confined,delete|act,update;|growing_circle;3;pre_drawable,drawable_obj,rel,confined|rel_actor:@1;color:@2;radius:@3;tl_max_time=.25,d=@4;|water_shot;4;post_drawable_2,mov,confined,col|x:@1;y:@2;xdir:@3;ydir:@4;touchable:no;ix:.85;iy:.85;i:@5;d:@6;tl_max_time=.5,;hit:@7;|pl_dead;3;post_drawable_1,spr,confined|x:@1;y:@2;xf:@3;sind:7;i=@4,u=@5,tl_max_time=3;|pl;3;post_drawable_1,spr,spr_obj,mov,x_bounded,tcol,popper,col,confined,y_bounded|x:@1;y:@2;xf:@3;ix:.85;iy:.85;touching_ground:no;jump_speed:.75;wall_jump_xspeed:.75;wall_jump_yspeed:.5;sind:1;iyy:-1;i:@4;u:@5;tile_hit:@6;destroyed:@8;d:@9;tl_max_time=.125,;shooting=no,u=@5,i=nf,hit=@7,;shooting=yes,tl_max_time=.25;tl_next=2,;|x=64,y=64,i=@8,u=nf,d=@1,tl_max_time=2.5;i=@2,u=@3,d=@4;i=@5,u=@6,d=@7;|water_gauge;0;above_map_post_camera_drawable,pos,confined|x:111;y:123;charge_max:10;charge:10;charge_speed:.5;d:@1;fill:@2;can_shoot:@3;empty:@4;u:@5;|act,clean|pre_drawable,d;pre_drawable_1,d;pre_drawable_2,d;|drawable,d;drawable_1,d;drawable_2,d;post_drawable,d;post_drawable_1,d;post_drawable_2,d;|"
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
create_parent([[6|7]],function(a)
a.popped=true
a:kill()
end)
create_actor([[8|9]],function(a)
if a.popped then
sfx"3"
end
end,function(a)
a.xf=flr_rnd(2)==0
a.sind=rnd_item{36,37,39,40}
end)
create_actor([[10|11]],function(a)
if a.popped then
sfx"3"
end
end,function(a)
local pl=get_pl()
amov_to_point(a,.01,pl.x,pl.y)
end,function(a)
local pl=get_pl()
if pl.y>a.y+3 then
a:next()
end
end,function(a)
a.xf=flr_rnd(2)==0
end)
create_actor([[12|13]],function(a)
g_level_max_coins+=1
if a.popped then
g_level_coins+=1
sfx"3"
end
end,function(a)
local pl=get_pl()
amov_to_point(a,.01,pl.x,pl.y)
end,function(a)
local pl=get_pl()
if pl.y>a.y+3 then
a:next()
end
end,function(a)
a.xf=flr_rnd(2)==0
end)
create_actor([[14|15]],function(a)
if a.popped then
sfx"3"
end
end,function(a)
local pl=get_pl()
amov_to_point(a,.01,pl.x,pl.y)
end,function(a)
local pl=get_pl()
if pl.y>a.y+3 then
a:next()
end
end,function(a)
a.xf=flr_rnd(2)==0
end)
create_actor([[16|17]],function(a)
g_card_fade=max(a.tl_tim/a.tl_max_time*10,g_card_fade)
end)
create_actor([[18|17]],function(a)
g_card_fade=min((a.tl_max_time-a.tl_tim)/a.tl_max_time*10,g_card_fade)
end)
function create_block(id,xf,...)
return{sind=rnd_item{...},xf=xf,id=id}
end
function draw_lvl_blocks(tbl)
for y,v in pairs(tbl)do
for x,a in pairs(v)do
spr(a.sind,x*8,y*8,1,1,a.xf,a.yf)
end
end
end
function allocate_level(blocks,context,yloc)
local buffer=flr(abs(context.buffer))
local infinite=context.infinite
local infinite_buffer=context.infinite_buffer
yloc=flr(yloc)
if infinite and yloc+infinite_buffer>context.room.h then
context.room.h=yloc+infinite_buffer
end
for y,v in pairs(blocks)do
if y<yloc-buffer then
blocks[y]=nil
end
end
for y=(yloc-buffer),(yloc+buffer)do
if not blocks[y]then
blocks[y]=context:generate(y)
end
end
end
function gen_lvl(lvl)
local infinite,generate,height,infinite_buffer,buffer
if lvl==0 then
infinite=true
generate=gen_title_row
height=30
infinite_buffer=22
buffer=18
elseif lvl>0 and lvl<4 then
infinite=false
generate=gen_well_row
height=14*14+(lvl-1)*7*7
infinite_buffer=40
buffer=18
else
infinite=true
generate=gen_clown_row
height=30
infinite_buffer=40
buffer=18
end
local room=tabcpy(ztable([[19]],height))
local context=tabcpy(ztable([[20]],lvl,room,buffer,infinite,infinite_buffer,generate))
local bucket=_g.bucket_control(room.w/2,-1.5)
local view=_g.view(15,16,0,bucket)
return context,room,bucket,view
end
function create_platform_for_row(row,y,x1,x2,s_center)
for x=x1,x2 do
row[x]=create_block("solid",false,rnd_item(s_center))
if flr_rnd(4)==0 then
_g.minispike(x+.5,y+.625-1,25,false)
end
end
end
function gen_sides_and_floor(c,y,s_bkgd,s_wall,s_side,s_center,s_floor,s_hole)
y=flr(y)
local row={}
local width=c.room.w
local bottom=c.room.h-1
if y>bottom or y<0 then
return{}
end
for x=1,flr_rnd(2)do
row[flr_rnd(width)]=create_block("bkgd",false,unpack(s_bkgd))
end
row[0]=create_block("solid",true,unpack(s_wall))
row[width-1]=create_block("solid",false,unpack(s_wall))
if c.lvl>0 and y>3 and y<bottom-4 then
if y%3==0 and flr_rnd(6)==0 then
if flr_rnd(2)==0 then
if c.spike_counter_left<-2 then
row[1]=create_block("solid",true,unpack(s_side))
c.plat_counter_left=0
end
else
if c.spike_counter_right<-2 then
row[width-2]=create_block("solid",false,unpack(s_side))
c.plat_counter_right=0
end
end
end
if c.plat_counter_middle<-6 and flr_rnd(10)==0 then
local variant=flr_rnd(5)
if variant==0 then
create_platform_for_row(row,y,width/2-1,width/2,s_center)
elseif variant==1 then
create_platform_for_row(row,y,width/2-3,width/2-2,s_center)
create_platform_for_row(row,y,width/2+1,width/2+2,s_center)
elseif variant==2 then
create_platform_for_row(row,y,width/2-1,width/2+1,s_center)
elseif variant==3 then
create_platform_for_row(row,y,width/2-2,width/2,s_center)
elseif variant==4 then
create_platform_for_row(row,y,width/2-2,width/2+1,s_center)
end
c.plat_counter_middle=0
end
c.plat_counter_middle-=1
if c.spike_counter_left>0 then
_g.wallspike(1+.25,y+.5,16,true)
elseif c.plat_counter_left<-2 and flr_rnd(12)==0 then
c.spike_counter_left=flr_rnd(2)+3
end
if c.spike_counter_right>0 then
_g.wallspike(width-1.25,y+.5,16,false)
elseif c.plat_counter_right<-2 and flr_rnd(12)==0 then
c.spike_counter_right=flr_rnd(2)+3
end
c.spike_counter_left-=1
c.spike_counter_right-=1
c.plat_counter_left-=1
c.plat_counter_right-=1
end
if y==bottom-1 or y==bottom then
for x=1,width/2-3 do
row[x]=create_block("solid",true,unpack(s_floor))
row[width-x-1]=create_block("solid",false,unpack(s_floor))
end
row[width/2-2]=create_block("solid",false,unpack(s_wall))
row[width/2+1]=create_block("solid",true,unpack(s_wall))
row[width/2-2]=create_block("solid",false,unpack(s_wall))
row[width/2+1]=create_block("solid",true,unpack(s_wall))
end
if y==bottom then
row[width/2-1]=create_block("solid",false,unpack(s_hole))
row[width/2]=create_block("solid",true,unpack(s_hole))
end
return row
end
function gen_baddies_for_row(c,y,row,chance)
y=flr(y)
local width=c.room.w
local safe_top=25
local bottom=c.room.h-1
local safe_bottom=bottom-20
local rand_x=function()
return flr_rnd(width-6)+3+.5
end
local x=rand_x()
if y>=safe_bottom or y<=safe_top or row[flr(x)]then
return
end
if c.lvl>=3 and flr_rnd(chance)==0 then
local num=flr_rnd(4)
if num==0 then
_g.nice_spawner(x,y+.5,_g.coin_bubble)
elseif num==1 then
_g.danger_spawner(x,y+.5,_g.clown_bubble)
else
_g.nice_spawner(x,y+.5,_g.bubble)
end
end
if c.lvl>=2 and flr_rnd(chance)==0 then
if c.lvl>=4 then
_g.boulder_spawner(x,y+.5,rnd_item{131,132,147,148},flr_rnd(2)==0)
else
_g.boulder_spawner(x,y+.5,13,flr_rnd(2)==0)
end
end
if c.lvl>=1 and flr_rnd(chance)==0 then
if flr_rnd(4)<2 then
_g.coin(x,y+.5)
else
_g.nice_spawner(x,y+.5,_g.simpleballoon)
end
end
end
function gen_title_row(c,y)
if y==0 then
_g.title_control()
end
if c.lvl==0 then
if y%10==0 then
_g.simpleballoon(y%20==0 and 3.5 or c.room.w-3.5,y+.5,rnd_item{19,23,36,40})
elseif(y+5)%10==0 then
_g.simpleballoon((y+5)%20==0 and c.room.w-2.5 or 2.5,y+.5,rnd_item{19,23,36,40})
end
end
return gen_sides_and_floor(
c,y,
{10,60,62,63},
{12,28},
{11,27},
{8},
{9},
{24}
)
end
function gen_well_row(c,y)
local row=gen_sides_and_floor(
c,y,
{10,60,62,63},
{12,28},
{11,27},
{8},
{9},
{24}
)
gen_baddies_for_row(c,y,row,15)
return row
end
function gen_clown_row(c,y)
if y==0 then
_g.clown_spawner()
end
local row=gen_sides_and_floor(
c,y,
{10,60,62,63},
{129},
{130,146},
{128},
{162},
{24}
)
gen_baddies_for_row(c,y,row,15)
return row
end
create_actor([[21|22]],function(a)
if a.xf then
a.ixx=3
else
a.ixx=-3
end
end)
create_actor([[23|24]])
create_actor([[25|26]],function(a)
if a.y<g_main_view.y-g_main_view.h/2-3 then
_g.boulder(a.x,a.y,a.sind,a.xf)
a:kill()
end
end,function(a)
if a.y<g_main_view.y-g_main_view.h/2 then
zprint("!",a.x*8-shiftx(g_main_view),1,0,8,2)
end
end)
create_actor([[27|28]])
create_actor([[29|30]],function(a)
g_level_max_coins+=1
if a.obtained then
g_level_coins+=1
sfx(1)
end
end,function(a)
a.obtained=true
a:kill()
end)
create_actor([[31|32]],function(a)
if a.y<g_main_view.y+g_main_view.h/2+3 then
a.spawn_func(a.x,a.y)
a:kill()
end
end,function(a)
if a.y<g_main_view.y+g_main_view.h/2+6 then
zprint("!",a.x*8-shiftx(g_main_view),128-8-7,0,8,2)
end
end)
create_actor([[33|32]],function(a)
if a.y<g_main_view.y+g_main_view.h/2+3 then
a.spawn_func(a.x,a.y)
a:kill()
end
end,function(a)
if a.y<g_main_view.y+g_main_view.h/2+6 then
zprint("!",a.x*8-shiftx(g_main_view),128-8-7,0,10,4)
end
end)
create_actor([[34|35]],function(a)
if a.bucket_control.bucket.pl_in_bucket then
a.able_to_go_to_next_level=true
else
a.able_to_go_to_next_level=false
end
if a.able_to_go_to_next_level and btn(3)then
a.bucket_control.bucket.ang_speed=0
a.bucket_control.bucket.eject_player_out_of_bucket=nf
a.bucket_control.u=nf
a.bucket_control.dy=.1
_g.fader_out(1,nf,
function()
g_stats.coins+=g_level_coins
g_stats.max_coins+=g_level_max_coins
g_level_coins=0
g_level_max_coins=0
if g_cur_level==4 then
g_tl.next()
else
tolevel((g_cur_level or 0)+1)
end
end
)
a:kill()
end
end,function(a)
if a.able_to_go_to_next_level then
local extra=t()%1<.25 and 1 or 0
zprint("press down",64,96-extra,0,7,5)
end
end)
g_puns=ztable[[36]]
create_actor([[37|38]],function(a)
if g_cur_level>0 then
zprint("level "..g_cur_level,a.x,a.y,0,7,5)
if g_puns[g_cur_level]then
zprint(g_puns[g_cur_level],a.x,a.y+8,0,7,5)
end
end
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
create_actor([[39|40]])
create_actor([[41|42]],function(a)
_g.falling_clown(a.x,a.y,a.rel_actor.xf)
end)
create_actor([[43|44]],function(a)
_g.clown_hold_balloon(a)
end,function(a)
local pl=get_pl()
a.xf=sgn(pl.x-a.x)==-1
amov_to_point(a,.005,pl.x,pl.y-2)
end,function(a)
if a.popped then
sfx"3"
end
end,function(a)
a.popped=true
a:kill()
end)
create_actor([[45|46]],function(a)
local ang=rnd(1)
local radius=12
sfx"14"
a.clown=_g.clownballoon(g_bucket_control.x+cos(ang)*radius,g_bucket_control.y+sin(ang)*radius)
end,function(a)
if not a.clown or not a.clown.alive then
a.fall_count-=1
if a.fall_count<=0 then
g_block_context.infinite=false
a:kill()
else
a.wait_state=true
a:next()
end
end
end)
create_actor([[47|48]],function(a)
local offset=0
if t()%2<.25 then offset=sin(t()*4)*2 end
zspr(72,64+offset,38,8,2)
rectfill(0,78,125,86,1)
rectfill(0,79,125,85,0)
if t()%2<1.75 then
print("press x or z",64-12*2,80,7)
end
zprint("a game for ld #48",64,113-8-8,0,6,1)
end,function(a)
if btn(4)or btn(5)then
g_stats.time_start=t()
a:kill()
g_block_context.infinite=false
_g.fader_out(.5,nf,function()tolevel(1)end)
end
end)
create_parent([[49|50]],function(a)
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
create_parent[[51|52]]
create_parent[[53|54]]
create_parent[[55|56]]
create_parent[[57|58]]
create_parent[[59|60]]
create_parent[[61|62]]
create_parent[[63|60]]
create_parent[[64|60]]
create_parent[[65|60]]
create_parent([[66|67]],function(a)
if a.y<g_main_view.y-g_main_view.h/2-8 then
a:kill()
end
end)
create_parent[[68|69]]
create_parent([[70|71]],function(a)
if a.x+a.dx<g_cur_room.x+.5 then
a.x=g_cur_room.x+.5
a.dx=0
end
if a.x+a.dx>g_cur_room.x+g_cur_room.w-.5 then
a.x=g_cur_room.x+g_cur_room.w-.5
a.dx=0
end
end)
create_parent([[72|71]],function(a)
if a.y+a.dy<g_cur_room.y+.5 then
a.y=g_cur_room.y+.5
a.dy=0
end
if a.y+a.dy>g_cur_room.y+g_cur_room.h-.5 then
a.y=g_cur_room.y+g_cur_room.h-.5
a.dy=0
end
end)
create_parent([[73|74]],function(a)
a.t+=1
end)
create_parent([[75|76]],function(a)
a.x+=a.dx
a.y+=a.dy
end)
create_parent([[77|78]],function(a)
a.dx+=a.ax a.dy+=a.ay
a.dx*=a.ix a.dy*=a.iy
if a.ax==0 and abs(a.dx)<.01 then a.dx=0 end
if a.ay==0 and abs(a.dy)<.01 then a.dy=0 end
end,function(a)
a.ax,a.ay,a.dx,a.dy=0,0,0,0
end)
create_parent([[79|80]],function(a)
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
create_parent([[81|82]],function(a)
a.xx,a.yy=0,0
end)
create_parent[[83|84]]
create_parent[[85|84]]
create_parent[[86|84]]
create_parent[[87|84]]
create_parent[[88|84]]
create_parent[[89|84]]
create_parent[[90|84]]
create_parent[[91|84]]
create_parent[[92|84]]
create_parent[[93|84]]
create_parent([[94|95]],scr_spr,scr_out,scr_spr_and_out
)
create_parent([[96|97]],scr_spr_and_out)
create_parent([[98|99]],function(a,speed,xdir,ydir)
a.dx=xdir*speed
a.dy=ydir*speed
end)
create_parent([[100|101]],function(a)
if a.stun_countdown>0 then
a.ay,a.ax=0,0
a.yy=rnd_one()
a.outline_color=2
else
a.outline_color=1
end
end)
create_parent([[102|103]],function(a,damage,stun_val)
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
create_parent[[104|60]]
create_parent([[105|106]],function(a)
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
create_parent([[107|108]],function(a,b)
if does_a_contain_b(a,b)then
a:contains(b)
elseif do_actors_intersect(a,b)then
a:intersects(b)
else
a:not_contains_or_intersects(b)
end
end)
create_parent[[109|110]]
create_parent([[111|112]],function(a,acts)
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
hit_list[b]=hit_list[b]or ztable[[113]]
batch_call_new(col_help,[[114]],a,b,x,dx,y,dy)
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
create_parent([[115|116]],function(a,solid_func)
local x,dx=coll_tile_help(a.x,a.y,a.dx,a.rx,a.ry,0,a,a.tile_hit,solid_func)
local y,dy=coll_tile_help(a.y,a.x,a.dy,a.ry,a.rx,2,a,a.tile_hit,function(y,x)return solid_func(x,y)end)
if a.tile_solid then
a.x,a.y,a.dx,a.dy=x,y,dx,dy
end
end)
create_parent([[117|118]],function(a)
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
create_parent[[119|120]]
create_parent([[121|122]],function(a,o)
if o!=a.rel_actor then
call_not_nil(o,"knockback",o,a.bash_dx,bool_to_num(a.xf),0)
change_cur_ma(o)
if a.rel_actor then
call_not_nil(a.rel_actor,"knockback",a.rel_actor,-a.rel_bash_dx,bool_to_num(a.xf),0)
end
end
end
)
create_parent([[123|124]],function(a)
if a==a.rel_actor.item then a.rel_actor.item=nil end
end)
create_parent([[125|126]],function(a)
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
create_parent([[127|128]],function(a)
if remove_money(a.cost)then
a:kill()
_g.item_show(g_pl,a.sind,a.mem_loc)
pause"chest"
stop_music"1"
else
zsfx(2,6)
end
end)
create_parent([[129|130]],function(a)
if zdget(a.mem_loc)==a.mem_loc_expect then
a:delete()
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
create_actor([[131|132]],
function(a)
if a.follow_act and not a.follow_act.alive then
a.follow_act=nil
end
batch_call_new(update_view_helper,[[133]],a)
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
create_actor([[134|135]],function(a)
local x1,y1,x2,y2=a.x+a.dx,a.y+a.dy,a.control.pivot_x,a.control.y-a.control.pivot_y
scr_line(x1,y1,x2,y2,2)
scr_line(x1-.125,y1,x2-.125,y2,2)
end)
create_parent([[136|137]],function(a)
if btnp(4)then
a:eject_player_out_of_bucket()
end
local gravity=.1
if btn(3)or btn(2)then
gravity=.2
end
if a.pl_in_bucket and xbtn()!=0 then
a.xf=xbtn()==-1
end
local pivot=a.rel_actor.pivot_y
a.ang=atan2(cos(a.ang),sin(a.ang)+gravity)
a.rel_x=round(pivot*cos(a.ang)*8)/8
a.rel_y=round(pivot*sin(a.ang)*8-pivot*8)/8
if a.pl_in_bucket then
a.sind=32
else
a.sind=34
end
end,function(a)
if a.pl_in_bucket then
sfx"25"
a.pl_in_bucket=false
a.pl=_g.pl(a.x,a.y,a.xf)
_g.growing_circle(a.pl,2,1)
end
end,function(a,other)
if a.pl_in_bucket then
shared_pl_col_logic(a,other)
end
if other.knock then
a:eject_player_out_of_bucket()
end
end)
create_actor([[138|139]],function(a)
if a.pl_in_bucket and xbtn()!=0 then
a.ang+=xbtn()*a.ang_speed
end
if btn(5)and a.pl_in_bucket and g_water_gauge:can_shoot()then
g_water_gauge:empty()
local xdir,ydir=get_direction_for_shooting(a.xf)
_g.water_shot(a.x,a.y,xdir,ydir)
end
if a.pl_in_bucket then
g_water_gauge:fill()
end
a:bucket_update()
end)
create_actor([[140|141]],function(a)
a.bucket=_g.bucket(a.x,a.y,a)
a.rope=_g.rope(a.bucket,a)
end,function(a)
a.dy=.1
local bounds_bottom=g_cur_room.y+g_cur_room.h-1.75
if a.y+a.dy>=bounds_bottom then
a.y=bounds_bottom-a.dy
if not a.next_lvl_checker then
a.next_lvl_checker=_g.next_lvl_control(a)
end
end
end,function(a)
a.rope:kill()
a.bucket:kill()
a.next_lvl_checker:kill()
end)
function end_init()
music(0,2000)
batch_call_new(acts_loop,[[142]])
g_stats.total_time=flr(t()-g_stats.time_start)
_g.fader_in(.5,nf,nf)
g_card_fade=8
end
function end_update()
batch_call_new(acts_loop,[[143]])
end
function end_draw()
fade(g_card_fade)
zspr(134,64,36,10,8)
zprint("you win!",64,68,0,11,1)
draw_stats(89-4)
zprint("@alanxoc3       code & sfx   ",64,118-8-8,0,6,1)
zprint("@thegreatcadet  gfx & sfx    ",64,118-8,0,6,1)
zprint("@codecodymorgan gfx & design ",64,118,0,6,1)
end
function seconds_to_str(d)
local seconds=flr(d%60)
local minutes=flr(d/60)
return ""..minutes.."M "..seconds.."S"
end
function draw_stats(y)
rect(-1,y-7,128,y+12,1)
zprint("time : "..seconds_to_str(g_stats.total_time),6,y-4,-1,15,2)
zprint("shots: "..g_stats.shots,6,y+4,-1,12,1)
zprint("died : "..g_stats.deaths,70,y-4,-1,8,2)
zprint("coins: "..g_stats.coins.."/"..g_stats.max_coins,70,y+4,-1,10,4)
end
function shared_pl_col_logic(a,other)
if other.coin then
other:obtain()
end
if other.balloon then
other:pop()
end
end
function get_direction_for_shooting(xf)
local xdir=0
local ydir=0
if btn(1)then
xdir=1
elseif btn(0)then
xdir=-1
end
if btn(2)then
ydir=-1
elseif btn(3)then
ydir=1
end
if xdir==0 and ydir==0 then
xdir=bool_to_num(xf)
end
return xdir,ydir
end
create_actor([[144|145]],function(a)
scr_circ(a.x,a.y,a.radius*a.tl_tim*6,a.color or 2)
end)
create_actor([[146|147]],function(a)
if g_cur_level!=0 then
g_stats.shots+=1
end
sfx"2"
local ang=atan2(a.xdir,a.ydir)
a.dx=cos(ang)*.8
a.dy=sin(ang)*.8+.2
end,function(a)
scr_circfill(a.x,a.y,1/(1.5+a.tl_tim*16),12)
end,function(a,other)
if other.balloon or other.boulder then
local sign=zsgn(a.dx)
if sign==0 then
sign=zsgn(other.x-a.x)
if sign==0 then
sign=flr_rnd(2)==0 and-1 or 1
end
end
other.dx+=sign*.05
_g.growing_circle(other,12,1)
a:kill()
end
end)
create_actor([[148|149]],function(a)
_g.fader_out(1,nf,resetlevel)
end,function(a)
a.ixx=rnd_one()
a.iyy=rnd_one()
end)
create_actor([[150|151]],function(a)
a.dy=-a.jump_speed
end,function(a)
if xbtn()!=0 then
a.xf=xbtn()==-1
end
if not a.touching_ground then
if a.touching_left_wall and btn(0)then
a.sind=6 a.iyy=-1 a.xf=false
elseif a.touching_right_wall and btn(1)then
a.sind=6 a.iyy=-1 a.xf=true
else
a.sind=1 a.iyy=-1
end
else
if a.ax==0 then
a.sind=2 a.iyy=-1
elseif a.ax!=0 then
if a.tl_tim*60%16<4 then
a.sind=3 a.iyy=-2
elseif a.tl_tim*60%16<8 then
a.sind=2 a.iyy=-1
elseif a.tl_tim*60%16<12 then
a.sind=4 a.iyy=-1
else
a.sind=2 a.iyy=-1
end
end
end
if not a.shooting then
a.ax=xbtn()*.05
a.ay=.04
if not a.touching_ground then
if a.touching_left_wall and btn(0)then
a.ay=.0117
elseif a.touching_right_wall and btn(1)then
a.ay=.0117
end
end
if btnp(4)then
if a.touching_ground then
a.dy=-a.jump_speed
sfx"25"
elseif a.touching_left_wall then
a.dx=a.wall_jump_xspeed
a.dy=(btn(3)and 1 or-1)*a.wall_jump_yspeed
sfx"25"
elseif a.touching_right_wall then
a.dx=-a.wall_jump_xspeed
a.dy=(btn(3)and 1 or-1)*a.wall_jump_yspeed
sfx"25"
end
end
if btnp(5)and g_water_gauge:can_shoot()then
xdir,ydir=get_direction_for_shooting(a.xf)
if xdir!=0 and a.touching_left_wall then
xdir=1
elseif xdir!=0 and a.touching_right_wall then
xdir=-1
end
g_water_gauge:empty()
_g.water_shot(a.x,a.y,xdir,ydir)
local ang=atan2(-xdir,-ydir)
a.dx+=a.jump_speed*cos(ang)
a.dy+=a.jump_speed*sin(ang)
a.ax,a.ay=0,0
a:next()
end
end
local bot_of_screen=g_main_view.y+g_main_view.h/2
if a.y>g_main_view.y+g_main_view.h/2 then
g_card_shake_x=4
if a.y>bot_of_screen+2 then
a:kill()
end
end
local top_of_screen=g_main_view.y-g_main_view.h/2+1.5
if a.y<top_of_screen then
a.dy+=.05
if a.y<top_of_screen-1.5 then
g_card_shake_x=4
end
if a.y<top_of_screen-3 then
a:kill()
end
end
a.touching_ground=false
if not a.shooting then
a.touching_left_wall=false
a.touching_right_wall=false
end
end,function(a,dir)
if dir==3 then a.touching_ground=true end
if dir==0 then
a.touching_left_wall=true
end
if dir==1 then
a.touching_right_wall=true
end
end,function(a,other)
shared_pl_col_logic(a,other)
if other.balloon then
a.dy=-a.jump_speed/2
end
if other.bucket_parent then
a.into_bucket=true
a:kill()
sfx"26"
other.pl_in_bucket=true
other.xf=a.xf
elseif other.bad then
a:kill()
end
end,function(a)
if not a.into_bucket then
sfx"15"
_g.pl_dead(a.x,a.y,a.xf)
if g_cur_level!=0 then
g_stats.deaths+=1
end
end
end,function(a)
a:draw_spr()
end)
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
g_tl=ztable([[152]],logo_draw,
game_init,game_update,game_draw,
end_init,end_update,end_draw,function()sfx(63)end
)
end
function get_pl()
if g_bucket_control.bucket.pl_in_bucket then
return g_bucket_control.bucket
else
return g_bucket_control.bucket.pl
end
end
function tolevel(level)
if(g_cur_level==nil or g_cur_level<4)and level==4 then
music(16,2000)
end
batch_call_new(acts_loop,[[142]])
g_cur_level=level
g_blocks={}
g_block_context,g_cur_room,g_bucket_control,g_main_view=gen_lvl(level)
g_card_fade=8
g_water_gauge=_g.water_gauge()
_g.fader_in(.5,nf,nf)
if level>0 then
_g.cur_level_status()
end
end
create_actor([[153|154]],function(a)
local multiplier=3
local max_charge_len=a.charge_max*multiplier
local charge_len=a.charge*multiplier
local ytop=a.y-1
local ybot=a.y+2
local col1=12
local col2=1
if t()%1<.25 then
if a:can_shoot()then
col1=6
col2=5
end
end
rect(a.x-max_charge_len+1,ytop,a.x-max_charge_len+1,ybot,col2)
rect(a.x,ytop,a.x,ybot,col2)
if charge_len>0 then
rectfill(a.x-max_charge_len+1+(max_charge_len-charge_len),ytop,a.x,ybot,col1)
rectfill(a.x-max_charge_len+1+(max_charge_len-charge_len),ybot,a.x,ybot,col2)
end
end,function(a)
if not a.empty_state then
a.charge=min(a.charge_max,a.charge+a.charge_speed)
end
end,function(a)
return not a.empty_state and a.charge==a.charge_max
end,function(a)
if a:can_shoot()then
a.empty_state=true
end
end,function(a)
if a.empty_state then
a.charge=max(0,a.charge-a.charge_speed*3)
if a.charge==0 then
a.empty_state=false
end
end
end)
function game_init(a)
end
function game_update(a)
batch_call_new(acts_loop,[[155]])
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
function game_draw(a)
fade(g_card_fade)
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
tl_node(g_tl)
end
function _draw()
cls()
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
batch_call_new(acts_loop,[[156]])
draw_lvl_blocks(g_blocks)
isorty(g_act_arrs.drawable)
batch_call_new(acts_loop,[[157]])
clip()
camera()
end
end