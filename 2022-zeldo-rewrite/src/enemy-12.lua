-- enemy can collide with the player
zclass[[enemy,box|
    pl_collide_func_batch,%f_enemy_pl_collide_func_batch,
    pl_collide_func,nop
]]

zclass[[quack,propel,ma_interact,actor,collidable,mov,enemy,simple_spr,drawlayer_50|
    x,@, y,@, rx, .25, ry, .25,
    should_dance,yes,
    sy,-2,
    propel_speed,.0125,
    pl_collide_func,%f_quack_pl_collide_func,
    sind,32, cspr,32, cname,"quack";
    start; init,%f_quack_change_dir, update,~propel, duration,1, next,start;
]]

|[f_quack_change_dir]| function(a)
    a.ang = rnd(2)-1
    a.xf = sgn(cos(a.ang))
end $$

|[f_quack_pl_collide_func]| function(a, pl)
    if not _g.f_sign_target_with_tbox_disable_callback() then
        a:start_timer('isma', 0)
    end
end $$

|[f_enemy_pl_collide_func_batch]| function(a, others)
    foreach(others, function(other)
        if not a:outside(other) then
            a:pl_collide_func(other)
        end
    end)
end $$
