|game_init| function(state)
    state.room_index = 8*16+8

    g_pl = _g.pl(7, 7)
end $$

|game_update| function()
    zcall(loop_entities, [[
        1;,actor, state;
        2;,mov,   mov_update;
        3;,vec,   vec_update;
    ]])


end $$

|game_draw| function(state)
    draw_room(g_rooms[state.room_index], 64, 64, function(x, y)
        loop_entities('outlayer_50', 'drawout')
        loop_entities('drawlayer_50', 'draw')
    end)

    -- loop_entities('outlayer_99', 'drawout')
    -- loop_entities('drawlayer_99', 'draw')
end $$
