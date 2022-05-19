function title_print(str, x, y, fg, bg, out)
    for yy=-1,2 do
        for xx=-1,1 do
            zprint(str, x+xx, y+yy, 0, out)
        end
    end
    zprint(str, x, y+1, 0, bg)
    zprint(str, x, y, 0, fg)
end

zclass[[title_logo,actor,drawlayer_99|
    update,%title_logo_update_normal,
    draw,%title_logo_draw,
    title_y,0;
    start;update,nop,duration,FADE_SPEED,next,normal;
    normal;update,%title_logo_update;
    ending;update,nop;
]]

|title_logo_update| function(a)
    if btnp(4) or btnp(5) then
        _g.fader_out(FADE_SPEED, function() end)
        a:load'ending'
    end
end $$

|title_logo_draw| function(a)
    camera(-8*8, -8*8)
    for i=-2,2 do
        zsprb(SPR_TITLE_L+i, i*10, cos(t()/2+i/4)/2+1+a.title_y, 1, 2)
    end

    title_print("not the story of", 0, a.title_y-17, 10, 4, 1)

    if t()%1 < .5 then
        title_print("🅾️ or ❎ to play  ", 0, a.title_y+12, 7, 5, 1)
    end
    camera()
end $$
