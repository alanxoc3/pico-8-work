-- todo: make this smaller
|[editparty_draw3]| function(game)
    local party = get_party(game:cursor'party')
    local partypkmn = party[game:cursor'editparty'+1]
    if partypkmn then
        draw3_pokeinfo(get_pokemon(partypkmn.num))
    else
        print_draw3_message{"select", "your", "pokemon"}
    end
end $$

-- todo: combine with partymoves_draw3
|[partymovesel_draw3]|  function(game)
    local num = game:entry'partymovesel'.num
    if num then
        local move = c_moves[num]
        print_draw3_message{'.'..c_types[move.type].name, move.pp..'/'..move.pp.." pp", move.damage..'/'..(move.accuracy*100\1).." sa"}
    end
end $$

-- todo: combine with partymoves_draw3
|[partymoves_draw3]| function(game)
    local num = game:entry'partymoves'.num
    if num then
        local move = c_moves[num]
        print_draw3_message{'.'..c_types[move.type].name, move.pp..'/'..move.pp.." pp", move.damage..'/'..(move.accuracy*100\1).." sa"}
    end
end $$

|[browse_draw3]|       function(game) draw3_pokeinfo(get_browse_pokemon(game:cursor'browse'+1))    end $$
|[main_draw3]|         function(game) print_draw3_message(split(game:entry'main'.desc, '|'))      end $$
|[partypkmn_draw3]|    function(game) draw3_pokeinfo(get_browse_pokemon(game:cursor'partypkmn'+1)) end $$
|[pselactions_draw3]|  function(_)                                                                end $$
|[pselmove_draw3]|     function(game)                                                             end $$
