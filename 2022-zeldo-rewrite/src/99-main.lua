cartdata"CART_NAME"

menuitem(2, "reset save data", function()
   memset(REAL_SAVE_LOCATION, 0, SAVE_LENGTH)
   extcmd'reset'
end)

zclass[[game_state,actor|
    ecs_exclusions;actor,true; -- remove game_state from the actor group
    curr,logo;
    logo; init,%logo_init, update,nop,          draw,%logo_draw, duration,2.5, next,game;
    game; init,%game_init, update,%game_update, draw,%game_draw;
]]

function _init()
    memset(TEMP_SAVE_LOCATION, 0, SAVE_LENGTH)
    g_tl, g_rooms = _g.game_state(), decode_map()
    g_tile_animation = create_tile_animation(g_rooms[ANIMATION_ROOM_INDEX])
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
    cls()
    fade(g_fade)
    loop_entities('game_state', 'draw')
end

-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
zclass[[test_obj,actor,drawlayer_50|x,@,y,@,color,7,init,%test_init,update,%test_update,draw,%test_draw;]]
|test_init|   function(a) a.color += 1                   end $$
|test_update| function(a) a.x += xbtn() a.y += ybtn()    end $$
|test_draw|   function(a) circfill(a.x, a.y, 2, a.color) end $$

|game_init|   function() _g.fader_in'.5' _g.test_obj(64, 64)             end $$
|game_update| function() loop_entities('actor', 'state')    end $$
|game_draw|   function() rect(0, 0, 127, 127, 8)
                         draw_room(g_rooms[8*16+8], 64, 64, nop, nop)
                         loop_entities('drawlayer_50', 'draw')  end $$
