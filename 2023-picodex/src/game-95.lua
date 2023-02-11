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
    browse;       init,%browse_init,       draw2,%browse_draw2,    draw3,%browse_draw3;
    partypkmn;    init,%partypkmn_init,    draw2,%browse_draw2,    draw3,%browse_draw3;
    browsestat;   init,%browsestat_init,   draw2,%browse_draw2,    draw3,%browse_draw3,    update,%browsestat_update; -- view pkmn info in browse
    partystat;    init,%partystat_init,    draw2,%editparty_draw2, draw3,%editparty_draw3, update,%partystat_update;  -- view pkmn info in teams
    credits;      init,%credits_init,      draw2,%main_draw2,      draw3,%main_draw3;
    editparty;    init,%editparty_init,    draw2,%editparty_draw2, draw3,%editparty_draw3, draw1,%editparty_draw1;
    fightsel;     init,%fightsel_init;
    main;         init,%main_init,         draw2,%main_draw2,         draw3,%main_draw3         ;
    partyaction;  init,%partyaction_init,  draw2,%editparty_draw2,    draw3,%editparty_draw3    ;
    partymovesel; init,%partymovesel_init, draw2,%partymovesel_draw2, draw3,%partymovesel_draw3 ;
    partymoves;   init,%partymoves_init,   draw2,%partymoves_draw2,   draw3,%partymoves_draw3   ;
    pselactions;  init,%pselactions_init,  draw2,%turn_draw2,         draw3,%pselactions_draw3  ;
    pselmove;     init,%pselmove_init,     draw2,%turn_draw2,         draw3,%pselmove_draw3     ;
    party;        init,%party_init,        draw2,%main_draw2,         draw3,%party_draw3, disable_empty_party,no,  select_func,%party_select;
    fightparty;   init,%party_init,        draw2,%main_draw2,         draw3,%party_draw3, disable_empty_party,yes, select_func,%fight_select;

    -- non-menu states
    -- these are the different states for a fight
    -- get to these with "begin_fight", because a few variables need to be set before entering the fight loop.
    -- the "next" state changes dynamically for p1sel and turn, based on human vs computer players.
    p1sel;        next,p2sel, init,%psel_init, p0key,p1, update,nop, draw1,nop;
    p2sel;        next,turn,  init,%psel_init, p0key,p2, update,nop, draw1,nop;
    turn;         next,p1sel,           update,%turn_update,      draw1,%turn_draw1,      draw2,%turn_draw2, draw3,%turn_draw3, init,%turn_init, cur_action,no;
    fightover;    init,%fightover_init, update,%fightover_update, draw1,%fightover_draw1, draw2,%fightover_draw2, draw3,%fightover_draw3;
]]

|[modes_default_update]| function(game) game.menu.update(game) end $$
|[modes_default_draw1]|  function(game) game.menu.draw1(game)  end $$

|[modes_cursor]| function(game, menu_name)
    return game[menu_name].menu.c
end $$

|[modes_entry]| function(game, menu_name)
    return game[menu_name].menu[game[menu_name].menu.c+1]
end $$

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

|[game_init]| function(game)
    -- unlock all 1st evolutions (pkmn has more evolutions, but this is the first one)
    for i=1,151 do
        if c_pokemon[i].evolvesto and not c_pokemon[i].evolvesfrom then
            poke(S_POKEMON+i, 1)
        end
    end

    -- todo: remove me and/or refactor me
    game.modes = _g.modes()

    zcall(function(menu_name, create_func, ...)
        game.modes[menu_name].menu = create_func(...)
    end, [[
        ;,browse,       %create_menu,      %browse_drawentry, 4 -- selecting a pkmn from dex (for browsing or changing team pkmn)
       ;;,browsestat,   %create_menu_view, %menu_drawentry      -- info for pkmn in browse mode
       ;;,partystat,    %create_menu_view, %menu_drawentry      -- info for pkmn in party mode
       ;;,credits,      %create_menu_view, %menu_drawentry      
       ;;,editparty,    %create_menu,      %browse_drawentry, 3 -- selecting a pkmn from party
       ;;,fightsel,     %create_menu,      %menu_drawentry      -- select a computer to play against
       ;;,main,         %create_menu,      %menu_drawentry      -- select a mode
       ;;,partyaction,  %create_menu,      %menu_drawentry      -- edit party what to do (delete, edit moves, edit pkmn)
       ;;,party,        %create_menu,      %menu_drawentry      -- select a party (1, 2, 3)
       ;;,partymovesel, %create_menu,      %menu_drawentry      -- select one of the moves a pokemon can learn (tms, hms, natural moves...)
       ;;,partymoves,   %create_menu,      %menu_drawentry      -- select 1 of 4 moves from a pokemon
       ;;,pselactions,  %create_menu,      %menu_drawentry      -- select an action during battle (fight, switch, forfeit)
       ;;,pselmove,     %create_menu,      %menu_drawentry      -- select 1 of 4 moves from a pokemon (during battle) -- TODO: try merging with other move select
    ]])

    game.modes.main.menu.cancel        = _g.beep -- only 2 menus you can't pop from.
    game.modes.pselactions.menu.cancel = _g.beep

    game.modes.fightparty.menu   = game.modes.party.menu  -- these menus share the cursor position
    game.modes.partypkmn.menu    = game.modes.browse.menu

    sfx(61,0)

    menuitem(1, "close picodex", function()
        menuitem(1) -- remove menu item
        menuitem(2) -- remove menu item
        game:load'closing'
    end)

    menuitem(2, "swap 🅾️/❎", function()
        poke(S_SWAP_CONTROLS, @S_SWAP_CONTROLS == 0 and 1 or 0)
    end)
end $$

|[game_update]| function(program)
    program.modes:state()
end $$

|[game_draw]| function(program)
    cls()
    draw_picodex(program:is_active'shaking', 1,
        function() program.modes:draw1() end,
        function() program.modes:draw2() end, 
        function() program.modes:draw3() end, 
        4, false, program.modes.main.menu.c, #program.modes.stack)
end $$
