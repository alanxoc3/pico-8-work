function _draw()
    cls()
    -- draw the pokedex, use camera to change position
    camera(0,-20)
    draw_back_panel()
    draw_right_flap()
    draw_left_flap()
    camera()
end

-- ! means male. ? means female. for nidoran.
function wobble_text(text, x, y, color)
    x -= #text*2

    local t1 = ""
    local t2 = ""
    for i=1,#text do
        letter = sub(text, i, i)
        if letter == '!' then
            letter = "\^:040e040e0e000000"
        end

        if letter == '?' then
            letter = "\^:0e0e040e04000000"
        end

        if i%2 == 0 then
            t1 = t1.." "
            t2 = t2..letter
        else
            t1 = t1..letter
            t2 = t2.." "
        end
    end

    print(t1, x, y+(t()%2), color)
    print(t2, x, y+((t()+1)%2), color)
end

function zprint(str, x, y, color, align)
    if align == 0    then x -= #str*2
    elseif align > 0 then x -= #str*4+1 end

    print(str, x, y, color)
end

-- pixels are 0 to 37 (38x38 screen)
function draw_main_screen()
    -- local fill_pattern = t()\1 % 2 == 0 and 0b1010010110100101 or 0b0101101001011010
    -- local fill_pattern = t()*2\1 % 2 == 0 and 0b1111000011110000 or 0b0000111100001111
    -- fillp(fill_pattern)
    --rectfill(0,0,37,37,0x5d)
    --fillp()
    sspr(0,0,16,16,23,0+t()*2%2,16,16)
    sspr(0,0,16,16,-1,21+(t()*2+1)%2,16,16, true)
end

function draw_screen(xoff, yoff, w, h, bg_color, screen_func)
    local ox, oy = %0x5f28, %0x5f2a
    clip(-ox+xoff,-oy+yoff,w,h)
    camera(ox-xoff, oy-yoff)

    rectfill(0,0,w,h,   bg_color)

    screen_func()
    camera(ox, oy)
    clip()
end

function draw_left_flap()
    draw_screen(12, 29, 38, 38, 5, draw_main_screen)

    map(103,  20, -1,  8, 8,  12)
    spr(btn(0) and 186 or 154, 07, 84) -- button presses
    spr(btn(1) and 188 or 156, 23, 84)
    spr(btn(2) and 171 or 139, 15, 80)
    spr(btn(3) and 187 or 155, 15, 88)
    spr(btn(4) and 170 or 138, 39, 84)
    spr(btn(5) and 172 or 140, 47, 84)

    spr(btn(0) and 100 or 99, 73,  48) spr(btn(0) and 100 or 99, 89,  56)
    spr(btn(1) and 100 or 99, 89,  48) spr(btn(1) and 100 or 99, 81,  56)
    spr(btn(2) and 100 or 99, 81,  48) spr(btn(2) and 100 or 99, 97,  56)
    spr(btn(3) and 100 or 99, 97,  48) spr(btn(3) and 100 or 99, 105, 56)
    spr(btn(4) and 100 or 99, 105, 48) spr(btn(4) and 100 or 99, 113, 56)
    spr(btn(5) and 100 or 99, 113, 48) spr(btn(5) and 100 or 99, 73,  56)
end

function draw_right_flap()
    draw_screen(74, 25, 46, 14,  5, function() wobble_text("nidoran?", 46/2, 4, 6) end)
    draw_screen(74, 73, 46, 22,  5, function() sspr(32,32,16,16,1,1,16,16,true) end)
    --draw_screen(106, 73, 14, 14, 5, function() sspr(64,32,16,16,1,1,12,12,true) end)

    map(111,  20, -1+8*8+2, 8, 8, 12)

    --spr(103, 77, 90, 5, 1)
    --spr(103, 77, 53, 5, 1)
    --zprint("aMORG gAMES",           97, 41+50, 7, 0)

end

function draw_back_panel()
    map(119, 20, -1,  8, 9, 12)
    local tval = t()*2\1%5 -- 0, 1, 2, 3, 4
    spr((tval > 0) and 120 or 121, 20-1, 10)
    spr((tval > 1) and 119 or 121, 15-1, 10)
    spr((tval > 2) and 118 or 121, 10-1, 10)
    spr((tval > 3) and 122 or 123, 3,  10)
end
