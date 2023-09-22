-- every state change will clean up all the entities.
|[f_game_state_init]| function(state)
    if state.mysfx then f_minisfx(state.mysfx) end
    state:sinit()
end $$

function _init()
    local _ENV = _g -- todo: this can be removed i think

    -- clear all the read only memory. testing things out showed that this doesn't get cleared automatically.
    memset(0x8000, 0, 0x7fff)

    menuitem(1, "reset data", function()
        memset(0x5e00, 0, 0x100)
        reboot()
    end)

    g_picodex = f_zclass[[
        curr,wait, init,~f_game_state_init, light,4; -- light,4 is needed here, otherwise, there is an error on startup

        defaults;
            foldstate,closed,
            light,4, mysfx,~c_no,
            backbuttonheld,~c_no,
            sinit,~f_nop, update,~f_nop, draw,~f_nop,
            draw1,~f_nop, draw2,~f_nop, draw3,~f_nop,
            modes,;

        wait;   next,moveup, duration,.3, draw,~f_draw_picodex;
        moveup; next,game, duration,.3, draw,~f_draw_picodex, mysfx,157;
        game;   foldstate,open,    next,closing,    light,0,              mysfx,B_DONE, sinit,~f_game_init, draw,~f_draw_picodex, update,~f_game_update, draw1,~f_game_draw1, draw2,~f_game_draw2, draw3,~f_game_draw3;
    ]]

    flip()

    f_minisfx_now'153' f_extract_sheet(0x0)
    f_minisfx_now'154' f_extract_sheet(0x2)
    f_minisfx_now'155' f_extract_sheet(0x4)

    f_zcall(poke, [[
         ;,0x5f5c, 8    -- set the initial delay before repeating. 255 means never repeat.
        ;;,0x5f5d, 2    -- set the repeating delay.
        ;;,0x5f56, 0xe0 -- make map funcs point here instead
    ]])

    -- 0x0006
    f_px9_decomp(peek2'0x6', mget, mset)

    f_populate_c_moves()

    -- 0x0008
    f_populate_c_pokemon()

    -- at the end of picodex development, i stored half the trainers in code. half are stored in cartridge data.
    local trainer_loc = peek2'0xa'
    for i=1,40 do
        c_trainers[i] = {name=c_trainer_names[i]}
        for j=1,6 do
            add(c_trainers[i], peek(trainer_loc))
            trainer_loc += 1
        end
    end

    -- Need the picodex tiles to stay loaded. This starts at sprite index #96.
    f_zcall(memcpy, [[;,0x0000, 0xc000, 0x2000]])
end

function _update60()
    local _ENV = _g
    g_bpo, g_bpx, g_bph, g_bpv = btnp'4', btnp'5', btnp'0' and btnp'1' and 0 or btnp'0' and -1 or btnp'1' and 1 or 0, btnp'2' and btnp'3' and 0 or btnp'2' and -1 or btnp'3' and 1 or 0

    if @S_SWAP_CONTROLS == 1 then
        g_bpo, g_bpx = g_bpx, g_bpo
    end

    g_picodex:f_actor_state()

    -- you can set the music speed with this
    -- poke(0x4055, 96)
    if g_cur_sound then
        -- returns nothing, so sets to nil
        g_cur_sound = f_minisfx_now(g_cur_sound)
    end
end

function _draw()
    local _ENV = _g
    g_picodex:draw()
end
