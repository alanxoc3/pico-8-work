-- CHOOSE PARTY LOGIC --
|[f_team_select]| function(game)
    game:f_modes_push'editteam'
end $$

-- UTILITY FUNCTIONS --
-- most usages of get team come with a cursor, so this can save some tokens
|[f_get_team_cursor]| function(game, cursor)
    return f_get_team(game:f_modes_cursor(cursor))
end $$

-- there are 5 places that use this function, all editparty related
|[f_get_pkmn_team_edit]| function(game)
    local team = f_get_team(game:f_modes_cursor'team1')
    return team[game:f_modes_cursor'editteam'+1], team
end $$
