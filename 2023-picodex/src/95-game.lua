zclass[[modes,actor|
    draw1,nop, draw2,nop, draw3,nop, curr,main;
    defaults; init,nop, update,nop, draw1,nop, draw2,nop, draw3,nop;

    main;   update,%main_update, draw1,%main_draw1;
    browse; update,%browse_update, draw1,%browse_draw1, draw2,%browse_draw2, draw3,%browse_draw3;
    battle; update,%battle_update, draw1,%battle_draw1, draw2,%battle_draw2, draw3,%browse_draw3;
]]

|[game_init]| function(a)
    a.modes = _g.modes()
    sfx(61,0)

    menuitem(1, "close picodex", function()
        menuitem(1)
        menuitem(2)
        a:load'closing'
    end)

    menuitem(2, "swap 🅾️/❎", function()
        poke(S_SWAP_CONTROLS, @S_SWAP_CONTROLS == 0 and 1 or 0)
    end)
end $$

|[game_update]| function(a)
    loop_entities('modes', 'state')
end $$

|[game_draw]| function(a)
    cls()
    draw_picodex(a:is_active'shaking', 1,
        function() a.modes:draw1() end,
        function() a.modes:draw2() end, 
        function() a.modes:draw3() end, 
        4)
end $$

-- if i run the minifier, we need a separate display name from the state it's mapped to.
c_modes = zobj[[
    len,6;
    4; name,"battle",  state,battle;
    5; name,"party",   state,party;
    0; name,"browse",  state,browse;
    1; name,"quiz",    state,quiz;
    2; name,"config",  state,config;
    3; name,"credits", state,credits;
]]

c_mode_positions = split"1,8,16,25,32"

|[main_update]| function(a)
    if g_bpu or g_bpl then poke(S_MODE, (@S_MODE - 1) % c_modes.len) end
    if g_bpd or g_bpr then poke(S_MODE, (@S_MODE + 1) % c_modes.len) end
    if g_bpx then a:load(c_modes[@S_MODE].state) end
end $$

|[main_draw1]| function(a)
        rectfill(0,14,37,23,1)

        for i=0,4 do
            local text, y = c_modes[(i-2+@S_MODE)%c_modes.len].name, c_mode_positions[i+1]
            if i == 2 then
                wobble_text(text, 19, y, 13)
            else
                zprint(text, 19, y, 1, 0)
            end
        end
end $$
