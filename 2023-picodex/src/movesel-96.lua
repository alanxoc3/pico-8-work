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

|[partymoves_init]| function(game)
    local party = get_party(game.menu_party.c)
    local partypkmn = party[game.menu_editparty.c+1]

    game.menu_partymoves:refresh(zobj[[,1,2,3,4]], function(i)
        return {
            num=partypkmn.moves[i],
            name=partypkmn.moves[i] and c_moves[partypkmn.moves[i]].name or "<empty>",
            select=function(_, game) game:push'partymovesel' end
        }
    end)
end $$

|[partymoves_update]| function(game) game.menu_partymoves:update(game) end $$
|[partymoves_draw1]|  function(game) game.menu_partymoves:draw1() end $$

|[partymoves_draw2]| function(_) end $$
|[partymoves_draw3]| function(game)
    local num = game.menu_partymoves[game.menu_partymoves.c+1].num
    if num then
        local move = c_moves[num]
        print_draw3_message(c_types[move.type].name, move.pp..'/'..move.pp.." pp", move.damage..'/'..(move.accuracy*100\1).." sa")
    end
end $$

|[partymovesel_init]| function(game)
    local party = get_party(game.menu_party.c)
    local partypkmn = party[game.menu_editparty.c+1]

    local pkmn = c_pokemon[partypkmn.num]
    game.menu_partymovesel:refresh(pkmn.moves, function(m)
        return {
            name=c_moves[m.num].name,
            num=m.num,
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
    local move = game.menu_partymovesel[game.menu_partymovesel.c+1]
    if move then
        -- todo, combine with other similar draw2s
        zprint(move.ref, 46/2, 4, 1, 0)
    end
end $$

-- todo: combine with partymoves_draw3
|[partymovesel_draw3]|  function(game)
    local num = game.menu_partymovesel[game.menu_partymovesel.c+1].num
    if num then
        local move = c_moves[num]
        print_draw3_message(c_types[move.type].name, move.pp..'/'..move.pp.." pp", move.damage..'/'..(move.accuracy*100\1).." sa")
    end
end $$

-- moves:
-- 4 moves max. if 0, then show struggle. if multiturn, show that move
-- 4 moves exact. show empty.
