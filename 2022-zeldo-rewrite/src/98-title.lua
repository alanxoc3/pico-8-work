|title_init| function()
    _g.title_logo()
end $$

|title_draw| function()
    draw_room(g_rooms[8*16+8], CARD_CX, CARD_CY, nop, nop)
    zcall(loop_entities, [[
        1;,outlayer_99, drawout;
        2;,drawlayer_99, draw;
    ]])

    zcall(zprinttbox, [[
        1;,"code/sfx:  @alanxoc3  ", 64, 104, 0, 7, 5;
        2;,"tile/spr:  @greatcadet", 64, 114, 0, 7, 5;
        3;,"amorg games presents",   64, 6, 0, 7, 5;
    ]])
end $$

zclass[[title_logo,actor,auto_outline,drawlayer_99,outlayer_99|
    update,%title_logo_update_normal,
    draw,%title_logo_draw;
    start;update,nop,duration,FADE_SPEED,next,normal;
    normal;update,%title_logo_update;
    ending;update,nop;
]]

|title_logo_update| function(a)
    if btnp'4' or btnp'5' then
        _g.fader_out(FADE_SPEED, function() g_state:load'room' end)
        a:load'ending'
    end
end $$

|title_logo_draw| function(a)
    for i=-2,2 do
        zspr(SPR_TITLE_L+i, i*10+64, 57+cos((g_i+i)/4)/2, 1, 2)
    end

    zcall(zprinttbox, [[
        1;,"not the story of", 64, 39, 0, 10, 4;
    ]])

    if g_i%2 == 0 then
        zcall(zprinttbox, [[
            1;,"🅾️ or ❎ to play  ", 64, 68, 0, 7, 5;
        ]])
    end
end $$
