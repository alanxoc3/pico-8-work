|[f_editteam_draw3]| function(game)
    f_draw3_pokeinfo(game:f_get_pkmn_team_edit())
end $$

-- for teammoves, teammovesel, pmovesel
|[f_move_draw3]| function(game)
    local move = game:f_modes_entry(game.movemode).move
    if move.num >= 0 then
        f_print_draw3_message(c_types[move.movetype].name.."|"..move.pp..'/'..move.maxpp.."|"..(move.damage >= 0 and move.damage or "??").."P "..(move.accuracy >= 0 and move.accuracy or "??").."A")
    else
        f_print_draw3_message"none|n/a|"
    end
end $$

|[f_browse_draw3]| function(game)
    f_draw3_pokeinfo(game:f_modes_entry'browse'.pkmn)
end $$

|[f_main_draw3]|        function(game) f_print_draw3_message(game:f_modes_entry'main'.desc) end $$

|[f_fight_draw3_helper]| function(_ENV)
    if num > -1 then
        f_print_draw3_message(name.."|"..hp..'/'..maxhp.."|"..c_major_names[major])
    else
        f_print_draw3_message"none|n/a|"
    end
end $$

|[f_pselswitch_draw3]|  function(_ENV) f_fight_draw3_helper(_ENV:f_modes_entry'pselswitch'.pkmn) end $$
|[f_pselactions_draw3]|  function(_ENV) f_fight_draw3_helper(p0.active) end $$

|[f_team_draw3]| function(game)
    local power, count = 0, 0
    _foreach(game:f_modes_entry().team, function(num)
        if num > -1 then
            power += c_pokemon[num].total
            count += 1
        end
    end)

    f_print_draw3_message(game:f_modes_entry().name.."|len "..count.."/6|pow "..power\10)
end $$

|[f_fightover_draw3]| function(game)
    f_print_draw3_message(game.pwin.name.."|is the|winner")
end $$

|[f_turn_draw3]|  function(game)
    f_print_draw3_message(game.cur_action.name..game.cur_action.message)
end $$
