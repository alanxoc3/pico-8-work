-- sword path, move path.
function get_move_coordinates(move_type)
    local pc = find_pl_on_grid()
    local sc = find_sword_on_grid()
    local spots = {}
    if move_type == 128 then
        add_spot(spots, sc.x, sc.y, 142, 156)
    elseif move_type == 130 then
        add_spot_if_attackable(spots, pc.x+1, pc.y,   142, 156)
        add_spot_if_attackable(spots, pc.x-1, pc.y,   142, 156)
        add_spot_if_attackable(spots, pc.x, pc.y+1,   142, 156)
        add_spot_if_attackable(spots, pc.x, pc.y-1,   142, 156)

        add_spot_if_attackable(spots, pc.x-1, pc.y-1, 142, 156)
        add_spot_if_attackable(spots, pc.x-1, pc.y+1, 142, 156)
        add_spot_if_attackable(spots, pc.x+1, pc.y+1, 142, 156)
        add_spot_if_attackable(spots, pc.x+1, pc.y-1, 142, 156)
    elseif move_type == 134 then
        add_spot_if_movable(spots, pc.x+1, pc.y,   143, 158)
        add_spot_if_movable(spots, pc.x-1, pc.y,   143, 158)
        add_spot_if_movable(spots, pc.x, pc.y+1,   143, 158)
        add_spot_if_movable(spots, pc.x, pc.y-1,   143, 158)

        add_spot_if_movable(spots, pc.x-1, pc.y-1, 143, 158)
        add_spot_if_movable(spots, pc.x-1, pc.y+1, 143, 158)
        add_spot_if_movable(spots, pc.x+1, pc.y+1, 143, 158)
        add_spot_if_movable(spots, pc.x+1, pc.y-1, 143, 158)
    end

    return spots
end

function find_on_grid(predicate)
    local l = {}
    for y=0,6 do
        for x=0,6 do
            if predicate(g_grid[y*7+x]) then
                add(l, {x=x, y=y})
            end
        end
    end
    return l
end

function find_sword_on_grid()
    return find_on_grid(function(spot)
        return spot.entity == g_sword
    end)[1]
end

function find_pl_on_grid()
    return find_on_grid(function(spot)
        return spot.entity == g_pl
    end)[1]
end

function is_spot_valid(x, y)
    local spot = g_grid[y*7+x]
    return x >= 0 and x <= 6 and y >= 0 and y <= 6 and spot.active
end

function is_spot_empty(x, y)
    local spot = g_grid[y*7+x]
    return is_spot_valid(x, y) and spot.entity == nil
end

function is_spot_movable(x, y)
    local spot = g_grid[y*7+x]
    return is_spot_valid(x, y) and spot.entity and spot.entity.id == 'sword'
end

function is_spot_attackable(x, y)
    local spot = g_grid[y*7+x]
    return is_spot_valid(x, y) and spot.entity and spot.entity.parents.enemy
end

function add_spot(list, x, y, sind, sel_sind)
    add(list, {x=x, y=y, sind=sind, sel_sind=sel_sind})
end

function add_spot_if_movable(list, x, y, ...)
    if is_spot_empty(x, y) or is_spot_movable(x, y) then
        add_spot(list, x, y, ...)
    end
end

function add_spot_if_attackable(list, x, y, ...)
    if is_spot_empty(x, y) or is_spot_attackable(x, y) then
        add_spot(list, x, y, ...)
    end
end
