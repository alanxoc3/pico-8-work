-- CHOOSE PARTY LOGIC --
|[f_team_select]| function(game)
    game:push'editteam'
end $$

-- UTILITY FUNCTIONS --
-- most usages of get team come with a cursor, so this can save some tokens
|[f_get_team_cursor]| function(game, cursor)
    return f_get_team(game:cursor(cursor))
end $$

-- there are 5 places that use this function, all editparty related
|[f_get_pkmn_team_edit]| function(game)
    local team = f_get_team(game:cursor'team1')
    return team[game:cursor'editteam'+1], team
end $$

-- %c_no moves means the pokemon is deleted
c_team_memlocs = f_zobj[[0,S_PARTY1, 1,S_PARTY2, 2,S_PARTY3]]
|[f_get_team]| function(team_index) -- 0 to 2
    local mem = c_team_memlocs[team_index]
    local team = f_zobj[[]]

    for i=1,6 do
        local memstart = mem+(i-1)*5
        local moves = {}
        local has_moves = false
        for i=1,4 do
            local move = _peek(memstart+i)
            if move > 0 then
                moves[i] = move
                has_moves = true
            end
        end

        team[i] = f_zobj([[moves,@]], moves)
        _setmetatable(team[i], {__index=c_pokemon[has_moves and @memstart or -1]})
    end

    return team
end $$

|[f_save_team]| function(team_index, team) -- 0 to 2
    local mem = c_team_memlocs[team_index]
    _memset(mem,0,30)

    -- clear team and we'll replace it with the logic below

    for i=1,6 do
        local memstart = mem+(i-1)*5
        local pkmn = team[i]
        if pkmn then
            _poke(memstart, pkmn.num)

            for i=1,4 do
                _poke(memstart+i, pkmn.moves[i])
            end
        end
    end
end $$
