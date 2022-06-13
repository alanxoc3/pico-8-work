-- sword path, move path.
function get_move_coordinates(move_type)
    local pc = {x=g_pl.target_x,    y=g_pl.target_y}
    local sc = {x=g_sword.target_x, y=g_sword.target_y}
    local spots = {}
    if move_type == 128 then
        add_spot(spots, sc.x, sc.y, 142, 156, path_spin)

    elseif move_type == 130 then
        add_spot_if_attackable(spots, pc.x+1, pc.y,   142, 156, path_slice)
        add_spot_if_attackable(spots, pc.x-1, pc.y,   142, 156, path_slice)
        add_spot_if_attackable(spots, pc.x, pc.y+1,   142, 156, path_slice)
        add_spot_if_attackable(spots, pc.x, pc.y-1,   142, 156, path_slice)

        add_spot_if_attackable(spots, pc.x-1, pc.y-1, 142, 156, path_slice)
        add_spot_if_attackable(spots, pc.x-1, pc.y+1, 142, 156, path_slice)
        add_spot_if_attackable(spots, pc.x+1, pc.y+1, 142, 156, path_slice)
        add_spot_if_attackable(spots, pc.x+1, pc.y-1, 142, 156, path_slice)

    elseif move_type == 134 then
        add_spot_if_movable(spots, pc.x+1, pc.y,   143, 158, path_move)
        add_spot_if_movable(spots, pc.x-1, pc.y,   143, 158, path_move)
        add_spot_if_movable(spots, pc.x, pc.y+1,   143, 158, path_move)
        add_spot_if_movable(spots, pc.x, pc.y-1,   143, 158, path_move)

        add_spot_if_movable(spots, pc.x-1, pc.y-1, 143, 158, path_move)
        add_spot_if_movable(spots, pc.x-1, pc.y+1, 143, 158, path_move)
        add_spot_if_movable(spots, pc.x+1, pc.y+1, 143, 158, path_move)
        add_spot_if_movable(spots, pc.x+1, pc.y-1, 143, 158, path_move)
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

function add_spot(list, x, y, sind, sel_sind, gen_path)
    add(list, {x=x, y=y, sind=sind, sel_sind=sel_sind, gen_path=gen_path})
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

-- GEN PATHS --
function path_move(x, y)
    local path = {}

    add(path, {x=x, y=y, sx=x+1, sy=y})

    return path
end

-- how do enemy paths work?

-- hermit turn moves spaces until all path spaces are used.
-- enemy turns go one at a time. Starting from top left.
-- a function will return the path for the enemy.

-- everything is constantly moving to where it is on the grid.
