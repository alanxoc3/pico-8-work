|[browse_update]| function(a)
    browse_update(a, 'browse')
    if g_bpx then a:push'browsestat' end
end $$

|[browse_draw1]| function(a)
    browse_draw1(a, 'browse')
end $$

|[browse_draw2]| function() draw2_pokeinfo(get_browse_pokemon(g_cursors.browse)) end $$
|[browse_draw3]| function() draw3_pokeinfo(get_browse_pokemon(g_cursors.browse)) end $$

|[browsestat_update]| function(a)
    browseupdate_shared(a, 'browse')

    if g_bpu then poke(S_BROWSE_SCREEN, max(0, @S_BROWSE_SCREEN-1)) end
    if g_bpd then poke(S_BROWSE_SCREEN, min(1, @S_BROWSE_SCREEN+1)) end

    if g_bpx then sfx(flr(rnd(9))) end
end $$

|[browsestat_draw1]| function(a)
    local pkmn = get_browse_pokemon(g_cursors.browse)
    local style = c_bg_styles[c_types[pkmn.type1].bg]
    rectfill(0,0,39,39,style.bg)

    if @S_BROWSE_SCREEN == 0 then
        rectfill(0,32,39,39,style.aa)
        pkmn.draw(20, 20, style.aa, 2, 2)
    elseif @S_BROWSE_SCREEN == 1 then
        rectfill(0,16,39,39,style.aa)
        pkmn.draw(20, 10, style.aa)
        rectfill(0,21,39,39,1)
        rectfill(6,21,33,39,7)

        zcall(print, [[
             ;,"a",1,22,13
            ;;,"h",36,22,13
            ;;,"d",1,28,13
            ;;,"s",36,28,13
            ;;,"*",1,34,13
            ;;,"t",36,34,13
        ]])

        rectfill(19,20,20,39,1)
        rectfill(0,20,39,20,1)

        local total = pkmn.attack + pkmn.hp + pkmn.defence + pkmn.speed + pkmn.special
        print(pkmn.attack, 7,  2+20, 13)  zprint(pkmn.hp, 35, 2+20,  13, 1)
        print(pkmn.defence, 7,  8+20, 13)  zprint(pkmn.speed, 35, 8+20,  13, 1)
        print(pkmn.special, 7,  14+20, 13) zprint(total, 35, 14+20, 13, 1)
    end
end $$

function set_browse(delta, key)
    local newval = g_cursors[key]+delta
    if newval == mid(1, #g_available_pokemon, newval) then
        g_cursors[key] = newval
    end

    g_cursors[key] = mid(1, #g_available_pokemon, g_cursors[key])
end

function browseupdate_shared(a, key)
    set_browse(0, key)
    if g_bpl then set_browse(-1, key) end
    if g_bpr then set_browse(1, key)  end
    if g_bpo then a:pop() end
end

function browse_update(a, key)
    browseupdate_shared(a, key)

    if g_bpu then set_browse(-4, key) end
    if g_bpd then set_browse(4, key)  end
end

function browse_draw1(a, key)

    rectfill(0,0,39,39,1)

    local c, v = g_cursors[key]-1, g_views[key]
    local pkmn = get_browse_pokemon(c+1)
    local xo, yo, pad = 5, 10, 10
    local perow = 4

    rectfill(0,-v*10+1+4,39,((max(#g_available_pokemon,9)-1)\perow-v+2)*10-1-5,13)

    if c\perow < v   then v = c\perow   end
    if c\perow > v+2 then v = c\perow-2 end

    v = max(0, min(152\perow, v))

    local x, y = (c%perow)*pad+xo, (c\perow-v)*pad+yo
    rectfill(x-6-1,y-6-1,x+5+1,y+5+1,5)

    for j=-1,3 do
        for i=0,3 do
            get_browse_pokemon((v+j)*perow+i+1).draw(i*pad+xo, j*pad+yo, 5, .375, .375)
        end
    end

    rectfill(x-5-1,y-5-1,x+4+1,y+4+1,6)
    pkmn.draw(x, y, 13, .375, .375)
    rect    (x-6-0  ,y-6-0  ,x+5+0  ,y+5+0  ,1)

    g_views[key] = v
end

function draw2_pokeinfo(pkmn) zprint(pkmn.name, 46/2, 4, 1, 0) end

function draw3_pokeinfo(pkmn)
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

function draw_pkmn_out(num, x, y, col, xscale, yscale)
    xscale = xscale or 1
    yscale = yscale or 1
    local outline_width = max(abs(xscale), 1) \ 1

    for c=1,15 do pal(c,col) end
    for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num, x-outline_width, y+i, xscale, yscale) end
    for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num, x+outline_width, y+i, xscale, yscale) end

    for c=1,15 do pal(c,1) end
    for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num, x+i, y, xscale, yscale) end
    for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num, x, y+i, xscale, yscale) end

    for c=1,15 do pal(c, c) end
    draw_pkmn(num, x, y, xscale, yscale)
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

function get_browse_pokemon(num)
    return c_pokemon[g_available_pokemon[num]] or {draw=nop}
end
