-- todo: rename "party" to "team" for consistency

f_zclass[[o_modes,o_actor|
    cursor,%f_modes_cursor, -- gets the cursor for a menu
    entry,%f_modes_entry,   -- gets the entry the cursor is on
    push,%f_modes_push,
    pop,%f_modes_pop,
    update,%f_nop,
    draw1,%f_nop,
    draw2,%f_nop,
    draw3,%f_nop,
    curr,main;

    stack;,;

    -- defaults are mostly functions, but also menu
    defaults;
        menu,no,
        ui_pl,"error",
        finit,%f_nop,
        init,%f_nop,
        update,%f_modes_default_update,
        draw1,%f_modes_default_draw1,
        draw2,%f_nop,
        draw3,%f_nop;

    -- main
    main; init,~f_main_init, draw2,~f_main_draw2, draw3,~f_main_draw3;

    -- browse
    browse;       init,%f_browse_init,     draw2,%f_browse_draw2, draw3,%f_browse_draw3;
    browsestat;   init,%f_browsestat_init, draw2,%f_browse_draw2, draw3,%f_browse_draw3, update,%f_browsestat_update; -- view pkmn info in browse

    -- edit
    editparty;    init,%f_editparty_init,    draw2,%f_editparty_draw2,    draw3,%f_editparty_draw3, draw1,%f_editparty_draw1;
    partypkmn;    init,%f_partypkmn_init,    draw2,%f_browse_draw2,       draw3,%f_browse_draw3;
    switchparty;  init,%f_switchparty_init,  draw2,%f_editparty_draw2,    draw3,%f_editparty_draw3, draw1,%f_editparty_draw1;
    partyaction;  init,%f_partyaction_init,  draw2,%f_editparty_draw2,    draw3,%f_editparty_draw3;
    moveaction;   init,%f_moveaction_init,   draw2,%f_partymoves_draw2,   draw3,%f_move_draw3;
    partymovesel; init,%f_partymovesel_init, draw2,%f_partymovesel_draw2, draw3,%f_move_draw3;
    partymoves;   init,%f_partymoves_init,   draw2,%f_partymoves_draw2,   draw3,%f_move_draw3;

    -- pre-fight menus
    team1;        ui_pl,"player 1", init,%f_party_init,    draw2,%f_team_draw2, draw3,%f_party_draw3, disable_empty_party,no,   select_func,%f_party_select; -- t1
    team1story;   ui_pl,"player 1", init,%f_party_init,    draw2,%f_team_draw2, draw3,%f_party_draw3, disable_empty_party,yes,  select_func,%f_story_select; -- s1
    team1match;   ui_pl,"player 1", init,%f_party_init,    draw2,%f_team_draw2, draw3,%f_party_draw3, disable_empty_party,yes,  select_func,%f_match_select; -- s1
    team1horde;   ui_pl,"player 1", init,%f_party_init,    draw2,%f_team_draw2, draw3,%f_party_draw3, disable_empty_party,yes,  select_func,%f_horde_select; -- s1
    team2match;   ui_pl,"player 2", init,%f_party_init,    draw2,%f_team_draw2, draw3,%f_party_draw3, disable_empty_party,yes,  select_func,%f_match_start;  -- s1
    team2story;   ui_pl,"trainer",  init,%f_fightsel_init, draw2,%f_team_draw2, draw3,%f_party_draw3;                                                        -- t2

    -- in-fight menus
    fightover;    init,%f_fightover_init,    draw2,%f_fightover_draw2,    draw3,%f_fightover_draw3;
    pselactions;  init,%f_pselactions_init,  draw2,%f_turn_draw2,         draw3,%f_pselactions_draw3;
    pselmove;     init,%f_pselmove_init,     draw2,%f_turn_draw2,         draw3,%f_move_draw3;
    pselswitch;   init,%f_pselswitch_init,   draw2,%f_turn_draw2,         draw3,%f_pselactions_draw3, draw1,%f_editparty_draw1;

    -- in-fight screens
    p1sel;        next,p2sel, init,%f_psel_init, update,%f_nop,         draw1,%f_nop,        p0key,p1;
    p2sel;        next,turn,  init,%f_psel_init, update,%f_nop,         draw1,%f_nop,        p0key,p2;
    turn;         next,p1sel, init,%f_turn_init, update,%f_turn_update, draw1,%f_turn_draw1, draw2,%f_turn_draw2, draw3,%f_turn_draw3, cur_action,no;

    -- credits
    credits;      init,%f_credits_init,      draw2,%f_main_draw2,         draw3,%f_main_draw3;
]]

|[f_modes_default_update]| function(_ENV) menu.update(_ENV) end $$
|[f_modes_default_draw1]|  function(_ENV) menu.draw1(_ENV)  end $$

