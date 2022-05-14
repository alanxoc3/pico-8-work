function nf()
end
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
end _g,g_ztable_cache,g_gunvals={},{},split("1:1,1,3,3,2,1,3,4,3,1,3,6,4,2,4,6,5,3,6,6;2:1,2,3,6,4,3,6,5;3:1,1,3,3,2,1,3,4,3,1,3,6,4,2,4,6,5,3,6,6;4:1,1,3,5,4,1,5,3;5:1,1,3,3,2,1,3,5,4,2,5,5;6:2,1,5,6;7:2,1,5,6,6,2,6,5;0:3,3,4,4;67:-1,3,8,5,1,-1,6,8;71:-1,1,8,7,0,0,6,7,1,-1,3,7,3,-1,3,8,4,0,5,8;228:-1,1,8,15,0,0,7,16;227:-1,-1,7,15,8,0,8,14;20:2,4,6,6,4,2,6,6;87:-1,3,8,5,0,0,8,6,1,-1,6,8,7,-1,7,7,8,0,8,7;226:-1,0,3,16,4,10,8,16;32:0,2,6,6,1,2,5,7,2,0,5,7,6,0,6,6,7,2,7,4;36:2,2,5,5;225:-1,-1,8,15;224:-1,0,8,16;48:0,1,6,6,1,0,6,7,7,4,7,6;115:-1,1,3,7,2,0,3,7,4,0,6,6,6,0,6,8,7,1,8,8;119:0,0,6,5,1,-1,6,6,7,1,7,5;150:-1,0,6,3,0,-1,6,4,1,-1,6,5,7,1,7,4,8,1,8,3;64:-1,2,8,5,0,0,7,7,1,-1,6,7,2,-1,5,8;68:-1,4,8,7,0,0,7,8,1,-1,6,8;149:-1,0,7,5,0,-1,6,5;148:-1,0,7,3,0,-1,6,4,1,-1,6,5,7,0,7,4;80:-1,4,8,6,0,-1,7,7,1,-1,7,8;21:1,2,3,6,4,4,5,6;147:-1,0,7,5,0,-1,6,5,8,3,8,5;146:1,3,3,8,4,3,6,7;33:0,1,7,6;37:2,2,5,5;145:1,3,6,7,4,3,6,8;45:0,1,7,7,1,0,6,7;49:1,2,6,5,2,1,5,6;116:1,2,6,6,2,1,6,6,7,2,7,5;144:1,3,6,8;118:0,1,6,5,1,0,6,6,7,2,7,5;65:-1,0,8,6,0,-1,5,8,6,-1,7,7,8,0,8,7;69:-1,3,8,6,0,0,7,8,1,-1,6,8;102:0,-1,2,2,1,-1,2,4,2,-1,2,5,3,0,6,5;114:-1,0,8,6,1,0,3,7,6,0,8,7;81:-1,1,7,6,0,-1,7,7,1,-1,7,8,8,4,8,6;85:-1,3,6,7,0,0,5,8,1,-1,5,8,6,-1,6,7,7,0,7,6,8,3,8,5;26:0,9,7,12,1,3,5,13,2,0,4,15,5,2,5,15,6,4,6,13,7,8,7,12;113:-1,2,8,5,0,2,7,7,1,0,7,7,2,-1,5,8,6,-1,7,7,8,0,8,5;34:0,3,2,7,3,2,3,6,4,0,4,5,5,0,5,4,6,0,7,3;101:-1,2,8,5,0,-1,6,6,1,-1,6,8,7,0,7,6,8,1,8,5;112:-1,2,8,5,0,0,7,7,1,-1,6,7,2,-1,5,8;46:0,-1,5,14,1,-1,5,15,2,-1,4,16,6,0,6,15,7,0,10,14,9,0,10,15,11,1,13,16,14,1,14,15,15,1,15,14;50:1,1,6,6;117:1,1,6,6,2,0,6,6,7,1,7,4;100:-1,4,8,7,0,0,7,8,1,-1,7,8,8,0,8,7;99:-1,0,7,5,0,-1,6,6,1,-1,6,8,7,0,7,6,8,3,8,5;66:-1,3,8,5,1,-1,6,8;70:-1,3,8,5,0,-1,6,8,7,0,7,6,8,1,8,5;98:-1,3,8,5,0,-1,6,6,1,-1,6,8,7,0,7,6;97:-1,3,8,5,0,0,6,6,1,-1,6,8,7,3,7,6;19:2,1,6,3,4,1,6,5;23:1,1,5,3;96:-1,3,8,5,0,0,6,8,1,-1,6,8,7,3,8,8;86:-1,3,6,7,0,0,5,8,1,-1,5,8,6,-1,6,7,7,0,7,6,8,3,8,5;35:1,-1,6,6;39:-1,-1,8,8;43:0,0,7,6,2,0,5,7;84:-1,3,6,7,0,0,5,8,1,-1,5,8,6,-1,6,7,7,0,7,6,8,3,8,5;51:-1,-1,3,4,1,-1,3,6,4,1,6,6;55:-1,-1,1,8,2,0,8,7,6,-1,8,8;83:0,0,6,8,1,-1,6,8,7,-1,7,7,8,0,8,4;82:-1,3,8,5,1,-1,6,8,7,0,7,5;|!plus/@1/-2,!plus/@2/-2,!plus/@3/2,!plus/@4/2,13;!plus/@1/-1,!plus/@2/-1,!plus/@3/1,!plus/@4/1,1;|96,0,4,4,!plus/@1/-3,!plus/@2/-3;96,4,4,4,!plus/@1/-3,@4;100,0,4,4,@3,!plus/@2/-3;100,4,4,4,@3,@4;|@1,@2,!plus/@3/1,@5;@1,@2,@3,@4;|0x8000,0x8000,0x7fff,0x7fff,@1|0,0,0,0,0,0,0;1,1,1,0,0,0,0;2,2,2,1,0,0,0;3,3,3,1,0,0,0;4,2,2,2,1,0,0;5,5,1,1,1,0,0;6,13,13,5,5,1,0;7,6,13,13,5,1,0;8,8,2,2,2,0,0;9,4,4,4,5,0,0;10,9,4,4,5,5,0;11,3,3,3,3,0,0;12,12,3,1,1,1,0;13,5,5,1,1,1,0;14,13,4,2,2,1,0;15,13,13,5,5,1,0;|mem_loc=7,enabled=no,name=force,xoff=-7,yoff=-9,sind=36;mem_loc=8,enabled=no,name=brang,xoff=0,yoff=-10,sind=4;mem_loc=9,enabled=yes,name=bomb,xoff=7,yoff=-9,sind=5;mem_loc=10,enabled=no,name=shield,xoff=-8,yoff=-3,sind=6;mem_loc=11,enabled=yes,name=interact,interact=yes,xoff=0,yoff=-3,sind=no;mem_loc=12,enabled=no,name=bow,xoff=8,yoff=-3,sind=7;mem_loc=13,enabled=no,name=shovel,xoff=-7,yoff=4,sind=3;mem_loc=14,enabled=no,name=sword,xoff=0,yoff=6,sind=2;mem_loc=15,enabled=no,name=banjo,xoff=7,yoff=4,sind=1;|item;banjo|alive|confined,room_end;confined,kill;confined,delete|@1,@2,@1,@4,13;@3,@2,@3,@4,13;@5,@2,@6,@4,@7;@5,@4,@6,@4,@8;|@1,@2,@3,@4,@5,@6,-1,11,3;|follow_act;ma_able|48,119,-1,@1;|10,3,117,7,@1,100,0,8,2;|13,115,-1,@1;117,115,1,@2;|0:x=4,y=4,room=00;x=6,y=5,room=13;|@1,3,3,-1,7,5;@2,3,11,-1,7,5;|;00:m=21,c=4,d=03/8/3,pot/2/8,pot/1/7,pot/1/8,pillow/10/0.5,bed/10/1.5,chest/7/6/yes/15,save_spot/4/5/0,sign/4/2/play the banjo on a save^spot to save.,box/6/2,box/7/8,box/5/1,box/9/4,box/9/6,box/10/5,box/8/5,box/8/7,box/2/2,box/3/1,box/1/1,box/1/3,;01:m=21,c=4,d=04/12/3,lark/3.5/3.5,box/6/6,box/1/6,pot/5/1,pot/2/1,bed/3.5/1.5,pillow/3.5/0.5,pot/1/2,pot/6/2,;02:m=16,c=3,l=04/23.5/7,u=24/3/11.5,sign/1.5/1.5/â¬ï¸ hiroll field^â¬ï¸ hiroll village/43,bob_build/4.5/1.5,;03:m=16,c=3,l=12/11.5/5,r=04/0.5/7,sign/9/2/lank's house/43,house/7.5/2/0/4/7.5/46,navy_blocking/4.5/6.5,;04:m=16,c=3,w=24,l=03/11.5/5,r=02/0.5/7,sign/5/4/lime and navy's house/43,sign/13/2/lark's house/43,sign/17/3/teach's studio/43,sign/9/3/bob and jane's house/43,sign/21/4/hi-roll shop/43,house/15.5/3/6/4/7.5/46,house/19.5/4/7/4/7.5/46,house/7.5/3/8/4/7.5/46,house/3.5/4/9/4/7.5/46,house/11.5/2/1/4/7.5/46,quack/11.5/6.5,quack/18/3,;06:m=21,c=4,d=04/16/4,sign/1/1/press ð¾ï¸ to use yer item./43,sign/6/1/hold down â to select^yer item./43,teach/3.5/3.5,box/6/6,box/1/6,pot/1/5,pot/2/6,pot/5/6,pot/6/5,;07:m=21,c=4,d=04/20/5,shop_brang/2/3,shop_shield/5/3,keep/3.5/3,pot/6/6,pot/1/6,box/6/1,box/1/1,chest/2/1/yes/13,chest/5/1/no/13,;08:m=21,c=4,d=04/8/4,jane/5/4,pot/5/6,pot/6/6,box/1/6,pillow/1/0.5,bed/1/1.5,pillow/4/0.5,bed/4/1.5,;09:m=21,c=4,d=04/4/5,box/6/6,box/1/6,pot/5/6,pot/2/6,pillow/1/0.5,pillow/6/0.5,bed/6/1.5,bed/1/1.5,navy_house/5/4,;10:m=24,c=3,l=17/4/4,r=12/0.5/5,u=17/4/4,d=11/6/0.5,spikes/9/2/0.7,spikes/10/2/0.7,spikes/1/2/0.7/yes,spikes/2/2/0.7/yes,spikes/1/7/0.7,spikes/2/7/0.7,spikes/9/7/0.7/yes,spikes/10/7/0.7/yes,spikes/4/4/0.7/yes,spikes/4/5/0.7,spikes/5/4/0/yes,spikes/5/5/0,spikes/6/4/0,spikes/6/5/0/yes,spikes/7/4/0.7,spikes/7/5/0.7/yes,spikes/5/3/0.7/yes,spikes/6/3/0.7,spikes/5/6/0.7,spikes/6/6/0.7/yes,slimy/5.5/1.5/3,slimy/5.5/7.5/3,;11:m=24,c=3,l=15/11.5/6,r=17/4/4,u=10/6/9.5,d=18/4/0.5,spikes/3/1/0.5,spikes/3/2/0.5,spikes/4/1/0.75,spikes/4/2/0.75,spikes/7/1/0.5,spikes/7/2/0.5,spikes/8/1/0.75,spikes/8/2/0.75,spikes/9/3/0,spikes/10/3/0,spikes/9/6/0,spikes/10/6/0,spikes/3/4/0,spikes/3/5/0,spikes/4/4/0,spikes/4/5/0,spikes/7/4/0,spikes/7/5/0,spikes/8/4/0,spikes/8/5/0,spikes/3/7/0.75,spikes/3/8/0.75,spikes/4/7/0.5,spikes/4/8/0.5,spikes/7/7/0.75,spikes/7/8/0.75,spikes/8/7/0.5,spikes/8/8/0.5,slimy/9.5/1.5/3,slimy/9.5/7.5/3,pot/1.5/1.5,pot/1.5/7.5,;12:m=24,c=3,l=10/11.5/5,r=03/0.5/5,d=17/4/0.5,sign/5.5/2/â¬ï¸ spike's forest^â¡ï¸ hiroll village/43,spikes/2/2/0.5,spikes/2/7/0.5,spikes/2/4/0,spikes/2/5/0,spikes/3/4/0,spikes/3/5/0,;13:m=24,c=3,l=17/4/4,r=17/4/4,u=14/6/11.5,d=15/6/0.5,spikes/2/4/0,spikes/3/4/0,spikes/2/5/0,spikes/3/5/0,spikes/8/4/0,spikes/9/4/0,spikes/8/5/0,spikes/9/5/0,spikes/1/1/0.5,spikes/10/1/0.5,spikes/1/8/0.5,spikes/10/8/0.5,save_spot/5.5/4.5/1,;14:m=29,c=3,r=16/0.5/4,d=13/6/0.5,spikes/5/5/0/yes,spikes/6/6/0.25/yes,spikes/6/5/0.7,spikes/5/6/0.95,spikes/2/4/0/yes,spikes/2/3/0/yes,spikes/1/3/0/yes,spikes/1/4/0/yes,spikes/3/2/0/yes,spikes/3/1/0/yes,spikes/4/1/0/yes,spikes/4/2/0/yes,spikes/8/2/0.7,spikes/8/1/0.7,spikes/7/1/0.7,spikes/7/2/0.7,spikes/9/3/0.7,spikes/10/3/0.7,spikes/10/4/0.7,spikes/9/4/0.7,spikes/2/7/0.95,spikes/1/7/0.95,spikes/1/8/0.95,spikes/2/8/0.95,spikes/4/9/0.95,spikes/3/9/0.95,spikes/3/10/0.95,spikes/4/10/0.95,spikes/8/9/0.25/yes,spikes/7/9/0.25/yes,spikes/7/10/0.25/yes,spikes/8/10/0.25/yes,spikes/10/7/0.25/yes,spikes/9/7/0.25/yes,spikes/9/8/0.25/yes,spikes/10/8/0.25/yes,slimy/1.5/1.5/3,slimy/9.5/9.5/3,slimy/1.5/9.5/3,slimy/9.5/1.5/3,;15:m=24,c=3,l=17/4/4,r=11/0.5/5,u=13/6/9.5,d=17/4/4,spikes/2/4/0,spikes/3/4/0,spikes/2/5/0,spikes/3/5/0,spikes/8/4/0,spikes/9/4/0,spikes/8/5/0,spikes/9/5/0,spikes/5/4/0.5,spikes/6/4/0.5,spikes/5/5/0.5,spikes/6/5/0.5,spikes/4/2/0.25,spikes/7/2/0.5,spikes/4/9/0.5,spikes/7/9/0.25,slimy/2/9/1,slimy/2/2/1.5,slimy/9/2/2,slimy/9/9/2.5,box/7/7,box/4/4,box/4/7,box/7/4,spikes/2/6/0,spikes/2/7/0,spikes/3/6/0,spikes/3/7/0,spikes/5/6/0,spikes/5/7/0,spikes/6/7/0,spikes/6/6/0,spikes/8/6/0,spikes/9/6/0,spikes/8/7/0,spikes/9/7/0,pot/1/1,pot/1/10,pot/10/10,pot/10/1,spikes/1/4/0,spikes/1/7/0,spikes/10/7/0,spikes/10/4/0,;16:m=24,c=3,l=14/11.5/6,spikes/5/1/0.7,spikes/6/2/0.7,spikes/1/5/0.7,spikes/2/6/0.7,spikes/1/2/0.7/yes,spikes/2/1/0.7/yes,spikes/5/6/0.7/yes,spikes/6/5/0.7/yes,chest/6/3.5/yes/15,save_spot/3.5/3.5,pot/1/1,pot/6/1,pot/6/6,pot/1/6,;17:m=24,c=3,u=12/6/9.5,slimy/3.5/6/3,sign/51/21/don't get lost!/43,spikes/6/1/0,spikes/1/6/0,spikes/1/1/0/yes,spikes/6/6/0/yes,;18:m=24,c=3,u=11/6/9.5,spikes/1/3/0,spikes/2/4/0,spikes/3/3/0.25,spikes/4/4/0.25,spikes/5/3/0.7,spikes/6/4/0.7,spikes/6/3/0/yes,spikes/5/4/0/yes,spikes/4/3/0.25/yes,spikes/3/4/0.25/yes,spikes/2/3/0.7/yes,spikes/1/4/0.7/yes,quack/3.5/5.5,;20:m=32,c=13,;21:m=32,c=13,d=26/4/0.5,;22:m=32,c=4,w=24,l=31/11.5/7,u=26/4/15.5,;24:m=32,c=3,w=24,d=02/8/0.5,tall_tree/6.5/3.5,tall_tree/5.5/3.5,tall_tree/4.5/3.5,;26:m=32,c=4,h=16,u=21/6/9.5,d=22/18/0.5,;28:m=21,c=4,;29:m=21,c=4,;30:m=16,c=13,h=20,l=33/11.5/7,r=31/0.5/7,;31:m=16,c=13,l=30/11.5/17,r=22/0.5/7,;33:m=16,c=13,l=24/23.5/3,r=30/0.5/17,;34:m=16,c=4,;35:m=16,c=4,;36:m=16,c=4,;37:m=16,c=4,;38:m=16,c=4,;39:m=16,c=4,;50:m=32,c=4,;51:m=32,c=4,;52:m=32,c=4,;53:m=16,c=4,;54:m=16,c=4,;55:m=16,c=4,;56:m=16,c=4,;59:m=21,c=4,;70:m=16,c=4,;71:m=16,c=4,;72:m=16,c=4,;73:m=16,c=4,;74:m=16,c=4,;75:m=16,c=4,;76:m=16,c=4,;77:m=16,c=4,;78:m=16,c=4,;79:m=16,c=4,|0:x=0,y=0,w=12,h=10;x=12,y=0,w=12,h=10;x=0,y=10,w=12,h=10;x=12,y=10,w=12,h=10;x=0,y=20,w=12,h=12;x=12,y=20,w=12,h=12;x=24,y=0,w=8,h=8;x=24,y=8,w=8,h=8;x=24,y=16,w=8,h=8;x=24,y=24,w=8,h=8;|act;0;,;room_init,pause_init,pause_update,pause_end,kill,clean,delete|alive:yes;stun_countdown:0;i:nf;u:nf;update:@1;clean:@2;kill:@3;delete:@4;room_init:nf;create_init:nf;pause_init:nf;pause_update:nf;pause_end:nf;destroyed:nf;get:@5;|ma_able;0;act,;|name:thing;|confined;0;act,;room_end,|room_end:nf;|loopable;0;act,;|tl_loop:yes;|pos;0;act,;|x:0;y:0;|move_pause;0;act,;update,move,vec_update,tick|;|dim;0;pos,;|rx:.375;ry:.375;|bounded;0;act,;|check_bounds:@1;|timed;0;act,;|t:0;tick:@1;|vec;0;pos,;|dx:0;dy:0;vec_update:@1;|mov;0;vec,;|ix:.85;iy:.85;ax:0;ay:0;move:@1;stop:@2;|dim;0;pos,;debug_rect,|rx:.375;ry:.375;debug_rect:@1;|rel;0;act,;rel_update,|rel_actor:null;rel_x:0;rel_y:0;rel_dx:0;rel_dy:0;flippable:no;rel_update:@1;|drawable_obj;0;act,;reset_off,|ixx:0;iyy:0;xx:0;yy:0;visible:yes;reset_off:@1;|drawable;0;drawable_obj,;d,|d:nf;|pre_drawable;0;drawable_obj,;d,|post_drawable;0;drawable_obj,;d,|above_map_drawable;0;drawable_obj,;d,|spr_obj;0;vec,drawable_obj,;|sind:0;outline_color:1;sw:1;sh:1;xf:no;yf:no;draw_spr:@1;draw_out:@2;draw_both:@3;|spr;0;spr_obj,;|d:@1;|knockable;0;mov,;|knockback:@1;|stunnable;0;mov,drawable_obj;|stun_update:@1;|hurtable;0;act,;|health:1;max_health:1;health_visible:yes;hurt:@1;heal:@2;|brang_hurtable;0;hurtable,;|anim;0;spr,timed;|sinds:,;anim_loc:1;anim_off:0;anim_len:1;anim_spd:0;anim_sind:null;anim_update:@1;|trig;0;vec,dim;|contains:nf;intersects:nf;not_contains_or_intersects:nf;contains_or_intersects:@1;trigger_update:@1;|anchored;1;vec,dim;|touchable:@1;hit:nf;|col;0;vec,dim;|touchable:yes;hit:nf;move_check:@1;|dx:0;dy:0|x,dx,@1,@2,@3,@4;y,dy,@1,@2,@5,@6;|tcol;0;vec,dim;|tile_solid:yes;tile_hit:nf;coll_tile:@1;|danceable;0;act,;|initial_time:0;dance_update:@1;pause_update:@1;pause_init:@2;|interactable;0;spr,anchored/yes,confined,ma_able;|interactable_trigger:nf;trig_x:0;trig_y:0;trig_rx:.75;trig_ry:.75;trig:null;i:@1;interactable_init:@1;|nnpc;0;drawable,danceable,interactable,ma_able;|rx:.5;ry:.5;iyy:-2;u:%look_at_pl|bashable;0;rel,knockable,col;|bash_dx:1;rel_bash_dx:1;hit:@1;bash:@1;|item;0;drawable,rel,confined,spr_obj;|being_held:yes;destroyed:@1;|pokeable;0;rel,drawable_obj,item;|i:@1;u:@2;e:@3;poke_init:@1;poke_update:@2;poke_end:@3;poke_update_reverse:@4;poke:20;poke_dist:20;poke_energy:0;|shop_item;0;drawable,interactable,ma_able;update,|costable:yes;interactable_trigger:@1;rx:.5;ry:.5;iyy:-3;trig_x:0;trig_y:.125;trig_rx:.5;trig_ry:.625;mem_loc:255;cost:99|brang_hittable;0;,;|mem_dep;0;act,;|room_init:@1;mem_loc:255;mem_loc_expect:yes;|brang;1;confined,anim,col,mov,tcol|did_brang_hit:no;item_stop:yes;tile_solid:no;rel_actor:@1;being_held:yes;rx:.375;ry:.375;sinds:4,19,20,21;anim_len:4;anim_spd:3;ix:.8;iy:.8;touchable:no;tile_hit:@10;item_slow:yes;i=@2,hit=@3,u=@4,tl_max_time=.1;i=nf,hit=@5,u=@6,tl_max_time=.75;ax=0,ay=0,dx=0,dy=0,i=@9,hit=nf,u=@4,tl_max_time=.15;i=nf,hit=@7,u=@8,tl_max_time=3;|banjo;1;item,danceable;update,|rel_actor:@1;rx:.3;ry:.3;sind:1;touchable:no;item_stop:yes;e:@3;i=@2,tl_max_time=4.25;|swordshieldparent;0;item,col,bashable,pokeable|item_slow:yes;poke:10;touchable:no;poke_ixx:0;sword_shield_u2:@1;sword_shield_hit_func:@2;|sword;1;swordshieldparent,|rel_actor:@1;rel_bash_dx:.2;min_stun_val:10;max_stun_val:20;energy:6;poke_dist:.75;rx:.375;ry:.375;rel_y:0;iyy:-2;sind:2;poke_energy:15;stun_amount:30;hit=$sword_shield_hit_func,hurt_amount=5,bash_dx=.3,tl_max_time=.1;i=nf,u=$sword_shield_u2,e=nf,hurt_amount=2,bash_dx=.1;hit=nf,u=$poke_update_reverse,tl_max_time=.1;|shield;1;swordshieldparent,|rel_actor:@1;rel_bash_dx:.1;min_stun_val:0;max_stun_val:60;energy:2;o_hurt:0;poke_dist:.625;rx:.25;ry:.5;iyy:-1;sind:6;hurt_amount:0;poke_energy:10;stun_amount:60;hit=$sword_shield_hit_func,bash_dx=.4,tl_max_time=.1;i=nf,u=$sword_shield_u2,e=nf,bash_dx=.2;hit=nf,u=$poke_update_reverse,tl_max_time=.1;|item_selector;1;rel,|rel_actor:@1;u:@2|inventory_item;6;rel,above_map_drawable,spr;|rel_actor:@1;rel_x:@2;rel_y:@3;enabled:@4;flippable:@5;sind:@6;visible:@6;i:@7;|fader_out;2;act,;update,|i:@1;e:@2;u:@3;tl_max_time=.5,|fader_in;2;act,;update,|view;4;act,confined;center_view,update_view|x:0;y:0;room_crop:2;tl_loop:yes;w:@1;h:@2;follow_dim:@3;follow_act:@4;update_view:@5;center_view:@6;change_ma:@7;,;|@1,x,w,ixx;@1,y,h,iyy|slimy_parent;8;brang_hittable,ma_able,drawable,bounded,danceable,confined,stunnable,mov,col,tcol,hurtable,knockable,spr_obj,spr|name:@1;rx:@2;ry:@3;max_health:@4;health:@4;sind:@7;evil:yes;tl_loop:yes;anim_len:1;touchable:no;jump_speed:.03;knockback_speed:@5;stun_len:@6;sind=@7,ax=0,ay=0,hit=nf,u=%look_at_pl,tl_max_time=2;i=nf,hit=nf,u=@9,tl_max_time=.25;sind=@8,ixx=0,i=nf,hit=@11,u=@10,tl_max_time=.25;|miny;3;slimy_parent/miny/.125/.125/1/.05/0/116/117,brang_hurtable|x:@1;y:@2;dy:@3;destroyed:%destroy_effect|slimy;2;slimy_parent/slimy/.25/.25/3/.2/30/118/119,|x:@1;y:@2;destroyed:@3;|@1,@2,.2;@1,@2,-.2;|evil_quack_spawner;0;loopable,confined|tl_max_time=.5,i=@1;|evil_quack;2;drawable,mov,col,spr,danceable,confined,anchored/no|x:@1;y:@2;evil:yes;sind:32;rx:.375;ry:.375;i:@3;hit:@4;tl_max_time=3,;|quack;2;brang_hittable,drawable,ma_able,hurtable,loopable,bounded,confined,stunnable,mov,col,tcol,knockable,spr,danceable|name:quack;evil:yes;x:@1;y:@2;rx:.375;ry:.375;sind:32;health:50;max_health:50;destroyed:@4;i=@3,tl_max_time=.5;|save_spot;3;trig,pre_drawable,confined,spr|rx:.625;ry:.625;sind:78;sw:2;sh:2;x:@1;y:@2;spot:@3;intersects:@4;contains:@4;pause_end:@6;not_contains_or_intersects:@5;|3,@1;5,@2;6,@3;4,@4;|sign;3;drawable,interactable|name:sign;sind:43;x:@1;y:@2;text_obj:@3;rx:.5;ry:.5;trig_x:0;trig_y:.125;trig_rx:.75;trig_ry:.625;interactable_trigger:!tbox_closure/~text_obj;|grave;3;drawable,interactable|name:grave;sind:45;rx:.5;ry:.5;trig_x:0;trig_y:.125;trig_rx:.75;trig_ry:.625;x:@1;y:@2;text_obj:@3;interactable_trigger:!tbox_closure/~text_obj;|shop_brang;2;shop_item,|name:brang;sind:4;x:@1;y:@2;mem_loc:8;|shop_shield;2;shop_item,|name:shield;sind:6;x:@1;y:@2;mem_loc:10;|item_show;3;above_map_drawable,confined,spr,rel;update,|rel_actor:@1;sind:@2;mem_loc:@3;rel_y:-1.125;tl_max_time=2,e=@4;|chest;4;drawable,interactable;update,|name:chest;sind:50;rx:.375;ry:.375;x:@1;y:@2;xf:@3;mem_loc:@4;trig_y:0;trig_rx:.5;trig_ry:.375;interactable_trigger:@6;i=@5,;i=nf,interactable_trigger=nf,sind=51;|gen_trigger_block;7;rel,confined,trig|rel_actor:@1;rel_x:@2;rel_y:@3;rx:@4;ry:@5;contains:@6;intersects:@7;not_contains_or_intersects:@8;|house;6;drawable,confined,spr|x:@1;y:@2;room:@3;room_x:@4;room_y:@5;sind:@6;iyy:-4;sw:2;sh:2;i:@7;|!plus/@1/-.75,@2,.25,.5;!plus/@1/.75,@2,.25,.5;@1,!plus/@2/-.5,1,.25;|@1,0,.125,.5,.625,@2,nf;|:pillow:2;#;.#:pre_drawable:spr:confined|x:@;y:@;sind:39;iyy:0;|bed;2;drawable,confined,spr|sind:55;x:@1;y:@2;i:@3;iyy:0;|!plus/@1/.53125,@2,.09375,.25;!plus/@1/-.53125,@2,.09375,.25;@1,!plus/@2/.375,.625,.25;|stat_hover;2;above_map_drawable,confined,spr,rel;update,|rel_actor:@1;sind:@2;rel_y:-1.25;tl_max_time=1,;|stat_parent;1;drawable,bounded,confined,tcol,spr,col,mov|sind:@1;rx:.125;ry:.125;hit:@2;touchable:no;destroyed:%destroy_effect;tl_max_time=5,;|money;2;stat_parent/36,|x:@1;y:@2;f_stat:@3;|health_obj;2;stat_parent/37,|static_block;4;confined,anchored/yes|x:@1;y:@2;rx:@3;ry:@4;|thing_destroyed;4;confined,mov,post_drawable,spr,bounded;update,vec_update,move|parent:@1;dx:@2;dy:@3;outline_color:@4;sind:0;i=@5,tl_max_time=.25;|pot_projectile;3;drawable,col,confined,mov,spr,bounded,tcol|tile_solid:yes;sind:49;x:@1;y:@2;xf:@3;touchable:no;i:@4;destroyed:@6;hit:@7;tile_hit:$next;u=@5,tl_max_time=.3;|pot;3;drawable,bounded,confined,tcol,spr,mov,anchored/yes|x:@1;y:@2;spawn_id:@3;sind:49;rx:.375;ry:.375;i:@4;|box;2;drawable,confined,anchored/yes,spr|rx:.375;ry:.375;sind:35;x:@1;y:@2;|tall_tree;2;drawable,confined,anchored/yes,spr,col|sw:1;sh:2;iyy:-4;rx:.5;ry:.5;sind:26;x:@1;y:@2;|spikes;4;trig,pre_drawable,confined,spr,loopable|rx:.375;ry:.375;sind:52;x:@1;y:@2;offset:@3;xf:@4;sind=52,tl_max_time=!minus/1/@3;sind=53,tl_max_time=.1;sind=54,intersects=@5,contains=@5,tl_max_time=.2;sind=53,intersects=nf,contains=nf,tl_max_time=.1;sind=52,tl_max_time=@3;|navy_house;2;nnpc,mem_dep|name:navy;sind:97;xf:yes;mem_loc:40;mem_loc_expect:no;x:@1;y:@2;interactable_trigger:!tbox_closure/hi lank;pause_end:!npc_dance_logic/umm.../nice playing lank!^^if i had money, i would^give it to you!;|navy_blocking;2;nnpc,mem_dep|name:navy;sind:97;mem_loc:40;u:nf;f_reload:!get_npc_reload_room/40;f_money:!memloc_money/15/0;x:@1;y:@2;interactable_trigger:!tbox_actor_logic/8/a boomerang?^^......^^isn't that a toy?^^......^^i hope you can save my^sister with that thing./~f_reload/10/a shield! good choice!^^you can use that protect^my sister from monsters!/~f_reload/11/my sister has been in the^forest all day.^find something to protect^yourself with and bring^her home./nf;pause_end:!npc_dance_logic/umm.../nice playing lank!^^if i had money i would^give it to you!;|teach;2;nnpc,|name:teach;sind:96;x:@1;y:@2;f_reload:!get_npc_reload_room/39;interactable_trigger:!tbox_actor_logic/39/try playing yer banjo on^a save spot!/nf/11/hi lank have you been^practicing the banjo?/nf;pause_end:!npc_dance_logic/oh. your banjo is out of^tune!^let me fix that for you./now that's my student!/nf/~f_reload|lark;2;nnpc,|name:lark;sind:99;x:@1;y:@2;interactable_trigger:@3;pause_end:@4;|jane;2;nnpc,|name:jane;sind:81;x:@1;y:@2;f_money:!memloc_money/20/24;interactable_trigger:!tbox_closure/my husband always works^so hard.^what should i make him^for dinner?;pause_end:!npc_dance_logic/that hurt my ears./i love that song!/~f_money;|bob_build;2;nnpc,mem_dep|name:bob;sind:80;mem_loc:38;x:@1;y:@2;f_reload:!get_npc_reload_room/38;f_money:!memloc_money/21/14;pause_end:!npc_dance_logic/i can't work with that^terrible music!/if only music could^quench my hunger./~f_money;interactable_trigger:!tbox_actor_logic/37/is that letter for me?^^oh..^^it's dinner time!!!/~f_reload/11/hey lank. i'm hungry.^^i mean...^^i'm fixing the road./nf;|keep;2;nnpc,|name:keep;sind:83;x:@1;y:@2;interactable_trigger:!tbox_closure/buy somethin' will ya?;f_money:!memloc_money/19/1;pause_end:!npc_dance_logic/that song sucked./that song was okay./~f_money;|lank_top;1;rel,spr_obj,danceable,pre_drawable|rel_actor:@1;sind:147;iyy:-2;u:@2;d:@3;|item;throwable|grabbed_item;4;rel,spr_obj,confined|rel_actor:@1;sind:@2;iyy:@3;create_func:@4;room_end:@7;throwable:yes;flippable:yes;being_held:yes;i=@6,throwing=no,tl_max_time=.2;i=nf,u=@5;throwing=yes,visible=no,tl_max_time=.05;|fairy_tail;1;mov,move_pause,confined;u,|rel_actor:@1;i:@2;u:@3;|fairy;1;post_drawable,mov,move_pause;u,|rel_actor:@1;u:@2;off_x:1;off_y:0;d:@4;i:@3;room_init:@3;|@1,@2,@3,@4,12;!plus/@1/.125,@2,@3,@4,1;!plus/@1/-.125,@2,@3,@4,1;@1,!plus/@2/.125,@3,@4,1;@1,!plus/@2/-.125,@3,@4,1;@1,@2,@1,@2,12;|pl;2;drawable,anim,col,mov,tcol,hurtable,knockable,stunnable,spr,danceable,ma_able|name:lank;x:@1;y:@2;sinds:144,145,146;sind:144;rx:.375;ry:.375;iyy:-2;spd:.02;anim_len:3;anim_spd:5;i:@3;u:@4;destroyed:@5;d:@6;|item;item_slow|item;item_stop|title;0;above_map_drawable,pos|d:@1;title_y:0;u=@2,;u=@3,tl_max_time=.5;|@1,0,!plus/-17/@2,10,4|@1,0,12,7,5|i=@2,u=@3,d=@4;i=@5,u=@6,d=@7;|game_over_checker;0;act,;|u:@1;|32,quack quack;68,and play with me;70,to save hi-roll;81,in time for dinner;83,and make me rich;96,the banjo awaits you;99,for your fans;118,splat splat boing;|act,update;|game over,0,-17,8,2;come back lank,0,12,10,4;@1,0,22,7,5;|act,pause_init|act,update;drawable_obj,reset_off;stunnable,stun_update;act,pause_update;mov,move;col,move_check,@1;col,move_check,@4;trig,trigger_update,@3;tcol,coll_tile,@2;rel,rel_update;vec,vec_update;bounded,check_bounds;anim,anim_update;timed,tick;view,update_view;|act,pause_end|act,clean|pre_drawable,d;drawable,d;post_drawable,d;|acts,kill;acts,delete;|8,;14,;10,;15,;16,;|","|")
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
elseif x=="nf"then x=nf
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
function new_ztable(original_str,...)
local str,index,params=g_gunvals[0+original_str],0,{...}
local tbl,ops=unpack(g_ztable_cache[str]or{})
if not tbl then
tbl,ops={},{}
local base_path,relative_path,indextbl={"#"},{},{}
for item in all(split(str,";"))do
local vals=split(item,":")
local key=deli(vals,1)
if key==""then key="#" end
local path=split(key,".")
if path[1]==""then
deli(path,1)
relative_path=path
else
base_path,relative_path=path
end
for val in all(vals)do
local subtbl,finalkey={tbl},1
for tmppath in all{base_path,relative_path}do
for i=1,#tmppath do
if type(subtbl[finalkey])~="table"then
subtbl[finalkey]={}
end
subtbl,finalkey=subtbl[finalkey],tmppath[i]
if finalkey=="#"then
indextbl[subtbl]=indextbl[subtbl]or 0
finalkey=indextbl[subtbl]+1
if tmppath==base_path and relative_path then
tmppath[i]=finalkey
else
indextbl[subtbl]=finalkey
end
end
end
end
local valchr,valcdr,func=sub(val,1,1),sub(val,2)
if val=="@"then
index+=1 local ind=index
func=function(p)return p[ind]end
elseif val=="yes"then val=true
elseif val=="no"then val=false
elseif val=="null"then val=nil
elseif val=="nf"then val=function()end
elseif val==""then val=subtbl[finalkey]
elseif valchr=="~"then
func=function()return tbl[valcdr]end
elseif sub(val,1,1)=="%"then
func=function()return _g[valcdr]end
end
subtbl[finalkey]=val
if func then
add(ops,{subtbl,finalkey,func})
end
end
end
g_ztable_cache[str]={tbl,ops}
end
foreach(params,function(t)
if type(t)=="table"then
t.is_tabcpy_disabled=true
end
end)
foreach(ops,function(op)
local t,k,f=unpack(op)
t[k]=f(params)
end)
return tbl
end
function create_parent_actor_shared(ztable_func,is_create_parent,meta_and_att_str,...)
local meta,template=unpack(split(meta_and_att_str,"|"))
local template_params,id,provided,parents,pause_funcs={...},unpack(ztable_func(meta))
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
tabcpy(ztable_func(template,unpack(params)),a)
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
end g_act_arrs={}
function create_parent(...)
create_parent_actor_shared(ztable,true,...)
end
function create_actor(...)
create_parent_actor_shared(ztable,false,...)
end
function new_create_parent(...)
create_parent_actor_shared(new_ztable,true,...)
end
function new_create_actor(...)
create_parent_actor_shared(new_ztable,false,...)
end
function zsfx(num,sub_num)
sfx(num,-1,sub_num*4,4)
end
function bool_to_num(condition)
return condition and 0xffff or 1
end
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
function btn_helper(f,a,b)
return f(a)and f(b)and 0 or f(a)and 0xffff or f(b)and 1 or 0
end
function xbtn()
return btn_helper(btn,0,1)
end
function ybtn()
return btn_helper(btn,2,3)
end
function xbtnp()
return btn_helper(btnp,0,1)
end
function ybtnp()
return btn_helper(btnp,2,3)
end
function zsgn(num)
return num==0 and 0 or sgn(num)
end
function round(num)
return flr(num+.5)
end
function rnd_one(val)
return(flr_rnd"3"-1)*(val or 1)
end
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
function acts_loop(id,func_name,...)
for a in all(g_act_arrs[id])do
call_not_nil(a,func_name,a,...)
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
function _g.plus(a,b)return a+b end
function _g.minus(a,b)return a-b end
function acts_loop(id,func_name,...)
for a in all(g_act_arrs[id])do
if not is_game_paused()or is_game_paused()and a.pause[func_name]then
call_not_nil(a,func_name,a,...)
end
end
end
function _g.look_at_pl(a)
if g_pl then
a.xf=a.x-g_pl.x>0
end
end
function npc_able_to_interact(a,other)
return(a.x>other.x-.5 and not other.xf or a.x<other.x+.5 and other.xf)
end
function able_to_interact()
return not g_menu_open
and get_selected_item().interact
and not is_game_paused()
and btnp"4"
end
function _g.memloc_money(mem_loc,money)
return function()
if not zdget(mem_loc)then
add_money(money)
zdset(mem_loc)
end
end
end
function tbox_logic_help(params)
for i=1,#params,3 do
local memloc,text,func=unpack(params,i)
if zdget(memloc)then
tbox(text,func or nf)
break
end
end
end
_g.tbox_actor_logic=function(...)
local params={...}
return function()
tbox_logic_help(params)
end
end
function _g.npc_dance_logic(bad_text,good_text,good_trigger,bad_trigger)
return function(a)
if g_pause_reason=="dancing"then
change_cur_ma(a)
tbox_logic_help{
39,good_text,good_trigger,
11,bad_text,bad_trigger or nf
}
end
end
end
function _g.get_npc_reload_room(mem_loc,val)
return function()
zdset(mem_loc,val)
transition(g_cur_room_index,g_pl.x-g_cur_room.x,g_pl.y-g_cur_room.y,g_pl)
end
end
g_out_cache=ztable[[1]]
function zspr(sind,x,y,sw,sh,...)
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
batch_call_new(sspr,[[3]],x1,y1,x2,y2)
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
zprint(str,x+i,y+j,0,1,1)
end
end
zprint(str,x,y,0,c1,c2)
end
function zprint(str,x,y,align,fg,bg)
if align==0 then x-=#str*2
elseif align>0 then x-=#str*4+1 end
batch_call_new(print,[[4]],str,x,y,fg,bg)
end
function zclip(x1,y1,x2,y2)
clip(x1,y1,x2+1-flr(x1),y2+1-flr(y1))
end
function zcls(col)
batch_call_new(rectfill,[[5]],col or 0)
end
g_fadetable=ztable[[6]]
function fade(i)
for c=0,15 do
pal(c,g_fadetable[c+1][min(flr(i+1),7)])
end
end
function inventory_init()
g_selected,g_items=5,ztable[[7]]
end
function gen_pl_item(pl)
return get_selected_item()and call_not_nil(_g,get_selected_item().name,pl)
end
function get_selected_item(ind)
local item=g_items[ind or g_selected]
return item.enabled and item or g_items[5]
end
function inventory_update()
local item=get_selected_item()
if not is_game_paused"tbox"and not g_menu_open and btn"5"then
g_selected=5
end
g_menu_open=g_pl and not g_pl:get[[8]]and g_pl:get[[9]]and not is_game_paused"tbox"and btn"5"
if g_menu_open then
if not g_items_drawn then
zsfx(2,0)
g_item_selector=_g.item_selector(g_pl)
g_items_drawn={}
for ind=1,9 do
local item=g_items[ind]
item.enabled=zdget(item.mem_loc)
g_items_drawn[ind]=_g.inventory_item(g_pl,item.xoff/8,item.yoff/8,item.enabled,item.flippable,item.sind)
end
end
if g_pl.item then g_pl.item.being_held=false end
elseif g_item_selector then
zsfx(2,1)
foreach(g_items_drawn,function(a)a.alive=false end)
g_item_selector.alive=false
g_pl.outline_color,g_items_drawn,g_item_selector=1
end
end
g_card_fade=0
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
function load_room(new_room_index,rx,ry,follow_actor)
reload(0x1000,0x1000,0x2000)
g_cur_room_index=new_room_index
g_cur_room=g_rooms[new_room_index]
switch_song(g_cur_room.m)
batch_call_new(acts_loop,[[10]])
if follow_actor then
follow_actor.x=rx+g_cur_room.x
follow_actor.y=ry+g_cur_room.y
end
if g_cur_room.i then g_cur_room.i()end
g_main_view=_g.view(min(14,g_cur_room.w),min(12,g_cur_room.h),2,follow_actor)
g_left_ma_view=_g.view(2.75,3,0,follow_actor)
g_right_ma_view=_g.view(2.75,3,0,nil)
acts_loop("view","center_view")
end
function room_update(fa)
if not is_game_paused()and g_cur_room then
local dir=nil
if fa.y>g_cur_room.y+g_cur_room.h-.375 then dir="d"
elseif fa.y<g_cur_room.y+.5 then dir="u"
elseif fa.x>g_cur_room.x+g_cur_room.w-.375 then dir="r"
elseif fa.x<g_cur_room.x+.5 then dir="l"
end
if dir!=nil and g_cur_room[dir]then
transition(g_cur_room[dir][1],g_cur_room[dir][2],g_cur_room[dir][3],fa)
end
end
end
function map_init()
for k,v in pairs(g_rooms)do
if tonum(k)then
local qx,qy=flr(k/10%4),flr(k/40)
local template=g_room_template[k%10]
v.x,v.y=template.x+qx*32,template.y+qy*32
v.w,v.h=v.w or template.w,v.h or template.h
v.i=function()
batch_call_table(function(att_name,x,y,...)
_g[att_name](v.x+x+.5,v.y+y+.5,...)
end,v)
acts_loop("act","room_init")
end
end
end
end
function change_cur_ma(a)
g_right_ma_view:change_ma(a)
end
function get_cur_ma()
return g_right_ma_view.follow_act
end
function draw_bar(x1,y1,x2,y2,num,dem,align,fg,bg)
if x1>x2 then x1-=3 x2-=3 end
local bar_off=x2-x1-min(num/dem,1)*(x2-x1)
if align==0 then bar_off/=2 end
if num>0 then
batch_call_new(rectfill,[[11]],x1,y1,x2,y2,
ceil(x1+(align>=0 and bar_off or 0)),
flr(x2-(align<=0 and bar_off or 0)),
fg,bg)
end
end
function draw_stat(x,y,align,view)
local xyo,a=x-10*align,view.follow_act
if a and a.alive and a.ma_able then
zprint(a.name or "",xyo,y-10,align,7,5)
map_draw(view,(x-1)/8,y/8)
if a.hurtable then
batch_call_new(draw_bar,[[12]],xyo,y-2,xyo-35*align,y+1,a.health,a.max_health)
zprint(flr(a.health).."/"..a.max_health,xyo,y+4,align,7,5)
elseif a.costable then
draw_money(xyo,y+4,align,a.cost)
end
end
end
function draw_money(x,y,align,amount)
local amount_str="0"..amount
zprint("$"..sub(amount_str,#amount_str-1,#amount_str),x,y,align,7,5)
end
function draw_status()
if get(g_left_ma_view,[[13]])then
batch_call_new(draw_money,[[14]],g_money)
end
batch_call_new(draw_bar,[[15]],g_energy)
batch_call_new(draw_stat,[[16]],g_left_ma_view,g_right_ma_view)
end
function _g.destroy_effect(a)
for i=0,3 do
_g.thing_destroyed(a,cos(i/4+.125)/8,sin(i/4+.125)/8,1)
end
end
g_save_spots=ztable[[17]]
function transition(new_room_index,room_x,room_y,follow_actor)
_g.fader_out(function()
pause"transitioning"
end,function()
load_room(new_room_index,room_x,room_y,follow_actor)
_g.fader_in(tbox_clear,unpause)
end)
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
function add_money(amount)
g_money=min(g_money+amount,99)
end
function remove_money(amount)
if g_money-amount>=0 then
g_money-=amount
return true
end
end
function energy_update(refresh_rate)
if g_energy_tired and g_energy<=0 then
g_energy_tired=false
end
if g_energy_amount>0 then
g_energy_amount=max(0,g_energy_amount-1)
g_energy+=1
elseif not g_energy_pause then
g_energy=max(0,g_energy-refresh_rate)
end
if g_energy>=100 then
g_energy_tired=true
end
g_energy_pause=false
end
function pause_energy()
g_energy_pause=true
end
function use_energy(amount)
g_energy_amount+=amount
end
g_tbox_messages,g_tbox_anim,g_tbox_max_len={},0,25
function tbox_interact()
if g_tbox_active then
g_tbox_anim+=.5
pause"tbox"
g_tbox_writing=g_tbox_anim<#g_tbox_active.l1+#g_tbox_active.l2
if not g_tbox_writing then
g_tbox_anim=#g_tbox_active.l1+#g_tbox_active.l2
end
if g_tbox_writing then
zsfx(0,0)
end
if btnp"4"and g_tbox_anim>.5 then
g_tbox_update=true
end
end
end
function tbox(str,trigger)
g_tbox_messages.trigger=trigger or nf
if type(trigger)~="function"then
printh("ohal: "..tostring(trigger))
end
for i,x in pairs(split(str,"^"))do
if i%2==1 then
add(g_tbox_messages,{l1=x,l2=""})
else
g_tbox_messages[#g_tbox_messages].l2=x
end
end
g_tbox_active=g_tbox_messages[1]
end
function _g.tbox_closure(obj)
return function()
tbox(obj)
end
end
function tbox_basic_draw(x,y)
if g_tbox_active then
camera(-x,-y)
batch_call_new(zprint,[[18]],
sub(g_tbox_active.l1,1,g_tbox_anim),
sub(g_tbox_active.l2,0,max(g_tbox_anim-#g_tbox_active.l1,0))
)
if not g_tbox_writing then
spr(38,100,ti(.6,.3)and 13 or 14)
end
camera()
end
end
function ttbox_draw(x,y)
if g_tbox_active then
camera(-x,-y)
rectfill(-1,0,105,19,0)
zrect(1,2,103,17)
camera()
tbox_basic_draw(x,y)
end
end
function tbox_clear()
g_tbox_messages,g_tbox_anim,g_tbox_active={},0,false
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
g_rooms=ztable[[19]]
g_room_template=ztable[[20]]
create_parent([[21|22]],function(a)
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
create_parent[[23|24]]
create_parent[[25|26]]
create_parent[[27|28]]
create_parent[[29|30]]
create_parent[[31|32]]
create_parent[[33|34]]
create_parent([[35|36]],function(a)
if a.x+a.dx<g_cur_room.x+.5 then
a.x=g_cur_room.x+.5
a.dx=0
end
if a.x+a.dx>g_cur_room.x+g_cur_room.w-.5 then
a.x=g_cur_room.x+g_cur_room.w-.5
a.dx=0
end
if a.y+a.dy<g_cur_room.y+.5 then
a.y=g_cur_room.y+.5
a.dy=0
end
if a.y+a.dy>g_cur_room.y+g_cur_room.h-.5 then
a.y=g_cur_room.y+g_cur_room.h-.5
a.dy=0
end
end)
create_parent([[37|38]],function(a)
a.t+=1
end)
create_parent([[39|40]],function(a)
a.x+=a.dx
a.y+=a.dy
end)
create_parent([[41|42]],function(a)
a.dx+=a.ax a.dy+=a.ay
a.dx*=a.ix a.dy*=a.iy
if a.ax==0 and abs(a.dx)<.01 then a.dx=0 end
if a.ay==0 and abs(a.dy)<.01 then a.dy=0 end
end,function(a)
a.ax,a.ay,a.dx,a.dy=0,0,0,0
end)
create_parent([[43|44]],function(a)
scr_rect(a.x-a.rx,a.y-a.ry,a.x+a.rx,a.y+a.ry,8)
end)
create_parent([[45|46]],function(a)
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
create_parent([[47|48]],function(a)
a.xx,a.yy=0,0
end)
create_parent[[49|50]]
create_parent[[51|50]]
create_parent[[52|50]]
create_parent[[53|50]]
create_parent([[54|55]],scr_spr,scr_out,scr_spr_and_out
)
create_parent([[56|57]],scr_spr_and_out)
create_parent([[58|59]],function(a,speed,xdir,ydir)
a.dx=xdir*speed
a.dy=ydir*speed
end)
create_parent([[60|61]],function(a)
if a.stun_countdown>0 then
a.ay,a.ax=0,0
a.yy=rnd_one()
a.outline_color=2
else
a.outline_color=1
end
end)
create_parent([[62|63]],function(a,damage,stun_val)
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
create_parent[[64|32]]
create_parent([[65|66]],function(a)
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
create_parent([[67|68]],function(a,b)
if does_a_contain_b(a,b)then
a:contains(b)
elseif do_actors_intersect(a,b)then
a:intersects(b)
else
a:not_contains_or_intersects(b)
end
end)
create_parent[[69|70]]
create_parent([[71|72]],function(a,acts)
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
hit_list[b]=hit_list[b]or ztable[[73]]
batch_call_new(col_help,[[74]],a,b,x,dx,y,dy)
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
create_parent([[75|76]],function(a,solid_func)
local x,dx=coll_tile_help(a.x,a.y,a.dx,a.rx,a.ry,0,a,a.tile_hit,solid_func)
local y,dy=coll_tile_help(a.y,a.x,a.dy,a.ry,a.rx,2,a,a.tile_hit,function(y,x)return solid_func(x,y)end)
if a.tile_solid then
a.x,a.y,a.dx,a.dy=x,y,dx,dy
end
end)
create_parent([[77|78]],function(a)
if is_game_paused"dancing"then
a.dance_time=cos(t()-a.initial_time)
if a.initial_xf then
a.xf=a.dance_time>0
else
a.xf=a.dance_time<0
end
end
end,function(a)
a.initial_xf=a.xf
a.initial_time=t()
end)
create_parent([[79|80]],function(a)
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
create_parent[[81|82]]
create_parent([[83|84]],function(a,o)
if o!=a.rel_actor then
call_not_nil(o,"knockback",o,a.bash_dx,bool_to_num(a.xf),0)
change_cur_ma(o)
if a.rel_actor then
call_not_nil(a.rel_actor,"knockback",a.rel_actor,-a.rel_bash_dx,bool_to_num(a.xf),0)
end
end
end
)
create_parent([[85|86]],function(a)
if a==a.rel_actor.item then a.rel_actor.item=nil end
end)
create_parent([[87|88]],function(a)
a.xf=a.rel_actor.xf
a.ixx=a.xf and a.poke_ixx or-a.poke_ixx
use_energy(a.poke_energy)
end,function(a)
a.rel_dx=bool_to_num(a.xf)*a.poke_dist/a.tl_max_time/60
pause_energy()
end,function(a)
a.rel_dx,a.rel_x=0,a.xf and-a.poke_dist or a.poke_dist
end,function(a)
a.rel_dx=-bool_to_num(a.xf)*a.poke_dist/a.tl_max_time/60/2
end)
create_parent([[89|90]],function(a)
if remove_money(a.cost)then
a:kill()
_g.item_show(g_pl,a.sind,a.mem_loc)
pause"chest"
stop_music"1"
else
zsfx(2,6)
end
end)
create_parent[[91|32]]
create_parent([[92|93]],function(a)
if zdget(a.mem_loc)==a.mem_loc_expect then
a:delete()
end
end)
function brang_hit_func(a,other)
if other.brang_hittable then
call_not_nil(other,"hurt",other,other.brang_hurtable and 1 or 0,30)
call_not_nil(other,"knockback",other,.3,a.xf and-1 or 1,0)
change_cur_ma(other)
a.did_brang_hit=true
end
end
create_actor([[94|95]],function(a)
a.x,a.y=a.rel_actor.x,a.rel_actor.y
a.xf=a.rel_actor.xf
a.ax=bool_to_num(a.xf)*.1
use_energy(10)
end,brang_hit_func,
function(a)
pause_energy()
end,function(a,other)
if other.pl then
a.alive=false
end
brang_hit_func(a,other)
end,function(a)
pause_energy()
a.ax=xbtn()*.05
a.ay=ybtn()*.05
return not a.being_held or a.did_brang_hit
end,function(a,other)
if other.pl then
a.alive=false
elseif other.touchable and not a.did_brang_hit then
if other.knockable then
other.knockback(other,.05,a.xf and-1 or 1,0)
end
a.did_brang_hit=true
end
end,function(a)
pause_energy()
amov_to_actor(a,a.rel_actor,.1)
end,function(a)
if a.did_brang_hit then
zsfx(2,7)
end
end,function(a)
a.did_brang_hit=true
end
)
create_actor([[96|97]],function(a)
a.rel_y=0
a.xf=a.rel_actor.xf
poke(0x5f41,15)
if zdget(39)then
sfx"7"
else
sfx"6"
end
pause("dancing")
end,function(a)
unpause()
poke(0x5f41,0)
end
)
create_parent([[98|99]],function(a)
if not a.being_held then a:next()end
pause_energy()
end,function(a,o)
if o!=a.rel_actor and o.hurtable then
call_not_nil(o,"hurt",o,a.hurt_amount,a.stun_amount)
a:bash(o)
end
end)
create_actor[[100|101]]
create_actor[[102|103]]
create_actor([[104|105]],function(a)
function zero_to_two(num)
return max(0,min(num,2))
end
local thing=g_selected-1
local next_selected=zero_to_two(flr(thing/3)+ybtnp())*3+zero_to_two(thing%3+xbtnp())+1
if g_selected!=next_selected then
g_items_drawn[g_selected].outline_color=1
g_items_drawn[next_selected].outline_color=2
g_selected=next_selected
end
end
)
create_actor([[106|107]],function(a)
if not a.enabled then a.sind=0 end
end)
create_actor([[108|109]],function(a)
g_card_fade=max(a.tl_tim/a.tl_max_time*10,g_card_fade)
end)
create_actor([[110|109]],function(a)
g_card_fade=min((a.tl_max_time-a.tl_tim)/a.tl_max_time*10,g_card_fade)
end)
create_actor([[111|112]],
function(a)
if a.follow_act and not a.follow_act.alive then
a.follow_act=nil
end
batch_call_new(update_view_helper,[[113]],a)
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
create_parent([[114|115]],function(a)
_g.look_at_pl(a)
a.ixx=rnd_one()
end,function(a)
amov_to_actor(a,g_pl,a.jump_speed)
a.iyy+=sin(a.tl_tim/a.tl_max_time)
end,function(a,other,...)
if other.pl then
call_not_nil(other,"knockback",other,a.knockback_speed,...)
other.hurt(other,0,a.stun_len)
end
end)
create_actor[[116|117]]
create_actor([[118|119]],function(a)
batch_call_new(_g.miny,[[120]],a.x,a.y)
end)
create_actor([[121|122]],function(a)
local rnd_num=rnd()
_g.evil_quack(cos(rnd_num)*25+g_pl.x,sin(rnd_num)*25+g_pl.y)
end)
create_actor([[123|124]],function(a)
amov_to_actor(a,g_pl,.08)
a.xf=a.ax<0
end,function(a,other)
if other.pl then
other.hurt(other,1,15)
end
end)
create_actor([[125|126]],function(a)
a.ax,a.ay=rnd_one".01",rnd_one".01"
a.xf=a.ax<0
end,function(a)
_g.destroy_effect(a)
_g.evil_quack_spawner()
end)
create_actor([[127|128]],change_cur_ma,function()
change_cur_ma()
end,function(a)
if do_actors_intersect(a,g_pl)then
if g_pause_reason=="dancing"then
if zdget"39"then
batch_call_new(zdset,[[129]],a.spot,g_pl.max_health,g_pl.health,g_money)
memcpy(0x5e00,0x5d00,64)
tbox"the game has been saved!"
else
tbox"the game won't save for^terrible music."
end
end
end
end,function(a)
if get_cur_ma()==a then
change_cur_ma()
end
end)
create_actor[[130|131]]
create_actor[[132|133]]
create_actor[[134|135]]
create_actor[[136|137]]
create_actor([[138|139]],function(a)
unpause()
resume_music()
zdset(a.mem_loc)
end
)
create_actor([[140|141]],function(a)
if zdget(a.mem_loc)then a:next()end
a.trig_x=a.xf and-.125 or.125
a:interactable_init()
end,function(a)
a:next()
pause"chest"
stop_music"1"
a.item_show=_g.item_show(g_pl,1,a.mem_loc)
end)
create_actor([[142|143]],function(a)
if get_cur_ma()==a.rel_actor then
change_cur_ma()
end
end
)
create_actor([[144|145]],function(a)
batch_call_new(_g.static_block,[[146]],a.x,a.y)
batch_call_new(_g.gen_trigger_block,[[147]],a,function(trig,other)
if other.pl then
transition(a.room,a.room_x,a.room_y,g_pl)
end
end)
end)
new_create_actor[[148|149]]
create_actor([[150|151]],function(a)
batch_call_new(_g.static_block,[[152]],a.x,a.y)
end)
create_actor[[153|154]]
create_parent([[155|156]],function(a,other)
if other.pl then
a.f_stat()
a.destroyed,a.alive=function()
_g.stat_hover(g_pl,a.sind)
end
end
end)
create_actor([[157|158]],function()
add_money"1"
end)
create_actor([[159|158]],function()
g_pl:heal(3)
end)
create_actor[[160|161]]
create_actor([[162|163]],function(a)
local p=a.parent
a.x=p.x+p.ixx/8
a.y=p.y+p.iyy/8
end)
create_actor([[164|165]],function(a)
a.ax=bool_to_num(a.xf)*.04
end,function(a)
a.iyy=-cos(a.tl_tim/a.tl_max_time/4)*8
end,function(a)
zsfx(2,7)
_g.destroy_effect(a,1)
end,function(a,o)
if o.touchable and not o.pl then
call_not_nil(o,"hurt",o,0,60)
call_not_nil(o,"knockback",o,.6,bool_to_num(a.xf),0)
a:next()
end
end)
create_actor([[166|167]],function(a)
_g.gen_trigger_block(a,0,.25,.5,.25,nf,function(trig,other)
if btnp(4)and not other.item and zdget"16"then
other.item=_g.grabbed_item(g_pl,a.sind,-7,function(x,y,xf)
_g.pot_projectile(other.x,other.y,xf)
end)
local rnd_num=flr_rnd"5"
if rnd_num==0 then
_g.money(a.x,a.y)
elseif rnd_num==1 then
_g.health_obj(a.x,a.y)
end
a:kill()
end
end)
end
)
create_actor[[168|169]]
create_actor[[170|171]]
create_actor([[172|173]],function(a,o)
call_not_nil(o,"hurt",o,1,15)
end)
create_actor[[174|175]]
create_actor[[176|177]]
create_actor[[178|179]]
create_actor([[180|181]],function(a)
if g_pl.health<g_pl.max_health then
tbox("please let me help you.",function()g_pl.health=g_pl.max_health end)
else
tbox"i'm your biggest fan!^^visit me if you're hurt."
end
end,_g.npc_dance_logic("i can't fix banjos.","you helped my soul!",_g.memloc_money(17,60)))
create_actor[[182|183]]
create_actor[[184|185]]
create_actor[[186|187]]
create_actor([[188|189]],function(a)
a.xf,a.alive=g_pl.xf,g_pl.alive
end,function(a)
if g_pl:get[[190]]then
a.sind=g_pl.item.throwing and 150 or 148
elseif is_game_paused"dancing"then
a.sind=abs(a.dance_time)>.5 and 149 or 147
elseif is_game_paused"chest"then
a.sind=148
else
a.sind=147
end
end)
create_actor([[191|192]],function(a)
if btnp"4"or btn"5"then
zsfx(2,3)
a.create_func(a.x,a.y+a.iyy/8,a.xf)
return true
end
end,function(a)
zsfx(2,2)
end,function(a)
a.rel_actor.item=nil
end)
function calc_act_dist(a,b)
return abs(a.x-b.x)+abs(a.y-b.y)
end
create_actor([[193|194]],function(a)
a.x=a.rel_actor.x;
a.y=a.rel_actor.y;
end,function(a)
amov_to_actor(a,a.rel_actor,.04*calc_act_dist(a,a.rel_actor))
end)
create_actor([[195|196]],function(a)
local act=get_cur_ma()or a.rel_actor
amov_to_actor(a,act,calc_act_dist(a,act)*.013,a.off_x,a.off_y)
a.off_x,a.off_y=cos(a.tl_tim*.75),sin(a.tl_tim*.75)-.25
if flr(a.tl_tim/10)%2==0 then
a.off_x=-a.off_x
end
end,function(a)
a.x,a.y,a.tail=a.rel_actor.x,a.rel_actor.y-.25,_g.fairy_tail(a)
end,function(a)
batch_call_new(scr_line,[[197]],a.x,a.y,a.tail.x,a.tail.y)
end)
create_actor([[198|199]],function(a)
a.ltop,a.max_health,a.health=_g.lank_top(a),zdget_value"5",zdget_value"6"
a.lanks_fairy=_g.fairy(a)
end,function(a)
if a.stun_countdown==0 then
if not btn"5"then
if(xbtn()!=0)and not a:get[[200]]then a.xf=btn"0" end
a.ax,a.ay=xbtn()*a.spd,ybtn()*a.spd
if g_debug then
a.ax*=3
a.ay*=3
a.touchable=false
else
a.touchable=true
end
else
a.ax=0 a.ay=0
end
end
if a:get[[201]]then
a.ax,a.ay=0,0
end
if not btn"5"and not a.item and btnp"4"then
if not get_selected_item().interact then
if g_energy_tired then
zsfx(2,7)
else
a.item=gen_pl_item(a)
zsfx(2,2)
end
end
end
local item=a.item
if item then
if not item.alive then
a.item=nil
end
if not btn"4"and not btn"5"then
item.being_held=false
end
a.ax*=.5 a.ay*=.5
end
a.anim_len=abs(a.dx)+abs(a.dy)>0 and 3 or 1
if a.stun_countdown!=0 and a.item then
a.item.xx=a.xx
end
end,function(a)
if a.item then a.item.alive=false end
_g.destroy_effect(a)
_g.fader_out(nf,g_tl.next)
switch_song"-1"
sfx"4"
if a.lanks_fairy then
a.lanks_fairy:kill()
end
end,function(a)
a.ltop.outline_color=a.outline_color
scr_spr_and_out(a,a.ltop,a.item)
end)
function spr_and_out(...)
spr_out(...)
zspr(...)
end
create_actor([[202|203]],function(a)
camera(-8*8,-7*8)
batch_call_new(tprint,[[204]],"that story about",a.title_y)
for i=-2,2 do
spr_and_out(226+i,i*10,cos(t()/2+i/4)/2+1+a.title_y,1,2,false,false,1)
end
if ti(1,.5)and a.title_y==0 then
batch_call_new(tprint,[[205]],"🅾️ or ❎ to play  ")
end
camera()
end,function(a)
if btnp"4"or btnp"5"then
a:next()
g_pl=_g.pl(a.x,a.y)
g_left_ma_view=_g.view(2.75,3,0,g_pl)
end
end,function(a)
a.title_y=cos(a.tl_tim/a.tl_max_time/4)*75-75
end)
cartdata"zeldo_test3"
g_debug=false
menuitem(1,"restart",function()
extcmd"reset"
end)
menuitem(2,"reset save data",function()
memset(0x5e00,0,64)
extcmd"reset"
end)
function _init()
memset(0x5d00,0,64)
map_init()
g_tl=ztable([[206]],logo_draw,game_init,game_update,game_draw,game_over_init,game_over_update,game_over_draw)
end
create_actor([[207|208]],function(a)
if btnp"4"or btnp"5"then
a:kill()
_g.fader_out(nf,function()
g_tl.tl_next=2
end)
end
end)
function game_over_init()
_g.fader_in(nf,_g.game_over_checker)
game_over_sind,game_over_text=unpack(rnd_item(ztable[[209]]))
end
function logo_draw(a)
local logo_opacity=8+cos(a.tl_tim/a.tl_max_time)*4-4
fade(logo_opacity)
camera(logo_opacity>1 and rnd_one())
zspr(192,a.x,a.y,4,2)
fade"0"
camera()
end
function game_over_update()
batch_call_new(acts_loop,[[210]])
end
function game_over_draw()
fade(g_card_fade)
camera(-8*8,-7*8)
spr_and_out(game_over_sind,.5,sgn(cos(t()/2))/2+1,1,1,true,false,1)
batch_call_new(tprint,[[211]],game_over_text)
camera()
end
function _update60()
if g_debug then
poke(0x5f42,15)
else
poke(0x5f42,0)
end
if g_tbox_update then
zsfx(2,5)
if g_tbox_writing then
g_tbox_anim=#g_tbox_active.l1+#g_tbox_active.l2
else
del(g_tbox_messages,g_tbox_active)
g_tbox_active,g_tbox_anim=g_tbox_messages[1],0
end
if not g_tbox_active then
unpause()
g_tbox_messages.trigger()
end
g_tbox_update=false
end
if btnp"5"and btn"4"then
g_debug=not g_debug
end
tl_node(g_tl)
tbox_interact()
end
function _draw()
cls()
call_not_nil(g_tl,"d",g_tl)
end
function game_update()
room_update(g_pl or g_title)
local was_paused=is_game_paused()
if is_game_paused()and g_pause_init then
g_pause_init=false
batch_call_new(acts_loop,[[212]])
elseif not is_game_paused()then
energy_update(.25)
end
inventory_update()
batch_call_new(
acts_loop,[[213]],
g_act_arrs["col"],
function(x,y)
return x>=g_cur_room.x and x<g_cur_room.x+g_cur_room.w and
y>=g_cur_room.y and y<g_cur_room.y+g_cur_room.h and
fget(mget(x,y),6)
end,
g_pl,
g_act_arrs["anchored"]
)
if not was_paused and is_game_paused()then
g_pause_init=true
end
if was_paused and not is_game_paused()then
batch_call_new(acts_loop,[[214]])
end
batch_call_new(acts_loop,[[215]])
end
function camera_to_view(view)
camera((view.x-view.off_x-8)*8,(view.y-view.off_y-8)*8)
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
isorty(g_act_arrs.drawable)
batch_call_new(acts_loop,[[216]])
if g_debug then acts_loop("dim","debug_rect")end
clip()
camera()
zrect(x1,y1,x2,y2)
end
end
function game_draw()
fade(g_card_fade)
map_draw(g_main_view,8,7)
camera_to_view(g_main_view)
if g_menu_open then
if g_selected==5 then g_pl.outline_color=2 end
g_pl.d(g_pl)
end
acts_loop("above_map_drawable","d")
camera()
draw_status()
ttbox_draw(2,105)
end
function game_init()
batch_call_new(acts_loop,[[217]])
memcpy(0x5d00,0x5e00,64)
memset(0x5d00,0,64)
batch_call_new(zdset,[[218]])
zdset"11"
if not zdget"1"then
zdset(5,10)
zdset(6,10)
zdset"1"
end
inventory_init()
g_energy,g_energy_tired,g_energy_amount=0,false,0
g_money=zdget_value(4)
g_pl=nil
g_title=_g.title()
g_card_fade=8
_g.fader_in(
function()
pause"transitioning"
end,function()
unpause()
end
)
local spot=g_save_spots[zdget_value"3"]
load_room(spot.room,spot.x,spot.y,g_title)
end
function pause(reason)
if reason=="dancing"or reason=="chest"then
mute_music()
end
stop_music()
g_pause_reason=reason g_game_paused=true
end
function unpause()resume_music()g_game_paused=false end
function is_game_paused(reason)
return g_game_paused and(reason==g_pause_reason or not reason)
end
function zdget_value(ind)
return peek(0x5d00+ind)
end
function zdget(ind)
return zdget_value(ind)>0
end
function zdset(ind,val)
return poke(0x5d00+ind,val or 1)
end
function mute_music()
sfx(63,0,0)
sfx(62,1,1)
end
function stop_music(sound)
poke(0x5f43,3)
if sound then
sfx(sound)
end
end
function resume_music(song)
switch_song(song)
poke(0x5f43,0)
sfx(63,-1)sfx(62,-1)
g_music_current=song or g_music_current
end
function switch_song(song)
if song and song ~=g_music_current then
g_music_current=song
music(song,500,7)
end
end