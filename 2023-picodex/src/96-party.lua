|[party_update]| function(a)
    if g_bpu then poke(S_CUR_PARTY, max(0, @S_CUR_PARTY-1)) end
    if g_bpd then poke(S_CUR_PARTY, min(2, @S_CUR_PARTY+1)) end

    if g_bpl then poke(S_BROWSE_PKMN, (@S_BROWSE_PKMN-1)%pkmn_len()) end
    if g_bpr then poke(S_BROWSE_PKMN, (@S_BROWSE_PKMN+1)%pkmn_len()) end

    if g_bpo then a:load'main' end
end $$

|[party_draw1]| function(a)
    draw_party_screen(@S_CUR_PARTY, @S_BROWSE_PKMN+2, @S_BROWSE_PKMN+3, @S_BROWSE_PKMN+4, @S_BROWSE_PKMN+5, @S_BROWSE_PKMN+6, @S_BROWSE_PKMN+7)
end $$

|[party_draw2]| function(a)
end $$

|[party_draw3]| function(a)
end $$

function draw_party_screen(sel,...)
    rectfill(0,0,39,49,13)
    local poks = {...}

    local drawbg = function(yoff)
        rect(-1, yoff-1, 40, yoff+8, 1)
        for i=0,5 do draw_pkmn_out(poks[i+1], 5+i*6, 4+yoff, 1, .25, 5) end
    end

    local ty = 0+sel*9
    rectfill( 0, ty-1, 39, ty+22, 6)
    rect    (-1, ty-1, 40, ty+22, 1)

    local locs = zobj[[
        0;,10,11,1;
        1;,25,7, .5;
        2;,35,8, .375;
        3;,24,17,.325;
        4;,31,17,.2;
        5;,37,17,.2;
    ]]

    for i=0,5 do draw_pkmn_out(poks[i+1], locs[i][1], ty+locs[i][2], 1, locs[i][3], 13) end

    drawbg((sel*9+23)  %41, (sel+1)%3)
    drawbg((sel*9+23+9)%41, (sel-1)%3)
end
