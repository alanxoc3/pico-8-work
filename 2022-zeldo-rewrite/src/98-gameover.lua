zclass[[gameover_control,actor|
    start;update,nop,duration,FADE_SPEED,next,normal;
    normal;update,%gameover_control_update;
    ending;update,nop;
]]

|gameover_control_update| function(a)
    if btnp(4) or btnp(5) then
        _g.fader_out(FADE_SPEED, function() g_state:load'title' end)
        a:load'ending'
    end
end $$

|gameover_init| function(state)
    _g.gameover_control()
    state.game_over_sind, state.game_over_text = unpack(split(rnd_item(split[[
        32|  "quack quack",
        68|  "and play with me",
        70|  "to save hi-roll",
        81|  "in time for dinner",
        83|  "and make me rich",
        96|  "the banjo awaits you",
        99|  "for your fans",
        118| "splat splat boing"
    ]]), '|'))

    printh(state.game_over_sind)
end $$

|gameover_update| function()
    loop_entities('actor', 'state')
end $$

|gameover_draw| function(state)
    camera(-8*8, -8*8)
    zsprb(state.game_over_sind, 0, g_i%2, 1, 1, true, false, 1)

    zprintgui("game over",      0, -17, 8, 2, 1)
    zprintgui("come back lank", 0, 12, 10, 4, 1)
    zprintgui(state.game_over_text, 0, 22, 7, 5, 1)
    camera()
end $$
