zclass[[modes,actor|
    push,%modes_push,
    pop,%modes_pop,
    update,nop,
    draw1,nop,
    draw2,nop,
    draw3,nop,
    curr,main;

    stack;,;

    defaults; sub,0, init,nop, update,nop, finit,nop, draw1,nop, draw2,nop, draw3,nop;

    main;         update,%main_update,         draw1,%main_draw1,         draw2,%main_draw2,         draw3,%main_draw3,   init,%main_init;
    credits;      update,%credits_update,      draw1,%credits_draw1,      draw2,%main_draw2,         draw3,%main_draw3,   init,%credits_init;
    browse;       update,%browse_update,       draw1,%browse_draw1,       draw2,%browse_draw2,       draw3,%browse_draw3, init,%browse_init;
    browsestat;   update,%browsestat_update,   draw1,%browsestat_draw1,   draw2,%browse_draw2,       draw3,%browse_draw3, init,%browsestat_init;
    fightsel;     update,%fightsel_update,     draw1,%fightsel_draw1,     draw2,%fightsel_draw2,     draw3,%fightsel_draw3,     init,%fightsel_init;

    -- party selects
    fightparty;   update,%party_update,        draw1,%party_draw1,        draw2,%party_draw2,        draw3,%party_draw3,        init,%party_init, disable_empty_party,yes, select_func,%fight_select;
    party;        update,%party_update,        draw1,%party_draw1,        draw2,%party_draw2,        draw3,%party_draw3,        init,%party_init, disable_empty_party,no,  select_func,%party_select;

    -- p0 is the winner of the fight
    fightover;    update,%fightover_update,    draw1,%fightover_draw1,    draw2,%fightover_draw2,    draw3,%fightover_draw3,    init,%fightover_init;

    -- these are the different states for a fight
    -- get to these with "begin_fight", because a few variables need to be set before entering the fight loop.
    -- the "next" state changes dynamically for p1sel and turn, based on human vs computer players.
    p1sel;        next,p2sel, init,%psel_init, p0key,p1;
    p2sel;        next,turn,  init,%psel_init, p0key,p2;
    turn;         next,p1sel, update,%turn_update, draw1,%turn_draw1, draw2,%turn_draw2, draw3,%turn_draw3, init,%turn_init, cur_action,no;

    pselactions;  update,%pselactions_update,  draw1,%pselactions_draw1,  draw2,%turn_draw2,  draw3,%pselactions_draw3, init,%pselactions_init;
    pselmove;     update,%pselmove_update,     draw1,%pselmove_draw1,     draw2,%turn_draw2,  draw3,%pselmove_draw3, init,%pselmove_init;

    editparty;    update,%editparty_update,    draw1,%editparty_draw1,    draw2,%editparty_draw2,    draw3,%editparty_draw3,    init,%editparty_init;
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

|[game_init]| function(game)
    -- we should always have these starter pokemon
    zcall(poke, [[
        ;,S_BULBASAUR,  1
       ;;,S_CHARMANDER, 1
       ;;,S_SQUIRTLE,   1
    ]])

    -- cheat: unlock all pkmn
    for i=0,13 do
        poke(S_POKEMON+i, 1)
    end

    -- todo: remove me
    game.modes = _g.modes()
    game.modes.menu_editparty    = create_menu(_g.browse_drawentry, 3, 30, 30, 5) -- selecting a pkmn from party
    game.modes.menu_browse       = create_menu(_g.browse_drawentry, 4) -- selecting a pkmn from dex (for browsing)
    game.modes.menu_partypkmn    = create_menu(_g.browse_drawentry, 4) -- selecting a pkmn from dex (for adding to party)
    game.modes.menu_main         = create_menu(_g.menu_drawentry) -- select a mode
    game.modes.menu_party        = create_menu(_g.menu_drawentry) -- select a party (1, 2, 3)
    game.modes.menu_fightsel     = create_menu(_g.menu_drawentry) -- select a computer to play against
    game.modes.menu_partyaction  = create_menu(_g.menu_drawentry) -- edit party what to do (delete, edit moves, edit pkmn)
    game.modes.menu_partymoves   = create_menu(_g.menu_drawentry) -- select 1 of 4 moves from a pokemon
    game.modes.menu_partymovesel = create_menu(_g.menu_drawentry) -- select one of the moves a pokemon can learn (tms, hms, natural moves...)
    game.modes.menu_pselmove     = create_menu(_g.menu_drawentry) -- select 1 of 4 moves from a pokemon (during battle) -- TODO: try merging with other move select
    game.modes.menu_pselactions  = create_menu(_g.menu_drawentry) -- select an action during battle (fight, switch, forfeit)
    game.modes.menu_credits      = create_menu(_g.menu_drawentry)

    sfx(61,0)

    menuitem(1, "close picodex", function()
        menuitem(1)
        menuitem(2)
        game:load'closing'
    end)

    menuitem(2, "swap 🅾️/❎", function()
        poke(S_SWAP_CONTROLS, @S_SWAP_CONTROLS == 0 and 1 or 0)
    end)
end $$

|[game_update]| function(game)
    game.modes:state()
end $$

|[game_draw]| function(a)
    cls()
    draw_picodex(a:is_active'shaking', 1,
        function() a.modes:draw1() end,
        function() a.modes:draw2() end, 
        function() a.modes:draw3() end, 
        4, false, a.modes.menu_main.c, #a.modes.stack)
end $$

|[main_init]| function(game)
    game.menu_main:refresh(
        zobj[[
            ;name,"browse",  state,browse,     select,%menu_state_callback, desc,"view|pokemon|info"
           ;;name,"teams",   state,party,      select,%menu_state_callback, desc,"edit|stored|teams"
           ;;name,"story",   state,fightparty, select,%menu_state_callback, desc,"battle|against|computer"
           ;;name,"versus",  state,games,      select,%menu_state_callback, disabled,yes, desc,"battle|against|player"
           ;;name,"hoard",   state,settings,   select,%menu_state_callback, disabled,yes, desc,"battle all|pokemon|in order"
           ;;name,"credits", state,credits,    select,%menu_state_callback, desc,"help|and|credits"
        ]]
    )
end $$

|[main_update]| function(game) game.menu_main:update(game) end $$
|[main_draw1]|  function(game) game.menu_main:draw1() end $$
|[main_draw3]|  function(game) end $$

-- picodex logo
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

