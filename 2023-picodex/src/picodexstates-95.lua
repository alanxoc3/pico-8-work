-- game state funcs
|[gamefadein_init]| function()
    fader_in()
    _sfx(-2,0) -- stop the creepy logo sound from looping
end $$

-- you can factory reset when the pokedex is closed
|[closed_init]| function(_ENV)
    _menuitem(1, "factory reset", function()
        _sfx(59,0)
        _memset(0x5e00, 0, 0x100)
        _ENV:start_timer('shaking', .5)
    end)
end $$

|[any_btn]| function()
    return g_bl or g_br or g_bu or g_bd or g_bx or g_bo
end $$

|[closed_update]| function(_ENV)
    -- if player 1 pressed any button, go to the next state.
    if not any_btn() and backbuttonheld then
        backbuttonheld = false
        _ENV:load()
        _menuitem(1) -- no factory reset now
    elseif any_btn() then
        backbuttonheld = true
        _menuitem(1) -- no factory reset now
    end
end $$

|[closed_draw]| function(_ENV)
    draw_picodex(_ENV:is_active'shaking', -1, nop, nop, nop, light, backbuttonheld)
end $$

|[closing_draw]| function(_ENV)
    draw_picodex(_ENV:is_active'shaking', _cos(_ENV:get_elapsed_percent'closing'/2), nop, nop, nop)
end $$

|[opened_draw]| function(_ENV)
    draw_picodex(_ENV:is_active'shaking', 1, nop, nop, nop, light)
end $$

|[opening_draw]| function(_ENV)
    draw_picodex(_ENV:is_active'shaking', -_cos(_ENV:get_elapsed_percent'opening'/2), nop, nop, nop)
end $$

-- utility funcs
|[beep]| function() _sfx(60, 0) end $$

|[draw_picodex]| function(shaking, rotation, l_screen, tr_screen, br_screen, light, backbuttonheld, top_row_buttons, bot_row_buttons)
    light = light or 0

    zcamera(28-(rotation+1)*14+(shaking and _flr(_rnd(3)-1) or 0), 15, function()
        draw_back_panel(light)
        draw_left_flap(light >= 4, l_screen)
        draw_right_flap(light >= 4, rotation, backbuttonheld, tr_screen, br_screen, top_row_buttons, bot_row_buttons)
    end)
end $$

-- started with: https://www.lexaloffle.com/bbs/?tid=38931
|[picodex_map]| function(cx,sx,sw)
    sw*=64
    for y=9,96 do
        _tline(sx,y,sx+sw-1,y,cx,y/8-1.125,8/sw,0)
    end
end $$

|[wobble_text]| function(text, x, y, color)
    local t1, t2 = "", ""
    for i=1,#text do
        local letter, switch = _sub(text, i, i), i%2==0
        t1 ..= switch and " " or letter
        t2 ..= switch and letter or " "
    end

    zprint(t1, x, y,   color, 0)
    zprint(t2, x, y+1, color, 0)
end $$

|[zprint]| function(text, x, y, color, align)
    text = ""..text
    if align == 0    then x -= #text*2
    elseif align > 0 then x -= #text*4+1 end

    _print(text, x, y, color)
end $$

|[draw_screen]| function(xoff, yoff, w, h, screen_func)
    _clip(-%0x5f28+xoff,-%0x5f2a+yoff,w,h)
    zcamera(xoff, yoff, screen_func)
    _clip()
end $$

|[draw_left_flap]| function(is_on, screen_func)
    _rectfill(4, 14, 59, 83, is_on and 13 or 5)
    if is_on then draw_screen(11, 21, 40, 40, screen_func) end

    _map(8,  0, -1,  9, 8,  11)
    _spr(g_bl and 186 or 154, 07, 77) -- button presses
    _spr(g_br and 188 or 156, 23, 77)
    _spr(g_bu and 171 or 139, 15, 73)
    _spr(g_bd and 187 or 155, 15, 81)
    _spr(g_bo and 170 or 138, 39, 77)
    _spr(g_bx and 172 or 140, 47, 77)
end $$

-- flap_rotation is between -1 and 1. -1 means closed, 1 means open.
|[draw_right_flap]| function(is_on, flap_rotation, backbuttonheld, topscreen_func, botscreen_func, top_row_buttons, bot_row_buttons)
    if flap_rotation < 0 then
        picodex_map(0, 64*(1-_abs(flap_rotation))-1, _abs(flap_rotation))

        -- once the rotation changes, the back button is released.
        if flap_rotation == -1 and backbuttonheld then _spr(123, 3, 49) end

    elseif flap_rotation > 0 then
        _rectfill(65+5, 9+5, 65+8*8*flap_rotation-5, 9+11*8-5, is_on and 13 or 5)
        if flap_rotation == 1 and is_on then
            draw_screen(74, 18, 46, 13, topscreen_func)
            draw_screen(74, 67, 46, 21, botscreen_func)
        end

        picodex_map(16, 65, flap_rotation)
        if flap_rotation == 1 then
            if top_row_buttons then _spr(100, 73+(top_row_buttons\1%6)*8,  41) end
            if bot_row_buttons and bot_row_buttons > 0 then _spr(100, 73+(bot_row_buttons\1-1)%6*8,  49) end
        end
    end
end $$

|[draw_back_panel]| function(light)
    local rate = _t()*7
    _map(24, 0, -1,  1, 9, 12)
    _spr((light > 0) and (rate%11<.5 and 131 or 130) or 132, 19, 3)
    _spr((light > 1) and (rate%13<.5 and 131 or 129) or 132, 14, 3)
    _spr((light > 2) and (rate%17<.5 and 131 or 128) or 132, 9,  3)
    _spr((light > 3) and (rate%43<.5 and 134 or 133) or 135, 3,  3)
end $$
