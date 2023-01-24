-- TODO: maybe make it so you don't need a memory address with menu.
-- TODO: cur pkmn should start when selecting

|[editparty_update]| function(a)
    -- local test = {}

    if g_bpu then poke(S_PARTY_PKMN_NUM, (@S_PARTY_PKMN_NUM-3)%6) end
    if g_bpd then poke(S_PARTY_PKMN_NUM, (@S_PARTY_PKMN_NUM+3)%6) end

    if g_bpl then poke(S_PARTY_PKMN_NUM, (@S_PARTY_PKMN_NUM-1)%6) end
    if g_bpr then poke(S_PARTY_PKMN_NUM, (@S_PARTY_PKMN_NUM+1)%6) end

    if g_bpo then a:pop() end
    if g_bpx then a:push'partyaction' end
end $$

-- todo: make this smaller
|[editparty_draw1]| function(a)
    local party = get_party(@S_CUR_PARTY)

    --rectfill(0,0,39,39,1)
    --rectfill(-1,0+7,40,39-7,13)
    --rect(-1,0+7,40,39-7,1)
    for i=1,6 do
        get_pokemon(party[i] and party[i].num or -2).draw(8+(i-1)%3*11, 14+(i-1)\3*12, 5, .5, .5)
    end

    local row, col = @S_PARTY_PKMN_NUM\3, @S_PARTY_PKMN_NUM%3
    rect    (-2+col*12, 4+row*12, 17+col*12, 23+row*12, 13)
    rect    (-1+col*12, 5+row*12, 16+col*12, 22+row*12, 1)
    rectfill(0+col*12,  6+row*12, 15+col*12, 21+row*12, 6)
    local sel_pkmn = party[@S_PARTY_PKMN_NUM+1]
    get_pokemon(sel_pkmn and sel_pkmn.num or -2).draw(8+col*11, 14+row*12, 13, 1, 1)
end $$

|[editparty_draw2]| function(a)
    local pkmn = get_party(@S_CUR_PARTY)[@S_PARTY_PKMN_NUM+1]
    if pkmn then
        draw2_pokeinfo(get_pokemon(pkmn.num))
    else
        zprint("spot #"..(@S_PARTY_PKMN_NUM+1), 46/2, 4, 1, 0)
    end
end $$

|[editparty_draw3]| function(a)
    -- local pkmn = get_party(@S_CUR_PARTY)[@S_PARTY_PKMN_NUM+1]
    -- if pkmn then draw3_pokeinfo(pkmn.num) end
    print_draw3_message("now", "pick a", "spot")
end $$

c_partyactions = zobj[[
    ; name,"pokemon", state,partypkmn, desc,"select|the|pokemon",   func,%menu_state_callback -- use browse pokemon selector
   ;; name,"moves",   state,partymoves,desc,"select|the|moves",     func,%menu_state_callback -- use the menu system
   ;; name,"delete",                   desc,"remove|from|party",    func,%partydel            -- use the edit party screen
]]

function get_partyactions()
    local party = get_party(@S_CUR_PARTY)
    if party[@S_PARTY_PKMN_NUM+1] then
        return c_partyactions
    else
        return {c_partyactions[1]}
    end
end

|[partydel]| function(a, game)
    local party = get_party(@S_CUR_PARTY)
    party[@S_PARTY_PKMN_NUM+1] = nil
    save_party(@S_CUR_PARTY, party)
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

|[partyaction_init]|   function(a) a.available_actions = get_partyactions() end $$
|[partyaction_update]| function(a) menu_update(a, 'partyaction', a.available_actions) end $$
|[partyaction_draw1]|  function(a) menu_draw1 (a, 'partyaction', a.available_actions) end $$
|[partyaction_draw3]|  function(a) menu_draw3 (a, 'partyaction', a.available_actions) end $$

|[partypkmn_init]| function(a)
    g_cursors.party_pkmn = flr_rnd(#g_available_pokemon)+1

    -- local party = get_party(@S_CUR_PARTY)
    -- local partypkmn = party[@S_PARTY_PKMN_NUM+1]
    -- if partypkmn then g_cursors.party_pkmn = partypkmn.num end
end $$

|[partypkmn_update]| function(a)
    browse_update(a, 'party_pkmn')
    if g_bpx then
        save_party(@S_CUR_PARTY, set_default_party_pkmn(get_party(@S_CUR_PARTY), @S_PARTY_PKMN_NUM+1, g_available_pokemon[g_cursors.party_pkmn]))
        a:pop() a:pop() -- pop twice, because you got here through a menu
    end
end $$

|[partypkmn_draw1]| function(a) browse_draw1(a, 'party_pkmn') end $$
|[partypkmn_draw2]| function() draw2_pokeinfo(get_browse_pokemon(g_cursors.party_pkmn)) end $$
|[partypkmn_draw3]| function() draw3_pokeinfo(get_browse_pokemon(g_cursors.party_pkmn)) end $$

|[partymoves_init]| function(a)
    a.moveset = {}
    local movedict = {}
    local party = get_party(@S_CUR_PARTY)
    local partypkmn = party[@S_PARTY_PKMN_NUM+1]

    for i=1,4 do
        add(a.moveset, {
            name=partypkmn.moves[i] and c_moves[partypkmn.moves[i]].name or "<empty>",
            func=function(a, game)
                game:push'partymovesel'
            end
        })
    end
end $$

|[partymoves_update]| function(a) menu_update(a, 'partymoves', a.moveset) end $$
|[partymoves_draw1]|  function(a) menu_draw1 (a, 'partymoves', a.moveset) end $$

|[partymoves_draw2]| function(a)

end $$

|[partymoves_draw3]| function(a)

end $$

|[partymovesel_init]| function(a)
    a.movelist = {}
    local movedict = {}
    local party = get_party(@S_CUR_PARTY)
    local partypkmn = party[@S_PARTY_PKMN_NUM+1]

    local pkmn = c_pokemon[partypkmn.num]
    for m in all(pkmn.moves) do
        if not movedict[m.num] then
            movedict[m.num] = true

            add(a.movelist, {
                name=c_moves[m.num].name,
                ref=m.ref,
                func=function(a, game)
                    save_party(@S_CUR_PARTY, set_party_pkmn_move(get_party(@S_CUR_PARTY), @S_PARTY_PKMN_NUM+1, g_cursors.partymoves+1, m.num))
                    game:pop()
                end
            })
        end
    end

    g_cursors.partymsel, g_views.partymsel = flr_rnd(#a.movelist), 0
end $$

|[partymovesel_update]| function(a) menu_update(a, 'partymsel', a.movelist) end $$
|[partymovesel_draw1]|  function(a) menu_draw1 (a, 'partymsel', a.movelist) end $$
|[partymovesel_draw2]|  function(a) 
    local move = a.movelist[g_cursors.partymsel+1]
    if move then
        print(move.ref, 3, 3, 1)
    end
end $$
|[partymovesel_draw3]|  function(a) end $$

    --partymoves;   update,%partymoves_update,   draw1,%partymoves_draw1,   draw2,%editparty_draw2, draw3,%partymoves_draw3;
