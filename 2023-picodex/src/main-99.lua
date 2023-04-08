-- every state change will clean up all the entities.
|[f_game_state_init]| function(state)
    if state.mysfx then f_minisfx(state.mysfx) end
    state:sinit()
end $$

function __init()
    local _ENV = _g

    -- clear all the read only memory. testing things out showed that this doesn't get cleared automatically.
    _memset(0x8000, 0, 0x7fff)

    g_picodex = f_zclass[[
        curr,wait, init,~f_game_state_init, light,4; -- light,4 is needed here, otherwise, there is an error on startup

        defaults;
            foldstate,closed,
            light,4, mysfx,~c_no,
            backbuttonheld,~c_no,
            sinit,~f_nop, update,~f_nop, draw,~f_nop,
            draw1,~f_nop, draw2,~f_nop, draw3,~f_nop,
            modes,;

        wait;   next,moveup, duration,.5, draw,~f_draw_picodex;
        moveup; next,closed, duration,.5, draw,~f_draw_picodex;

        shaking;    foldstate,closed,  next,closed,                duration,.5, mysfx,159,                        draw,~f_draw_picodex;
        closed;     foldstate,closed,  next,opening,                          sinit,~f_closed_init,             draw,~f_draw_picodex, update,~f_closed_update;
        opening;    foldstate,opening, next,starting_1,            duration,.2,                                   draw,~f_draw_picodex;
        starting_1; foldstate,open,    next,starting_2, light,3, duration,.2, mysfx,B_OKAY,                     draw,~f_draw_picodex;
        starting_2; foldstate,open,    next,starting_3, light,2, duration,.2, mysfx,B_BACK,                     draw,~f_draw_picodex;
        starting_3; foldstate,open,    next,game,       light,1, duration,.2, mysfx,B_ERROR,                    draw,~f_draw_picodex;
        game;       foldstate,open,    next,closing,    light,0,              mysfx,B_DONE, sinit,~f_game_init, draw,~f_draw_picodex, update,~f_game_update, draw1,~f_game_draw1, draw2,~f_game_draw2, draw3,~f_game_draw3;

        closing;    foldstate,closing, next,closed,                duration,.25,                                draw,~f_draw_picodex, update,~f_nop;
    ]]

    f_draw_picodex(g_picodex)
    _flip()

    _sfx(53, 2)
    f_extract_sheet(0x0)
    f_extract_sheet(0x2)
    f_extract_sheet(0x4)

    f_zcall(_poke, [[
         ;,0x5f5c, 8    -- set the initial delay before repeating. 255 means never repeat.
        ;;,0x5f5d, 2    -- set the repeating delay.
        ;;,0x5f56, 0xe0 -- make map funcs point here instead
    ]])

    -- 0x0006
    f_px9_decomp(_peek2'0x6', _mget, _mset)

    f_populate_c_moves()

    -- 0x0008
    f_populate_c_pokemon()

    -- 0x000a trainers
    local trainer_loc = _peek2'0xa'
    for i, v in _pairs(c_trainers) do
        local tbl = {name=v}
        for j=1,6 do
            _add(tbl, _peek(trainer_loc))
            trainer_loc += 1
        end
        c_trainers[i] = tbl
    end

    -- Need the pokedex tiles to stay loaded. This starts at sprite index #96.
    f_zcall(_memcpy, [[;,0x0000, 0xc000, 0x2000]])
end

function __update60()
    local _ENV = _g
    g_bpo, g_bpx, g_bph, g_bpv = _btnp'4', _btnp'5', _btnp'0' and _btnp'1' and 0 or _btnp'0' and -1 or _btnp'1' and 1 or 0, _btnp'2' and _btnp'3' and 0 or _btnp'2' and -1 or _btnp'3' and 1 or 0

    if @S_SWAP_CONTROLS == 1 then
        g_bpo, g_bpx = g_bpx, g_bpo
    end

    g_picodex:f_actor_state()

    -- you can set the music speed with this
    -- _poke(0x4055, 96)
end

function __draw()
    local _ENV = _g
    g_picodex:draw()
end
