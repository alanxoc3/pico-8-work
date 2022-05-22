cartdata"CART_NAME"

menuitem(1, "reset save data", function()
   memset(REAL_SAVE_LOCATION, 0, SAVE_LENGTH)
   extcmd'reset'
end)

zclass[[game_state,actor|
    ecs_exclusions;actor,true; -- remove game_state from the actor group
    curr,room, init,%game_state_init,
    room_index,136,
    pl_x,3, pl_y,3, pl_xf,yes,
    fairy_x,7, fairy_y,8;

    logo;     state_init, %logo_init,     update, nop,              draw,%logo_draw, duration,2.5, next,title;
    title;    state_init, %title_init,    update, %title_update,    draw,%title_draw;
    room;     state_init, %room_init,     update, %room_update,     draw,%room_draw, leaving,no;
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
    poke2(0x5f5c, BTN_DELAY) -- set custom delay
    g_state, g_rooms = _g.game_state(), decode_map()
    g_tile_animation_lookup = create_tile_animation_lookup(g_rooms[ANIMATION_ROOM_INDEX])
end

function _update60()
    -- DEBUG_BEGIN
    if btn(4) and btnp(5) then g_debug = not g_debug end
    -- DEBUG_END

    loop_entities('actor',      'clean') -- delete any actors that were killed, and call their "destroy" callback
    register_entities()                  -- register all zobs from previous game loop iteration
    zcall(loop_entities, [[
        1;,timer,tick;
        2;,actor,state;
        3;,game_state,state;
    ]])
end

function _draw()
    g_i = g_animation.index
    cls()
    loop_entities('game_state', 'draw')
    fade(g_fade)
    -- DEBUG_BEGIN
    if g_debug then rect(0,0,127,127,8) end
    -- DEBUG_END
end
