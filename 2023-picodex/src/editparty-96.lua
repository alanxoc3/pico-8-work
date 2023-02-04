-- TODO: cur pkmn should start when selecting
|[partydel]| function(entry, game)
    local party = get_party(game.menu_party.c)
    party[game.menu_editparty.c+1] = nil
    save_party(game.menu_party.c, party)
    game:pop()
end $$

function set_default_party_pkmn(party, ind, num)
    party[ind] = {num=num, moves=c_pokemon[num].get_natural_moveset(100)}
    return party
end

|[partyaction_init]|   function(game)
    local possible_actions = zobj[[
        ; name,"pokemon", state,partypkmn,  desc,"select|the|pokemon", select,%menu_state_callback -- use browse pokemon selector
       ;; name,"moves",   state,partymoves, desc,"select|the|moves",   select,%menu_state_callback -- use the menu system
       ;; name,"delete",                    desc,"remove|from|party",  select,%partydel            -- use the edit party screen
    ]]

    local party = get_party(game.menu_party.c)
    game.menu_partyaction:refresh(party[game.menu_editparty.c+1] and possible_actions or {possible_actions[1]})
end $$

|[partyaction_update]| function(game) game.menu_partyaction:update(game) end $$
|[partyaction_draw1]|  function(game) game.menu_partyaction:draw1()  end $$
|[partyaction_draw3]|  function(game) end $$

|[partypkmn_update]| function(game) game.menu_partypkmn:update(game) end $$
|[partypkmn_draw1]|  function(game) game.menu_partypkmn:draw1() end $$
|[partypkmn_draw2]|  function(game) draw2_pokeinfo(get_browse_pokemon(game.menu_partypkmn.c+1)) end $$
|[partypkmn_draw3]|  function(game) draw3_pokeinfo(get_browse_pokemon(game.menu_partypkmn.c+1)) end $$

|[partypkmn_init]| function(game)
    game.menu_partypkmn:refresh(
        g_available_pokemon,
        function(num)
            return {
                select=function(_, game)
                    save_party(game.menu_party.c, set_default_party_pkmn(get_party(game.menu_party.c), game.menu_editparty.c+1, g_available_pokemon[game.menu_partypkmn.c+1]))
                    game:pop() game:pop() -- pop twice, because you got here through a menu
                end,
                num=num
            }
        end
    )
end $$