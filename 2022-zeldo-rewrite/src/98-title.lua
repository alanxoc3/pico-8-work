|title_init| function()
    _g.title_logo()
end $$

|title_update| function()
    loop_entities('actor', 'state')
end $$

|title_draw| function()
    draw_room(g_rooms[8*16+8], 64, 64, nop, nop)
    loop_entities('outlayer_99', 'drawout')
    loop_entities('drawlayer_99', 'draw')
end $$

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
        _g.fader_out(FADE_SPEED, function() g_state:load'game' end)
        a:load'ending'
    end
end $$

|title_logo_draw| function(a)
    camera(-8*8, -8*8)
    for i=-2,2 do
        zsprb(SPR_TITLE_L+i, i*10, cos((g_i+i)/4)/2+1+a.title_y, 1, 2)
    end

    zprintgui("not the story of", 0, a.title_y-17, 10, 4, 1)

    if g_i%2 == 0 then
        zprintgui("🅾️ or ❎ to play  ", 0, a.title_y+12, 7, 5, 1)
    end
    camera()
end $$
