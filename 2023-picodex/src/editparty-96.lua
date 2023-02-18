-- TODO: cur pkmn should start when selecting
|[f_partydel]| function(game)
    local team = f_get_party(game:cursor'team1')
    team[game:cursor'editparty'+1] = nil
    f_save_party(game:cursor'team1', team)
    game:pop()
end $$

|[f_set_default_party_pkmn]| function(team, ind, num)
    team[ind] = {num=num, moves=c_pokemon[num].get_natural_moveset(100)}
    return team
end $$
