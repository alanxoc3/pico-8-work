-- TODO: cur pkmn should start when selecting
|[partydel]| function(entry, game)
    local team = get_party(game:cursor'team1')
    team[game:cursor'editparty'+1] = nil
    save_party(game:cursor'team1', team)
    game:pop()
end $$

function set_default_party_pkmn(team, ind, num)
    team[ind] = {num=num, moves=c_pokemon[num].get_natural_moveset(100)}
    return team
end
