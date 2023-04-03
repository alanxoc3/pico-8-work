|[f_game_init]| function(_ENV)
    -- cheats!
    -- for i=0,151 do _poke(S_POKEMON+i, 1) end -- gives you all pokemon
    -- poke(S_STORY, 40) -- gives you all trainers

    local team = {} -- default team for new games
    for ind, num in _pairs(_split'133,7,35,1,25,4') do
        f_set_default_team_pkmn(team, ind, num)
        _poke(S_POKEMON+num, 1)
    end

    if @S_NEW == 0 then
        _poke(S_NEW, 1)
        f_save_team(0, team)
    end

    modes = f_zclass[[
        curr,main;

        -- defaults are mostly functions, but also menu
        defaults;
            menu,~c_no,
            init,~f_nop,
            lrfunc,~f_beep, xfunc,~f_nop,
            update,~f_modes_default_update,
            movemode,~c_no,
            draw1,~f_modes_default_draw1,
            draw2,~f_nop,
            draw3,~f_nop;

        -- main
        main; init,~f_main_init, draw2,~f_main_draw2, draw3,~f_main_draw3;

        -- browse
        browse;       init,~f_browse_init,     draw2,~f_browse_draw2, draw3,~f_browse_draw3;
        browsestat;   init,~f_browsestat_init, draw2,~f_browse_draw2, draw3,~f_browse_draw3, lrfunc,~f_browsestat_lrfunc, xfunc,~f_browsestat_xfunc; -- view pkmn info in browse

        -- edit
        editteam;    init,~f_editteam_init,    draw2,~f_editteam_draw2,    draw3,~f_editteam_draw3, draw1,~f_editteam_draw1;
        switchteam;  init,~f_switchteam_init,  draw2,~f_editteam_draw2,    draw3,~f_editteam_draw3, draw1,~f_editteam_draw1;
        teampkmn;    init,~f_teampkmn_init,    draw2,~f_browse_draw2,      draw3,~f_browse_draw3  ;
        teamaction;  init,~f_teamaction_init,  draw2,~f_editteam_draw2,    draw3,~f_editteam_draw3;
        moveaction;  init,~f_moveaction_init,  draw2,~f_teammoves_draw2,   draw3,~f_move_draw3    , movemode,teammoves;
        teammovesel; init,~f_teammovesel_init, draw2,~f_teammovesel_draw2, draw3,~f_move_draw3    ;
        teammoves;   init,~f_teammoves_init,   draw2,~f_teammoves_draw2,   draw3,~f_move_draw3    ;
        switchmoves; init,~f_switchmoves_init, draw2,~f_teammoves_draw2,   draw3,~f_move_draw3    ;

        -- pre-fight menus
        team1;        ui_pl,"player",   init,~f_team_init,     draw2,~f_team_draw2, draw3,~f_team_draw3, disable_empty_team,~c_no,   select_func,~f_team_select; -- t1
        team1story;   ui_pl,"player",   init,~f_team_init,     draw2,~f_team_draw2, draw3,~f_team_draw3, disable_empty_team,~c_yes,  select_func,~f_story_select; -- s1
        team1match;   ui_pl,"player 1", init,~f_team_init,     draw2,~f_team_draw2, draw3,~f_team_draw3, disable_empty_team,~c_yes,  select_func,~f_match_select; -- s1
        team1horde;   ui_pl,"player",   init,~f_team_init,     draw2,~f_team_draw2, draw3,~f_team_draw3, disable_empty_team,~c_yes,  select_func,~f_horde_select; -- s1
        team2match;   ui_pl,"player 2", init,~f_team_init,     draw2,~f_team_draw2, draw3,~f_team_draw3, disable_empty_team,~c_yes,  select_func,~f_match_start;  -- s1
        team2story;   ui_pl,"trainer",  init,~f_fightsel_init, draw2,~f_team_draw2, draw3,~f_team_draw3;                                                        -- t2

        -- in-fight menus
        fightover;    init,~f_fightover_init,   draw2,~f_fightover_draw2,    draw3,~f_fightover_draw3, xfunc,~f_fightover_xfunc;
        pselactions;  init,~f_pselactions_init, draw2,~f_turn_draw2,         draw3,~f_pselactions_draw3;
        pselmove;     init,~f_pselmove_init,    draw2,~f_turn_draw2,         draw3,~f_move_draw3;
        pselswitch;   init,~f_pselswitch_init,  draw2,~f_turn_draw2,         draw3,~f_pselswitch_draw3, draw1,~f_editteam_draw1;

        -- in-fight screens
        p1sel;        next,p2sel, init,~f_psel_init, update,~f_nop,         draw1,~f_nop,        p0key,p1;
        p2sel;        next,turn,  init,~f_psel_init, update,~f_nop,         draw1,~f_nop,        p0key,p2;
        turn;         next,p1sel, init,~f_turn_init, update,~f_turn_update, draw1,~f_turn_draw1, draw2,~f_turn_draw2, draw3,~f_turn_draw3, cur_action,~c_no;

        -- credits
        credits;      init,~f_credits_init,      draw2,~f_main_draw2,         draw3,~f_main_draw3, xfunc,~f_credits_xfunc;
    ]]

    f_zcall(function(menu_name, create_func, ...)
        modes[menu_name].menu = create_func(...)
    end, [[
        ;,browse,      ~f_create_menu,      ~f_browse_drawentry, 4 -- selecting a pkmn from dex (for browsing or changing team pkmn)
       ;;,browsestat,  ~f_create_menu_view, ~f_menu_drawentry      -- info for pkmn in browse mode
       ;;,credits,     ~f_create_menu_view, ~f_menu_drawentry      -- credits view obviously
       ;;,fightover,   ~f_create_menu_view, ~f_menu_drawentry      -- stats that display when you finish a fight
       ;;,editteam,    ~f_create_menu,      ~f_browse_drawentry, 3 -- selecting a pkmn from team
       ;;,switchteam,  ~f_create_menu,      ~f_browse_drawentry, 3 -- selecting a pkmn from team
       ;;,main,        ~f_create_menu,      ~f_menu_drawentry      -- select a mode
       ;;,teamaction,  ~f_create_menu,      ~f_menu_drawentry      -- edit team what to do (delete, edit moves, edit pkmn)
       ;;,moveaction,  ~f_create_menu,      ~f_menu_drawentry      -- selecting what to do with a move (switch, delete, select)
       ;;,teammovesel, ~f_create_menu,      ~f_menu_drawentry      -- select one of the moves a pokemon can learn (tms, hms, natural moves...)
       ;;,teammoves,   ~f_create_menu,      ~f_menu_drawentry      -- select 1 of 4 moves from a pokemon
       ;;,switchmoves, ~f_create_menu,      ~f_menu_drawentry      -- switch 1 of 4 moves

       ;;,team1,       ~f_create_menu,      ~f_menu_drawentry      -- select a team
       ;;,team1match,  ~f_create_menu,      ~f_menu_drawentry      -- select a team, shouldn't share with team1, because this is for custom match.
       ;;,team2story,  ~f_create_menu,      ~f_menu_drawentry      -- select a cpu trainer
       ;;,team2match,  ~f_create_menu,      ~f_menu_drawentry      -- select a team
    ]])

    f_zobj_set(modes, [[
        team1menu,@, browsemenu,@;

        main;menu;cancel,~f_beep;
        pselactions;menu;cancel,~f_beep;

        team1horde;menu,~team1menu;
        team1story;menu,~team1menu;
        teampkmn;menu,~browsemenu;
       
    ]], modes.team1.menu, modes.browse.menu)

    _menuitem(1, "close picodex", function()
        _menuitem(1) -- remove menu item, can't pass in string number here
        _menuitem(2) -- remove menu item, can't pass in string number here
        _ENV:f_actor_load'closing'
    end)

    _menuitem(2, "swap 🅾️/❎", function()
        _poke(S_SWAP_CONTROLS, @S_SWAP_CONTROLS == 0 and 1 or 0)
    end)
end $$

|[f_game_update]| function(program)
    program.modes:f_actor_state()
end $$

|[f_game_draw1]| function() g_picodex.modes:draw1() end $$
|[f_game_draw2]| function() g_picodex.modes:draw2() end $$
|[f_game_draw3]| function() g_picodex.modes:draw3() end $$

|[f_modes_default_update]| function(_ENV) menu.update(_ENV) end $$
|[f_modes_default_draw1]|  function(_ENV) menu.draw1(_ENV)  end $$

|[f_modes_cursor]| function(_ENV, menu_name)
    return _ENV[menu_name].menu.c
end $$

|[f_modes_entry]| function(_ENV, menu_name)
    local menu = menu_name and _ENV[menu_name].menu or menu
    return menu[menu.c+1]
end $$
