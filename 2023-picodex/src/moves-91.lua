-- this is called on startup to populate c_moves
|[f_populate_c_moves]| function()
    for i=-1,#c_moves_raw do
        local move = c_moves_raw[i]
        c_moves[i] = f_zobj([[
            name,@, type,@, pp,@, maxpp,~pp, damage,@, accuracy,@, num,@
        ]],
            move[1],
            move[2],
            move[3],
            move[4],
            move[5],
            i
        )
    end
end $$

|[f_get_natural_moveset]| function(num)
    local pkmn, moveset = c_pokemon[num], f_create_empty_moveset()
    for i=1,min(4,#pkmn.moves_natural) do
        moveset[i] = f_create_move(pkmn.moves_natural[i])
    end
    return moveset
end $$

-- move is between -1 and 
|[f_create_move]| function(id)
    return _setmetatable(f_zobj[[]], {__index=c_moves[id]})
end $$

|[f_create_empty_moveset]| function()
    local moveset = {}
    for i=1,4 do _add(moveset, f_create_move(-1)) end
    return moveset
end $$
