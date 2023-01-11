|[party_update]| function(a)
    if g_bpu then poke(S_CUR_PARTY, max(0, @S_CUR_PARTY-1)) end
    if g_bpd then poke(S_CUR_PARTY, min(2, @S_CUR_PARTY+1)) end

    if g_bpl then poke(S_BROWSE_PKMN, (@S_BROWSE_PKMN-1)%152) end
    if g_bpr then poke(S_BROWSE_PKMN, (@S_BROWSE_PKMN+1)%152) end

    if g_bpo then a:pop() end
    if g_bpx then a:push'editparty' end
end $$

|[party_draw1]| function(a)
    draw_party_screen(@S_CUR_PARTY)
end $$

|[party_draw2]| function(a)
    zprint("party #"..@S_CUR_PARTY+1, 46/2, 4, 1, 0)
end $$

|[party_draw3]| function(a)
    print_draw3_message("please", "select a", "party")
end $$

function print_draw3_message(top, mid, bot)
    rectfill(0,0,45,20,1)
    zprint(top, 46/2, 1,  13, 0)
    zprint(mid, 46/2, 8,  13, 0)
    zprint(bot, 46/2, 15, 13, 0)
end

function draw_party_screen(sel, party1, party2, party3)
    rectfill(0,0,39,49,13)

    local drawbg = function(yoff, party)
        rect(-1, yoff-1, 40, yoff+7, 1)

        for i=1,6 do
            get_pokemon(party[i] and party[i].num or -1).draw(5+(i-1)*6, 4+yoff, 5, .2)
        end
    end

    local ty = 0+sel*8
    rectfill( 0, ty, 39, ty+23, 6)
    -- rect    ( -1, ty, 40, ty+23, 13)

    local selparty = get_party(sel)
    for i=1,6 do
        get_pokemon(selparty[i] and selparty[i].num or -2).draw(8+(i-1)%3*12, ty+6+(i-1)\3*12, 13, .5)
    end

    drawbg((sel*8+25)  %41, get_party((sel+1)%3))
    drawbg((sel*8+25+8)%41, get_party((sel+2)%3))
end

c_party_memlocs = zobj[[0,S_PARTY1, 1,S_PARTY2, 2,S_PARTY3]]
function get_party(party_index) -- 0 to 2
    local mem = c_party_memlocs[party_index]
    local party, party_len = {}, peek(mem) % 7

    for i=1,party_len do
        local memstart = mem+1+(i-1)*5
        local moves = {}
        for i=1,4 do add(moves, peek(memstart+i)) end
        add(party, { num=peek(memstart), moves=moves })
    end
    return party
end

function save_party(party_index, party) -- 0 to 2
    local mem = c_party_memlocs[party_index]
    local partylen = max(0, min(#party, 6))
    poke(mem, partylen)

    for i=1,min(#party, 6) do
        local memstart = mem+1+(i-1)*5
        local pkmn = party[i]

        poke(memstart, pkmn.num)
        for i=1,4 do
            poke(memstart+i, (pkmn.moves or {})[i] or 0)
        end
    end
end
