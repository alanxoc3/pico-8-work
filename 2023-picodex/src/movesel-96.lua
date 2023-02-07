-- different move menus:
    -- select move when battling
        -- draw3: pp, type
    -- select move to edit
        -- draw3: 
    -- select move to learn

function set_party_pkmn_move(party, ind, moveind, move)
    local partypkmn = party[ind]

    -- if the move already exists on the pkmn, remove it.
    for i=1,4 do
        if partypkmn.moves[i] == move then
            partypkmn.moves[i] = nil
        end
    end

    partypkmn.moves[moveind] = move
    return party
end
