function set_browse(delta)
    poke(S_BROWSE_PKMN, (@S_BROWSE_PKMN+delta)%152)
    if @S_BROWSE_PKMN == 0 and @S_MISSINGNO == 0 then
        set_browse(sgn(delta))
    end
end

|[browse_update]| function(a)
    set_browse'0'
    if g_bpl then set_browse'-1' end
    if g_bpr then set_browse'1'  end

    if a.list_view then
        if g_bpu then set_browse'-4' end
        if g_bpd then set_browse'4'  end

        if g_bpo then a:load'main' end
        if g_bpx then a.list_view = false end
    else
        if g_bpu then poke(S_BROWSE_SCREEN, max(0, @S_BROWSE_SCREEN-1)) end
        if g_bpd then poke(S_BROWSE_SCREEN, min(1, @S_BROWSE_SCREEN+1)) end

        if g_bpo then a.list_view = true end
        if g_bpx then sfx(flr(rnd(9))) end
    end
end $$

|[browse_draw1]| function(a)
    local pkmn = get_pokemon(@S_BROWSE_PKMN)

    if a.list_view then
        if @S_BROWSE_PKMN\4 < @S_BROWSE_VIEW   then poke(S_BROWSE_VIEW, @S_BROWSE_PKMN\4  ) end
        if @S_BROWSE_PKMN\4 > @S_BROWSE_VIEW+3 then poke(S_BROWSE_VIEW, @S_BROWSE_PKMN\4-3) end

        poke(S_BROWSE_VIEW, max(0, @S_BROWSE_VIEW))
        poke(S_BROWSE_VIEW, min(152/4-4, @S_BROWSE_VIEW))

        for j=0,3 do
            for i=0,3 do
                get_pokemon((@S_BROWSE_VIEW+j)*4+i).draw(i*10+5, j*10+5, 5, .375)
            end
        end

        local x, y = (@S_BROWSE_PKMN%4)*10+5, (@S_BROWSE_PKMN\4-@S_BROWSE_VIEW)*10+5
        if (@S_BROWSE_PKMN)%4 == 0 then x+=1 end
        if (@S_BROWSE_PKMN)%4 == 3 then x-=1 end
        if (@S_BROWSE_PKMN)\4-@S_BROWSE_VIEW == 0 then y+=1 end
        if (@S_BROWSE_PKMN)\4-@S_BROWSE_VIEW == 3 then y-=1 end
        rectfill(x-7-1,y-7-1,x+6+1,y+6+1,13)
        rectfill(x-6-1,y-6-1,x+5+1,y+5+1,6)
        pkmn.draw(x, y, 13, .5)
        rect    (x-7  ,y-7  ,x+6  ,y+6  ,1)
    else
        local style = c_bg_styles[c_types[pkmn.type1].bg]
        rectfill(0,0,39,39,style.bg)

        if @S_BROWSE_SCREEN == 0 then
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
    end
end $$

|[browse_draw2]| function(a)
    zprint(get_pokemon(@S_BROWSE_PKMN).name, 46/2, 4, 1, 0)
end $$

|[browse_draw3]| function(a)
    local pkmn = get_pokemon(@S_BROWSE_PKMN)
    rectfill(0,0,46,6,1)

    zprint(format_num(pkmn.num),  23, 1,  13, 0)
    zprint(c_types[pkmn.type1].name, 23, 8, 1, 0)
    if pkmn.type2 then
        rectfill(0,14,46,20,1)
        zprint(c_types[pkmn.type2].name, 23, 15, 13, 0)
    end
end $$

-- Draw a pokemon by number. Pokemon is centered at x & y. sw and sh can be decimals.
-- Num 1 would be bulbasaur.
g_loaded_row = 16 -- default corresponds to the top row in the "129-151.p8" file.
function draw_pkmn(num, x, y, sw, sh)
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
