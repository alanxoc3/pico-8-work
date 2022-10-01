-- a: vec,box -- b: box --
function get_solid_tile(room, index)
    local t2 = room.tiles_2[index]
    if t2 then return fget(t2, 0) and t2 end
    t2 = room.tiles_1[index]
    return fget(t2, 0) and t2
end

zclass[[collidable,box,vec|
    calc_deltas,%calc_deltas,
    should_collide_below,yes,
    should_collide_with_screen_edge,yes,

    adjust_deltas_for_solids,%adjust_deltas_for_solids,
    adjust_deltas_for_tiles, %adjust_deltas_for_tiles,
    adjust_deltas_for_screen,%adjust_deltas_for_screen
]]

|[adjust_deltas_for_solids]| function(a, setdelta, list)
    foreach(list, function(b)
        if a ~= b then
            setdelta(a, b)
        end
    end)
end $$

|[adjust_deltas_for_tiles]| function(a, checkfunc)
    for tx=flr(a.x-a.rx)-1,ceil(a.x+a.rx) do
        for ty=flr(a.y-a.ry)-1,ceil(a.y+a.ry) do
            checkfunc(a, tx+.5, ty+.5, mget(g_bounds.tx_off+tx, g_bounds.ty_off+ty))
        end
    end
end $$

|[set_x_delta2]| function(a, b)
    b = {x=b.x-a.dx, y=b.y, rx=b.rx, ry=b.ry}

    local p = (a.x-b.x)/b.rx
    if abs(p)+a.rx/b.rx > 1 then
        a.dx = b.x+sgn(p)*(b.rx-a.rx)-(a.x-a.dx)
    end
end $$

|[set_y_delta2]| function(a, b)
    b = {x=b.x, y=b.y-a.dy, rx=b.rx, ry=b.ry}

    local p = (a.y-b.y)/b.ry
    if abs(p)+a.ry/b.ry > 1 then
        a.dy = b.y+sgn(p)*(b.ry-a.ry)-(a.y-a.dy)
    end
end $$

|[adjust_deltas_for_screen]| function(a, setdelta2)
    if a.should_collide_with_screen_edge then
        setdelta2(a, g_room_bounds)
    end
end $$
