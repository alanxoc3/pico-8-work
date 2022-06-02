|[slimy]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.slimy_actual(x, y) end)
end $$

|[miny]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.miny_actual(x, y) end)
end $$

-- enemy can collide with the player
zclass[[enemy,box,mov,collidable,healthobj,actor|
    pl_collide_func_batch,%enemy_pl_collide_func_batch,
    pl_collide_func,nop
]]

|[enemy_pl_collide_func_batch]| function(a, others)
    foreach(others, function(other)
        if not a:outside(other) then
            a:pl_collide_func(other)
        end
    end)
end $$

zclass[[slimy_actual,enemy,simple_spr,drawlayer_50|
    x,@, y,@, rx, .25, ry, .25,
    cspr,118, cname,"slimy", sind,118,
    destroyed,%slimy_destroyed,
    statcollide,%slimy_statcollide,
    max_health,5;

    -- start
    -- shake
    -- jump!
    start; pl_collide_func,nop, sind,118, speed,0, sx,0, sy,0, update,%slimy_start, duration, 1,   next,shake;
    shake; speed,0,             update,%slimy_shake, duration, .25, next,jump;
    jump;  pl_collide_func,%slimy_pl_collide_func, sind,119, speed,.05, sx,0,       update,%slimy_jump,  duration, .375, next,start;
]]

|[slimy_pl_collide_func]| function(a, pl)
    if not pl:is_active'stunned' then
        a.isma = true
        a.speed = 0
        a:load'start'
        a:start_timer('isma', 2, function() a.isma = false end)
        pl:start_timer('stunned', .375, nop)
        pl.ang = atan2(a.xf, pl.y-a.y)
    end
end $$

|[slimy_destroyed]| function(a)
    _g.miny(a.x, a.y-.5)
    _g.miny(a.x, a.y+.5)
end $$

|[slimy_start]| function(a)
    if a.isma then g_rstat_right:set(a) end
    a.xf = sgn(g_pl.x-a.x)
    a.target_ang = atan2(g_pl.x-a.x, g_pl.y-a.y)
end $$

|[slimy_shake]| function(a)
    if a.isma then g_rstat_right:set(a) end
    a.sx = rnd_one()
end $$

|[slimy_jump]| function(a)
    if a.isma then g_rstat_right:set(a) end
    a.ang = a.target_ang
    a.sy = sin(a:get_elapsed_percent'jump'/2)*8
end $$

    -- damage: how much damage to do to enemies
    -- stunlen: how much time enemy should be stunned after hit
    -- pushspeed: how fast the enemy should be pushed
    -- should_use_xf: should push speed be reflected by the xf or position
    -- item_hit_func: a function that gets when it hits the enemy

|[slimy_statcollide]| function(a, items)
    foreach(items, function(item)
        if not a:outside(item) and item:is_alive() then
            a:start_timer('isma', 2, function() a.isma = false end)
            a.isma = true

            if not a:is_active'stunned' then
                a:start_timer('stunned', item.stunlen, nop)
                a:hurt(item.damage)
            end

            item:item_hit_func()

            if item.should_use_xf then
                a.dx += item.pushspeed*item.xf
            else
                local abx, aby = a:abside(item)
                a.dx += item.pushspeed*abx
                a.dy += item.pushspeed*aby
            end
        end
    end)
end $$

-- shield collide
-- brang collide
-- arrow collide
-- sword collide

zclass[[miny_actual,simple_spr,vec,drawlayer_50,actor|
    x,@, y,@,
    cspr,116, cname,"miny", sind,116
]]
