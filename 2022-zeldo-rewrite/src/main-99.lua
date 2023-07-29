cartdata"CART_NAME"

menuitem(1, "reset save data", function()
   memset(REAL_SAVE_LOCATION, 0, SAVE_LENGTH)
   extcmd'reset'
end)

zclass[[game_state,actor|
    ecs_exclusions;actor,yes,timer,yes; -- remove game_state from the actor group
    curr,room, init,%f_game_state_init;

    logo;     state_init,%f_logo_init,     update,%f_simple_update,   draw,%f_logo_draw, duration,2.5, next,title;
    title;    state_init,%f_title_init,    update,%f_simple_update,   draw,%f_title_draw;
    room;     state_init,%f_room_init,     update,%f_room_update,     draw,%f_room_draw;
    gameover; state_init,%f_gameover_init, update,%f_gameover_update, draw,%f_gameover_draw;
]]

|[f_game_state_init]| function(state)
    sfx(-1,3) -- in case there was an issue with stopping active sfx
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
            2 ;,MEM_ROOM_IND      ,224;
            3 ;,MEM_PL_X          ,24;
            4 ;,MEM_PL_Y          ,34;
            5 ;,MEM_RET_ROOM_IND  ,121;
            6 ;,MEM_RET_PL_X      ,96;
            7 ;,MEM_RET_PL_Y      ,72;
            8 ;,MEM_PL_XF         ,1;
            9 ;,MEM_ITEM_INDEX    ,ITEM_IND_INTERACT;
            10;,MEM_PL_HEALTH     ,10;
            11;,MEM_PL_MAX_HEALTH ,10;

            12;,MEM_HAS_SWORD  , 1;
            13;,MEM_HAS_BRANG  , 1;
            14;,MEM_HAS_SHIELD , 1;

            15;,MEM_HAS_MASK   , 1;
            16;,MEM_HAS_BANJO   , 1;
            17;,MEM_HAS_BOWL  , 1;
            18;,MEM_HAS_BOW   , 1;
            19;,MEM_HAS_BOMB   , 1;
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
