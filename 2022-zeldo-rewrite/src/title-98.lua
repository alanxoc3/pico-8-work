|[f_title_init]| function()
    _g.title_logo()
end $$

|[f_simple_update]| function()
    if does_entity_exist'fader' then return end
    zcall(loop_entities, [[
        1;,timer, tick;
        2;,actor, state;
        3;,vec,   f_vec_update_x;
        4;,vec,   f_vec_update_y;
    ]])
end $$

|[f_title_draw]| function()
    draw_room(g_rooms[TITLE_ROOM_INDEX], CARD_CX, CARD_CY, nop, nop)
    zcall(loop_entities, [[
        1;,drawlayer_99, draw;
    ]])

    zcall(zprinttbox, [[
        1;,"code/sfx:  @alanxoc3  ", 64, 104, 0, 7, 5;
        2;,"tile/spr:  @greatcadet", 64, 114, 0, 7, 5;
        3;,"amorg games presents",   64, 6, 0, 7, 5;
    ]])
end $$

zclass[[title_logo,actor,auto_outline,drawlayer_99|
    update,%f_title_logo_update,
    drawout,%f_title_logo_drawout;
]]

|[f_title_logo_update]| function(a)
    if btnp'4' or btnp'5' then
        _g.fader_out(function() g_state:load'room' end)
    end
end $$

|[f_title_logo_drawout]| function(a)
    for i=-2,2 do
        zspr(SPR_TITLE_L+i, i*10+64, 57+cos((g_si+i)/4)/2, 1, 2)
    end

    zcall(zprinttbox, [[
        1;,"not the story of", 64, 39, 0, 10, 4;
    ]])

    if g_si%2 == 0 then
        zcall(zprinttbox, [[
            1;,"🅾️ or ❎ to play  ", 64, 68, 0, 7, 5;
        ]])
    end
end $$
