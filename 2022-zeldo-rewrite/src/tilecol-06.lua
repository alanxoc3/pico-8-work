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

    f_adjust_deltas_for_solids,%f_adjust_deltas_for_solids,
    f_adjust_deltas_for_tiles, %f_adjust_deltas_for_tiles,
    f_adjust_deltas_for_screen,%f_adjust_deltas_for_screen
]]

|[f_set_x_delta]| function(a, b) a.dx, _ = a:getdelta(b, a.dx, 0) end $$
|[f_set_y_delta]| function(a, b) _, a.dy = a:getdelta(b, 0, a.dy) end $$

|[f_adjust_deltas_for_solids]| function(a, setdelta, list)
    foreach(list, function(b)
        if a ~= b then
            setdelta(a, b)
        end
    end)
end $$

|[f_adjust_deltas_for_tiles]| function(a, setdelta, room)
    for tx=max(flr(a.x-a.rx)-1,0),min(ceil(a.x+a.rx),ROOM_W-1) do
        for ty=flr(a.y-a.ry)-1,ceil(a.y+a.ry) do
            local sind = get_solid_tile(room, ty*ROOM_W+tx)
            if sind then
                local rx, ry = .5, .5

                if not fget(sind,1) or fget(sind,1) and a.should_collide_below then
                    if fget(sind,2) then rx, ry = .375, .375 end
                    if fget(sind,3) then rx, ry = .375, .625 end
                    setdelta(a, {x=tx+.5, y=ty+.5, rx=rx, ry=ry})
                end
            end
        end
    end
end $$

|[f_set_x_delta2]| function(a, b)
    b = {x=b.x-a.dx, y=b.y, rx=b.rx, ry=b.ry}

    local p = (a.x-b.x)/b.rx
    if abs(p)+a.rx/b.rx > 1 then
        a.dx = b.x+sgn(p)*(b.rx-a.rx)-(a.x-a.dx)
    end
end $$

|[f_set_y_delta2]| function(a, b)
    b = {x=b.x, y=b.y-a.dy, rx=b.rx, ry=b.ry}

    local p = (a.y-b.y)/b.ry
    if abs(p)+a.ry/b.ry > 1 then
        a.dy = b.y+sgn(p)*(b.ry-a.ry)-(a.y-a.dy)
    end
end $$

|[f_adjust_deltas_for_screen]| function(a, setdelta2)
    if a.should_collide_with_screen_edge then
        setdelta2(a, g_room_bounds)
    end
end $$
