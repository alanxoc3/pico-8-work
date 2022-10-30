|[gameover_update]| function()
    zcall(loop_entities, [[
        1;,timer, tick;
        2;,actor, state;
        3;,vec,   vec_update_x;
        4;,vec,   vec_update_y;
    ]])
end $$

|[gameover_init]| function(state)
    game_over_sind, game_over_text = unpack(rnd_item(zobj[[
        1;,32,  "quack quack.";
        2;,68,  "and play with me.";
        3;,9,   "to save hi-roll.";
        4;,81,  "in time for dinner.";
        5;,83,  "and make me rich.";
        6;,96,  "the banjo awaits you.";
        7;,99,  "for your fans.";
        8;,118, "splat splat boing.";
    ]]))

    _g.tbox(game_over_sind.."^come back lank!^"..game_over_text, function(a)
        _g.fader_out(function() g_state:load'room' end)
    end)

    poke(0x5f43, 0) -- ensure music is not faded anymore
    music'-1'
    g_music_ind = -1
    load_save_state()
end $$

|[gameover_draw]| function(state)
     zcall(loop_entities, [[
        1;,drawlayer_99, draw;
    ]])
end $$
