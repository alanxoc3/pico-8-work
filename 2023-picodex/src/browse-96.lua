|[browse_update]| function(game) game.menu_browse:update(game) end $$
|[browse_draw1]| function(game) game.menu_browse:draw1() end $$
|[browse_draw2]| function(game) draw2_pokeinfo(get_browse_pokemon(game.menu_browse.c+1)) end $$
|[browse_draw3]| function(game) draw3_pokeinfo(get_browse_pokemon(game.menu_browse.c+1)) end $$

|[browse_init]| function(game)
    game.menu_browse:refresh(
        g_available_pokemon,
        function(num) return {select=function(entry, game) game:push'browsestat' end, num=num} end
    )
end $$

|[browsestat_update]| function(game)
    if g_bpl then game.menu_browse:set(-1) end
    if g_bpr then game.menu_browse:set(1)  end
    if g_bpo then game:pop() end

    if g_bpu then poke(S_BROWSE_SCREEN, max(0, @S_BROWSE_SCREEN-1)) end
    if g_bpd then poke(S_BROWSE_SCREEN, min(1, @S_BROWSE_SCREEN+1)) end

    if g_bpx then sfx(flr(rnd(9))) end
end $$

|[browsestat_draw1]| function(game)
    local pkmn = get_browse_pokemon(game.menu_browse.c+1)
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
