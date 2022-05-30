|[slimy]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.slimy_actual(x, y) end)
end $$

|[miny]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.miny_actual(x, y) end)
end $$

zclass[[slimy_actual,box,mov,simple_spr,drawlayer_50,collidable,actor|
    x,@, y,@, rx, .5, ry, .5,
    cspr,118, cname,"slimy", sind,118;

    start; update, %slimy_update, statcollide,%slimy_statcollide;
]]

|[slimy_update]| function(a)
    if a.isma then g_rstat_right:set(a) end
end $$

|[slimy_statcollide]| function(a, items)
    foreach(items, function(item)
        if not a:outside(item) then
            a:start_timer('isma', 1.5, function() a.isma = false end)
            a.isma = true

            if item.id == 'brang' or item.id == 'bomb' then
                local abx, aby = a:abside(item)
                a.dx += .125*abx
                a.dy += .125*aby
            elseif item.id == 'arrow' or item.id == 'shield' or item.id == 'sword' then
                a.dx += .125*item.xf
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
