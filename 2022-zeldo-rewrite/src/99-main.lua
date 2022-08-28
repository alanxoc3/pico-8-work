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
    g_slow_animation = _g.animation'.5'
    g_fast_animation = _g.animation'.05'
    state:state_init()
end $$

function load_save_state()
    memcpy(MEM_SAVE_LOCATION, REAL_SAVE_LOCATION, SAVE_LENGTH)

    if peek'MEM_SAVE_LOCATION' == 0 then
        zcall(poke, [[
            1 ;,MEM_SAVE_LOCATION ,1;
            2 ;,MEM_ROOM_IND      ,136;
            3 ;,MEM_PL_X          ,44;
            4 ;,MEM_PL_Y          ,26;
            5 ;,MEM_PL_XF         ,1;
            6 ;,MEM_ITEM_INDEX    ,ITEM_IND_INTERACT;
            7 ;,MEM_PL_HEALTH     ,10;
            8 ;,MEM_PL_MAX_HEALTH ,10;

            9 ;,MEM_HAS_SWORD  , 1;
            10;,MEM_HAS_BRANG  , 1;
            11;,MEM_HAS_SHIELD , 1;

            12;,MEM_HAS_MASK   , 1;
            13;,MEM_HAS_BANJO   , 1;
            14;,MEM_HAS_BOWL  , 1;
            15;,MEM_HAS_BOW   , 1;
            16;,MEM_HAS_BOMB   , 1;
        ]])
    end
end

function _init()
    load_save_state()

    poke2(0x5f5c, 6) -- custom press delay... a bit more than the default hold delay
    g_si, g_fi, g_state, g_rooms = 0, 0, _g.game_state(), decode_map()
    g_tile_animation_lookup = create_tile_animation_lookup(g_rooms[ANIMATION_ROOM_INDEX])
end

function _update60()
    -- a few places check for a button press, making global for token count sake
    g_zbtn_0, g_zbtn_2 = zbtn(btn, 0), zbtn(btn, 2)

    -- DEBUG_BEGIN
    if btn(4) and btnp(5) then g_debug = not g_debug end
    -- DEBUG_END

    zcall(loop_entities, [[
        1;,actor,clean;
        2;,fader,clean;
    ]])

    register_entities()

    zcall(loop_entities, [[
        1;,fader,tick;
        2;,game_state,tick;
        3;,fader,state;
        4;,game_state,state;
    ]])
end

function _draw()
    g_si, g_fi = g_slow_animation.index, g_fast_animation.index
    cls()
    loop_entities('game_state', 'draw')
    fade(g_fade)
    -- DEBUG_BEGIN
    camera()
    rect(0, 0, 127, 127, 8)
    -- DEBUG_END
end
