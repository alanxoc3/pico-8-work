f_zclass[[o_game_state,o_actor|
    curr,moveup;

    init,%f_game_state_init;
    ecs_exclusions; o_actor,yes; -- remove o_game_state from the o_actor group
    defaults;
        foldstate,closed,
        light,0,
        backbuttonheld,no,
        sinit,%f_nop, update,%f_nop, draw,%f_nop,
        draw1,%f_nop, draw2,%f_nop, draw3,%f_nop,
        modes,;

    wait;   next,moveup, duration,1,    draw,%f_logo_draw;
    moveup; next,closed, duration,.125, draw,%f_logo_draw, sinit,%f_moveup_init;

    closed;     foldstate,closed,  next,opening,                          sinit,%f_closed_init, draw,%f_draw_picodex2, update,%f_closed_update;
    opening;    foldstate,opening, next,starting_1,          duration,.2,                       draw,%f_draw_picodex2;
    starting_1; foldstate,open,    next,starting_2, light,1, duration,.2, sinit,%f_beep_okay,   draw,%f_draw_picodex2;
    starting_2; foldstate,open,    next,starting_3, light,2, duration,.2, sinit,%f_beep_back,   draw,%f_draw_picodex2;
    starting_3; foldstate,open,    next,game,       light,3, duration,.2, sinit,%f_beep,        draw,%f_draw_picodex2;
    game;       foldstate,open,    next,closing,    light,4,              sinit,%f_game_init,   draw,%f_draw_picodex2, update,%f_game_update, draw1,%f_game_draw1, draw2,%f_game_draw2, draw3,%f_game_draw3;

    closing;    foldstate,closing, next,closed,              duration,.25,                      draw,%f_draw_picodex2, update,%f_nop;
]]

-- every state change will clean up all the entities.
|[f_game_state_init]| function(state)
    f_clean_all_entities('o_game_state', 'o_fader_in')
    state:sinit()
end $$

|[f_logo_draw]| function()
    f_cool_bg()
    f_zprint("aMORG gAMES", 64, 64+-4, 7, 0)
    f_zprint("pRESENTS",    64, 64+3, 7, 0)
end $$

function _init()
    local _ENV = _g

    -- clear all the read only memory. testing things out showed that this doesn't get cleared automatically.
    _memset(0x8000, 0, 0x7fff)

    _poke(0x5f5c, 8) -- set the initial delay before repeating. 255 means never repeat.
    _poke(0x5f5d, 2) -- set the repeating delay.

    g_picodex = o_game_state()
    f_logo_draw()
    -- f_draw_picodex2(g_picodex)
    _sfx(63,1,24)

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

    _menuitem(1, "change groove", function()
        poke(S_BG_PATTERN, (@S_BG_PATTERN+1) % #g_bgs)
    end)
end

function _update60()
    local _ENV = _g
    g_bpo, g_bpx = _btnp'4', _btnp'5'
    -- horizontal and vertical
    g_bph, g_bpv = f_btn_helper(_btnp, 0, 1), f_btn_helper(_btnp, 2, 3)

    if @S_SWAP_CONTROLS == 1 then
        g_bpo, g_bpx = g_bpx, g_bpo
    end

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
