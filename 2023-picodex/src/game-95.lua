zclass[[modes,actor|
    push,%modes_push,
    pop,%modes_pop,
    update,nop,
    draw1,nop,
    draw2,nop,
    draw3,nop,
    curr,main;

    stack;,;

    defaults; sub,0, init,nop, update,nop, draw1,nop, draw2,nop, draw3,nop;

    main;        update,%main_update,        draw1,%main_draw1,        draw2,%main_draw2,        draw3,%main_draw3;
    credits;     update,%credits_update,     draw1,%credits_draw1,     draw2,%main_draw2,        draw3,%main_draw3, init,%credits_init;
    browse;      update,%browse_update,      draw1,%browse_draw1,      draw2,%browse_draw2,      draw3,%browse_draw3;
    browsestat;  update,%browsestat_update,  draw1,%browsestat_draw1,  draw2,%browse_draw2,      draw3,%browse_draw3;
    fight;       update,%fight_update,       draw1,%fight_draw1,       draw2,%fight_draw2,       draw3,%fight_draw3;
    party;       update,%party_update,       draw1,%party_draw1,       draw2,%party_draw2,       draw3,%party_draw3;
    editparty;   update,%editparty_update,   draw1,%editparty_draw1,   draw2,%editparty_draw2,   draw3,%editparty_draw3;
    partyaction; update,%partyaction_update, draw1,%partyaction_draw1, draw2,%partyaction_draw2, draw3,%partyaction_draw3;
]]

|[modes_push]| function(a, newstate)
    add(a.stack, newstate)
    a:load(newstate)
end $$

|[modes_pop]| function(a)
    -- delete the last item on the stack, then load the new last item.
    -- most modes on the stack won't have an init in this game.
    deli(a.stack) 
    a:load(a.stack[#a.stack] or 'main')
end $$

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
    a.modes:state()
end $$

|[game_draw]| function(a)
    cls()
    draw_picodex(a:is_active'shaking', 1,
        function() a.modes:draw1() end,
        function() a.modes:draw2() end, 
        function() a.modes:draw3() end, 
        4, false, @S_MODE, #a.modes.stack)
end $$

-- if i run the minifier, we need a separate display name from the state it's mapped to.
c_modes = zobj[[
    len,6;
    0; name,"browse",    state,browse,   desc,"view/pokemon/info";
    1; name,"credits",   state,credits,  desc,"by/amorg/games";
    2; name,"fight",     state,fight,    desc,"pokemon/battle/simulator";
    3; name,"games",     state,games,    desc,"minigames/and/quizzes";
    4; name,"party",     state,party,    desc,"change/your/teams";
    5; name,"settings",  state,settings, desc,"customize/this/picodex";
]]

c_mode_positions = split"2,9,17,26,33"

|[main_update]| function(a)
    if g_bpu or g_bpl then poke(S_MODE, (@S_MODE - 1) % c_modes.len) end
    if g_bpd or g_bpr then poke(S_MODE, (@S_MODE + 1) % c_modes.len) end
    if g_bpx then a:push(c_modes[@S_MODE].state) end
end $$

|[main_draw1]| function(a)
        rectfill(0,15,39,24,1)

        for i=0,4 do
            local text, y = c_modes[(i-2+@S_MODE)%c_modes.len].name, c_mode_positions[i+1]
            if i == 2 then
                wobble_text(text, 20, y, 13)
            else
                zprint(text, 20, y, 1, 0)
            end
        end
end $$

g_picodex_div = zobj[[,6,5,5,6,6,5,6]]
|[main_draw2]| function(a)
    rectfill(0, 0, 46, 13, 13)
    pal(7,1)

    local xx = 0
    for i,v in ipairs(g_picodex_div) do
        sspr(6*8+xx, 6*8, v,8, xx+3, 3.5+cos((t()+i)/4))
        xx += v
    end

    pal()
end $$

|[main_draw3]| function(a)
    print_draw3_message(unpack(split(c_modes[@S_MODE].desc, '/')))
end $$
