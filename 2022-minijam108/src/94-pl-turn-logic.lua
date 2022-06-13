-- sword path, move path.
function get_move_coordinates(move_type)
    local pc = {x=g_pl.target_x,    y=g_pl.target_y}
    local sc = {x=g_sword.target_x, y=g_sword.target_y}
    local spots = {}
    if move_type == 128 then
        add_spot(spots, pc.x, pc.y, 142, 156, path_spin)

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

    elseif move_type == 160 then
        local coords = find_on_grid(function(spot)
            return spot.entity and spot.entity.parents.enemy
        end)

        for coord in all(coords) do
            add_spot(spots, coord.x, coord.y,   143, 158, path_swap)
        end

    elseif move_type == 164 then
    elseif move_type == 166 then
        add_spot_if_movable(spots, pc.x+2, pc.y,   143, 158, path_move)
        add_spot_if_movable(spots, pc.x-2, pc.y,   143, 158, path_move)
        add_spot_if_movable(spots, pc.x, pc.y+2,   143, 158, path_move)
        add_spot_if_movable(spots, pc.x, pc.y-2,   143, 158, path_move)

        add_spot_if_movable(spots, pc.x-2, pc.y-2, 143, 158, path_move)
        add_spot_if_movable(spots, pc.x-2, pc.y+2, 143, 158, path_move)
        add_spot_if_movable(spots, pc.x+2, pc.y+2, 143, 158, path_move)
        add_spot_if_movable(spots, pc.x+2, pc.y-2, 143, 158, path_move)
    end

    -- idle spot if there is nothing to do
    if #spots == 0 then
        add_spot(spots, pc.x, pc.y, 143, 158, function() return {{x=pc.x, y=pc.y, sx=sc.x, sy=sc.y}} end)
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

function is_spot_on_sword(x, y)
    return x == g_sword.target_x and y == g_sword.target_y
end

function is_spot_on_player(x, y)
    return x == g_pl.target_x and y == g_pl.target_y
end

function is_spot_puddle(x, y)
    local spot = g_grid[y*7+x]
    return is_spot_valid(x, y) and spot.puddle
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
    if not is_spot_puddle(x, y) and (is_spot_empty(x, y) or is_spot_movable(x, y)) then
        add_spot(list, x, y, ...)
    end
end

function add_spot_if_attackable(list, x, y, ...)
    if x == g_sword.target_x and y == g_sword.target_y then
        return
    end

    if is_spot_empty(x, y) or is_spot_attackable(x, y) then
        add_spot(list, x, y, ...)
    end
end

-- GEN PATHS --
function path_move(x, y)
    local plx, ply = g_pl.target_x,    g_pl.target_y
    local swx, swy = g_sword.target_x, g_sword.target_y
    local xdiff, ydiff = swx-plx, swy-ply
    local path = {{x=plx, y=ply, sx=swx, sy=swy}}

    add(path, {x=x, y=y, sx=x+xdiff, sy=y+ydiff})

    return path
end

function path_swap(x, y)
    local plx, ply = g_pl.target_x,    g_pl.target_y
    local swx, swy = g_sword.target_x, g_sword.target_y
    local xdiff, ydiff = swx-plx, swy-ply
    local path = {{x=plx, y=ply, sx=swx, sy=swy}}

    add(path, {x=x, y=y, sx=x+xdiff, sy=y+ydiff, func=function()
        printh("TEST")
        local entity = g_grid[y*7+x].entity
        printh(entity.id)
        printh(g_pl.target_x)
        entity.target_x = g_pl.target_x
        entity.target_y = g_pl.target_y
    end})

    return path
end

function path_spin(x, y)
    local path = {}

    local plx, ply = g_pl.target_x,    g_pl.target_y
    local swx, swy = g_sword.target_x, g_sword.target_y
    local xdiff, ydiff = swx-plx, swy-ply
    local initial_ang = atan2(xdiff,ydiff)

    for i=0,8 do
        local spin_x = zsgn(cos(initial_ang-i/8))
        local spin_y = zsgn(sin(initial_ang-i/8))
        printh("x: "..spin_x.." | y: "..spin_y)
        add(path, {x=plx, y=ply, sx=plx+spin_x, sy=ply+spin_y})
    end

    return path
end

function path_slice(x, y)
    local plx, ply = g_pl.target_x,    g_pl.target_y
    local swx, swy = g_sword.target_x, g_sword.target_y

    return {
        {x=plx, y=ply, sx=swx, sy=swy},
        {x=plx, y=ply, sx=x, sy=y}
    }
end

-- how do enemy paths work?

-- hermit turn moves spaces until all path spaces are used.
-- enemy turns go one at a time. Starting from top left.
-- a function will return the path for the enemy.

-- everything is constantly moving to where it is on the grid.
