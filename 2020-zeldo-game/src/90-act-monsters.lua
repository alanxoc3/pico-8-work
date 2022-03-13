-- SECTION: MONSTERS
create_parent([[slimy_parent;8;brang_hittable,ma_able,drawable,bounded,danceable,confined,stunnable,mov,col,tcol,hurtable,knockable,spr_obj,spr|
   name:@1; rx:@2; ry:@3;
   max_health:@4; health:@4;
   sind:@7;
   evil:yes; tl_loop:yes;
   anim_len:1;
   touchable:no;
   jump_speed:.03;
   knockback_speed:@5;
   stun_len:@6;

sind=@7,ax=0,ay=0,hit=nf,u=%look_at_pl,tl_max_time=2;
i=nf,hit=nf,u=@9,tl_max_time=.25;
sind=@8,ixx=0,i=nf,hit=@11,u=@10,tl_max_time=.25;

-- #;.tl_max_time:2;.u:%look_at_pl;
-- #;.tl_max_time:.25;.u:~u_shake;
-- #;.tl_max_time:.25;.u:~u_air;.hit:~hit_air;.sind:~other_sind;
 
]], function(a)
   _g.look_at_pl(a)
   a.ixx = rnd_one()
end, function(a)
   amov_to_actor(a, g_pl, a.jump_speed)
   a.iyy += sin(a.tl_tim/a.tl_max_time)
end, function(a, other, ...)
   if other.pl then
      call_not_nil(other, 'knockback', other, a.knockback_speed, ...)
      other.hurt(other, 0, a.stun_len)
   end
end)

create_actor[[
   miny;3;slimy_parent/"miny"/.125/.125/1/.05/0/116/117,brang_hurtable|
   x:@1;y:@2;dy:@3;destroyed:%destroy_effect
]]

create_actor([[slimy;2;slimy_parent/"slimy"/.25/.25/3/.2/30/118/119,|
    x:@1;y:@2;destroyed:@3;
]], function(a)
   batch_call_new(_g.miny, [[
      @1,@2,.2;
      @1,@2,-.2;
   ]], a.x, a.y)
end)

create_actor([[evil_quack_spawner;0;loopable,confined|
   tl_max_time=.5,i=@1;
]], function(a)
   local rnd_num = rnd()
   _g.evil_quack(cos(rnd_num)*25 + g_pl.x, sin(rnd_num)*25 + g_pl.y)
end)

create_actor([[evil_quack;2;drawable,mov,col,spr,danceable,confined,anchored/no|
   x:@1;y:@2;

   evil:yes; sind:32;
   rx:.375;ry:.375;
   i:@3; hit:@4;
   tl_max_time=3,;

]], function(a)
   amov_to_actor(a, g_pl, .08)
   a.xf = a.ax < 0
end, function(a, other)
   if other.pl then
      other.hurt(other, 1, 15)
   end
end)

create_actor([[quack;2;brang_hittable,drawable,ma_able,hurtable,loopable,bounded,confined,stunnable,mov,col,tcol,knockable,spr,danceable|
   name:"quack";
   evil:yes;
   x:@1;y:@2;
   rx:.375;ry:.375;
   sind:32;
   health:50;
   max_health:50;
   destroyed:@4;

   i=@3,tl_max_time=.5;
]], function(a)
   a.ax, a.ay = rnd_one'.01', rnd_one'.01'
   a.xf = a.ax < 0
end, function(a)
   _g.destroy_effect(a)
   _g.evil_quack_spawner()
end)

-- create_actor[[miny;3;ma_able,drawable,bounded,danceable,confined,stunnable,mov,col,tcol,brang_hurtable,knockable,spr_obj,spr|
--    x:@1;y:@2;dy:@3;
--    max_health:1;health:1;
--    name:"miny";evil:yes;tl_loop:yes;
--    rx:.125;ry:.125;
--    sind:116;
--    iyy:-1;
--    anim_len:1;
--    touchable:yes;
--    jump_speed:.02;
--    knockback_speed:.05;
--    stun_len:0;
-- 
--    sind=116,iyy=-2,ax=0,ay=0,hit=nf,u=%look_at_pl,tl_max_time=1;  -- wait
--    i=nf,hit=nf,u=%slimy_shake,tl_max_time=.25; -- shake
--    sind=117,ixx=0,i=nf,hit=%slimy_knockback,u=%slimy_jump,tl_max_time=.25; -- in air
-- ]]

-- create_actor([[topy;2;drawable,bounded,danceable,confined,stunnable,mov,col,tcol,hurtable,knockable,anim,spr]], [[
--    max_health:10; health:10;
--    name:"topy";
--    evil:yes;
--    x:@1;y:@2;
--    rx:.375;ry:.375;
--    tl_loop:yes;
--    iyy:-2;
--    sinds:112,113;
--    anim_len:1;
--    touchable:yes;
--    destroyed:@8;
--    hurt_func:@9;
-- 
--    i=@4,hit=nf,u=nf,tl_max_time=.5;
--    i=@7,hit=nf,u=@5,tl_max_time=.5;
--    i=@6,hit=@3,u=nf,tl_max_time=1;
-- ]], function(a, other, ...)
--    call_not_nil(other, 'knockback', other, .3, ...)
-- 
--    if other.pl then
--       other.hurt(other, 2, 30)
--    end
-- end, function(a) -- init 1 @4
--    a.ax, a.ay = 0, 0
--    a.anim_off = 0
-- end, look_at_pl, -- update 1 @5
-- function(a) -- init 2 @6
--    amov_to_actor(a, g_pl, .06)
-- end, function(a)
--    a.anim_off = 1
-- end, function(a)
--    destroy_effect(a, 30, 1, 4, 5, 2)
--    _g.money(a.x, a.y, a.dx, a.dy)
-- end, function(a)
--    a.tl_next = 2
--    change_cur_ma(a)
-- end)

-- create_actor([['bat', 2, {'bounded','confined','stunnable','mov','col','hurtable','knockable','anim','spr'}]], [[
--    evil=yes,
--    x=@1, y=@2,
--    rx=.375, ry=.375,
--    sinds={114,115},
--    anim_len=2,
--    anim_spd=10,
--    destroyed=@4,
--    touchable=no,

--    {i=@3, tl_max_time=1.5}
-- ]], function(a)
--    a.ax = .01
-- end, destroy_func
-- )

-- create_actor([['skelly', 2, {'bounded','confined','stunnable','mov','col','tcol','hurtable','knockable','anim','spr'}]], [[
--    evil=yes,
--    x=@1, y=@2,
--    ax=.005, ay=.01,
--    rx=.375, ry=.375,
--    sinds={66},
--    destroyed=@4,
--    anim_len=1,
--    {i=@3, tl_max_time=1.5}
-- ]], function(a)
--    end, destroy_func
-- )

-- create_actor([['ghost', 2, {'bounded','confined','stunnable','mov','col','hurtable','knockable','anim','spr'}]], [[
--    evil=yes,
--    x=@1, y=@2,
--    rx=.375, ry=.375,
--    sinds={84},
--    anim_len=1,
--    destroyed=@4,
--    touchable=no,

--    {i=@3, tl_max_time=1.5}
-- ]], function(a)
--       a.ax = sin(t())/50
--       a.xf = sgn(a.ax) < 1
--    end, destroy_func
-- )

