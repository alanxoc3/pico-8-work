-- every state change will clean up all the entities.
|[f_game_state_init]| function(state)
    f_minisfx(state.sfx)
    state:sinit()
end $$

function _init()
    local _ENV = _g

    -- clear all the read only memory. testing things out showed that this doesn't get cleared automatically.
    _memset(0x8000, 0, 0x7fff)

    g_picodex = f_zclass[[
        curr,wait;
        init,%f_game_state_init, light,4;
        defaults;
            foldstate,closed,
            light,4, sfx,-1,
            backbuttonheld,%c_no,
            sinit,%f_nop, update,%f_nop, draw,%f_nop,
            draw1,%f_nop, draw2,%f_nop, draw3,%f_nop,
            modes,;

        wait;   next,moveup, duration,.5, draw,%f_draw_picodex;
        moveup; next,closed, duration,.5, draw,%f_draw_picodex, sinit,%f_moveup_init;

        shaking;    foldstate,closed,  next,closed,              duration,.5,                       draw,%f_draw_picodex;
        closed;     foldstate,closed,  next,opening,                          sinit,%f_closed_init, draw,%f_draw_picodex, update,%f_closed_update;
        opening;    foldstate,opening, next,starting_1,          duration,.2,                       draw,%f_draw_picodex;
        starting_1; foldstate,open,    next,starting_2, light,3, duration,.2, sfx,B_OKAY,           draw,%f_draw_picodex;
        starting_2; foldstate,open,    next,starting_3, light,2, duration,.2, sfx,B_BACK,           draw,%f_draw_picodex;
        starting_3; foldstate,open,    next,game,       light,1, duration,.2, sfx,B_ERROR,          draw,%f_draw_picodex;
        game;       foldstate,open,    next,closing,    light,0,              sinit,%f_game_init,   draw,%f_draw_picodex, update,%f_game_update, draw1,%f_game_draw1, draw2,%f_game_draw2, draw3,%f_game_draw3;

        closing;    foldstate,closing, next,closed,              duration,.25,                      draw,%f_draw_picodex, update,%f_nop;
    ]]

    f_draw_picodex(g_picodex)
    _flip()
    f_minisfx'158'
    f_extract_sheet(0) -- 0x0000
    f_extract_sheet(1) -- 0x0002
    f_extract_sheet(2) -- 0x0004

    f_zcall(_poke, [[
         ;,0x5f5c, 8    -- set the initial delay before repeating. 255 means never repeat.
        ;;,0x5f5d, 2    -- set the repeating delay.
        ;;,0x5f56, 0xe0 -- make map funcs point here instead
    ]])

    -- 0x0006
    f_px9_decomp(_peek2(3*2), _mget, _mset)

    -- 0x0008
    f_populate_c_moves()
    f_populate_c_pokemon()

    -- Need the pokedex tiles to stay loaded. This starts at sprite index #96.
    _memcpy(0x0000, 0xc000, 0x2000)
end

function _update60()
    local _ENV = _g
    g_bpo, g_bpx = _btnp'4', _btnp'5'

    -- horizontal and vertical
    g_bph, g_bpv = f_btn_helper(_btnp, 0, 1), f_btn_helper(_btnp, 2, 3)

    if @S_SWAP_CONTROLS == 1 then
        g_bpo, g_bpx = g_bpx, g_bpo
    end

    g_picodex:state()
end

function _draw()
    local _ENV = _g
    g_picodex:draw()
end
