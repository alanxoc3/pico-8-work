zclass[[ant,actor,collidable,mov,drawlayer_50|
    x,@,y,@,
    rx,.375, ry,.375,
    color,7,
    init,%ant_init,
    update,%ant_update,
    draw,%ant_draw
]]

|[ant_init]| function(a)
    a.color += 1
end $$

|[ant_update]| function(a)
    a.speed = 0
    if g_zbtn_0 | g_zbtn_2 ~= 0 then
        a.ang, a.speed = atan2(g_zbtn_0, g_zbtn_2), .25
    end
    a.dy += .125
end $$

|[ant_draw]| function(a)
    circfill(a.x, a.y, 2, a.color)
end $$
