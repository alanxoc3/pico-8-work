|[f_teamdel]| function(game)
    local team = game:f_get_team_cursor'team1'
    team[game:cursor'editteam'+1] = f_get_team_pkmn(-1, f_create_empty_moveset())
    f_save_team(game:cursor'team1', team)
    game:pop()
end $$

|[f_set_default_team_pkmn]| function(team, ind, num)
    team[ind] = f_get_team_pkmn(num, f_get_natural_moveset(num))
    return team
end $$
