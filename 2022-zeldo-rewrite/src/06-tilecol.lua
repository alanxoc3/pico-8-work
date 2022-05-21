zclass[[tilecol,vec,box|
    adjust_deltas_for_tiles,%adjust_deltas_for_tiles
]]

-- {
--   w:12, h:10,
--   tiles_1: {[y*ROOM_W+x]:0},
--   tiles_2: {[y*ROOM_W+x]:0},
--   objects: {{x:0, y:0, index:0}...},
--   color:0, music:0,
-- }

function is_solid_tile(room, x, y)
    if x < ROOM_W then
        local t2 = room.tiles_2[y*ROOM_W+x]
        if t2 then return fget(t2, 0) end
        return fget(room.tiles_1[y*ROOM_W+x], 0)
    end
end

-- a: mov,box
-- b: box
function adjust_for_collision(a, b)
    local dx, dy = a.dx, a.dy
    local tdxrect = {x=b.x-dx, y=b.y, rx=b.rx, ry=b.ry}
    local abx, aby = a:abside(tdxrect)
    if abx ~= 0 and not a:outside(tdxrect) then
        local xp, yp, xr, yr = a:side(tdxrect)
        local xthing = abs(xp)-xr
        local xgoal = tdxrect.x+sgn(xp)*(a.rx+tdxrect.rx)
        if xthing < 1 then dx = xgoal-(a.x-dx) end
    elseif aby ~= 0 and not a:outside(tdxrect) then
        local xp, yp, xr, yr = a:side(tdxrect)
        local ything = abs(yp)-yr
        local ygoal = tdxrect.y+sgn(yp)*(a.ry+tdxrect.ry)
        if ything < 1 then dy = ygoal-(a.y-dy) end
    end

    local tdyrect = {x=b.x-dx, y=b.y-dy, rx=b.rx, ry=b.ry}
    abx, aby = a:abside(tdyrect)
    if aby ~= 0 and not a:outside(tdyrect) then
        local xp, yp, xr, yr = a:side(tdyrect)
        local ything = abs(yp)-yr
        local ygoal = tdyrect.y+sgn(yp)*(a.ry+tdyrect.ry)
        if ything < 1 then dy = ygoal-(a.y-dy) end
    end

    return dx, dy
end

|adjust_deltas_for_tiles| function(a, room)
    local tx1, ty1, tx2, ty2 = flr(a.x-a.rx)-1, flr(a.y-a.ry)-1, ceil(a.x+a.rx), ceil(a.y+a.ry)
    local nextx, nexty = a.x+a.dx, a.y+a.dy

    for tx=tx1,tx2 do
        for ty=ty1,ty2 do
            local trect = {x=tx+.5, y=ty+.5, rx=.5, ry=.5}
            if is_solid_tile(room, tx, ty) then
                a.dx, a.dy = adjust_for_collision(a, {x=tx+.5, y=ty+.5, rx=.5, ry=.5})
            end
        end
    end
end $$
