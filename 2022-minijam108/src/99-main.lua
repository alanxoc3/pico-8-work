-- TEMPLATE TOKEN COUNT: 1045
zclass[[game_state,actor|
    ecs_exclusions;actor,true; -- remove game_state from the actor group
    init,%game_state_init, curr,game;

    logo;    state_init,%logo_init,   update,nop,             draw,%logo_draw,  duration,2.5, next,title;
    title;   state_init,nop,          update,%title_update,   draw,%title_draw;
    game;    state_init,%game_init,   update,%game_update,    draw,%game_draw;
    lvlwin;  state_init,nop,          update,%lvlwin_update,  draw,%lvlwin_draw;
    lvllose; state_init,nop,          update,%lvllose_update, draw,%lvllose_draw;
]]

|[lvlwin_update]| function(a)
    if a.timers.lvlwin.elapsed and a.timers.lvlwin.elapsed >= 1.5 and not does_entity_exist'fader' then
        _g.fader_out(function()
            a:load'game'
        end)
    end
end $$

|[lvlwin_draw]| function(a)
    cls(12)
    local func = function()
        print_wide_centered("next level",              64, 53, 7)
        print_wide_centered("turns: "..g_turn_count,   64, 75, 7)
        print_wide_centered("deaths: "..g_death_count, 64, 83, 7)
    end

    draw_outline(1, func)
    func()
end $$

|[lvllose_update]| function(a)
    if a.timers.lvllose.elapsed and a.timers.lvllose.elapsed >= 1.5 and not does_entity_exist'fader' then
        _g.fader_out(function()
            a:load'game'
        end)
    end
end $$

|[lvllose_draw]| function(a)
    cls(12)
    local func = function()
        print_wide_centered("retry level",             64, 53, 7)
        print_wide_centered("turns: "..g_turn_count,   64, 75, 7)
        print_wide_centered("deaths: "..g_death_count, 64, 83, 7)
    end

    draw_outline(1, func)
    func()
end $$

|[title_update]| function(a)
    if a.timers.title.elapsed and a.timers.title.elapsed >= 1.5 and not does_entity_exist'fader' then
        _g.fader_out(function()
            a:load'game'
        end)
    end
end $$

|[title_draw]| function(a)
    cls(12)
    print("\^wstabby\^-w", 41, 40, 7)
    print("\^wcrabby\^-w", 41, 83, 7)
    zspr(202, 64, 64, 4, 4)
end $$

|[game_state_init]| function(state)
    clean_all_entities'game_state'
    _g.fader_in()
    state:state_init()
end $$

function _init()
    g_tl = _g.game_state()
end

function _update60()
    -- DEBUG_BEGIN
    if btn(4) and btnp(5) then g_debug = not g_debug end
    -- DEBUG_END

    zcall(loop_entities, [[
        1;,actor,clean;
        2;,fader,clean;
    ]])

    register_entities()

    zcall(loop_entities, [[
        1;,fader,tick;
        2;,game_state,tick;
        3;,fader,state;
        4;,game_state,state;
    ]])

    -- DEBUG_BEGIN
    if btn(5) and xbtnp() ~= 0 then
        g_level += xbtnp()

        _g.fader_out(function()
            g_tl:load'game'
        end)
    end
    -- DEBUG_END
end

function _draw()
    cls()
    loop_entities('game_state', 'draw')
    fade(g_fade)
end
