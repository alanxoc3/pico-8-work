zclass[[level_state,actor|
    itemind,2,
    curr,pre_card_select;

    items;,;

    pre_card_select;     init,%pre_card_select_init, update,nop,                 duration,0, next,card_select;
    card_select;         init,%card_select_init,     update,%card_select_update;
    move_select;         init,%move_select_init,     update,%move_select_update;
    player_update;       init,%player_update_init,   update,nop,                 duration,1, next,baddie_update;
    baddie_update;       init,%baddie_update_init,   update,nop,                 duration,1, next,pre_card_select;
]]

-- PRE CARD SELECT --
|[pre_card_select_init]| function(a)
    a.items = {
        _g.card(35,       128, false),
        _g.card(35+21,    130, true),
        _g.card(35+21+21, 134, false)
    }
end $$

-- CARD SELECT --
|[card_select_init]| function(a)
    local moves = get_move_coordinates(a.items[a.itemind].sind)
    for m in all(moves) do
        _g.pos_preview(a, a.itemind, m.x, m.y, m.sind, m.sel_sind)
    end
end $$

|[card_select_update]| function(a)
    local prev_ind = a.itemind
    if xbtnp() ~= 0 then
        a.itemind = mid(1, a.itemind +xbtnp(), 3)
    end

    if a.itemind ~= prev_ind then
        local moves = get_move_coordinates(a.items[a.itemind].sind)
        for m in all(moves) do
            _g.pos_preview(a, a.itemind, m.x, m.y, m.sind, m.sel_sind)
        end
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

    for m in all(a.moves) do
        _g.pos_real(a, a.itemind, m.x, m.y, m.sind, m.sel_sind)
    end
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
|[player_update_init]| function(a)
    _g.status_text("hermit turn", 'player_update')
end $$

-- PLAYER UPDATE
|[baddie_update_init]| function(a)
    _g.status_text("baddie turn", 'baddie_update')
end $$
