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

|[partymoves_init]| function(game)
    local party = get_party(game.menu_party.c)
    local partypkmn = party[game.menu_editparty.c+1]

    game.menu_partymoves:refresh(zobj[[,1,2,3,4]], function(i)
        return {
            name=partypkmn.moves[i] and c_moves[partypkmn.moves[i]].name or "<empty>",
            select=function(_, game) game:push'partymovesel' end
        }
    end)
end $$

|[partymoves_update]| function(game) game.menu_partymoves:update(game) end $$
|[partymoves_draw1]|  function(game) game.menu_partymoves:draw1() end $$

|[partymoves_draw2]| function(_)

end $$

|[partymoves_draw3]| function(_)

end $$

|[partymovesel_init]| function(game)
    local party = get_party(game.menu_party.c)
    local partypkmn = party[game.menu_editparty.c+1]

    local pkmn = c_pokemon[partypkmn.num]
    game.menu_partymovesel:refresh(pkmn.moves, function(m)
        return {
            name=c_moves[m.num].name,
            ref=m.ref,
            select=function(_, game)
                save_party(game.menu_party.c, set_party_pkmn_move(get_party(game.menu_party.c), game.menu_editparty.c+1, game.menu_partymoves.c+1, m.num))
                game:pop()
            end
        }
    end)
end $$

|[partymovesel_update]| function(game) game.menu_partymovesel:update(game) end $$
|[partymovesel_draw1]|  function(game) game.menu_partymovesel:draw1() end $$
|[partymovesel_draw2]|  function(game) 
    --local move = game.menu_[....partymsel+1]
    --if move then
    --    print(move.ref, 3, 3, 1)
    --end
end $$

|[partymovesel_draw3]|  function(_) end $$

-- moves:
-- 4 moves max. if 0, then show struggle. if multiturn, show that move
-- 4 moves exact. show empty.
