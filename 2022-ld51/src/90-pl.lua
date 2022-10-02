zclass[[pbox_spawn,actor,box,drawlayer_20|
    x,@, y,@, rx,.5, ry,.5,
    sind,98,
    update,%pbox_spawn_update
]]

|[pbox_spawn_update]| function(a)
    if g_pbox:touching(a) then
        a.draw = nop
    else
        a.draw = _g.panda_draw
        foreach(g_pbox.pandas, function(panda)
            if a:touching(panda) then
                g_pbox.x, g_pbox.y = a.x, a.y-.5
            end
        end)
    end
end $$

zclass[[pbox,actor,collidable,mov,drawlayer_25|
    x,@, y,@,

    should_collide_with_screen_edge,yes,
    rx,.25, ry,.25,
    sind,13,
    update,%pbox_update,
    draw,%panda_draw,
    pandas_col_y,%pandas_col_y,
    normal,yes,
    curr,idle;
    pandas;,;

    idle; duration,10, init,%spawn_panda, next,idle;
]]

|[pandas_col_y]| function(a)
    for i=2,#a.pandas do
        local aa, bb = a.pandas[i], a.pandas[1]
        if aa.solid and bb.solid and aa:touching(bb) then
            aa.touching_panda = true
            aa.touching_ground = true
        end
    end
end $$

