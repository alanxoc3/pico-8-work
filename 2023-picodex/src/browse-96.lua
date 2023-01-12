|[browse_update]| function(a)
    browse_update(a, S_CURSOR_BROWSE)
    if g_bpx then a:push'browsestat' end
end $$

|[browse_draw1]| function(a)
    browse_draw1(a, S_CURSOR_BROWSE)
end $$

|[browse_draw2]| function() draw2_pokeinfo(@S_CURSOR_BROWSE) end $$
|[browse_draw3]| function() draw3_pokeinfo(@S_CURSOR_BROWSE) end $$

|[browsestat_update]| function(a)
    browseupdate_shared(a, S_CURSOR_BROWSE)

    if g_bpu then poke(S_BROWSE_SCREEN, max(0, @S_BROWSE_SCREEN-1)) end
    if g_bpd then poke(S_BROWSE_SCREEN, min(1, @S_BROWSE_SCREEN+1)) end

    if g_bpx then sfx(flr(rnd(9))) end
end $$

|[browsestat_draw1]| function(a)
    local pkmn = get_pokemon(@S_CURSOR_BROWSE)
    local style = c_bg_styles[c_types[pkmn.type1].bg]
    rectfill(0,0,39,39,style.bg)

    if @S_BROWSE_SCREEN == 0 then
        rectfill(0,32,39,39,style.aa)
        pkmn.draw(20, 20, style.aa, 2, 2)
    elseif @S_BROWSE_SCREEN == 1 then
        rectfill(0,16,39,39,style.aa)
        pkmn.draw(20, 10, style.aa, 1)
        rectfill(0,21,39,39,1)
        rectfill(6,21,33,39,7)

        print("a",1,22,13) print("h",36,22,13)
        print("d",1,28,13) print("s",36,28,13)
        print("*",1,34,13) print("t",36,34,13)

        rectfill(19,20,20,39,1)
        rectfill(0,20,39,20,1)

        local total = pkmn.attack + pkmn.hp + pkmn.defence + pkmn.speed + pkmn.special
        print(pkmn.attack, 7,  2+20, 13)  zprint(pkmn.hp, 35, 2+20,  13, 1)
        print(pkmn.defence, 7,  8+20, 13)  zprint(pkmn.speed, 35, 8+20,  13, 1)
        print(pkmn.special, 7,  14+20, 13) zprint(total, 35, 14+20, 13, 1)
    end
end $$

function set_browse(delta, mem)
    poke(mem, (@mem+delta)%152)
    if @mem == 0 and @S_MISSINGNO == 0 then
        set_browse(sgn(delta), mem) -- sgn can't be zero
    end
end

function browseupdate_shared(a, mem)
    set_browse(0, mem)
    if g_bpl then set_browse(-1, mem) end
    if g_bpr then set_browse(1, mem)  end
    if g_bpo then a:pop() end
end

function browse_update(a, mem)
    browseupdate_shared(a, mem)

    if g_bpu then set_browse(-4, mem) end
    if g_bpd then set_browse(4, mem)  end
end

function browse_draw1(a, mem)
    local c, v = peek(mem), peek(mem+1)
    local pkmn = get_pokemon(c)

    if c\4 < v   then v = c\4   end
    if c\4 > v+3 then v = c\4-3 end

    v = max(0, min(152/4-4, v))

    for j=0,3 do
        for i=0,3 do
            get_pokemon((v+j)*4+i).draw(i*10+5, j*10+5, 5, .375)
        end
    end

    local x, y = (c%4)*10+5, (c\4-v)*10+5
    if (c)%4 == 0 then x+=1 end
    if (c)%4 == 3 then x-=1 end
    if (c)\4-v == 0 then y+=1 end
    if (c)\4-v == 3 then y-=1 end
    rectfill(x-7-1,y-7-1,x+6+1,y+6+1,13)
    rectfill(x-6-1,y-6-1,x+5+1,y+5+1,6)
    pkmn.draw(x, y, 13, .5)
    rect    (x-7  ,y-7  ,x+6  ,y+6  ,1)

    poke(mem+1, v)
end

function draw2_pokeinfo(num)
    zprint(get_pokemon(num).name, 46/2, 4, 1, 0)
end

function draw3_pokeinfo(num)
    local pkmn = get_pokemon(num)
    rectfill(0,0,46,6,1)

    zprint(format_num(pkmn.num),  23, 1,  13, 0)
    zprint(c_types[pkmn.type1].name, 23, 8, 1, 0)
    if pkmn.type2 then
        rectfill(0,14,46,20,1)
        zprint(c_types[pkmn.type2].name, 23, 15, 13, 0)
    end
end

-- Draw a pokemon by number. Pokemon is centered at x & y. sw and sh can be decimals.
-- Num 1 would be bulbasaur.
g_loaded_row = 16 -- default corresponds to the top row in the "129-151.p8" file.
function draw_pkmn(num, x, y, sw, sh)
    if num < 0 then rectfill(x-1, y-1,x,y-num%2,6) return end

    sw = sw or 1
    sh = sh or 1

    local row = num/8\1
    local col = num%8

    if row ~= g_loaded_row then
        g_loaded_row = row
        memcpy(0x0000, 0x8000+0x400*row, 0x400)
    end

    local w, h = 16*sw, 16*sh
    sspr(col*16, 0, 16, 16, x-w/2, y-h/2, w, h)
end

function draw_pkmn_out(num, x, y, col, scale_factor, outline_width)
    scale_factor = scale_factor or 1
    outline_width = outline_width or 1

    for c=1,15 do pal(c,col) end
    for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num, x-outline_width, y+i, scale_factor, scale_factor) end
    for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num, x+outline_width, y+i, scale_factor, scale_factor) end

    for c=1,15 do pal(c,1) end
    for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num, x+i, y, scale_factor, scale_factor) end
    for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num, x, y+i, scale_factor, scale_factor) end

    for c=1,15 do pal(c, c) end
    draw_pkmn(num, x, y, scale_factor, scale_factor)
end

function format_num(num)
    local str = ''..num
    for i=#str+1,3 do
        str = '0'..str
    end
    return '#'..str
end

function get_pokemon(num)
    return c_pokemon[num]
end
