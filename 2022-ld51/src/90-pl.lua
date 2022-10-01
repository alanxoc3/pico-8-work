zclass[[pbox,actor,tcol,mov,drawlayer_25|
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

zclass[[follow_panda,actor,mov|
    anchor,@, x,0, y,0, init,%follow_panda_init, update,%follow_panda_update
]]

|[follow_panda_init]| function(a)
    a.x = a.anchor.x
    a.y = a.anchor.y
end $$

|[follow_panda_update]| function(a)
    local dist = a:dist_point(a.anchor.x, a.anchor.y)

    if dist > .125 then
        local ang = atan2(a.anchor.x-a.x, a.anchor.y-a.y)
        a.x += cos(ang)*dist/4
        a.y += sin(ang)*dist/4
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

zclass[[panda,actor,tcol,mov,drawlayer_50|
    x,@,y,@,
    rx,.375, ry,.5,

    sind,7,
    xf,no,

    color,7,
    init,%panda_init,
    col_pbox,%panda_col_pbox,
    update,%panda_update,
    draw,%panda_draw,
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

|[panda_update]| function(a)
    a.ay = .015

    if g_zbtn_0 ~= 0 then
        a.ax = (a.touching_ground and .065/2 or .065/2) * g_zbtn_0
        a.xf = a.ax < 0
    end

    if a:is_active'jump'       then a.dy = -.2
    elseif a:is_active'ldjump' then a.ax =  .125 a.dy =  .25/2
    elseif a:is_active'lujump' then a.ax =  .125 a.dy = -.25
    elseif a:is_active'rdjump' then a.ax = -.125 a.dy =  .25/2
    elseif a:is_active'rujump' then a.ax = -.125 a.dy = -.25
    else
        if btn(4) then
            if a.touching_ground         then a:start_timer('jump', .125)
            elseif a.touching_left_wall  then a:start_timer(btn'3' and 'ldjump' or 'lujump', .125/2)
            elseif a.touching_right_wall then a:start_timer(btn'3' and 'rdjump' or 'rujump', .125/2)
            end
        end
    end

    if not a.touching_ground and (a.touching_left_wall or a.touching_right_wall) then
        a.sind = 23
    elseif not a.touching_ground then
        if a:is_active'jump' then
            a.sind = 9
        elseif a.dy > 0 then
            a.sind = 11
        else
            a.sind = 10
        end
    else
        if a.dx ~= 0 then
            if t()%.25 < .125 then
                a.sind = 7
            else
                a.sind = 8
            end
        else
            if t()%1 < .5 then
                a.sind = 7
            else
                a.sind = 8
            end
        end
    end

    a.touching_ground = false
    a.touching_left_wall = false
    a.touching_right_wall = false
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
