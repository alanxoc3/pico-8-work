|[f_editteam_draw3]| function(game)
    f_draw3_pokeinfo(game:f_get_pkmn_team_edit())
end $$

-- for teammoves, teammovesel, pmovesel
|[f_move_draw3]| function(game)
    local move = game:entry(game.movemode).move
    if move.num >= 0 then
        f_print_draw3_message(c_types[move.type].name.."|"..move.pp..'/'..move.maxpp.."|"..(move.damage >= 0 and move.damage or "??").."P "..(move.accuracy >= 0 and move.accuracy or "??").."A")
    else
        f_print_draw3_message"????|?/?|??P ???A"
    end
end $$

|[f_browse_draw3]| function(game)
    f_draw3_pokeinfo(game:entry'browse'.pkmn)
end $$

|[f_main_draw3]|        function(game) f_print_draw3_message(game:entry'main'.desc) end $$
|[f_pselactions_draw3]| function(game) f_print_draw3_message(game:entry'pselactions'.desc) end $$
|[f_pstat_draw3]| function(_ENV) f_fight_draw3_helper(p0.statplayer.active) end $$

|[f_fight_draw3_helper]| function(_ENV)
    if num > -1 then
        f_print_draw3_message(name.."|"..hp..'/'..maxhp.."|"..c_major_names[major])
    else
        f_print_draw3_message"?????????|???/???|"
    end
end $$

|[f_pselswitch_draw3]|  function(_ENV) f_fight_draw3_helper(_ENV:entry'pselswitch'.pkmn) end $$

|[f_team_draw3]| function(game)
    local count, power = 0, 0
    for i=1,6 do
        local num = game:entry().team[i]
        if num then
            count += 1
            power += c_pokemon[num].total
        end
    end

    f_print_draw3_message(game:entry().name.."|pkmn "..count.."/6|pow "..power)
end $$

|[f_fightover_draw3]| function(game)
    f_print_draw3_message(game.p0.name.."|is the|winner")
end $$

|[f_turn_draw3]|  function(game)
    f_print_draw3_message(game.cur_action.active.name..game.cur_action.message)
end $$
