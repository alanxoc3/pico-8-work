-- different move menus:
    -- select move when battling
        -- draw3: pp, type
    -- select move to edit
        -- draw3: 
    -- select move to learn

|[f_set_team_pkmn_move]| function(team, ind, moveind, move)
    local teampkmn = team[ind]

    -- if the move already exists on the pkmn, remove it.
    for i=1,4 do
        if teampkmn.moveids[i] == move then
            -- todo: try -1 instead of nil
            teampkmn.moveids[i] = nil
        end
    end

    teampkmn.moveids[moveind] = move
    return team
end $$
