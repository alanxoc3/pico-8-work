-- todo: try splitting minifier on underscore
-- todo: rename "party" to "team" for consistency

zclass[[modes,actor|
    cursor,%modes_cursor, -- gets the cursor for a menu
    entry,%modes_entry,   -- gets the entry the cursor is on
    push,%modes_push,
    pop,%modes_pop,
    update,nop,
    draw1,nop,
    draw2,nop,
    draw3,nop,
    curr,main;

    stack;,;

    -- defaults are mostly functions, but also menu
    defaults; menu,no, finit,nop, init,nop, update,%modes_default_update, draw1,%modes_default_draw1, draw2,nop, draw3,nop;

    -- menu states
    browse;       init,%browse_init,       draw2,%browse_draw2,       draw3,%browse_draw3;
    partypkmn;    init,%partypkmn_init,    draw2,%browse_draw2,       draw3,%browse_draw3;
    browsestat;   init,%browsestat_init,   draw2,%browse_draw2,       draw3,%browse_draw3,    update,%browsestat_update; -- view pkmn info in browse
    partystat;    init,%partystat_init,    draw2,%editparty_draw2,    draw3,%editparty_draw3, update,%partystat_update;  -- view pkmn info in teams
    credits;      init,%credits_init,      draw2,%main_draw2,         draw3,%main_draw3;
    fightover;    init,%fightover_init,    draw2,%fightover_draw2,    draw3,%fightover_draw3;
    editparty;    init,%editparty_init,    draw2,%editparty_draw2,    draw3,%editparty_draw3, draw1,%editparty_draw1;
    main;         init,~main_init,         draw2,~main_draw2,         draw3,~main_draw3         ;
    partyaction;  init,%partyaction_init,  draw2,%editparty_draw2,    draw3,%editparty_draw3    ;
    partymovesel; init,%partymovesel_init, draw2,%partymovesel_draw2, draw3,%move_draw3;
    partymoves;   init,%partymoves_init,   draw2,%partymoves_draw2,   draw3,%move_draw3;
    pselactions;  init,%pselactions_init,  draw2,%turn_draw2,         draw3,%pselactions_draw3  ;
    pselmove;     init,%pselmove_init,     draw2,%turn_draw2,         draw3,%move_draw3;

    team1;        init,%party_init,        draw2,%main_draw2,         draw3,%party_draw3, disable_empty_party,no,  select_func,%party_select;  -- t1
    team1fight;   init,%party_init,        draw2,%main_draw2,         draw3,%party_draw3, disable_empty_party,yes,  select_func,%fight_select; -- s1
    team2;        init,%party_init,        draw2,%main_draw2,         draw3,%party_draw3, disable_empty_party,yes, select_func,%fight_select;  -- ??
    team2cpu;     init,%fightsel_init,     draw2,%main_draw2,         draw3,%party_draw3;                                                      -- t2

    -- fightsel;     init,%fightsel_init,     draw2,%main_draw2,         draw3,%party_draw3;
    -- fightparty;   init,%fightsel_init,     draw2,%main_draw2,         draw3,%party_draw3, disable_empty_party,yes, select_func,%fight_select;

    -- non-menu states
    -- these are the different states for a fight
    -- get to these with "begin_fight", because a few variables need to be set before entering the fight loop.
    -- the "next" state changes dynamically for p1sel and turn, based on human vs computer players.
    p1sel;        next,p2sel, init,%psel_init, p0key,p1, update,nop, draw1,nop;
    p2sel;        next,turn,  init,%psel_init, p0key,p2, update,nop, draw1,nop;
    turn;         next,p1sel,           update,%turn_update,      draw1,%turn_draw1,      draw2,%turn_draw2, draw3,%turn_draw3, init,%turn_init, cur_action,no;
]]

|[modes_default_update]| function(_ENV) menu.update(_ENV) end $$
|[modes_default_draw1]|  function(_ENV) menu.draw1(_ENV)  end $$

