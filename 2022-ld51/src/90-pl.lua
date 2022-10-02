zclass[[pbox,actor,collidable,mov,drawlayer_25|
    x,@, y,@,
    rx,.375, ry,.375,
    sind,13,
    update,%pbox_update,
    draw,%panda_draw,
    normal,yes
]]

|[pbox_update]| function(a)
    a.ay = .015
end $$

zclass[[follow_panda,mov|
    anchor,@, x,0, y,0, update,%follow_panda_update
]]

|[follow_panda_update]| function(a)
    a.x = a.anchor.x

    if a.anchor.touching_ground and not a.anchor.active_ledge then
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

    if a.anchor.touching_ground or a.anchor.active_ledge then
        local dist = (a.anchor.y+a.yoff) - a.y
        a.y += dist/4
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

zclass[[pbox_hold,anchor,drawlayer_75|
    anchoring,@,
    sind,13,
    offy,-.75,
    draw,%panda_draw
]]

zclass[[panda,actor,collidable,mov,drawlayer_50|
    x,@,y,@,
    rx,.25, ry,.25,

    sind,1,
    xf,no,

    color,7,
    init,%panda_init,
    col_pbox,%panda_col_pbox,
    update,%panda_update,
    draw,%panda_draw,
    controls,%panda_controls,
    tile_hit,%panda_tile_hit
]]

|[panda_col_pbox]| function(a, pboxes)
    foreach(pboxes, function(pbox)
        if a:touching(pbox) and btnp(2) then
            pbox:kill()
            _g.pbox_hold(a)
        end
    end)
end $$

|[panda_init]| function(a)
    a.color += 1
end $$

|[panda_controls]| function(a)
    a.ix = .8
    if g_zbtn_0 ~= 0 then
        a.ax += (a.touching_ground and .065/3 or .065/3) * g_zbtn_0
        a.xf = a.ax < 0
    end
end $$

JMPSP = .125

|[panda_update]| function(a)
    a.ax = 0
    a.ay = .015 -- gravity
    a.ix = .95
    a.iy = 1

    if btnp(4) and a.think_touch_ground then
        a:start_timer('jump', .1)
        if btn(3) then
            a.jumpdx, a.jumpdy = false, JMPSP
        else
            a.jumpdx, a.jumpdy = false, -JMPSP
        end
    elseif (btn(4) and a.active_ledge == 'left')  or (btnp(4) and a.touching_left_wall) then
        a:end_timer'jump'

        if a.think_touch_ground then
            a.active_ledge = nil
        elseif a.touching_left_wall then
            a.active_ledge = 'left'
            a.ay = 0 a.dx = -JMPSP a.iy = .8
            if g_zbtn_2 ~= 0 then a.ay = .065/4 * g_zbtn_2 else a.dy = 0 end
        else
            a.active_ledge = nil
            a:start_timer('jump', .1)
            a.jumpdx, a.jumpdy = 0, -JMPSP/2
        end
    elseif (btn(4) and a.active_ledge == 'right') or (btnp(4) and a.touching_right_wall) then
        a:end_timer'jump'

        if a.think_touch_ground then
            a.active_ledge = nil
        elseif a.touching_right_wall then
            a.active_ledge = 'right'
            a.ay = 0 a.dx = JMPSP a.iy = .8
            if g_zbtn_2 ~= 0 then a.ay = .065/4 * g_zbtn_2 else a.dy = 0 end
        else
            a.active_ledge = nil
            a:start_timer('jump', .1)
            a.jumpdx, a.jumpdy = 0, -JMPSP/2
        end
    elseif not btn(4) and a.active_ledge == 'left' then
        a:start_timer('jump', .1)
        a:start_timer('jump_recoil', .1)

        if btn'3' then
            a.jumpdx, a.jumpdy = JMPSP, JMPSP
        else
            a.jumpdx, a.jumpdy = JMPSP, -JMPSP
        end

        a.active_ledge = nil
    elseif not btn(4) and a.active_ledge == 'right' then
        a:start_timer('jump', .1)
        a:start_timer('jump_recoil', .1)

        if btn'3' then
            a.jumpdx, a.jumpdy = -JMPSP, JMPSP/2
        else
            a.jumpdx, a.jumpdy = -JMPSP, -JMPSP/2
        end

        a.active_ledge = nil
    end

    if a:is_active'jump' then
        a.dx = a.jumpdx or a.dx
        a.dy = a.jumpdy or a.dy
        printh(a.dy)
    end

    if not a:is_active'jump_recoil' and not a.active_ledge then
        a:controls()
    else
        if a.dx > 0 then a.xf = false end
        if a.dx < 0 then a.xf = true end
    end

    if a.active_ledge then
        a.sind = 37
    elseif not a.think_touch_ground then
        if a:is_active'jump' then
            a.sind = 21
        elseif a.dy > 0 then
            a.sind = 20
        else
            a.sind = 21
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
