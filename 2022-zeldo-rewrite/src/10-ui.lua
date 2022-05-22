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
    camera(-x-2, -y)
        local xyo = -8*align-1
        zprinttbox(name, xyo, -10, align, 7, 5)
        draw_bar(xyo, -2, xyo-35*align, 1, health, max_health, -1, 11, 3)
        zprinttbox(flr(health)..'/'..max_health, xyo, 4, align, 7, 5)

        camera(-x,-y-g_i%2*align)
        draw_outline(1, draw)
        draw()
    camera()
end
