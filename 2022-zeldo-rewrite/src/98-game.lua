zclass[[room_bounds,box|x,@,y,@,rx,@,ry,@]]

|game_init| function(state)
    state.room_index = 8*16+8
    local r = g_rooms[state.room_index]
    g_room_bounds = _g.room_bounds(r.w/2, r.h/2, r.w/2, r.h/2)
    g_pl = _g.pl(5.5, 5)
end $$

|game_update| function()
    zcall(loop_entities, [[
        1;,actor, state;
        2;,mov,   mov_update;
        3;,vec,   vec_update;
    ]])

    -- DEBUG_BEGIN
    if g_debug then debug_boxes(g_pl, g_room_bounds) end
    -- DEBUG_END
end $$

|game_draw| function(state)
    draw_room(g_rooms[state.room_index], 64, 64, function()
        loop_entities('outlayer_50', 'drawout')
        loop_entities('drawlayer_50', 'draw')

        -- DEBUG_BEGIN
        if g_debug then
            for inst in all(g_zclass_entities['box']) do
                scr_rect(inst.x-inst.rx, inst.y-inst.ry, inst.x+inst.rx-.125, inst.y+inst.ry-.125, 8)
            end
        end
        -- DEBUG_END
    end)

    -- loop_entities('outlayer_99', 'drawout')
    -- loop_entities('drawlayer_99', 'draw')
end $$
