-- todo: beep when lr on most lr of browsestat
-- todo: combine scrollable logic maybe (credits + browse stat)
-- todo: make browse stat screen scrollable
|[f_draw2_pokeinfo]| function(pkmn)
    f_print_draw2_message("pkmn "..f_format_num(pkmn.num))
end $$

|[f_draw3_pokeinfo]| function(num)
    local pkmn = c_pokemon[num] or {}
    if pkmn.available then
        f_print_draw3_message{'.'..pkmn.name, c_types[pkmn.type1].name, c_types[pkmn.type2].name}
    else
        f_print_draw3_message{".?????????", "????", "??????"}
    end
end $$

-- Draw a pokemon by number. Pokemon is centered at x & y. sw and sh can be decimals.
-- Num 1 would be bulbasaur.
g_loaded_row = 16 -- default corresponds to the top row in the "129-151.p8" file.
|[f_draw_pkmn]| function(num, x, y, sw, sh)
    sw = sw or 1
    sh = sh or 1

    local row = num/8\1
    local col = num%8

    if row ~= g_loaded_row then
        g_loaded_row = row
        _memcpy(0x0000, 0x8000+0x400*row, 0x400)
    end

    local w, h = 16*sw, 16*sh
    _sspr(col*16, 0, 16, 16, x-w/2, y-h/2, w, h)
end $$

|[f_draw_pkmn_out]| function(num, x, y, col, xscale, yscale)
    if num < 0 then _spr(107, x-4, y-4) return end

    xscale = xscale or 1
    yscale = yscale or 1
    local outline_width = _max(_abs(xscale), 1) \ 1

    for c=1,15 do _pal(c,col) end
    for i=-outline_width,outline_width,outline_width*2 do f_draw_pkmn(num, x-outline_width, y+i, xscale, yscale) end
    for i=-outline_width,outline_width,outline_width*2 do f_draw_pkmn(num, x+outline_width, y+i, xscale, yscale) end

    for c=1,15 do _pal(c,1) end
    for i=-outline_width,outline_width,outline_width*2 do f_draw_pkmn(num, x+i, y, xscale, yscale) end
    for i=-outline_width,outline_width,outline_width*2 do f_draw_pkmn(num, x, y+i, xscale, yscale) end

    for c=1,15 do _pal(c, c) end
    f_draw_pkmn(num, x, y, xscale, yscale)
end $$

|[f_format_num]| function(num)
    local str = ''..num
    for i=#str+1,3 do
        str = '0'..str
    end
    return '#'..str
end $$

|[f_get_pokemon]| function(num)
    return c_pokemon[num]
end $$

-- this is for populating the pokemon info menu (sometimes called browsestat in code)
|[f_update_stat_menu]| function(menu, pkmn)
       -- ;,"basestat,hp,spd,spc,att,def"
       --;;,"stats,hp,spd,spc,att,def,acc,eva,lvl"
       --;;,"flags,burn,paralyze,poison,sleep,freeze,confuse"
       --;;,"flamethwr,pp,kj

    menu:refresh{}
    _add(menu, {pkmn=pkmn.num})
    _add(menu, {hidden=true})
    _add(menu, {name="lvl 50", style=5})
    _add(menu, {name=(pkmn.hp or pkmn.maxhp)..'/'..pkmn.maxhp})

    _foreach(f_zobj[[
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
            _add(menu, { name=pair.name, style=5 })
        elseif pkmn[pair.key] then
            _add(menu, { name=pair.name.." "..pkmn[pair.key] })
        end
    end)

    _add(menu, {name="learn", style=5})
    _foreach(c_pokemon[pkmn.num].moves_natural, function(m)
        _add(menu, {name=c_moves[m].name})
    end)

    if #c_pokemon[pkmn.num].moves_teach > 0 then
        _add(menu, {name="teach", style=5})
        _foreach(c_pokemon[pkmn.num].moves_teach, function(m)
            _add(menu, {name=c_moves[m].name})
        end)
    end

    if #c_pokemon[pkmn.num].moves_event > 0 then
        _add(menu, {name="event", style=5})
        _foreach(c_pokemon[pkmn.num].moves_event, function(m)
            _add(menu, {name=c_moves[m].name})
        end)
    end
end $$
