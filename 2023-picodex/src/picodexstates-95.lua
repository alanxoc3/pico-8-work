-- todo: pkmn cries. 19 sfx slots (8 per slot) could give me all 152 pkmn cries.
-- todo: 3 channels for song. 1 for picodex noise/cry.
-- game state funcs
|[f_moveup_init]| function()
    _sfx(-2,1) -- stop the creepy logo sound from looping
end $$

-- you can factory reset when the pokedex is closed
|[f_closed_init]| function(_ENV)
    _menuitem(2, "factory reset", function()
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
        _menuitem(2) -- no factory reset now
    elseif f_any_btn() then
        backbuttonheld = true
        _menuitem(2) -- no factory reset now
    end
end $$

|[f_draw_picodex2]| function(_ENV)
    f_logo_draw()
    f_zcamera(0, _ENV:get_elapsed_percent'moveup'*128-128, function()
        f_draw_picodex(
            _ENV:is_active'shaking',
            foldstate == 'open' and 1 or foldstate == 'closed' and -1 or (foldstate == 'opening' and -1 or 1)*_cos(_ENV:get_elapsed_percent(foldstate)/2),
            draw1, draw2,
            draw3, light,
            backbuttonheld
        )
    end)
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

|[f_draw_picodex]| function(shaking, rotation, l_screen, tr_screen, br_screen, light, backbuttonheld, top_row_buttons, bot_row_buttons)
    light = light or 0

    local off = 1
    f_zspr(102,                  64, off+9, 5, 1)
    f_zprint("a pICO-8 pOKEDEX sIM", 64, off+13, 7, 0)

    -- f_zprint("picodex", 63, 20, 7, 0)
    f_zcamera(28-(rotation+1)*14+(shaking and _flr(_rnd(3)-1) or 0), 25, function()
        f_draw_back_panel(light)
        f_draw_left_flap(light >= 4, l_screen)
        f_draw_right_flap(light >= 4, rotation, backbuttonheld, tr_screen, br_screen, top_row_buttons, bot_row_buttons)
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

|[f_draw_left_flap]| function(is_on, screen_func)
    _rectfill(4, 14, 59, 83, is_on and 13 or 5)
    if is_on then f_draw_screen(11, 21, 40, 40, screen_func) end

    _map(8,  0, -1,  9, 8,  11)

    _spr(_btn'0' and 186 or 154, 07, 77) -- button presses
    _spr(_btn'1' and 188 or 156, 23, 77)
    _spr(_btn'2' and 171 or 139, 15, 73)
    _spr(_btn'3' and 187 or 155, 15, 81)
    _spr(_btn'4' and 170 or 138, 39, 77)
    _spr(_btn'5' and 172 or 140, 47, 77)

    if stat'46' >= 0 then
        circ(50, 65, 5+sin(t()*2), 12)
    end
end $$

-- flap_rotation is between -1 and 1. -1 means closed, 1 means open.
|[f_draw_right_flap]| function(is_on, flap_rotation, backbuttonheld, topscreen_func, botscreen_func, top_row_buttons, bot_row_buttons)
    if flap_rotation < 0 then
        f_picodex_map(0, 64*(1-_abs(flap_rotation))-1, _abs(flap_rotation))

        -- once the rotation changes, the back button is released.
        if flap_rotation == -1 and backbuttonheld then _spr(123, 3, 49) end

    elseif flap_rotation > 0 then
        _rectfill(65+5, 9+5, 65+8*8*flap_rotation-5, 9+11*8-5, is_on and 13 or 5)
        if flap_rotation == 1 and is_on then
            f_draw_screen(74, 18, 46, 13, topscreen_func)
            f_draw_screen(74, 67, 46, 21, botscreen_func)
        end

        f_picodex_map(16, 65, flap_rotation)
        if flap_rotation == 1 then
            if top_row_buttons then _spr(100, 73+(top_row_buttons\1%6)*8,  41) end
            if bot_row_buttons and bot_row_buttons > 0 then _spr(100, 73+(bot_row_buttons\1-1)%6*8,  49) end
        end
    end
end $$

|[f_draw_back_panel]| function(light)
    local rate = _t()*7
    _map(24, 0, -1,  1, 9, 12)
    
    f_zcall(function(l, s, off, on, flash, x, y)
        return _spr((light > l) and (g_picodex:is_active(s) and flash or on) or off, x, y)
    end, [[
         ;,0, 153,  132, 130, 131, 19, 3
        ;;,1, 154,  132, 129, 131, 14, 3
        ;;,2, 155,  132, 128, 131, 9,  3
        ;;,3, pkmn, 135, 133, 134, 3,  3
    ]])
end $$
