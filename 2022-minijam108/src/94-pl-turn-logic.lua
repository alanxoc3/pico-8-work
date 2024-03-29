-- sword path, move path.
function get_move_coordinates(move_type)
    local pc = {x=g_pl.target_x,    y=g_pl.target_y}
    local sc = {x=g_sword.target_x, y=g_sword.target_y}
    local spots = {}
    if move_type == 128 then
        add_spot(spots, pc.x, pc.y, 'attack', path_spin)

    elseif move_type == 130 then
        add_spot_if_attackable(spots, pc.x+1, pc.y,   'attack', path_slice)
        add_spot_if_attackable(spots, pc.x-1, pc.y,   'attack', path_slice)
        add_spot_if_attackable(spots, pc.x, pc.y+1,   'attack', path_slice)
        add_spot_if_attackable(spots, pc.x, pc.y-1,   'attack', path_slice)

        add_spot_if_attackable(spots, pc.x-1, pc.y-1, 'attack', path_slice)
        add_spot_if_attackable(spots, pc.x-1, pc.y+1, 'attack', path_slice)
        add_spot_if_attackable(spots, pc.x+1, pc.y+1, 'attack', path_slice)
        add_spot_if_attackable(spots, pc.x+1, pc.y-1, 'attack', path_slice)

    elseif move_type == 132 then
        if not is_spot_puddle(sc.x, sc.y) and (is_spot_empty(sc.x, sc.y) or is_spot_movable(sc.x, sc.y)) then
            local xdiff, ydiff = sc.x-pc.x, sc.y-pc.y
            add_spot(spots, sc.x+xdiff, sc.y+ydiff, 'attack', path_thrust)
        end

    elseif move_type == 134 then
        add_spot_if_movable(spots, pc.x+1, pc.y,   'move', path_move)
        add_spot_if_movable(spots, pc.x-1, pc.y,   'move', path_move)
        add_spot_if_movable(spots, pc.x, pc.y+1,   'move', path_move)
        add_spot_if_movable(spots, pc.x, pc.y-1,   'move', path_move)

        add_spot_if_movable(spots, pc.x-1, pc.y-1, 'move', path_move)
        add_spot_if_movable(spots, pc.x-1, pc.y+1, 'move', path_move)
        add_spot_if_movable(spots, pc.x+1, pc.y+1, 'move', path_move)
        add_spot_if_movable(spots, pc.x+1, pc.y-1, 'move', path_move)

    elseif move_type == 136 then
        for ang=0,8 do
            local xdir, ydir = zsgn(cos(ang/8)), zsgn(sin(ang/8))
            local sxdir, sydir = sc.x - pc.x, sc.y - pc.y
            local cur_x, cur_y = pc.x, pc.y
            local is_good = false

            while true do
                cur_x += xdir
                cur_y += ydir

                if not is_spot_valid(cur_x, cur_y) or is_spot_puddle(cur_x, cur_y) then
                    break
                elseif not is_spot_empty(cur_x, cur_y) and not (sxdir == xdir and sydir == ydir) then
                    is_good = false
                    break
                end

                is_good = true
            end

            if is_good then
                add_spot(spots, cur_x-xdir, cur_y-ydir, 'move', path_charge)
            end
        end

    elseif move_type == 160 then
        local coords = find_on_grid(function(spot)
            return spot.entity and spot.entity.parents.enemy
        end)

        for coord in all(coords) do
            if not is_spot_puddle(coord.x, coord.y) then
                add_spot(spots, coord.x, coord.y,   'special', path_swap)
            end
        end

    elseif move_type == 162 then
        local pp = g_level_state.prev_path
        if pp then
            local good = true
            local reverse_prev_path = {}
            for i=#pp,1,-1 do
                local x, y, sx, sy, duration, isswap = pp[i].x, pp[i].y, pp[i].sx, pp[i].sy, pp[i].duration, pp[i].isswap
                local func = nil
                if isswap and i == 1 then
                    func = function()
                        local entity = g_grid[y*7+x].entity
                        if entity then
                            entity.target_x = g_pl.target_x
                            entity.target_y = g_pl.target_y
                        end
                    end
                end
                add(reverse_prev_path, {isswap=isswap, x=x, y=y, sx=sx, sy=sy, duration=duration, func=func})
                if not isswap and (not is_spot_empty(x, y) or is_spot_puddle(x, y)) then
                    good = false
                    break
                end
            end

            if good and #reverse_prev_path > 0 then
                add_spot(spots, reverse_prev_path[#reverse_prev_path].x, reverse_prev_path[#reverse_prev_path].y, 'special', function()
                    local copy_reverse_prev_path = {}
                    for spot in all(reverse_prev_path) do
                        add(copy_reverse_prev_path, spot)
                    end
                    return copy_reverse_prev_path
                end)
            end
        end

    elseif move_type == 164 then
        add_spot(spots, pc.x, pc.y, 'special', function() return {{x=pc.x, y=pc.y, sx=sc.x, sy=sc.y}} end)

    elseif move_type == 166 then
        add_spot_if_movable(spots, pc.x+2, pc.y,   'move', path_move)
        add_spot_if_movable(spots, pc.x-2, pc.y,   'move', path_move)
        add_spot_if_movable(spots, pc.x, pc.y+2,   'move', path_move)
        add_spot_if_movable(spots, pc.x, pc.y-2,   'move', path_move)

        add_spot_if_movable(spots, pc.x-2, pc.y-2, 'move', path_move)
        add_spot_if_movable(spots, pc.x-2, pc.y+2, 'move', path_move)
        add_spot_if_movable(spots, pc.x+2, pc.y+2, 'move', path_move)
        add_spot_if_movable(spots, pc.x+2, pc.y-2, 'move', path_move)
    end

    -- idle spot if there is nothing to do
    if #spots == 0 then
        add_spot(spots, pc.x, pc.y, 'disable', function() return {{x=pc.x, y=pc.y, sx=sc.x, sy=sc.y}} end)
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

function add_spot(list, x, y, seltype, gen_path)
    add(list, {x=x, y=y, seltype=seltype, gen_path=gen_path})
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

function path_charge(x, y)
    local plx, ply = g_pl.target_x,    g_pl.target_y
    local swx, swy = g_sword.target_x, g_sword.target_y
    local xdiff, ydiff = swx-plx, swy-ply
    local path = {{x=plx, y=ply, sx=swx, sy=swy}}
    local xdir, ydir = zsgn(x-plx), zsgn(y-ply)

    local cur_x, cur_y = plx, ply
    while true do
        cur_x += xdir
        cur_y += ydir
        add(path, {x=cur_x, y=cur_y, sx=cur_x+xdiff, sy=cur_y+ydiff})
        if cur_x == x and cur_y == y then
            break
        end
    end

    return path
end

function path_swap(x, y)
    local plx, ply = g_pl.target_x,    g_pl.target_y
    local swx, swy = g_sword.target_x, g_sword.target_y
    local xdiff, ydiff = swx-plx, swy-ply
    local path = {{isswap=true, x=plx, y=ply, sx=swx, sy=swy}}

    add(path, {isswap=true, x=x, y=y, sx=x+xdiff, sy=y+ydiff, func=function()
        local entity = g_grid[y*7+x].entity
        if entity then
            entity.target_x = g_pl.target_x
            entity.target_y = g_pl.target_y
        end
    end})

    return path
end

function path_spin(x, y)
    local plx, ply = g_pl.target_x,    g_pl.target_y
    local swx, swy = g_sword.target_x, g_sword.target_y
    local xdiff, ydiff = swx-plx, swy-ply
    local initial_ang = atan2(xdiff,ydiff)
    local path = {{x=plx, y=ply, sx=swx, sy=swy}}

    for i=1,8 do
        local spin_x = zsgn(cos(initial_ang-i/8))
        local spin_y = zsgn(sin(initial_ang-i/8))
        add(path, {x=plx, y=ply, sx=plx+spin_x, sy=ply+spin_y, duration=.125})
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

function path_thrust(x, y)
    local plx, ply = g_pl.target_x,    g_pl.target_y
    local swx, swy = g_sword.target_x, g_sword.target_y
    local xdiff, ydiff = swx-plx, swy-ply

    return {
        {x=plx, y=ply, sx=swx, sy=swy},
        {x=swx, y=swy, sx=swx+xdiff, sy=swy+ydiff},
        {x=plx, y=ply, sx=swx, sy=swy}
    }
end

-- how do enemy paths work?

-- hermit turn moves spaces until all path spaces are used.
-- enemy turns go one at a time. Starting from top left.
-- a function will return the path for the enemy.

-- everything is constantly moving to where it is on the grid.
