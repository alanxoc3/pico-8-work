zclass[[game_state,actor|
    ecs_exclusions;actor,true; -- remove game_state from the actor group
    -- curr,level_select;
    curr,logo;
    logo; init,%logo_init, update,%logo_update, draw,%logo_draw, duration,2.5, next,level_select;
    level_select; init,%level_select_init, update,%level_select_update, draw,%level_select_draw;

    level_bear;  init,%level_bear_init,  update,%level_bear_update,  draw,%standard_level_draw;
    level_mouse; init,%level_mouse_init, update,%level_mouse_update, draw,%standard_level_draw;
    level_cat;   init,%level_cat_init,   update,%level_cat_update,   draw,%standard_level_draw;
    level_pig;   init,%level_pig_init,   update,%level_pig_update,   draw,%standard_level_draw;
]]

function _init()
    g_game_state = _g.game_state()
    g_fade = 0
end

function _update60()
    -- DEBUG_BEGIN
    if btnp(4) and btnp(5) then g_debug = not g_debug end
    -- DEBUG_END

    loop_zobjs('actor',      'clean') -- delete any actors that were killed, and call their "destroy" callback
    register_zobjs()                  -- register all zobs from previous game loop iteration
    loop_zobjs('timer',      'tick')  -- update the timers
    loop_zobjs('game_state', 'state') -- game state controls the different overall states in the game
end

function _draw()
    cls()
    fade(g_fade)
    loop_zobjs('game_state', 'draw')
    -- DEBUG_BEGIN
    if g_debug then rect(0, 0, 127, 127, 8) end
    -- DEBUG_END
end

|standard_level_draw| function()
    loop_zobjs_in_view(g_view, 'drawable_pre',  'draw')
    loop_zobjs_in_view(g_view, 'drawable',      'draw')
    loop_zobjs_in_view(g_view, 'drawable_post', 'draw')
end $$
