cartdata"CART_NAME"

menuitem(2, "reset save data", function()
   memset(REAL_SAVE_LOCATION, 0, SAVE_LENGTH)
   extcmd'reset'
end)

zclass[[game_state,actor|
    ecs_exclusions;actor,true; -- remove game_state from the actor group
    curr,title, init,%game_state_init;

    logo;     state_init, %logo_init,     update, nop,              draw,%logo_draw, duration,2.5, next,title;
    title;    state_init, %title_init,    update, %title_update,    draw,%title_draw;
    game;     state_init, %game_init,     update, %game_update,     draw,%game_draw;
    gameover; state_init, %gameover_init, update, %gameover_update, draw,%gameover_draw;
]]

|game_state_init| function(state)
    clean_all_entities'game_state'
    _g.fader_in'FADE_SPEED'
    g_animation = _g.animation'ANIMATION_SPEED'
    state:state_init()
end $$

function _init()
    memset(TEMP_SAVE_LOCATION, 0, SAVE_LENGTH)
    g_state, g_rooms = _g.game_state(), decode_map()
    g_tile_animation_lookup = create_tile_animation_lookup(g_rooms[ANIMATION_ROOM_INDEX])
end

function _update60()
    -- DEBUG_BEGIN
    if btnp(4) and btnp(5) then g_debug = not g_debug end
    -- DEBUG_END

    loop_entities('actor',      'clean') -- delete any actors that were killed, and call their "destroy" callback
    register_entities()                  -- register all zobs from previous game loop iteration
    loop_entities('timer',      'tick')  -- update the timers
    loop_entities('game_state', 'state') -- game state controls the different overall states in the game
end

function _draw()
    g_i = g_animation.index
    cls()
    loop_entities('game_state', 'draw')
    fade(g_fade)
end

-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
-- zclass[[test_obj,actor,drawlayer_50|x,@,y,@,color,7,init,%test_init,update,%test_update,draw,%test_draw;]]
-- |test_init|   function(a) a.color += 1                   end $$
-- |test_update| function(a) a.x += xbtn() a.y += ybtn()    end $$
-- |test_draw|   function(a) circfill(a.x, a.y, 2, a.color) end $$
