-- todo: pkmn cries. 19 sfx slots (8 per slot) could give me all 152 pkmn cries.
-- todo: 3 channels for song. 1 for picodex noise/cry.
-- game state funcs
|[f_moveup_init]| function()
    _sfx(-2,1) -- stop the creepy logo sound from looping
end $$

-- you can factory reset when the pokedex is closed
|[f_closed_init]| function(_ENV)
    _menuitem(1, "factory reset", function()
        _sfx(59,0)
        _memset(0x5e00, 0, 0x100)
        _ENV:start_timer('shaking', .5)
    end)
end $$

|[f_any_btn]| function()
    -- check for any button, besides pause button
    -- bits 6/7 are pause button related, so ignore those
    return _btn() & 0x3f ~= 0
end $$

|[f_closed_update]| function(_ENV)
    -- if player 1 pressed any button, go to the next state.
    if not f_any_btn() and backbuttonheld then
        backbuttonheld = false
        _ENV:load()
        _menuitem(1) -- %c_no factory reset now
    elseif f_any_btn() then
        backbuttonheld = true
        _menuitem(1) -- %c_no factory reset now
    end
end $$

-- todo: combine with f_draw_picodex below
|[f_draw_picodex2]| function(_ENV)
    _cls(0)
    local dfunc = function(xoff, yoff)
        f_zcamera(xoff, yoff, function()
            local off = 2
            f_zprint("aMORG gAMES", 64, 64+-4-128, 7, 0)
            f_zprint("pRESENTS",    64, 64+3 -128, 7, 0)
            f_zspr(102,                  64, off+9, 5, 1)
            f_zprint("a pICO-8 pOKEDEX sIM", 64, off+13, 7, 0)

            f_draw_picodex(
                _ENV:is_active'shaking',
                foldstate == 'open' and 1 or foldstate == 'closed' and -1 or (foldstate == 'opening' and -1 or 1)*_cos(_ENV:get_elapsed_percent(foldstate)/2),
                draw1, draw2,
                draw3, light,
                backbuttonheld,
                modes and modes.main.menu.c,
                modes and #modes.stack
            )
        end)
    end

    dfunc(0, 128+sin(_ENV:get_elapsed_percent'moveup'/4)*128)
end $$

-- utility funcs
|[f_minisfx]| function(num)
    g_picodex:start_timer((0+num <= 152) and 'pkmn' or 0+num, .25)
    _sfx(44+num\8, 0, num%8*4, 4)
end $$

-- |[f_stat_minisfx]| function() return stat'46' and g_last_minisfx                      end $$
|[f_beep_done]|    function() f_minisfx'152' end $$
|[f_beep_okay]|    function() f_minisfx'153' end $$
|[f_beep_back]|    function() f_minisfx'154' end $$
|[f_beep]|         function() f_minisfx'155' end $$

-- todo: try making logo go down when picodex goes down... or maybe black screen...
|[f_draw_picodex]| function(shaking, rotation, l_screen, tr_screen, br_screen, light, backbuttonheld, top_row_buttons, bot_row_buttons)
    -- f_zprint("picodex", 63, 20, 7, 0)
    f_zcamera(30-(rotation+1)*15+(shaking and _flr(_rnd(3)-1) or 0), 27, function()
        ----- LEFT SIDE SCREENS -----
        _rectfill(5, 16, 60, 85, light >= 4 and 13 or 5)
        if light >= 4 then f_draw_screen(14, 21, 40, 40, l_screen) end

        ----- LEFT SIDE PANELS ----- 
        _map(24, 0, 2,  1, 8, 3)
        _map(8,  0, 2,  9, 8,  11)

        ----- LEFT SIDE ADDONS -----
        f_zcall(function(l, s, off, on, flash, x, y)
            return _spr((light > l) and (g_picodex:is_active(s) and flash or on) or off, x, y)
        end, [[
             ;,0, 153,  132, 130, 131, 22, 3
            ;;,1, 154,  132, 129, 131, 17, 3
            ;;,2, 155,  132, 128, 131, 12, 3
            ;;,3, pkmn, 135, 133, 134, 6,  3
        ]])

        f_zcall(function(b, s1, s2, x, y)
            _spr(_btn(b) and s1 or s2, x, y)
        end, [[
             ;,0, 186, 154, 10, 77
            ;;,1, 188, 156, 26, 77
            ;;,2, 171, 139, 18, 73
            ;;,3, 187, 155, 18, 81
            ;;,4, 170, 138, 42, 77
            ;;,5, 172, 140, 50, 77
        ]])

        if stat'46' >= 0 then
            circ(53, 65, 5+sin(t()*2), 12)
        end

        ----- RIGHT SIDE -----
        if rotation < 0 then
            f_picodex_map(0, 2+64*(1-_abs(rotation)), _abs(rotation))
            if rotation == -1 and backbuttonheld then _spr(123, 6, 49) end
        elseif rotation > 0 then
            _rectfill(65+5-2, 9+5, 65+8*8*rotation-5-2, 9+11*8-5, light >= 4 and 13 or 5)

            if rotation == 1 and light >= 4 then
                f_draw_screen(71, 18, 46, 13, tr_screen)
                f_draw_screen(71, 67, 46, 21, br_screen)
            end

            f_picodex_map(16, 62, rotation)

            if rotation == 1 then
                if top_row_buttons then _spr(100, 70+(top_row_buttons\1%6)*8,  41) end
                if bot_row_buttons and bot_row_buttons > 0 then _spr(100, 70+(bot_row_buttons\1-1)%6*8,  49) end
            end
        end
    end)
end $$

-- started with: https://www.lexaloffle.com/bbs/?tid=38931
|[f_picodex_map]| function(cx,sx,sw)
    sw*=64
    for y=9,96 do
        _tline(sx,y,sx+sw-1,y,cx,y/8-1.125,8/sw,0)
    end
end $$

|[f_wobble_text]| function(text, x, y, color)
    local t1, t2 = "", ""
    for i=1,#text do
        local letter, switch = _sub(text, i, i), i%2==0
        t1 ..= switch and " " or letter
        t2 ..= switch and letter or " "
    end

    f_zprint(t1, x, y,   color, 0)
    f_zprint(t2, x, y+1, color, 0)
end $$

|[f_zprint]| function(text, x, y, color, align)
    text = ""..text
    if align == 0    then x -= #text*2
    elseif align > 0 then x -= #text*4+1 end

    _print(text, x, y, color)
end $$

|[f_draw_screen]| function(xoff, yoff, w, h, screen_func)
    _clip(-%0x5f28+xoff,-%0x5f2a+yoff,w,h)
    f_zcamera(xoff, yoff, screen_func)
    _clip()
end $$
