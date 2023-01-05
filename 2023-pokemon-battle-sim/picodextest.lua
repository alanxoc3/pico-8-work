function zprint(str, x, y, color, align)
    if align == 0    then x -= #str*2
    elseif align > 0 then x -= #str*4+1 end

    print(str, x, y, color)
end

-- pixels are 0 to 37 (38x38 screen)
function draw_main_screen()
    -- local fill_pattern = t()\1 % 2 == 0 and 0b1010010110100101 or 0b0101101001011010
    local fill_pattern = t()*2\1 % 2 == 0 and 0b1111000011110000 or 0b0000111100001111
    fillp(fill_pattern)
    rectfill(0,0,37,37,0x5d)
    fillp()
    sspr(0,0,16,16,3,3,32,32)
end

function draw_screen(xoff, yoff, w, h, screen_func)
    local ox, oy = %0x5f28, %0x5f2a
    clip(-ox+xoff,-oy+yoff,w,h)
    camera(ox-xoff, oy-yoff)
    rectfill(0,0,w,h,1)
    screen_func()
    camera(ox, oy)
    clip()
end

function draw_left_flap()
    draw_screen(12, 29, 38, 38, draw_main_screen)

    map(0,  16, -1,  0, 8,  16)
    spr(btn(0) and 186 or 154, 07, 88) -- button presses
    spr(btn(1) and 188 or 156, 23, 88)
    spr(btn(2) and 171 or 139, 15, 80)
    spr(btn(3) and 187 or 155, 15, 88)
    spr(btn(4) and 170 or 138, 39, 80)
    spr(btn(5) and 172 or 140, 47, 88)
end

function draw_right_flap()
    draw_screen(74, 24, 46, 14, function() zprint("wigglytuff", 46/2, 4, 7, 0) end)
    draw_screen(74, 72, 14, 14, function() spr(78, 3, 3) end)
    draw_screen(106, 72, 14, 14, function() spr(79, 3, 3) end)

    map(8,  16, -1+8*8+2,-1, 8, 16)

    zprint("aMORG gAMES",           97, 41+50, 7, 0)

end

function draw_back_panel()
    map(16, 16, -1,  0, 9, 16)
    local tval = t()*2\1%5 -- 0, 1, 2, 3, 4
    spr((tval > 0) and 111 or 127, 20-1, 10)
    spr((tval > 1) and 110 or 127, 15-1, 10)
    spr((tval > 2) and 109 or 127, 10-1, 10)
    spr((tval > 3) and 126 or 125, 3,  10)
end

function _draw()
    cls()

    -- draw the pokedex, use camera to change position
    camera(0,-20)
    draw_back_panel()
    draw_left_flap()
    draw_right_flap()
    camera()
end
