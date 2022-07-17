zclass[[ant,actor,tcol,mov,drawlayer_50|
    x,@,y,@,
    rx,.375, ry,.5,

    sind,7,
    xf,no,

    color,7,
    init,%ant_init,
    update,%ant_update,
    draw,%ant_draw,
    tile_hit,%ant_tile_hit
]]

|[ant_init]| function(a)
    a.color += 1
end $$

|[ant_update]| function(a)
    a.ay = .015

    if g_zbtn_0 ~= 0 then
        a.ax = (a.touching_ground and .065 or .065) * g_zbtn_0
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

    if btn(5) and not a:is_active'diceroll' then
        a:start_timer('diceroll', .5)
        create_dice(a.x, a.y, 0, a.xf and 1 or -1)
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

    if not a.touching_ground and a.touching_left_wall then
    end

    a.touching_ground = false
    a.touching_left_wall = false
    a.touching_right_wall = false
end $$

|[ant_draw]| function(a)
    zspr(a.sind, a.x*8, a.y*8, 1, 1, a.xf, false)
end $$

|[ant_tile_hit]| function(a, dir)
    if dir == 3 then a.touching_ground = true end

    if dir == 0 then
        a.touching_left_wall = true
    end

    if dir == 1 then
        a.touching_right_wall = true
    end
end $$
