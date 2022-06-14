zclass[[level_state,actor|
    itemind,3,

    items;,;

    start;               init,%level_state_init,     update,nop,                 duration,0, next,pre_card_select;
    pre_card_select;     init,%pre_card_select_init;
    card_select;         init,nop,                   update,%card_select_update;
    move_select;         init,%move_select_init,     update,%move_select_update;
    player_update;       init,%player_update_init,   update,%player_update_update;
    baddie_update;       init,%baddie_update_init,   update,%baddie_update_update;
]]

function get_random_green_ind()
    return rnd_item{134, 134, 136, 166} -- double move
end

function get_random_red_ind()
    return rnd_item{130, 130, 128, 132} -- double stab
end

function get_random_card_ind()
    return rnd_item{128, 130, 132, 134, 136, 160, 162, 164, 166}
end

function is_level_win()  return not get_next_baddie{} end
function is_level_lose() return not g_pl:is_alive()   end

|[level_state_init]| function(a)
    a.item_inds = { get_random_card_ind(), get_random_green_ind(), get_random_red_ind(), get_random_green_ind(), get_random_card_ind() }
end $$

-- PRE CARD SELECT --
|[pre_card_select_init]| function(a)
    if is_level_win() then
        a:kill()
        _g.fader_out(function()
            set_g_level(g_level()+1)
            if g_level() >= 50 then
                g_tl:load'gamewin'
            else
                g_tl:load'lvlwin'
            end
        end)
    elseif is_level_lose() then
        set_g_death_count(g_death_count()+1)
        a:kill()
        _g.fader_out(function()
            g_tl:load'lvllose'
        end)
    else
        set_g_turn_count(g_turn_count()+1)
        a:load'card_select'

        a.items = {}
        for i=1,5 do
            add(a.items, _g.card(22+(i-1)*17, a.item_inds[i], false))
        end

        a.items[a.itemind].selected = true
    end
end $$

|[card_select_update]| function(a)
    local prev_ind = a.itemind
    if xbtnp() ~= 0 then
        a.itemind = mid(1, a.itemind +xbtnp(), 5)
    end

    for i=1,#a.items do
        a.items[i].selected = i == a.itemind
    end

    if btnp'4' then
        a:load'move_select'
    end
end $$

-- MOVE SELECT --
|[move_select_init]| function(a)
    a.moves = get_move_coordinates(a.items[a.itemind].sind)
    a.moves_ind = 1
    _g.selected_move()
end $$

function move_select_update_helper(moves, ind, btnpress, default, axis, default_key, axis_key)
    local smallest_diff, smallest_axis_diff = 16, 16

    for i=1,#moves do
        local m = moves[i]
        local diff, axis_diff = m[default_key] - default, m[axis_key] - axis
        if zsgn(diff) == btnpress then
            if abs(axis_diff) < abs(smallest_axis_diff) then
                smallest_diff, smallest_axis_diff, ind = diff, axis_diff, i
            elseif abs(axis_diff) == abs(smallest_axis_diff) and abs(diff) < abs(smallest_diff) then
                smallest_diff, smallest_axis_diff, ind = diff, axis_diff, i
            elseif abs(axis_diff) == abs(smallest_axis_diff) and abs(diff) == abs(smallest_diff) and axis_diff < smallest_axis_diff then
                smallest_diff, smallest_axis_diff, ind = diff, axis_diff, i
            end
        end
    end

    return ind
end

|[move_select_update]| function(a)
    local cur_move_x = a.moves[a.moves_ind].x
    local cur_move_y = a.moves[a.moves_ind].y
    local next_ind = a.moves_ind

        if xbtnp() ~= 0 then next_ind = move_select_update_helper(a.moves, a.moves_ind, xbtnp(), cur_move_x, cur_move_y, 'x', 'y')
    elseif ybtnp() ~= 0 then next_ind = move_select_update_helper(a.moves, a.moves_ind, ybtnp(), cur_move_y, cur_move_x, 'y', 'x')
    end

    a.moves_ind = next_ind

    if btnp(5) then
        a:load'card_select'
    elseif btnp(4) then
        a:load'player_update'
    end
end $$

-- PLAYER UPDATE
function get_enemy_count()
    local enemy_coords =  find_on_grid(function(spot)
        return spot.entity and spot.entity.parents.enemy
    end)

    return enemy_coords and #enemy_coords or 0
end

|[player_update_init]| function(a)
    _g.status_text("hermit turn", 'player_update')
    local m = a.moves[a.moves_ind]

    a.path = m.gen_path(m.x, m.y)
    a.prev_path = m.gen_path(m.x, m.y)

    a.reset_turn_timer = true
    a.item_inds[a.itemind] = get_random_card_ind()
    a.initial_enemy_count = get_enemy_count()
end $$

|[player_update_update]| function(a)
    if a.timers.player_update.elapsed and a.timers.player_update.elapsed > .5 and a.reset_turn_timer then
        a.reset_turn_timer = false
        local spot = deli(a.path, 1)
        if spot.func then spot.func() end
        g_pl.target_x, g_pl.target_y, g_sword.target_x, g_sword.target_y = spot.x, spot.y, spot.sx, spot.sy

        a:start_timer('turn_tick', spot.duration or .25, function()
            if #a.path > 0 then
                a.reset_turn_timer = true
            else
                a.reset_turn_timer = false

                if a.initial_enemy_count > get_enemy_count() then
                    a:load'pre_card_select'
                else
                    a:load'baddie_update'
                end
            end
        end)
    end
end $$

-- BADDIE UPDATE
function get_next_baddie(visited_baddies)
    local bad_coords = find_on_grid(function(spot)
        return spot.entity and spot.entity.parents.enemy and not visited_baddies[spot.entity]
    end)

    if #bad_coords > 0 then
        local coord = bad_coords[1]
        return g_grid[coord.y*7+coord.x].entity
    end
end

|[baddie_update_init]| function(a)
    _g.status_text("baddie turn", 'baddie_update')
    a.reset_turn_timer = true

    a.visited_baddies = {}
    a.baddie = get_next_baddie(a.visited_baddies)
    if a.baddie then
        a.visited_baddies[a.baddie] = true
        a.path = a.baddie:get_path()
    end
end $$

|[baddie_update_update]| function(a)
    if a.timers.baddie_update.elapsed and a.timers.baddie_update.elapsed > .5 and a.reset_turn_timer then
        if a.baddie then
            a.reset_turn_timer = false
            local spot = deli(a.path, 1)
            a.baddie.target_x, a.baddie.target_y = spot.x, spot.y

            a:start_timer('turn_tick', .25, function()
                if #a.path > 0 then
                    a.reset_turn_timer = true
                else
                    local next_baddie = get_next_baddie(a.visited_baddies)
                    if next_baddie then
                        a.baddie = next_baddie
                        a.visited_baddies[a.baddie] = true
                        a.path = a.baddie:get_path()
                        a.reset_turn_timer = true
                    else
                        a.reset_turn_timer = false
                        a:load'pre_card_select'
                    end
                end
            end)
        else
            a.reset_turn_timer = false
            a:load'pre_card_select'
        end
    end
end $$

