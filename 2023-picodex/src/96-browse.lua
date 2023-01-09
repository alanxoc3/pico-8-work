-- Draw a pokemon by number. Pokemon is centered at x & y. sw and sh can be decimals.
-- Num 1 would be bulbasaur.
g_loaded_row = 16 -- default corresponds to the top row in the "129-151.p8" file.
function draw_pkmn(num, x, y, sw, sh)
    sw = sw or 1
    sh = sh or 1

    local row = (num-1)/8\1
    local col = (num-1)%8

    if row ~= g_loaded_row then
        g_loaded_row = row
        memcpy(0x0000, 0x8000+0x400*row, 0x400)
    end

    local w, h = 16*sw, 16*sh
    sspr(col*16, 0, 16, 16, x-w/2, y-h/2, w, h)
end

function draw_pkmn_out(num, x, y, orad, prad, col)
    orad = orad or 1
    prad = prad or 1

    for c=1,15 do pal(c,col) end
    for i=-orad,orad,orad*2 do draw_pkmn(num, x-orad, y+i, prad, prad) end
    for i=-orad,orad,orad*2 do draw_pkmn(num, x+orad, y+i, prad, prad) end

    for c=1,15 do pal(c,1) end
    for i=-orad,orad,orad*2 do draw_pkmn(num, x+i, y, prad, prad) end
    for i=-orad,orad,orad*2 do draw_pkmn(num, x, y+i, prad, prad) end

    for c=1,15 do pal(c, c) end
    draw_pkmn(num, x, y, prad, prad)
end

function pkmn_len()
    return @S_MISSINGNO ~= 0 and 152 or 151
end

|[browse_update]| function(a)
    if g_bpl then poke(S_BROWSE_PKMN, (@S_BROWSE_PKMN-1)%pkmn_len()) end
    if g_bpr then poke(S_BROWSE_PKMN, (@S_BROWSE_PKMN+1)%pkmn_len()) end
    if g_bpo then a:load'main' end
    if g_bpx then sfx(flr(rnd(9))) end
end $$

function format_num(num)
    local str = ''..num
    for i=#str+1,3 do
        str = '0'..str
    end
    return '#'..str
end

|[browse_draw1]| function(a)
    local type = c_bg_styles[0]-- c_types[c_pokemon[@S_BROWSE_PKMN+1].type1].bg ]
    rectfill(0,0,39,39,5)

    rectfill(0, 9, 39, 30, 6)
    rect    (-1, 9, 40, 30, 1)
    for j=0,2 do
        local y = 5+j*15
        local xoff = 5
        local siz = .25
        if j == 1 then siz = .5 y -= 4 xoff=10

        draw_pkmn_out((@S_BROWSE_PKMN+1)%151, xoff-1, y+4, 1, .875, 5)
        for i=2,1,-1 do draw_pkmn_out((@S_BROWSE_PKMN+1+i+j*8)%151, 12+i    *11, y, 1, siz, 5) end
        for i=3,5    do draw_pkmn_out((@S_BROWSE_PKMN+1+i+j*8)%151, 21+(i-3)*7, y+9, 1, .25, 5) end

        else
            for i=0,5 do draw_pkmn_out((@S_BROWSE_PKMN+1+i+j*8)%151, xoff+i*6, y, 1, siz, 5) end
        end
    end
end $$

|[browse_draw2]| function(a)
    zprint(c_pokemon[@S_BROWSE_PKMN+1].name, 46/2, 4, 1, 0)
end $$

|[browse_draw3]| function(a)
    rectfill(0,0,46,22,13)
    rectfill(0,0,6,46,1)

    zprint(""..(c_pokemon[@S_BROWSE_PKMN+1].height/10).." m",  9, 3-1,  1, -1)
    zprint(""..(c_pokemon[@S_BROWSE_PKMN+1].width/10).." kg", 9, 9-1,  1, -1)
    -- zprint("transport", 9, 15-1,  1, -1)

    print("h", 2, 3-1, 13) --
    print("w", 2, 9-1, 13)-- 
    -- print("s", 2, 15-1, 13)-- 


    --zprint("ABCDEFGHIJKLM", 2+4, 1, 1, -1)
    --zprint("ABCDEFGHIJKLM", 2+4, 6, 1, -1)
    --zprint("ABCDEFGHIJKLM", 2+4, 11, 1, -1)
    --zprint("ABCDEFGHIJKLM", 2+4, 16, 1, -1)
end $$
