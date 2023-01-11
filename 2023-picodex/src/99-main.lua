zclass[[game_state,actor|
    curr,fadein; -- curr,logo;

    init,%game_state_init;
    ecs_exclusions; actor,yes; -- remove game_state from the actor group
    defaults;       sinit,nop, update,nop, draw,nop, light,0, backbuttonheld,no, modes,;

    logo; next,fadein, sinit,%logo_init, update,nop, draw,%logo_draw, duration,2.5;

    fadein; next,game, duration,0, sinit,%gamefadein_init; -- fadein; next,closed, duration,0, sinit,%gamefadein_init;

    closed;     next,opening,                            sinit,%closed_init, update,%closed_update, draw,%closed_draw;
    opening;    next,starting_1,          duration,.25,                                             draw,%opening_draw;
    starting_1; next,starting_2, light,1, duration,.125, sinit,%light_init,                         draw,%opened_draw;
    starting_2; next,starting_3, light,2, duration,.125, sinit,%light_init,                         draw,%opened_draw;
    starting_3; next,game,       light,3, duration,.125, sinit,%light_init,                         draw,%opened_draw;
    game;       next,closing,    light,4,                sinit,%game_init,   update,%game_update,   draw,%game_draw;
    closing;    next,closed,              duration,.25,                      update,nop,            draw,%closing_draw;
]]

-- every state change will clean up all the entities.
|[game_state_init]| function(state)
    clean_all_entities('game_state', 'fader_in')
    state:sinit()
end $$

function _init()
    -- initializing some data to make it easier to work with.
    for i=0,151 do
        c_pokemon[i] = {
            name       = c_pokemon[i][1],
            width      = c_pokemon[i][2],
            height     = c_pokemon[i][3],
            type1      = c_pokemon[i][4],
            type2      = c_pokemon[i][5],
            hp         = c_pokemon[i][6],
            attack     = c_pokemon[i][7],
            defence    = c_pokemon[i][8],
            speed      = c_pokemon[i][9],
            special    = c_pokemon[i][10],
            draw       = function(...) draw_pkmn_out(i, ...) end,
            num        = i,
        }
    end

    c_pokemon[0].draw = function(...)
        if @S_MISSINGNO ~= 0 then
            draw_pkmn_out(i, ...)
        end
    end

    -- clear all the read only memory. testing things out showed that this doesn't get cleared automatically.
    memset(0x8000, 0, 0x7fff)

    poke(0x5f5c, 15) -- set the initial delay before repeating. 255 means never repeat.
    poke(0x5f5d, 5) -- set the repeating delay.

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
end
