-- todo: make this smaller
|[f_editparty_draw3]| function(game)
    local team = f_get_party(game:cursor'team1')
    local partypkmn = team[game:cursor'editparty'+1]
    if partypkmn then
        f_draw3_pokeinfo(f_get_pokemon(partypkmn.num))
    else
        f_print_draw3_message{".?????????", "????", "??????"}
    end
end $$

-- todo: put "move" directly on entry so pp reflects correctly.
-- for partymoves, partymovesel, pmovesel
|[f_move_draw3]| function(game)
    local num = game:entry().num
    if num then
        local move = c_moves[num]
        f_print_draw3_message{'.'..c_types[move.type].name, move.pp..'/'..move.pp, move.damage.."P "..(move.accuracy*100\1).."A"}
    else
        f_print_draw3_message{".????", "?/?", "??P ???A"}
    end
end $$

|[f_browse_draw3]|       function(game) f_draw3_pokeinfo(f_get_browse_pokemon(game:cursor'browse'+1))   end $$
|[f_main_draw3]|         function(game) f_print_draw3_message(_split(game:entry'main'.desc, '|'))      end $$
|[f_pselactions_draw3]|  function(game) f_print_draw3_message(_split(game:entry'pselactions'.desc, '|'))      end $$

|[f_party_draw3]|        function(game)
    local count, power = 0, 0
    for i=1,6 do
        local num = game:entry().team[i]
        if num then
            count += 1
            power += c_pokemon[num].total
        end
    end

    f_print_draw3_message{".team stats", "pkm "..count.."/6", "pow "..power}
end $$

|[f_pselmove_draw3]|     function(game)                                                             end $$
|[f_fightover_draw3]|  function(game) f_print_draw3_message{game.p0.name, "is the", "winner"} end $$

|[f_turn_draw3]|  function(game)
    local message_tbl = _split(game.cur_action.message)
    if message_tbl[1] == '#' then message_tbl[1] = c_pokemon[game.cur_action.active.shared.num].name end
    f_print_draw3_message(message_tbl)
end $$
