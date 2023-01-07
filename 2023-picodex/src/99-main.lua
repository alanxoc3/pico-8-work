zclass[[game_state,actor|
    -- DEBUG_BEGIN
    curr,fadein;
    -- DEBUG_END

    -- NORMAL_BEGIN
    curr,logo;
    -- NORMAL_END

    ecs_exclusions; actor,true; -- remove game_state from the actor group
    defaults;       init,nop, update,nop, draw,nop, light,0, backbuttonheld,no, modes,;

    logo; next,fadein, init,%logo_init, update,nop, draw,%logo_draw, duration,2.5;

    -- DEBUG_BEGIN
    fadein; next,game, duration,0, init,%gamefadein_init;
    -- DEBUG_END

    -- NORMAL_BEGIN
    fadein; next,closed, duration,0, init,%gamefadein_init;
    -- NORMAL_END

    closed;     next,opening,                                             update,%closed_update, draw,%closed_draw;
    opening;    next,starting_1,          duration,.25,                                          draw,%opening_draw;
    starting_1; next,starting_2, light,1, duration,.125, init,%light_init,                       draw,%opened_draw;
    starting_2; next,starting_3, light,2, duration,.125, init,%light_init,                       draw,%opened_draw;
    starting_3; next,game,       light,3, duration,.125, init,%light_init,                       draw,%opened_draw;
    game;       next,closing,    light,4,               init,%game_init,  update,%game_update,   draw,%game_draw;
    closing;    next,closed,              duration,.25,                   update,nop,            draw,%closing_draw;
]]

function _init()
    -- clear all the read only memory. testing things out showed that this doesn't get cleared automatically.
    memset(0x8000, 0, 0x7fff)

    menuitem(1, "swap 🅾️/❎", function()
        poke(S_SWAP_CONTROLS, @S_SWAP_CONTROLS == 0 and 1 or 0)
    end)

    poke(0x5f5c, 255) -- no key repeats allowed

    cls()
    sfx(62,0) -- a sound indicator that the came is actually running while loading

    -- NORMAL_BEGIN -- debug mode doesn't need to load these sheets for faster startup
    extract_sheet(0)
    extract_sheet(1)
    -- NORMAL_END

    extract_sheet(2)

    poke(0x5f56, 0xe0) -- make map funcs point here instead
    px9_decomp(0, 0, peek2(3*2), mget, mset)

    -- Need the pokedex tiles to stay loaded. This starts at sprite index #96.
    memcpy(0x0000, 0xc000, 0x2000)

    g_tl = _g.game_state()
end

function _update60()
    g_bl  = btn'0'  g_br  = btn'1'
    g_bu  = btn'2'  g_bd  = btn'3'
    g_bo  = btn'4'  g_bx  = btn'5'
    g_bpl = btnp'0' g_bpr = btnp'1'
    g_bpu = btnp'2' g_bpd = btnp'3'
    g_bpo = btnp'4' g_bpx = btnp'5'

    if @S_SWAP_CONTROLS == 1 then
        g_bo,  g_bx  = g_bx,  g_bo
        g_bpo, g_bpx = g_bpx, g_bpo
    end

    -- DEBUG_BEGIN
    if g_bo and g_bpx then g_debug = not g_debug end
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