|[f_modes_cursor]| function(_ENV, menu_name)
    return _ENV[menu_name].menu.c
end $$

|[f_modes_entry]| function(_ENV, menu_name)
    local menu = (menu_name and _ENV[menu_name].menu or menu)
    return menu[menu.c+1]
end $$

|[f_modes_push]| function(_ENV, newstate)
    _add(stack, newstate)
    _ENV:f_actor_load(newstate)
end $$

|[f_modes_pop]| function(_ENV)
    -- delete the last item on the stack, then load the new last item.
    -- most modes on the stack won't have an init in this game.
    _deli(stack) 
    _ENV:load(stack[#stack] or 'main')
end $$

|[f_game_init]| function(_ENV)
    -- uncomment to unlock all 1st evolutions or cheat for all
    -- for i=0,151 do
    --     if c_pokemon[i].evolvesto and not c_pokemon[i].evolvesfrom then
    --     _poke(S_POKEMON+i, 1)
    --     end
    -- end

    local party = {} -- default party for new games
    -- f_zcall(function(num) _poke(S_POKEMON+num, 1) end, [[;]])
    _foreach(_split'133,7,35,1,25,4', function(num)
        _add(party, {num=num, moves=f_get_natural_moveset(num)})
        _poke(S_POKEMON+num, 1)
    end)

    if @S_NEW == 0 then
        _poke(S_NEW, 1)
        f_save_party(0, party)
    end

    -- todo: remove me and/or refactor me
    modes = o_modes()

    f_zcall(function(menu_name, create_func, ...)
        modes[menu_name].menu = create_func(...)
    end, [[
        ;,browse,       ~f_create_menu,      ~f_browse_drawentry, 4 -- selecting a pkmn from dex (for browsing or changing team pkmn)
       ;;,browsestat,   ~f_create_menu_view, ~f_menu_drawentry      -- info for pkmn in browse mode
       ;;,credits,      ~f_create_menu_view, ~f_menu_drawentry      -- credits view obviously
       ;;,fightover,    ~f_create_menu_view, ~f_menu_drawentry      -- stats that display when you finish a fight
       ;;,editparty,    ~f_create_menu,      ~f_browse_drawentry, 3 -- selecting a pkmn from party
       ;;,switchparty,  ~f_create_menu,      ~f_browse_drawentry, 3 -- selecting a pkmn from party
       ;;,main,         ~f_create_menu,      ~f_menu_drawentry      -- select a mode
       ;;,partyaction,  ~f_create_menu,      ~f_menu_drawentry      -- edit party what to do (delete, edit moves, edit pkmn)
       ;;,moveaction,   ~f_create_menu,      ~f_menu_drawentry      -- selecting what to do with a move (switch, delete, select)
       ;;,partymovesel, ~f_create_menu,      ~f_menu_drawentry      -- select one of the moves a pokemon can learn (tms, hms, natural moves...)
       ;;,partymoves,   ~f_create_menu,      ~f_menu_drawentry      -- select 1 of 4 moves from a pokemon

       ;;,pselactions,  ~f_create_menu,      ~f_menu_drawentry      -- select an action during battle (fight, switch, forfeit)
       ;;,pselmove,     ~f_create_menu,      ~f_menu_drawentry      -- select 1 of 4 moves from a pokemon (during battle) -- TODO: try merging with other move select
       ;;,pselswitch,   ~f_create_menu,      ~f_browse_drawentry, 3 -- selecting a pkmn from party

       ;;,team1,        ~f_create_menu,      ~f_menu_drawentry      -- select a party
       ;;,team2story,   ~f_create_menu,      ~f_menu_drawentry      -- select a cpu trainer
       ;;,team2match,   ~f_create_menu,      ~f_menu_drawentry      -- select a party
    ]])

    modes.main.menu.cancel        = f_beep -- only 2 menus you can't pop from.
    modes.pselactions.menu.cancel = f_beep

    -- these menus share the cursor position
    modes.team1horde.menu  = modes.team1.menu
    modes.team1match.menu  = modes.team1.menu
    modes.team1story.menu  = modes.team1.menu
    modes.partypkmn.menu   = modes.browse.menu

    f_beep_done()

    _menuitem(2, "close picodex", function()
        _menuitem(2) -- remove menu item
        _menuitem(3) -- remove menu item
        _ENV:load'closing'
    end)

    _menuitem(3, "swap 🅾️/❎", function()
        _poke(S_SWAP_CONTROLS, @S_SWAP_CONTROLS == 0 and 1 or 0)
    end)
end $$

|[f_game_update]| function(program)
    program.modes:state()
end $$

|[f_game_draw1]| function() g_picodex.modes:draw1() end $$
|[f_game_draw2]| function() g_picodex.modes:draw2() end $$
|[f_game_draw3]| function() g_picodex.modes:draw3() end $$