|[modes_cursor]| function(_ENV, menu_name)
    return _ENV[menu_name].menu.c
end $$

|[modes_entry]| function(_ENV, menu_name)
    local menu = (menu_name and _ENV[menu_name].menu or menu)
    return menu[menu.c+1]
end $$

|[modes_push]| function(_ENV, newstate)
    _add(stack, newstate)
    _ENV:actor_load(newstate)
end $$

|[modes_pop]| function(_ENV)
    -- delete the last item on the stack, then load the new last item.
    -- most modes on the stack won't have an init in this game.
    _deli(stack) 
    _ENV:load(stack[#stack] or 'main')
end $$

|[game_init]| function(_ENV)
    -- unlock all 1st evolutions (pkmn has more evolutions, but this is the first one)
    for i=1,151 do
        if c_pokemon[i].evolvesto and not c_pokemon[i].evolvesfrom then
            _poke(S_POKEMON+i, 1)
        end
    end

    -- todo: remove me and/or refactor me
    modes = modes()

    zcall(function(menu_name, create_func, ...)
        modes[menu_name].menu = create_func(...)
    end, [[
        ;,browse,       ~create_menu,      ~browse_drawentry, 4 -- selecting a pkmn from dex (for browsing or changing team pkmn)
       ;;,browsestat,   ~create_menu_view, ~menu_drawentry      -- info for pkmn in browse mode
       ;;,partystat,    ~create_menu_view, ~menu_drawentry      -- info for pkmn in party mode
       ;;,credits,      ~create_menu_view, ~menu_drawentry      -- credits view obviously
       ;;,fightover,    ~create_menu_view, ~menu_drawentry      -- stats that display when you finish a fight
       ;;,editparty,    ~create_menu,      ~browse_drawentry, 3 -- selecting a pkmn from party
       ;;,main,         ~create_menu,      ~menu_drawentry      -- select a mode
       ;;,partyaction,  ~create_menu,      ~menu_drawentry      -- edit party what to do (delete, edit moves, edit pkmn)
       ;;,partymovesel, ~create_menu,      ~menu_drawentry      -- select one of the moves a pokemon can learn (tms, hms, natural moves...)
       ;;,partymoves,   ~create_menu,      ~menu_drawentry      -- select 1 of 4 moves from a pokemon
       ;;,pselactions,  ~create_menu,      ~menu_drawentry      -- select an action during battle (fight, switch, forfeit)
       ;;,pselmove,     ~create_menu,      ~menu_drawentry      -- select 1 of 4 moves from a pokemon (during battle) -- TODO: try merging with other move select

       ;;,team1,        ~create_menu,      ~menu_drawentry      -- select a party (1, 2, 3, presets...)
       ;;,team2,        ~create_menu,      ~menu_drawentry      -- select a party (1, 2, 3, presets...)
    ]])

    modes.main.menu.cancel        = beep -- only 2 menus you can't pop from.
    modes.pselactions.menu.cancel = beep

    -- these menus share the cursor position
    modes.team1fight.menu  = modes.team1.menu
    modes.team2cpu.menu    = modes.team2.menu
    modes.partypkmn.menu   = modes.browse.menu

    _sfx(61,0)

    _menuitem(1, "close picodex", function()
        _menuitem(1) -- remove menu item
        _menuitem(2) -- remove menu item
        _ENV:load'closing'
    end)

    _menuitem(2, "swap 🅾️/❎", function()
        _poke(S_SWAP_CONTROLS, @S_SWAP_CONTROLS == 0 and 1 or 0)
    end)
end $$

|[game_update]| function(program)
    program.modes:state()
end $$

|[game_draw]| function(program)
    _cls()
    draw_picodex(program:is_active'shaking', 1,
        function() program.modes:draw1() end,
        function() program.modes:draw2() end, 
        function() program.modes:draw3() end, 
        4, false, program.modes.main.menu.c, #program.modes.stack)
end $$
