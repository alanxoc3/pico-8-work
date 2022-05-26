zclass[[gameover_control,actor|
    start;duration,.75, next,ending;
    ending;init,%gameover_control_ending;
]]

|[gameover_control_ending]| function(a)
    _g.fader_out(function() g_state:load'title' end)
end $$

|[gameover_init]| function(state)
    _g.gameover_control()
    state.game_over_sind, state.game_over_text = unpack(rnd_item(zobj[[
        1;,32,  "quack quack";
        2;,68,  "and play with me";
        3;,9,  "to save hi-roll";
        4;,81,  "in time for dinner";
        5;,83,  "and make me rich";
        6;,96,  "the banjo awaits you";
        7;,99,  "for your fans";
        8;,118, "splat splat boing";
    ]]))
end $$

|[gameover_draw]| function(state)
    local drawfunc = function()
        zspr(state.game_over_sind, 0, g_i%2, 1, 1, true, false, 1)
    end

    zcall(zprinttbox, [[
        1;,"come back lank", 64, 38,0,  10, 4, 1;
        2;,@,                64, 69, 0, 7, 5, 1;
    ]], state.game_over_text)

    draw_card(64, 56+g_i%2, 6, 8, 2, 4, function()
        spr(state.game_over_sind, 0, 0)
    end, nop)
end $$