|[spawn_panda]| function(a)
    local moves = {}
    foreach(a.pandas, function(panda)
        add(moves, panda.moves)
        panda:kill()
    end)

    g_pl = _g.panda(a.x, a.y, {}, function(aa)
        add(aa.moves, {btn(3), btn(4), zbtn(btn, 0), zbtn(btn, 2)})
        _g.panda_update_control(aa, unpack(aa.moves[#aa.moves]))
    end, true)

    a.pandas = {g_pl}

    foreach(moves, function(m)
        if #a.pandas < 2 then
            add(a.pandas, _g.panda(a.x, a.y, m, function(a)
                if not a.move_ind then a.move_ind = 1 end
                if a.move_ind <= #a.moves then
                    _g.panda_update_control(a, unpack(a.moves[a.move_ind]))
                    a.move_ind += 1
                else
                    a:kill()
                end
            end, false))
        end
    end)
end $$

|[pbox_update]| function(a)
    a.ay = .015

    local reload = true
    foreach(a.pandas, function(panda)
        if panda.alive then
            reload = false
        end
    end)

    if reload then
        a:load'idle'
    end
end $$

zclass[[follow_panda,mov|
    x,0, y,43, update,%follow_panda_update
]]

|[follow_panda_update]| function(a)
    local anchor = g_pbox
    for i=#g_pbox.pandas, 1, -1 do
        if g_pbox.pandas[i].alive then
            anchor = g_pbox.pandas[i]
        end
    end

    if anchor.id == 'panda' and btnp(5) then
        anchor:kill()
    end

    if anchor.touching_ground then
        if g_zbtn_2 > 0 then
            a.yoff = 1
        elseif g_zbtn_2 < 0 then
            a.yoff = -1
        else
            a.yoff = 0
        end
    else
        a.yoff = 0
    end

    a.x = anchor.x

    local dist = (anchor.y+a.yoff) - a.y
    if abs(dist) > .125 then
        a.y += dist/4
    else
        a.y = anchor.y+a.yoff
    end
end $$

zclass[[anchor,pos|
    update_anchor,%anchor_update_anchor;
    offx,0, offy,0,
    anchoring;,
]]

|[anchor_update_anchor]| function(a)
    a.x, a.y = a.anchoring.x+a.offx, a.anchoring.y+a.offy
end $$

zclass[[panda,actor,collidable,mov,drawlayer_50|
    x,@,y,@,moves,@,update,@,is_main,@,
    rx,.25, ry,.25,
    should_collide_with_screen_edge,yes,

    sind,0,
    xf,no,

    touching_panda,yes,
    draw,%panda_draw,
    tile_hit,%panda_tile_hit;

    start;  duration,1, next,normal;
    normal; solid,yes;
]]

JMPSP = .125

|[panda_update_control]| function(a, b3, b4, zbtn0, zbtn2)
    a.ax = 0
    a.ay = .015 -- gravity
    a.ix = .95
    a.iy = 1

    if b4 and a.think_touch_ground then
        a:start_timer('jump', .1)
        if b3 then
            a.jumpdx, a.jumpdy = false, JMPSP
        else
            a.jumpdx, a.jumpdy = false, -JMPSP
        end
    elseif a.touching_panda then
        a:start_timer('jump', .1)
        a.jumpdx, a.jumpdy = false, -JMPSP
        a.touching_panda = false
    elseif (b4 and a.active_ledge == 'left')  or (b4 and a.touching_left_wall) then
        a:end_timer'jump'

        if a.think_touch_ground then
            a.active_ledge = nil
        elseif a.touching_left_wall then
            a.active_ledge = 'left'
            a.ay = 0 a.dx = -JMPSP a.iy = .8
            if zbtn2 ~= 0 then a.ay = .065/4 * zbtn2 else a.dy = 0 end
        else
            a.active_ledge = nil
            a:start_timer('jump', .1)
            a.jumpdx, a.jumpdy = 0, -JMPSP/2
        end
    elseif (b4 and a.active_ledge == 'right') or (b4 and a.touching_right_wall) then
        a:end_timer'jump'

        if a.think_touch_ground then
            a.active_ledge = nil
        elseif a.touching_right_wall then
            a.active_ledge = 'right'
            a.ay = 0 a.dx = JMPSP a.iy = .8
            if zbtn2 ~= 0 then a.ay = .065/4 * zbtn2 else a.dy = 0 end
        else
            a.active_ledge = nil
            a:start_timer('jump', .1)
            a.jumpdx, a.jumpdy = 0, -JMPSP/2
        end
    elseif not b4 and a.active_ledge == 'left' then
        a:start_timer('jump', .1)
        a:start_timer('jump_recoil', .1)

        if b3 then
            a.jumpdx, a.jumpdy = JMPSP, JMPSP
        else
            a.jumpdx, a.jumpdy = JMPSP, -JMPSP
        end

        a.active_ledge = nil
    elseif not b4 and a.active_ledge == 'right' then
        a:start_timer('jump', .1)
        a:start_timer('jump_recoil', .1)

        if b3 then
            a.jumpdx, a.jumpdy = -JMPSP, JMPSP/2
        else
            a.jumpdx, a.jumpdy = -JMPSP, -JMPSP/2
        end

        a.active_ledge = nil
    end

    if a:is_active'jump' then
        a.dx = a.jumpdx or a.dx
        a.dy = a.jumpdy or a.dy
    end

    if not a:is_active'jump_recoil' and not a.active_ledge then
        a.ix = .8
        if zbtn0 ~= 0 then
            a.ax += (a.touching_ground and .065/3 or .065/3) * zbtn0
            a.xf = a.ax < 0
        end
    else
        if a.dx > 0 then a.xf = false end
        if a.dx < 0 then a.xf = true end
    end

    if a.active_ledge then
        a.sind = 37
    elseif not a.think_touch_ground then
        if a:is_active'jump' then
            a.sind = 4
        elseif a.dy > 0 then
            a.sind = 6
        else
            a.sind = 5
        end
    else
        if a.dx ~= 0 then
            if t()%.25 < .125 then
                a.sind = 3
            else
                a.sind = 2
            end
        else
            if t()%1 < .5 then
                a.sind = 1
            else
                a.sind = 2
            end
        end
    end

    if not a.touching_ground and a.think_touch_ground and not a:is_active'ground_timer' then
        a:start_timer('ground_timer', .075, function()
            a.think_touch_ground = false
        end)
    elseif a.touching_ground then
        a.think_touch_ground = true
    end

    a.touching_left_wall = false
    a.touching_right_wall = false
    a.touching_ground = false

    if not a.is_main then
        a.sind += 16
    end
end $$

|[panda_draw]| function(a)
    zspr(a.sind, a.x*8, a.y*8, 1, 1, a.xf, false)
end $$

|[panda_tile_hit]| function(a, dir)
    if dir == 3 then a.touching_ground = true end

    if dir == 0 then
        a.touching_left_wall = true
    end

    if dir == 1 then
        a.touching_right_wall = true
    end
end $$
