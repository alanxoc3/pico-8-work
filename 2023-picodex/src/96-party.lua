|[party_update]| function(a)
    if g_bpu then poke(S_CUR_PARTY, max(0, @S_CUR_PARTY-1)) end
    if g_bpd then poke(S_CUR_PARTY, min(2, @S_CUR_PARTY+1)) end

    if g_bpl then poke(S_BROWSE_PKMN, (@S_BROWSE_PKMN-1)%152) end
    if g_bpr then poke(S_BROWSE_PKMN, (@S_BROWSE_PKMN+1)%152) end

    if g_bpo then a:load'main' end
end $$

|[party_draw1]| function(a)
    draw_party_screen(@S_CUR_PARTY, @S_BROWSE_PKMN, (@S_BROWSE_PKMN+1)%152, (@S_BROWSE_PKMN+2)%152, (@S_BROWSE_PKMN+3)%152, (@S_BROWSE_PKMN+4)%152, (@S_BROWSE_PKMN+5)%152)
end $$

|[party_draw2]| function(a)
    zprint("party #"..@S_CUR_PARTY+1, 46/2, 4, 1, 0)
end $$

|[party_draw3]| function(a)
    print_draw3_message("select", "your", "party")
end $$

function print_draw3_message(top, mid, bot)
    rectfill(0,0,45,20,1)
    zprint(top, 46/2, 1,  13, 0)
    zprint(mid, 46/2, 8,  13, 0)
    zprint(bot, 46/2, 15, 13, 0)
end

function draw_party_screen(sel,...)
    rectfill(0,0,39,49,13)
    local poks = {...}

    local drawbg = function(yoff)
        rect(-1, yoff-1, 40, yoff+7, 1)
        for i=0,5 do get_pokemon(poks[i+1]).draw(5+i*6, 4+yoff, 5, .2) end
    end

    local ty = 0+sel*8
    rectfill( 0, ty, 39, ty+23, 6)
    rect    ( -1, ty, 40, ty+23, 13)

    local locs = zobj[[
        0;,10,12,1;
        1;,25,9, .5;
        2;,35,9, .375;
        3;,24,18,.2;
        4;,30,18,.2;
        5;,36,18,.2;
    ]]

    for i=0,5 do get_pokemon(poks[i+1]).draw(locs[i][1], ty+locs[i][2], 13, locs[i][3]) end

    drawbg((sel*8+25)  %41)
    drawbg((sel*8+25+8)%41)
end
