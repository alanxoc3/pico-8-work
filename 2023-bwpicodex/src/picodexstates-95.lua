-- game state funcs
|[f_any_btn]| function()
    -- check for any button, besides pause button
    -- bits 6/7 are pause button related, so ignore those
    return btn() & 0x3f ~= 0
end $$

-- utility funcs
|[g_cur_light]| 0 $$
|[f_minisfx]| function(num)
    g_cur_sound = num
end $$

|[f_minisfx_now]| function(num)
    num += 0
    if num > 152 then
        _g.g_cur_light = num-152
    end
    sfx(59+num\32, num <= 152 and 1 or 0, num%32, 1)
end $$

|[f_draw_picodex]| function(_ENV)
    cls'0'
    f_zcamera(0, 128+sin(_ENV:f_actor_get_elapsed_percent'moveup'/4)*128, function()
        f_zcall(f_zprint, [[
           ;,"aMORG gAMES"         ,64, -68,7,0
          ;;,"pRESENTS"            ,64, -61,7,0
          ;;,"a pOKEMON bATTLE sIM",64, 15 ,7,0
        ]])
        f_zcall(spr, [[;,128,44,7,5,1]])

        local top_row_buttons,
              bot_row_buttons,
              rotation =
              modes and modes.main.menu.c,
              modes and modes.stacksize-1,
              foldstate == 'open' and 1
              or foldstate == 'closed' and -1
              or (foldstate == 'opening' and -1 or 1)*cos(_ENV:f_actor_get_elapsed_percent(foldstate)/2)

        f_zcamera(30-(rotation+1)*15+(curr == 'shaking' and f_flr_rnd'3'-1 or 0), 27, function()
            ----- SCREENS -----
            f_zcall(rectfill, [[;,14,18,@,87,5]], 63+max(0, rotation*54))
            if light == 0 then
                f_zcall(rectfill, [[;,14,18,117,87,13]])
                f_zcall(function(xoff, yoff, w, h, screen_func)
                    clip(-%0x5f28+xoff,-%0x5f2a+yoff,w,h)
                    f_zcamera(xoff, yoff, screen_func)
                    clip()
                end, [[
                     ;,14, 21, 40, 40, @
                    ;;,71, 18, 46, 13, @
                    ;;,71, 67, 46, 21, @
                ]], draw1, draw2, draw3)
            end
        end)
    end)
end $$

-- started with: https://www.lexaloffle.com/bbs/?tid=38931
|[f_picodex_map]| function(cx,sx,sw)
    sw*=64
    for y=9,96 do
        tline(sx,y,sx+sw-1,y,cx,y/8-1.125,8/sw,0)
    end
end $$

|[f_wobble_text]| function(text, x, y, color)
    local t1, t2 = "", ""
    for i=1,#text do
        local letter, switch = sub(text, i, i), i%2==0
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

    print(text, x, y, color)
end $$
