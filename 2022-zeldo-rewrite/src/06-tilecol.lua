-- a: vec,box -- b: box --
function is_solid_tile(room, x, y)
    if x >= 0 and x < ROOM_W then
        local t2 = room.tiles_2[y*ROOM_W+x]
        if t2 then return fget(t2, 0) end
        return fget(room.tiles_1[y*ROOM_W+x], 0)
    end
end

zclass[[collidable,box,vec|
    calc_deltas,%calc_deltas,
    adjust_deltas_for_solids,%adjust_deltas_for_solids,
    adjust_deltas_for_tiles,%adjust_deltas_for_tiles
]]

|calc_deltas| function(a, b)
    local box = {x=b.x-a.dx, y=b.y-a.dy, rx=b.rx, ry=b.ry}
    return a:getdelta(box, a.dx, a.dy)

    -- box.x, box.y = b.x-a.dx, b.y-a.dy
    -- return a:getdelta(box, dx, dy)
end $$

|adjust_deltas_for_solids| function(a, list)
    local junk
    foreach(list, function(b)
        -- a.dx, junk = a:calc_deltas(obj)
        local box = {x=b.x-a.dx, y=b.y-a.dy, rx=b.rx, ry=b.ry}
        a.dx, a.dy = a:getdelta(box, a.dx, a.dy)
    end)
end $$

|adjust_deltas_for_tiles| function(a, room)
    for tx=flr(a.x-a.rx)-1,ceil(a.x+a.rx) do
        for ty=flr(a.y-a.ry)-1,ceil(a.y+a.ry) do
            if is_solid_tile(room, tx, ty) then
                a.dx, a.dy = a:calc_deltas{x=tx+.5, y=ty+.5, rx=.5, ry=.5}
            end
        end
    end
end $$
