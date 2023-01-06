-- TEMPLATE TOKEN COUNT: 1045
zclass[[game_state,actor|
    ecs_exclusions;actor,true; -- remove game_state from the actor group
    curr,logo;
    logo; init,%logo_init, update,nop,          draw,%logo_draw, duration,2.5, next,game;
    game; init,%game_init, update,%game_update, draw,%game_draw;
]]

function _init()
    extract_sheet(0)
    extract_sheet(1)
    extract_sheet(2)

    -- Need the pokedex tiles to stay loaded. This starts at sprite index #96.
    memcpy(0x0000, 0xc000, 0x2000)

    g_tl = _g.game_state()
end

function _update60()
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
    cls()
    loop_entities('game_state', 'draw')
    fade(g_fade)
end
