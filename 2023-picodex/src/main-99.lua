f_zclass[[o_game_state,o_actor|
    curr,fadein; -- curr,logo;

    init,%f_game_state_init;
    ecs_exclusions; o_actor,yes; -- remove o_game_state from the o_actor group
    defaults;       sinit,%f_nop, update,%f_nop, draw,%f_nop, light,0, backbuttonheld,no, modes,;

    logo; next,fadein, sinit,%f_logo_init, update,%f_nop, draw,%f_logo_draw, duration,2.5;

    fadein; next,game, duration,0, sinit,%f_gamefadein_init; -- fadein; next,closed, duration,0, sinit,%f_gamefadein_init;

    closed;     next,opening,                            sinit,%f_closed_init, update,%f_closed_update, draw,%f_closed_draw;
    opening;    next,starting_1,          duration,.25,                                             draw,%f_opening_draw;
    starting_1; next,starting_2, light,1, duration,.125, sinit,%f_beep, draw,%f_opened_draw;
    starting_2; next,starting_3, light,2, duration,.125, sinit,%f_beep, draw,%f_opened_draw;
    starting_3; next,game,       light,3, duration,.125, sinit,%f_beep, draw,%f_opened_draw;
    game;       next,closing,    light,4,                sinit,%f_game_init,   update,%f_game_update,   draw,%f_game_draw;
    closing;    next,closed,              duration,.25,                      update,%f_nop,            draw,%f_closing_draw;
]]

-- every state change will clean up all the entities.
|[f_game_state_init]| function(state)
    f_clean_all_entities('o_game_state', 'o_fader_in')
    state:sinit()
end $$

function _init()
    local _ENV = _g

    -- clear all the read only memory. testing things out showed that this doesn't get cleared automatically.
    _memset(0x8000, 0, 0x7fff)

    _poke(0x5f5c, 12) -- set the initial delay before repeating. 255 means never repeat.
    _poke(0x5f5d, 2) -- set the repeating delay.

    _cls()
    _sfx(62,0) -- a sound indicator that the came is actually running while loading

-- NORMAL_BEGIN -- debug mode doesn't need to load these sheets for faster startup

    -- 0x0000
    f_extract_sheet(0)

    -- 0x0002
    f_extract_sheet(1)

-- NORMAL_END

    -- 0x0004
    f_extract_sheet(2)

    _poke(0x5f56, 0xe0) -- make map funcs point here instead

    -- 0x0006
    f_px9_decomp(0, 0, _peek2(3*2), _mget, _mset)

    -- 0x0008
    f_populate_c_moves()
    f_populate_c_pokemon()

    -- Need the pokedex tiles to stay loaded. This starts at sprite index #96.
    _memcpy(0x0000, 0xc000, 0x2000)

    g_tl = o_game_state()
end

function _update60()
    local _ENV = _g
    g_bl, g_br, g_bu, g_bd, g_bo, g_bx, g_bpl, g_bpr, g_bpu, g_bpd, g_bpo, g_bpx = _btn'0', _btn'1', _btn'2', _btn'3', _btn'4', _btn'5', _btnp'0', _btnp'1', _btnp'2', _btnp'3', _btnp'4', _btnp'5'
    g_available_pokemon = {}
    for i=0,151 do
        if @(S_POKEMON+i) > 0 then
            _add(g_available_pokemon, i)
        end
    end

    if @S_SWAP_CONTROLS == 1 then
        g_bo,  g_bx  = g_bx,  g_bo
        g_bpo, g_bpx = g_bpx, g_bpo
    end

    -- DEBUG_BEGIN
    if g_bo and g_bpx then g_debug = not g_debug end
    -- DEBUG_END

    f_zcall(f_loop_entities, [[
        1;,o_actor,clean;
        2;,o_fader,clean;
    ]])

    f_register_entities()

    f_zcall(f_loop_entities, [[
        1;,o_fader,tick;
        2;,o_game_state,tick;
        3;,o_fader,state;
        4;,o_game_state,state;
    ]])
end

function _draw()
    local _ENV = _g
    _cls()
    f_loop_entities('o_game_state', 'draw')
    f_fade(g_fade)
end

|[f_parse_numlist]| function(str)
    local tbl = {}
    for x in _all(_split(str or '', '|')) do
        if _type(x) == "number" then
            _add(tbl, x)
        end
    end
    return tbl
end $$

-- how does it l
-- 1-5|10|20

-- 255 = dash
-- 0   = next-pkmn
