-- todo: combine scrollable logic maybe (credits + browse stat)
-- todo: make browse stat screen scrollable
function draw2_pokeinfo(pkmn) print_draw2_message("pkmn "..format_num(pkmn.num)) end

function draw3_pokeinfo(pkmn)
    print_draw3_message{'.'..pkmn.name, c_types[pkmn.type1].name, pkmn.type2 and c_types[pkmn.type2].name or ''}
end

-- Draw a pokemon by number. Pokemon is centered at x & y. sw and sh can be decimals.
-- Num 1 would be bulbasaur.
g_loaded_row = 16 -- default corresponds to the top row in the "129-151.p8" file.
function draw_pkmn(num, x, y, sw, sh)
    if num < 0 then rectfill(x-1, y-1,x,y,6) return end

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

-- this is for populating the pokemon info menu (sometimes called browsestat in code)
function update_stat_menu(menu, pkmn)
       -- ;,"basestat,hp,spd,spc,att,def"
       --;;,"stats,hp,spd,spc,att,def,acc,eva,lvl"
       --;;,"flags,burn,paralyze,poison,sleep,freeze,confuse"
       --;;,"flamethwr,pp,kj

    menu:refresh{}
    add(menu, {pkmn=pkmn.num})
    add(menu, {hidden=true})
    add(menu, {name="lvl 50", style=3})
    add(menu, {name=pkmn.hp..'/'..pkmn.maxhp})

    foreach(zobj[[
        ;key,special, name,"spc"
       ;;key,attack,  name,"att"
       ;;key,defense, name,"def"
       ;;key,speed,   name,"spd"
       ;;key,total,   name,"tot"
       --;;key,level,   name,"lvl"
       ;;key,accuracy,name,"acc"
       ;;key,evasion, name,"eva"
    ]], function(pair)
        if not pair.key then
            add(menu, { name=pair.name, style=3 })
        elseif pkmn[pair.key] then
            add(menu, { name=pair.name.." "..pkmn[pair.key] })
        end
    end)
end
