-- TEMPLATE TOKEN COUNT: 1045
zclass[[game_state,actor|
    curr,fadein;
    ecs_exclusions; actor,true; -- remove game_state from the actor group
    defaults;       init,nop, update,nop, draw,nop, light,0, backbuttonheld,no;

    logo; next,fadein, init,%logo_init, update,nop, draw,%logo_draw, duration,2.5;
    fadein; next,closed, duration,0, init,%gamefadein_init;

    closed;     next,opening,                           init,nop,         update,%closed_update, draw,%closed_draw;
    opening;    next,starting_1,          duration,.25, init,nop,         update,nop,            draw,%opening_draw;
    starting_1; next,starting_2, light,1, duration,.25, init,%light_init, update,%game_update,   draw,%opened_draw;  -- no lights
    starting_2; next,starting_3, light,2, duration,.25, init,%light_init, update,%game_update,   draw,%opened_draw;  -- green
    starting_3; next,game,       light,3, duration,.25, init,%light_init, update,%game_update,   draw,%opened_draw;  -- yellow
    game;       next,closing,    light,4,               init,%game_init,  update,%game_update,   draw,%game_draw;    -- white
    closing;    next,closed,              duration,1,   init,nop,         update,%game_update,   draw,%closing_draw;
]]

function _init()
    cls()
    sfx(62,0) -- a sound indicator that the came is actually running while loading
    extract_sheet(0)
    extract_sheet(1)
    extract_sheet(2)

    poke(0x5f56, 0xe0) -- make map funcs point here instead
    px9_decomp(0, 0, peek2(3*2), mget, mset)

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
    --map(0,0,0,0,34,12) -- 0x6000, 0x0000, 0x2000)
end
