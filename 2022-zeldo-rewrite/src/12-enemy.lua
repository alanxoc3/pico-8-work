|[slimy]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.slimy_actual(x, y) end)
end $$

|[miny]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.miny_actual(x, y) end)
end $$

zclass[[slimy_actual,box,mov,simple_spr,drawlayer_50,collidable,healthobj,actor|
    x,@, y,@, rx, .375, ry, .375,
    cspr,118, cname,"slimy", sind,118,
    destroyed, %standard_explosion,
    max_health,5;

    start; update, %slimy_update, statcollide,%slimy_statcollide;
]]

|[slimy_update]| function(a)
    if a.isma then g_rstat_right:set(a) end
end $$

    -- damage: how much damage to do to enemies
    -- stunlen: how much time enemy should be stunned after hit
    -- pushspeed: how fast the enemy should be pushed
    -- should_use_xf: should push speed be reflected by the xf or position
    -- item_hit_func: a function that gets when it hits the enemy

|[slimy_statcollide]| function(a, items)
    foreach(items, function(item)
        if not a:outside(item) and item:is_alive() then
            a:start_timer('isma', 1.5, function() a.isma = false end)
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

zclass[[miny_actual,simple_spr,drawlayer_50,actor|
    x,@, y,@,
    cspr,116, cname,"miny", sind,116
]]
