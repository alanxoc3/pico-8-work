|[f_editteam_draw3]| function(game)
    f_draw3_pokeinfo(game:f_get_pkmn_team_edit().num)
end $$

-- todo (wait): put "move" directly on entry so pp reflects correctly.
-- for teammoves, teammovesel, pmovesel
|[f_move_draw3]| function(game)
    local num = game:entry(game.movemode).num
    if num then
        local move = c_moves[num]
        local accuracy = move.accuracy*100\1
        f_print_draw3_message{'.'..c_types[move.type].name, move.pp..'/'..move.pp, (move.damage >= 0 and move.damage or "??").."P "..(accuracy >= 0 and accuracy or "??").."A"}
    else
        f_print_draw3_message{".????", "?/?", "??P ???A"}
    end
end $$

|[f_browse_draw3]| function(game)
    f_draw3_pokeinfo(game:cursor'browse')
end $$

|[f_main_draw3]|         function(game) f_print_draw3_message(_split(game:entry'main'.desc, '|'))      end $$
|[f_pselactions_draw3]|  function(game) f_print_draw3_message(_split(game:entry'pselactions'.desc, '|'))      end $$

|[f_team_draw3]|        function(game)
    local count, power = 0, 0
    for i=1,6 do
        local num = game:entry().team[i]
        if num then
            count += 1
            power += c_pokemon[num].total
        end
    end

    f_print_draw3_message{".team stats", "pkmn "..count.."/6", "pow "..power}
end $$

|[f_pselmove_draw3]|     function(game)                                                             end $$
|[f_fightover_draw3]|  function(game) f_print_draw3_message{game.p0.name, "is the", "winner"} end $$

|[f_turn_draw3]|  function(game)
    local message_tbl = _split(game.cur_action.message)
    if message_tbl[1] == '#' then message_tbl[1] = c_pokemon[game.cur_action.active.shared.num].name end
    f_print_draw3_message(message_tbl)
end $$
