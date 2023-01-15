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

    main;         update,%main_update,         draw1,%main_draw1,         draw2,%main_draw2,         draw3,%main_draw3;
    credits;      update,%credits_update,      draw1,%credits_draw1,      draw2,%main_draw2,         draw3,%main_draw3, credits_offset,5;
    browse;       update,%browse_update,       draw1,%browse_draw1,       draw2,%browse_draw2,       draw3,%browse_draw3;
    browsestat;   update,%browsestat_update,   draw1,%browsestat_draw1,   draw2,%browse_draw2,       draw3,%browse_draw3;
    fightparty;   update,%party_update,        draw1,%party_draw1,        draw2,%party_draw2,        draw3,%party_draw3,        select_func,%fight_select;
    fightsel;     update,%fightsel_update,     draw1,%fightsel_draw1,     draw2,%fightsel_draw2,     draw3,%fightsel_draw3,     init,%fightsel_init;
    fight;        update,%fight_update,        draw1,%fight_draw1,        draw2,%fight_draw2,        draw3,%fight_draw3,        init,%fight_init;

    party;        update,%party_update,        draw1,%party_draw1,        draw2,%party_draw2,        draw3,%party_draw3,        select_func,%party_select;
    editparty;    update,%editparty_update,    draw1,%editparty_draw1,    draw2,%editparty_draw2,    draw3,%editparty_draw3;
    partyaction;  update,%partyaction_update,  draw1,%partyaction_draw1,  draw2,%editparty_draw2,    draw3,%partyaction_draw3,  init,%partyaction_init;
    partypkmn;    update,%partypkmn_update,    draw1,%partypkmn_draw1,    draw2,%partypkmn_draw2,    draw3,%partypkmn_draw3,    init,%partypkmn_init;
    partymoves;   update,%partymoves_update,   draw1,%partymoves_draw1,   draw2,%editparty_draw2,    draw3,%partymoves_draw3,   init,%partymoves_init;
    partymovesel; update,%partymovesel_update, draw1,%partymovesel_draw1, draw2,%partymovesel_draw2, draw3,%partymovesel_draw3, init,%partymovesel_init;
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
        4, false, @S_CURSOR_MODE, #a.modes.stack)
end $$

-- if i run the minifier, we need a separate display name from the state it's mapped to.
c_modes = zobj[[
    ;name,"browse",    state,browse,     func,%menu_state_callback, desc,"view|pokemon|info"
   ;;name,"credits",   state,credits,    func,%menu_state_callback, desc,"by|amorg|games"
   ;;name,"fight",     state,fightparty, func,%menu_state_callback, desc,"pokemon|battle|simulator"
   ;;name,"games",     state,games,      func,%menu_state_callback, desc,"minigames|and|quizzes"
   ;;name,"party",     state,party,      func,%menu_state_callback, desc,"change|your|teams"
   ;;name,"settings",  state,settings,   func,%menu_state_callback, desc,"customize|this|picodex"
]]

|[main_update]| function(a) menu_update(a, S_CURSOR_MODE, c_modes) end $$
|[main_draw1]|  function(a) menu_draw1 (a, S_CURSOR_MODE, c_modes) end $$
|[main_draw3]|  function(a) menu_draw3 (a, S_CURSOR_MODE, c_modes) end $$

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

