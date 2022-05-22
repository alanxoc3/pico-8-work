function draw_bar(x1,y1,x2,y2,num,dem,align,fg,bg)
    if x1 > x2 then x1 -= 3 x2 -= 3 end

    local bar_off = x2-x1-min(num/dem, 1)*(x2-x1)
    if align == 0 then bar_off /= 2 end

    if num > 0 then
        local xx = ceil(x1+(align >= 0 and bar_off or 0))
        local yy = flr(x2-(align <= 0 and bar_off or 0))
        rectfill(x1, y1, x1, y2, 13)
        rectfill(x2, y1, x2, y2, 13)
        rectfill(xx, y1, yy, y2, fg)
        rectfill(xx, y2, yy, y2, bg)
   end
end

function draw_stat(x, y, align, name, draw, max_health, health)
    zcamera(x+2, y, function()
        local xyo = -8*align-1
        zprinttbox(name, xyo, -10, align, 7, 5)
        draw_bar(xyo, -2, xyo-35*align, 1, health, max_health, -1, 11, 3)
        zprinttbox(flr(health)..'/'..max_health, xyo, 4, align, 7, 5)
    end)

    draw_card(x, y-cos(g_i/4)*align, 6, 8, 6, 8, draw, nop)
end

function draw_card(x, y, rx, ry, coffx, coffy, card_func, post_card_func)
    local x1, x2, y1, y2 = x-rx, x+rx-1, y-ry, y+ry-1
    rectfill(x1, y1, x2, y2, 1)
    local cam_x, cam_y = x1+coffx, y1+coffy

    clip(x1,y1,x2-x1,y2-y1)
    zcamera(cam_x, cam_y, card_func)
    clip()

    for i, c in pairs{1,13,0} do
        i=2-i
        color(c)
        if c ~= 0 then rect(x1+i, y1+i, x2-i, y2-i) end
        i+=1
        pset(x1+i, y1+i) pset(x1+i, y2-i)
        pset(x2-i, y1+i) pset(x2-i, y2-i)
    end

    zcamera(cam_x, cam_y, post_card_func)
end

function draw_tbox(x, y)
    draw_card(x+g_i%2, y, 46.5, 10, 2.5, 5,
    function()
        zprinttbox("1234567890123456789012345", 0, -2, -1, 7, 5)
        zprinttbox("1234567890123456789012345", 0, 6, -1, 7, 5)
    end, function()
        zspr(38, 44, 16+g_i%2)
    end)
end
