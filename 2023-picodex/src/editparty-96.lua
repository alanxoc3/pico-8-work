|[editparty_update]| function(a)
    -- local test = {}

    if g_bpu then poke(S_PARTY_PKMN_NUM, (@S_PARTY_PKMN_NUM-3)%6) end
    if g_bpd then poke(S_PARTY_PKMN_NUM, (@S_PARTY_PKMN_NUM+3)%6) end

    if g_bpl then poke(S_PARTY_PKMN_NUM, (@S_PARTY_PKMN_NUM-1)%6) end
    if g_bpr then poke(S_PARTY_PKMN_NUM, (@S_PARTY_PKMN_NUM+1)%6) end

    -- temp randomize party
    --if g_bx then
    --    for i=1,6 do add(test, {num=rnd(151)\1+1}) end
    --    save_party(@S_CUR_PARTY, test)
    --end

    if g_bpo then a:pop() end
    if g_bpx then a:push'partyaction' end
end $$

|[editparty_draw1]| function(a)
    local party = get_party(@S_CUR_PARTY)

    rectfill(0,0,39,39,1)
    rectfill(-1,0+7,40,39-7,13)
    rect(-1,0+7,40,39-7,1)
    for i=1,6 do
        get_pokemon(party[i] and party[i].num or -2).draw(8+(i-1)%3*12, 14+(i-1)\3*12, 5, .5)
    end

    local row, col = @S_PARTY_PKMN_NUM\3, @S_PARTY_PKMN_NUM%3
    rect    (-2+col*12, 4+row*12, 17+col*12, 23+row*12, 13)
    rect    (-1+col*12, 5+row*12, 16+col*12, 22+row*12, 1)
    rectfill(0+col*12,  6+row*12, 15+col*12, 21+row*12, 6)
    local sel_pkmn = party[@S_PARTY_PKMN_NUM+1]
    get_pokemon(sel_pkmn and sel_pkmn.num or -2).draw(8+col*12, 14+row*12, 13, .75)

    --get_pokemon(get_party(@S_CUR_PARTY)[1].num).draw(7+(1-1)%3*13, 20+(1-1)\3*13, 13, .825)
end $$

|[editparty_draw2]| function(a)
    local pkmn = get_party(@S_CUR_PARTY)[@S_PARTY_PKMN_NUM+1]
    if pkmn then
        draw2_pokeinfo(pkmn.num)
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
    ; name,"pokemon", state,partypkmn, desc,"change|the|pokemon",   func,%menu_state_callback -- use browse pokemon selector
   ;; name,"moves",   state,partymoves,desc,"change|pokemon|moves", func,%menu_state_callback -- use the menu system
   ;; name,"switch",  state,main,      desc,"switch|pokemon|spot",  func,%menu_state_callback -- use the edit party screen
   ;; name,"delete",                   desc,"remove|from|party",    func,%partydel            -- use the edit party screen
]]

|[partydel]| function(a, game)
    local party = get_party(@S_CUR_PARTY)
    party[@S_PARTY_PKMN_NUM+1] = nil
    save_party(@S_CUR_PARTY, party)
    game:pop()
end $$

|[partyaction_update]| function(a) menu_update(a, S_CURSOR_PARTYACTION, c_partyactions) end $$
|[partyaction_draw1]|  function(a) menu_draw1 (a, S_CURSOR_PARTYACTION, c_partyactions) end $$
|[partyaction_draw3]|  function(a) menu_draw3 (a, S_CURSOR_PARTYACTION, c_partyactions) end $$

|[partypkmn_update]| function(a)
    browse_update(a, S_CURSOR_PARTY_PKMN)
    if g_bpx then
        local party = get_party(@S_CUR_PARTY)
        party[@S_PARTY_PKMN_NUM+1] = {num=@S_CURSOR_PARTY_PKMN, moves=c_pokemon[@S_CURSOR_PARTY_PKMN].get_natural_moveset(100)}
        save_party(@S_CUR_PARTY, party)
        a:pop() a:pop() -- pop twice, because you got here through a menu
    end
end $$

|[partypkmn_draw1]| function(a) browse_draw1(a, S_CURSOR_PARTY_PKMN) end $$
|[partypkmn_draw2]| function() draw2_pokeinfo(@S_CURSOR_PARTY_PKMN) end $$
|[partypkmn_draw3]| function() draw3_pokeinfo(@S_CURSOR_PARTY_PKMN) end $$

|[partymoves_init]| function(a)
    a.moveset = {}
    local movedict = {}
    local party = get_party(@S_CUR_PARTY)
    local partypkmn = party[@S_PARTY_PKMN_NUM+1]

    for i=1,4 do
        add(a.moveset, {
            name=partypkmn.moves[i] and c_moves[partypkmn.moves[i]].name or "empty",
            func=function(a, game)
                game:push'partymovesel'
            end
        })
    end
end $$

|[partymoves_update]| function(a) menu_update(a, S_CURSOR_PARTYMOVES, a.moveset) end $$
|[partymoves_draw1]|  function(a) menu_draw1 (a, S_CURSOR_PARTYMOVES, a.moveset) end $$

|[partymoves_draw2]| function(a)

end $$

|[partymoves_draw3]| function(a)

end $$


-- TODO: add a check so there are no duplicate moves in the moveset when saving.
-- TODO: maybe make it so you don't need a memory address with menu.
-- TODO: redo move db
|[partymovesel_init]| function(a)
    -- should always start at 0, since every pokemon is different
    poke2(S_CURSOR_PARTYMSEL, 0)

    a.movelist = {}
    local movedict = {}
    local party = get_party(@S_CUR_PARTY)
    local partypkmn = party[@S_PARTY_PKMN_NUM+1]
    foreach(partypkmn.moves, function(move) movedict[move] = true end)

    local pkmn = c_pokemon[partypkmn.num]
    printh(pkmn.name)

    for m in all(pkmn.moves_natural) do
        if not movedict[m] then
            movedict[m] = true

            add(a.movelist, {
                name=c_moves[m].name,
                func=function(a, game)
                    local party = get_party(@S_CUR_PARTY)
                    local partypkmn = party[@S_PARTY_PKMN_NUM+1]
                    partypkmn.moves[@S_CURSOR_PARTYMOVES+1] = m
                    save_party(@S_CUR_PARTY, party)
                    game:pop()
                end
            })
        end
    end
end $$

|[partymovesel_update]| function(a) menu_update(a, S_CURSOR_PARTYMSEL, a.movelist) end $$
|[partymovesel_draw1]|  function(a) menu_draw1 (a, S_CURSOR_PARTYMSEL, a.movelist) end $$
|[partymovesel_draw2]|  function(a) end $$
|[partymovesel_draw3]|  function(a) end $$

    --partymoves;   update,%partymoves_update,   draw1,%partymoves_draw1,   draw2,%editparty_draw2, draw3,%partymoves_draw3;
