-- a: vec,box -- b: box --
zclass[[room_bounds,box|x,@,y,@,rx,@,ry,@,tx_off,@,ty_off,@]]

function get_solid_tile(room, index)
    local t2 = room.tiles_2[index]
    if t2 then return fget(t2, 0) and t2 end
    t2 = room.tiles_1[index]
    return fget(t2, 0) and t2
end

zclass[[collidable,box,vec|
    calc_deltas,%calc_deltas,
    should_collide_with_screen_edge,yes,

    adjust_deltas_for_solids,%adjust_deltas_for_solids,
    adjust_deltas_for_tiles, %adjust_deltas_for_tiles,
    adjust_deltas_for_screen,%adjust_deltas_for_screen
]]

|[calc_deltas]| function(a, b)
    local box = {x=b.x-a.dx, y=b.y-a.dy, rx=b.rx, ry=b.ry}
    return a:getdelta(box, a.dx, a.dy)
end $$

|[adjust_deltas_for_solids]| function(a, list)
    foreach(list, function(b)
        local box = {x=b.x-a.dx, y=b.y-a.dy, rx=b.rx, ry=b.ry}
        a.dx, a.dy = a:getdelta(box, a.dx, a.dy)
    end)
end $$

|[adjust_deltas_for_tiles]| function(a)
    for tx=flr(g_room_bounds.x-g_room_bounds.rx),ceil(g_room_bounds.x+g_room_bounds.rx) do
        for ty=flr(g_room_bounds.y-g_room_bounds.ry),ceil(g_room_bounds.y+g_room_bounds.ry) do
            printh("tx: "..tx.." ty: "..ty)    
            if fget(mget(g_room_bounds.tx_off+tx, g_room_bounds.tx_off+ty), 0) then
                local rx, ry = .5, .5
                a.dx, a.dy = a:calc_deltas{x=tx+.5, y=ty+.5, rx=rx, ry=ry}
            end
        end
    end
end $$

function get_delta_axis2(dx, x, rx, tdx, tdrx)
    local xp = (x-tdx)/tdrx
    if abs(xp)+rx/tdrx > 1 then
        return tdx+sgn(xp)*(tdrx-rx)-(x-dx)
    else
        return dx
    end
end

|[adjust_deltas_for_screen]| function(a)
    if a.should_collide_with_screen_edge then
        local box = {
            x =g_room_bounds.x-a.dx,
            y =g_room_bounds.y-a.dy,
            rx=g_room_bounds.rx,
            ry=g_room_bounds.ry
        }

        a.dx = get_delta_axis2(a.dx, a.x, a.rx, box.x, box.rx)
        a.dy = get_delta_axis2(a.dy, a.y, a.ry, box.y, box.ry)
    end
end $$
