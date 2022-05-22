zclass[[col,vec,box|
    adjust_for_collision,%col_adjust_for_collision
]]

-- a: mov,box -- b: box --
|col_adjust_for_collision| function(a, b)
    local box = {x=b.x-a.dx, y=b.y, rx=b.rx, ry=b.ry}
    local dx, dy = a:getdelta(box, a.dx, a.dy)
    box.x, box.y = b.x-dx, b.y-dy
    return         a:getdelta(box, dx,   dy)
end $$

zclass[[tilecol,col|
    adjust_deltas_for_tiles,%adjust_deltas_for_tiles
]]

function is_solid_tile(room, x, y)
    if x >= 0 and x < ROOM_W then
        local t2 = room.tiles_2[y*ROOM_W+x]
        if t2 then return fget(t2, 0) end
        return fget(room.tiles_1[y*ROOM_W+x], 0)
    end
end

|adjust_deltas_for_tiles| function(a, room)
    for tx=flr(a.x-a.rx)-1,ceil(a.x+a.rx) do
        for ty=flr(a.y-a.ry)-1,ceil(a.y+a.ry) do
            if is_solid_tile(room, tx, ty) then
                a.dx, a.dy = a:adjust_for_collision{x=tx+.5, y=ty+.5, rx=.5, ry=.5}
            end
        end
    end
end $$
