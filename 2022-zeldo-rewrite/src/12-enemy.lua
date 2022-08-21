|[slimy]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.slimy_actual(rnd'1', x, y) end)
end $$

|[miny]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.miny_actual(rnd'1', x, y, 0) end)
end $$

-- enemy can collide with the player
zclass[[enemy,box|
    pl_collide_func_batch,%enemy_pl_collide_func_batch,
    pl_collide_func,nop
]]

zclass[[quack,ma_right,actor,collidable,mov,enemy,simple_spr,drawlayer_50|
    x,@, y,@, rx, .25, ry, .25,
    sy,-2,
    speed,.0125,
    pl_collide_func,%quack_pl_collide_func,
    sind,32, cspr,32, cname,"quack";
    start; init,%quack_change_dir, duration,1, next,start;
]]

|[quack_change_dir]| function(a)
    a.ang = rnd(2)-1
    a.xf = sgn(cos(a.ang))
end $$

|[quack_pl_collide_func]| function(a, pl)
    a:start_timer('isma', 0)
end $$

|[enemy_pl_collide_func_batch]| function(a, others)
    foreach(others, function(other)
        if not a:outside(other) then
            a:pl_collide_func(other)
        end
    end)
end $$

zclass[[slimy_shared,ma_right,actor,collidable,healthobj,mov,enemy,simple_spr,drawlayer_50|
    rx, .25, ry, .25,
    statcollide,%slimy_statcollide,
    drawout,%slimy_draw,
    pl_collide_func,%slimy_pl_collide_func,
    max_health,5;

    stunned; init,nop, speed,0, sx,0, duration,0, next,idle;
    start;   next,idle;
    idle;    init,nop, speed,0, sx,0, update,%slimy_start, duration, 1,   next,bounce_1;
    bounce_1;init,%slimy_bounce, speed,0, update,nop, duration,.0625, next,bounce_2;
    bounce_2;init,%slimy_bounce, speed,0, update,nop, duration,.0625, next,jump;
    jump;    init,%slimy_jump_init, update,nop, pl_collide_func,%slimy_pl_collide_func, speed,.025, sx,0, duration, .25, next,idle;
]]

zclass[[slimy_actual,slimy_shared |
    start;duration,@;
    x,@, y,@, cspr,118, cname,"slimy", sind,118, max_health,5, destroyed,%slimy_destroyed;
    stunned;sind,118;
    idle;sind,118;
    jump;sind,119;
]]

zclass[[miny_actual,slimy_shared  |
    start;duration,@;
    x,@, y,@, dy,@, cspr,116, cname,"miny", sind,116, max_health,1, destroyed,%standard_explosion;
    stunned;sind,116;
    idle;sind,116;
    jump;sind,117;
]]

|[slimy_pl_collide_func]| function(a, pl)
    a.speed = 0
    a:start_timer('isma', 2)
    if a:is_active'jump' then
        pl:push(atan2(a.xf, pl.y-a.y), .125)
        pl:stun()
    end
end $$

|[slimy_destroyed]| function(a)
    _g.miny_actual(rnd'1', a.x, a.y, -.2)
    _g.miny_actual(rnd'1', a.x, a.y, .2)
end $$

|[slimy_start]| function(a)
    a.xf = sgn(g_pl.x-a.x)
    a.target_ang = atan2(g_pl.x-a.x, g_pl.y-a.y)
end $$

|[slimy_bounce]| function(a)
    if a.sind == a.idle.sind then
        a.sind = a.jump.sind
    else
        a.sind = a.idle.sind
    end
end $$

|[slimy_jump_init]| function(a)
    a.ang = a.target_ang
    a:start_timer('jumpanim', .25)
    -- a.stunned.duration = rnd"1"
end $$

|[slimy_draw]| function(a)
    a.sy = sin(a:get_elapsed_percent'jumpanim'/2)*8
    _g.simple_spr_draw(a)
end $$

|[slimy_statcollide]| function(a, items)
    foreach(items, function(item)
        if not a:outside(item) and item:is_alive() then
            a:start_timer('isma', 2)

            a:hurt(item.damage)
            if not a:is_active'stunned' then
                if item.should_use_xf then
                    a.dx += item.pushspeed*item.xf
                else
                    local abx, aby = a:abside(item)
                    a.dx += item.pushspeed*abx
                    a.dy += item.pushspeed*aby
                end
            end

            item:item_hit_func()
        end
    end)
end $$
