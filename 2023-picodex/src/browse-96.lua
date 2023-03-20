|[f_pkmn_available]| function(_ENV)
    -- non-browse pokemon are always available (credit, edit, and battle) the browse attribute represents that
    if num >= 0 then -- shouldn't be -1
        return not browse or @(S_POKEMON+num) > 0
    end
end $$

|[f_draw2_pokeinfo]| function(pkmn)
    f_print_draw2_message("pkmn #"..pkmn.num)
end $$

|[f_draw3_pokeinfo]| function(pkmn)
    if pkmn:f_pkmn_available() then
        f_print_draw3_message(pkmn.name.."|"..c_types[pkmn.type1].name.."|"..c_types[pkmn.type2].name)
    else
        f_print_draw3_message"?????????|????|??????"
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

|[f_draw_pkmn_out]| function(_ENV, x, y, col, xscale, yscale)
    -- todo: maybe combine this logic with f_draw_pkmn_out itself (since this is the only instance).
    local num = _ENV:f_pkmn_available() and num or -1
    if num == P_PIKACHU and _ENV:f_pkmn_has_move(M_SURF)    then num = 152 end
    if num == P_PSYDUCK and _ENV:f_pkmn_has_move(M_AMNESIA) then num = 153 end

    -- substitute check should go after pika/psyduck checks above, for if pika/psy know substitute
    if substitute and substitute > 0 then num = 154 end

    -- todo: substitute should trump fly/dig
    if not isactive or major ~= C_MAJOR_FAINTED and not invisible and not (moveturn ~= 0 and curmove.ofunc == f_move_flydig) then
        if num < 0 then _spr(107, x-4, y-4) return end
        xscale, yscale = xscale or 1, yscale or 1
        local outline_width = _max(_abs(xscale), 1) \ 1

        f_zcall(function(color, v1, v2, v3, v4)
            for c=1,15 do _pal(c,color) end
            for i=-outline_width,outline_width,outline_width*2 do
                f_draw_pkmn(num, x+(v1 or i), y+(v2 or i), xscale, yscale)
                f_draw_pkmn(num, x+(v3 or i), y+(v4 or i), xscale, yscale) 
            end
        end, [[
             ;,@, @, %c_no, @, %c_no
            ;;,1, %c_no, 0, 0, %c_no
        ]], col, -outline_width, outline_width)

        _pal() f_draw_pkmn(num, x, y, xscale, yscale)
    end
end $$

-- this is for populating the pokemon info menu (sometimes called browsestat in code)
|[f_update_stat_menu]| function(menu, pkmn)
    menu:refresh{}

    f_zobj_set(menu, [[
        ;pkmn,@
       ;;hidden,%c_yes
       ;;name,"lvl C_LEVEL", style,5
       ;;name,@
    ]], pkmn, (pkmn.hp or pkmn.maxhp)..'/'..pkmn.maxhp)

    _foreach(f_zobj[[
        ;key,special, name,"spc"
       ;;key,attack,  name,"att"
       ;;key,defense, name,"def"
       ;;key,speed,   name,"spd"
       ;;key,total,   name,"tot"
    ]], function(pair)
        if not pair.key then
            _add(menu, { name=pair.name, style=5 })
        elseif pkmn[pair.key] then
            _add(menu, { name=pair.name.." "..pkmn[pair.key] })
        end
    end)

    f_zcall(function(name, key)
        if #c_pokemon[pkmn.num][key] > 0 then
            _add(menu, {name=name, style=5})
            _foreach(c_pokemon[pkmn.num][key], function(m)
                _add(menu, {name=c_moves[m].name})
            end)
        end
    end, [[
         ;,"learn",moves_natural
        ;;,"teach",moves_teach
        ;;,"event",moves_event
    ]])
end $$
