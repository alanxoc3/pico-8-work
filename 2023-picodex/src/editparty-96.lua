-- TODO: cur pkmn should start when selecting
|[partydel]| function(game)
    local team = get_party(game:cursor'team1')
    team[game:cursor'editparty'+1] = nil
    save_party(game:cursor'team1', team)
    game:pop()
end $$

|[set_default_party_pkmn]| function(team, ind, num)
    team[ind] = {num=num, moves=c_pokemon[num].get_natural_moveset(100)}
    return team
end $$
