function detect_collisions(obj)
    foreach(walls, function(wall)
        local coords = collide_obj(obj, wall)
        if coords then fix_pos(obj, coords) end
    end)
end

function fix_pos(obj, coords)
    if coords[1] < coords[2] then
        if coords[3] < coords[4] then
            if coords[1] < coords[3] then
                obj.x -= coords[1] -- Eject L
                obj.dx = 0
            else
                obj.y -= coords[3] -- Eject T
                obj.dy = 0
            end
        else
            if coords[1] < coords[4] then
                obj.x -= coords[1] -- Eject L
                obj.dx = 0
            else
                obj.y += coords[4] -- Eject B
                obj.dy = 0
            end
        end
    else
        if coords[3] < coords[4] then
            if coords[2] < coords[3] then
                obj.x += coords[2] -- Eject R
                obj.dx = 0
            else
                obj.x -= coords[3] -- Eject T
                obj.dy = 0
            end
        else
            if coords[2] < coords[4] then
                obj.x += coords[2] -- Eject R
                obj.dx = 0
            else
                obj.y += coords[4] -- Eject B
                obj.dy = 0
            end
        end
    end
end

function collide_obj(a, b)
    -- On intersect, returns the distance required on either side to remove the overlap. Else returns false.
    -- {dx=?, dy=?} (from a's perspective)
    -- { eject a on the left   / b on the right
    -- , eject a on the right  / b on the left
    -- , eject a on the top    / b on the top 
    -- , eject a on the bottom / b on the bottom
    -- }
    -- This can be used to adjust the positions to not overlap.
    local lr = collide_coords(a.x, a.rx, b.x, b.rx)
    if lr then
        local tb = collide_coords(a.y, a.ry, b.y, b.ry)
        if tb then
            return { lr[1], lr[2], tb[1], tb[2] }
        end
    end
    return nil
end

function collide_coords(a_x, a_rx, b_x, b_rx)
    return intersect(
        a_x-a_rx,
        a_x+a_rx,
        b_x-b_rx,
        b_x+b_rx)
end

function intersect(a_a, a_b, b_a, b_b)
    -- On intersect, returns the distance required on either side to remove the overlap. Else returns false.
    -- { eject a on the left / b on the right
    -- , eject a on the right / b on the left
    -- }
    -- a: (), b: []
    --printh(between(b_a, a_b, b_b) and "true" or "false")

    if between(b_a, a_b, b_b) -- (---[---)---] or [---(------)---]
    or between(b_a, a_a, b_b) -- [---(---]---) or [---(------)---]
    or between(a_a, b_b, a_b) -- [---(---]---) or (---[------]---)
    or between(a_a, b_a, a_b) -- (---[---)---] or (---[------]---)
    then
        return { a_b-b_a, b_b-a_a }
    end
    return nil
end

function between(lo, x, hi)
    return lo < x and x < hi
end

function table_to_str(any)
    local str = "{ "
    for k,v in pairs(any) do
        str=str..tostring(k).."->"..tostring(v).." "
    end
    return str.."}"
end
