zclass[[gameover_control,actor|
    start;duration,.75, next,ending;
    ending;init,%gameover_control_ending;
]]

|[gameover_control_ending]| function(a)
    _g.fader_out(function() g_state:load'room' end)
end $$

|[gameover_init]| function(state)
--    _- _g.tbox"SPR_NAVY^come back lank^from the forest"
    poke(0x5f43, 0) -- ensure music is not faded anymore
    music'-1'
    sfx'3'
    sfx(5,-2) -- banjo
    sfx(6,-2) -- banjo
    sfx(7,-2) -- banjo
    g_music_ind = -1
    load_save_state()
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
    draw_card(64, 64, 46, 10, 2.5, 5, function() end, nop)

    local drawfunc = function()
        zspr(state.game_over_sind, 0, g_si%2, 1, 1, true, false, 1)
    end

    zcall(zprinttbox, [[
        1;,"come back lank", 21, 57,-1,  10, 4, 1;
        2;,@,                21, 65, -1, 7, 5, 1;
    ]], state.game_over_text)

    draw_card(118, 64, 6, 6, 2, 2, function()
        spr(state.game_over_sind, 0, 0, 1, 1, true)
    end, nop)
end $$
