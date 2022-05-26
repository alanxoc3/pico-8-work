-- a: vec,box -- b: box --
function get_solid_tile(room, index)
    local t2 = room.tiles_2[index]
    if t2 then return fget(t2, 0) and t2 end
    t2 = room.tiles_1[index]
    return fget(t2, 0) and t2
end

zclass[[collidable,box,vec|
    calc_deltas,%calc_deltas,
    adjust_deltas_for_solids,%adjust_deltas_for_solids,
    adjust_deltas_for_tiles,%adjust_deltas_for_tiles
]]

|[calc_deltas]| function(a, b)
    local box = {x=b.x-a.dx, y=b.y-a.dy, rx=b.rx, ry=b.ry}
    return a:getdelta(box, a.dx, a.dy)
end $$

|[adjust_deltas_for_solids]| function(a, list)
    local junk
    foreach(list, function(b)
        -- a.dx, junk = a:calc_deltas(obj)
        local box = {x=b.x-a.dx, y=b.y-a.dy, rx=b.rx, ry=b.ry}
        a.dx, a.dy = a:getdelta(box, a.dx, a.dy)
    end)
end $$

|[adjust_deltas_for_tiles]| function(a, room)
    for tx=max(flr(a.x-a.rx)-1,0),min(ceil(a.x+a.rx),ROOM_W-1) do
        for ty=flr(a.y-a.ry)-1,ceil(a.y+a.ry) do
            local sind = get_solid_tile(room, ty*ROOM_W+tx)
            if sind then
                local rx, ry = .5, .5
                if fget(sind,2) then rx, ry = .375, .375 end

                a.dx, a.dy = a:calc_deltas{x=tx+.5, y=ty+.5, rx=rx, ry=ry}
            end
        end
    end
end $$
