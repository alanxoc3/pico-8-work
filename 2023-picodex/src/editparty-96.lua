-- TODO: cur pkmn should start when selecting
|[partydel]| function(entry, game)
    local party = get_party(game:cursor'party')
    party[game:cursor'editparty'+1] = nil
    save_party(game:cursor'party', party)
    game:pop()
end $$

function set_default_party_pkmn(party, ind, num)
    party[ind] = {num=num, moves=c_pokemon[num].get_natural_moveset(100)}
    return party
end
