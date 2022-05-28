cartdata"CART_NAME"

menuitem(1, "reset save data", function()
   memset(REAL_SAVE_LOCATION, 0, SAVE_LENGTH)
   extcmd'reset'
end)

zclass[[game_state,actor|
    ecs_exclusions;actor,yes,timer,yes; -- remove game_state from the actor group
    curr,room, init,%game_state_init;

    logo;     state_init,%logo_init,     update,%simple_update, draw,%logo_draw, duration,2.5, next,title;
    title;    state_init,%title_init,    update,%simple_update, draw,%title_draw;
    room;     state_init,%room_init,     update,%room_update,   draw,%room_draw;
    gameover; state_init,%gameover_init, update,%simple_update, draw,%gameover_draw;
]]

|[game_state_init]| function(state)
    clean_all_entities'game_state'
    _g.fader_in()
    g_animation = _g.animation'ANIMATION_SPEED'
    state:state_init()
end $$

function _init()
    memcpy(MEM_SAVE_LOCATION, REAL_SAVE_LOCATION, SAVE_LENGTH)

    if peek'MEM_SAVE_LOCATION' == 0 then
        zcall(poke, [[
            1;,MEM_SAVE_LOCATION ,1;
            2;,MEM_ROOM_IND  ,136;
            3;,MEM_PL_X      ,48;
            4;,MEM_PL_Y      ,48;
            5;,MEM_PL_XF     ,1;
            6;,MEM_ITEM_INDEX,4;

            7; ,MEM_HAS_SWORD  , 1;
            8; ,MEM_HAS_MASK   , 1;
            10; ,MEM_HAS_BOW   , 1;
            11; ,MEM_HAS_SHIELD   , 1;
            12; ,MEM_HAS_BOMB   , 1;
            13; ,MEM_HAS_BANJO   , 1;
            14; ,MEM_HAS_BRANG  , 1;
            -- 11; ,MEM_HAS_BOMB   , 1;
            --12; ,MEM_HAS_MASK   , 1;
            --14; ,MEM_HAS_BRANG  , 1;
            --15; ,MEM_HAS_SHIELD , 1;
        ]])
    end

    -- poke2(0x5f5c, BTN_DELAY) -- set custom delay
    g_i, g_state, g_rooms = 0, _g.game_state(), decode_map()
    g_tile_animation_lookup = create_tile_animation_lookup(g_rooms[ANIMATION_ROOM_INDEX])
end

function _update60()
    -- DEBUG_BEGIN
    if btn(4) and btnp(5) then g_debug = not g_debug end
    -- DEBUG_END

    zcall(loop_entities, [[
        1;,actor,clean;
        2;,fader,clean;
    ]])

    register_entities()                  -- register all zobs from previous game loop iteration

    zcall(loop_entities, [[
        1;,fader,tick;
        2;,game_state,tick;
        3;,fader,state;
        4;,game_state,state;
    ]])
end

function _draw()
    g_i = g_animation.index
    cls()
    loop_entities('game_state', 'draw')
    fade(g_fade)
    -- DEBUG_BEGIN
    if g_debug then
        zcall(rect, [[
            1;,17,12,110,18,1;
            2;,17,95,110,101,1;

            3;,17,0,110,5,1;
            4;,17,122,110,127,1;

            5;,0,0,17,127,1;
            6;,110,0,127,127,1;
        ]])
    end
    
    -- DEBUG_END
end
