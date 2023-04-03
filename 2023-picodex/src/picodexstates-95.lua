-- game state funcs

-- you can factory reset when the pokedex is closed
|[f_closed_init]| function(_ENV)
    _menuitem(1, "factory reset", function()
        _memset(0x5e00, 0, 0x100)
        _ENV:f_actor_load'shaking'
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
        _ENV:f_actor_load()
        _menuitem(1) -- no factory reset now
    elseif f_any_btn() then
        backbuttonheld = true
        _menuitem(1) -- no factory reset now
    end
end $$

-- utility funcs
|[g_cur_light]| 0 $$
|[f_minisfx]| function(num)
    _g.g_cur_light = _max(0, 0+num-152)
    _sfx(54+num\16, 0, num%16*2, 2)
end $$

|[f_draw_picodex]| function(_ENV)
    _cls'0'
    f_zcamera(0, 128+_sin(_ENV:f_actor_get_elapsed_percent'moveup'/4)*128, function()
        f_zcall(f_zprint, [[
           ;,"aMORG gAMES"         ,64, -68,7,0
          ;;,"pRESENTS"            ,64, -61,7,0
          ;;,"a pOKEMON bATTLE sIM",64, 15 ,7,0
        ]])
        f_zcall(_spr, [[;,102,44,7,5,1]])

        local top_row_buttons,
              bot_row_buttons,
              rotation =
              modes and modes.main.menu.c,
              modes and modes.stacksize-1,
              foldstate == 'open' and 1
              or foldstate == 'closed' and -1
              or (foldstate == 'opening' and -1 or 1)*_cos(_ENV:f_actor_get_elapsed_percent(foldstate)/2)

        f_zcamera(30-(rotation+1)*15+(curr == 'shaking' and f_flr_rnd'3'-1 or 0), 27, function()
            ----- SCREENS -----
            f_zcall(_rectfill, [[;,14,18,@,87,5]], 63+_max(0, rotation*54))
            if light == 0 then
                f_zcall(_rectfill, [[;,14,18,117,87,13]])
                f_zcall(f_draw_screen, [[
                     ;,14, 21, 40, 40, @
                    ;;,71, 18, 46, 13, @
                    ;;,71, 67, 46, 21, @
                ]], draw1, draw2, draw3)
            end

            ----- LEFT SIDE ----- 
            f_zcall(_map, [[
               ;,24,0,2,1,8,3
              ;;, 8,0,2,9,8,11
            ]])

            f_zcall(function(l, off, on, flash, x, y)
                return _spr((light <= l) and (g_cur_light == l and _stat'46'>=0 and flash or on) or off, x, y)
            end, [[
                 ;,0, 135, 133, 134, 6,  3
                ;;,1, 132, 128, 131, 12, 3
                ;;,2, 132, 129, 131, 17, 3
                ;;,3, 132, 130, 131, 22, 3
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

            -- uncomment to enable a speaker circle
            -- if _stat'46' >= 0 then
            --     f_zcall(_circ, [[;,53,65,@,12]], 5+_sin(_t()*2))
            -- end

            ----- RIGHT SIDE -----
            if rotation <= 0 then
                f_picodex_map(0, 2+64*(1-_abs(rotation)), _abs(rotation))
                if rotation == -1 and backbuttonheld then _spr(123, 6, 49) end
            else
                f_picodex_map(16, 62, rotation)

                if rotation == 1 then
                    if top_row_buttons then                          _spr(153, 70+top_row_buttons*8, 41) end
                    if bot_row_buttons and bot_row_buttons >= 0 then _spr(153, 70+bot_row_buttons*8, 49) end
                end
            end
        end)
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
