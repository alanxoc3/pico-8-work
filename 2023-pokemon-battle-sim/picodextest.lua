function zprint(str, x, y, color, align)
    if align == 0    then x -= #str*2
    elseif align > 0 then x -= #str*4+1 end

    print(str, x, y, color)
end

function _draw()
    -- clear and border
    cls() -- rect(0,0,127,127,3)


    camera(0,-8)
    -- memcpy(0x6000, 0x0000, 0x2000)
    map(16, 16, -1,  0, 9, 16)

    -- spr(96, 4, 10, 3, 1)

    -- lights
    local tval = t()*2\1%5 -- 0, 1, 2, 3, 4
    spr((tval > 0) and 111 or 127, 20-1, 10)
    spr((tval > 1) and 110 or 127, 15-1, 10)
    spr((tval > 2) and 109 or 127, 10-1, 10)
    spr((tval > 3) and 126 or 125, 3,  10)

    map(0,  16, -1,  0, 8,  16)
    map(8,  16, -1+8*8+2,-1, 8, 16)

    -- button presses
    spr(btn(0) and 186 or 154, 07, 88)
    spr(btn(1) and 188 or 156, 23, 88)
    spr(btn(2) and 171 or 139, 15, 80)
    spr(btn(3) and 187 or 155, 15, 88)
    spr(btn(4) and 170 or 138, 39, 80)
    spr(btn(5) and 172 or 140, 47, 88)

    -- small screen
    spr(103, 77, 27, 5, 1)
    -- zprint("\"gOTTA cATCH", 97, 40, 7, 0)
    -- zprint("100 tYRANITAR", 97, 50, 7, 0)

    -- credits
    -- zprint("bY",                 97, 40+40, 7, 0)
    zprint("aMORG gAMES",           97, 41+50, 7, 0)
    -- zprint("tHEGREATCADET",      97, 40+52, 7, 0)
    camera()
end
