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
    len,6;
    0; name,"info",    state,browse,   desc,"view/pokemon/info";
    1; name,"moves",   state,credits,  desc,"by/amorg/games";
    2; name,"switch",     state,fight,    desc,"pokemon/battle/simulator";
    3; name,"delete",     state,games,    desc,"minigames/and/quizzes";
    4; name,"party",     state,party,    desc,"change/your/teams";
    5; name,"settings",  state,settings, desc,"customize/this/picodex";
]]

|[partyaction_update]| function(a)
    if g_bpo then a:pop() end
end $$

|[partyaction_draw1]| function(a)

end $$

|[partyaction_draw2]| function(a)

end $$

|[partyaction_draw3]| function(a)

end $$
