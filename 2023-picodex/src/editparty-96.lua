-- TODO: maybe make it so you don't need a memory address with menu.
-- TODO: cur pkmn should start when selecting
|[partydel]| function(entry, game)
    local party = get_party(game.menu_party.c)
    party[@S_PARTY_PKMN_NUM+1] = nil
    save_party(game.menu_party.c, party)
    game:pop()
end $$

function set_default_party_pkmn(party, ind, num)
    party[ind] = {num=num, moves=c_pokemon[num].get_natural_moveset(100)}
    return party
end

function set_party_pkmn_move(party, ind, moveind, move)
    local partypkmn = party[ind]

    -- if the move already exists on the pkmn, remove it.
    for i=1,4 do
        if partypkmn.moves[i] == move then
            partypkmn.moves[i] = nil
        end
    end

    partypkmn.moves[moveind] = move
    return party
end

|[partyaction_init]|   function(game)
    local possible_actions = zobj[[
        ; name,"pokemon", state,partypkmn,  desc,"select|the|pokemon", select,%menu_state_callback -- use browse pokemon selector
       ;; name,"moves",   state,partymoves, desc,"select|the|moves",   select,%menu_state_callback -- use the menu system
       ;; name,"delete",                    desc,"remove|from|party",  select,%partydel            -- use the edit party screen
    ]]

    local party = get_party(game.menu_party.c)
    game.menu_partyaction:refresh(party[@S_PARTY_PKMN_NUM+1] and possible_actions or {possible_actions[1]})
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
                    save_party(game.menu_party.c, set_default_party_pkmn(get_party(game.menu_party.c), @S_PARTY_PKMN_NUM+1, g_available_pokemon[game.menu_partypkmn.c+1]))
                    game:pop() game:pop() -- pop twice, because you got here through a menu
                end,
                num=num
            }
        end
    )
end $$

|[partymoves_init]| function(game)
    local party = get_party(game.menu_party.c)
    local partypkmn = party[@S_PARTY_PKMN_NUM+1]

    game.menu_partymoves:refresh(zobj[[,1,2,3,4]], function(i)
        return {
            name=partypkmn.moves[i] and c_moves[partypkmn.moves[i]].name or "<empty>",
            select=function(_, game) game:push'partymovesel' end
        }
    end)
end $$

|[partymoves_update]| function(game) game.menu_partymoves:update(game) end $$
|[partymoves_draw1]|  function(game) game.menu_partymoves:draw1() end $$

|[partymoves_draw2]| function(_)

end $$

|[partymoves_draw3]| function(_)

end $$

|[partymovesel_init]| function(game)
    local party = get_party(game.menu_party.c)
    local partypkmn = party[@S_PARTY_PKMN_NUM+1]

    local pkmn = c_pokemon[partypkmn.num]
    game.menu_partymovesel:refresh(pkmn.moves, function(m)
        return {
            name=c_moves[m.num].name,
            ref=m.ref,
            select=function(_, game)
                save_party(game.menu_party.c, set_party_pkmn_move(get_party(game.menu_party.c), @S_PARTY_PKMN_NUM+1, g_cursors.partymoves+1, m.num))
                game:pop()
            end
        }
    end)
end $$

|[partymovesel_update]| function(game) game.menu_partymovesel:update(game) end $$
|[partymovesel_draw1]|  function(game) game.menu_partymovesel:draw1() end $$
|[partymovesel_draw2]|  function(game) 
    --local move = game.movelist[g_cursors.partymsel+1]
    --if move then
        --print(move.ref, 3, 3, 1)
    --end
end $$

|[partymovesel_draw3]|  function(_) end $$
--partymoves;   update,%partymoves_update,   draw1,%partymoves_draw1,   draw2,%editparty_draw2, draw3,%partymoves_draw3;
