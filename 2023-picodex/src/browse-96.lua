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
        f_print_draw3_message"none|n/a|"
    end
end $$

-- Draw a pokemon by number. Pokemon is centered at x & y. sw and sh can be decimals.
-- Num 1 would be bulbasaur.
g_loaded_row = 16 -- default corresponds to the top row in the "129-151.p8" file.
|[f_draw_pkmn_out]| function(_ENV, x, y, style, xscale, yscale, is_thick)
    local num, mini = _ENV:f_pkmn_available() and num or -1, 8*(minimize or 1)
    xscale *= mini yscale *= mini

    local drawpkmn = function(x, y)
        local row, col = num/8\1, num%8

        if row ~= g_loaded_row then
            _g.g_loaded_row = row
            _memcpy(0x0000, 0x8000+0x400*row, 0x400)
        end

        _sspr(col*16, 0, 16, 16, x-xscale, y-yscale, xscale*2, yscale*2)
    end

    -- substitute check should go after pika/psyduck checks above, for if pika/psy know substitute
    if substitute and substitute > 0 then num = 152 end

    if not isactive or major ~= C_MAJOR_FAINTED and not invisible and not (moveturn ~= 0 and curmove.ofunc == f_move_flydig) then
        if num < 0 then _spr(203, x-4, y-4) return end
        local outline_width = 1

        local outline_func = function(color, v1, v2, v3, v4, outline_width)
            if color > 0 then
                for c=1,15 do _pal(c,color) end
                for i=-1,1,2 do
                    drawpkmn(x+(v1 or i*outline_width), y+(v2 or i*outline_width))
                    drawpkmn(x+(v3 or i*outline_width), y+(v4 or i*outline_width)) 
                end
            end
        end

        if is_thick then
            f_zcall(outline_func, [[
                bg,@

                ;;,~bg, -2,    ~c_no, 2,     ~c_no, 1
                ;;,~bg, ~c_no, -2,    ~c_no, 2,     1
                ;;,~bg, -2,    0,     2,     0,     1
                ;;,~bg, 0,     -2,    0,     2,     1

            ]], style.bg)
        end

        f_zcall(outline_func, [[
             ;,@, -1,    ~c_no, 1, ~c_no, 1
            ;;,1, ~c_no, 0,     0, ~c_no, 1
        ]], style.aa)

        _pal() drawpkmn(x, y)
    end
end $$

