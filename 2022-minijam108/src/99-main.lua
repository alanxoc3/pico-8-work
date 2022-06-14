cartdata"stabby_crabby"
menuitem(1, "reset high score", function()
    memset(REAL_SAVE_LOCATION, 0, SAVE_LENGTH)
    extcmd'reset'
end)

memcpy(MEM_SAVE_LOCATION, REAL_SAVE_LOCATION, SAVE_LENGTH)

function save()
    memcpy(REAL_SAVE_LOCATION, MEM_SAVE_LOCATION, SAVE_LENGTH)
end

-- hi turn death | level death turn | level state
function hi_turn()       return peek(MEM_SAVE_LOCATION+0) end
function hi_death()      return peek(MEM_SAVE_LOCATION+1) end
function g_level()       return peek(MEM_SAVE_LOCATION+2) end
function g_death_count() return peek(MEM_SAVE_LOCATION+3) end
function g_turn_count()  return peek(MEM_SAVE_LOCATION+4) end

-- when to save? on level completion (level win screen)
function set_hi_turn(num)       return poke(MEM_SAVE_LOCATION+0, num) end
function set_hi_death(num)       return poke(MEM_SAVE_LOCATION+1, num) end
function set_g_level(num)       return poke(MEM_SAVE_LOCATION+2, num) end
function set_g_death_count(num) return poke(MEM_SAVE_LOCATION+3, num) end
function set_g_turn_count(num)  return poke(MEM_SAVE_LOCATION+4, num) end

-- TEMPLATE TOKEN COUNT: 1045
zclass[[game_state,actor|
    ecs_exclusions;actor,true; -- remove game_state from the actor group
    init,%game_state_init, curr,game;

    logo;    state_init,%logo_init,   update,nop,             draw,%logo_draw,  duration,2.5, next,title;
    title;   state_init,nop,          update,%title_update,   draw,%title_draw;
    game;    state_init,%game_init,   update,%game_update,    draw,%game_draw;
    lvlwin;  state_init,nop,          update,%lvlwin_update,  draw,%lvlwin_draw;
    gamewin; state_init,nop,          update,%gamewin_update, draw,%gamewin_draw;
    lvllose; state_init,nop,          update,%lvllose_update, draw,%lvllose_draw;
]]

|[gamewin_update]| function(a)
    if (btnp(4) or btnp(5)) and not does_entity_exist'fader' then
        _g.fader_out(function()
            if g_turn_count() > 0 and (hi_turn() <= 0 or hi_turn() > g_turn_count()) then
                set_hi_turn(g_turn_count())
                set_hi_death(g_death_count())
            end

            set_g_level(0)
            set_g_death_count(0)
            set_g_turn_count(0)
            save()

            a:load'title'
        end)
    end
end $$

function print_press()
    if t()%1 < .5 then
        print_wide_centered("press",        64, 14+64-7, 7)
        print_wide_centered("❎ or 🅾️  ",    64, 14+64, 7)
    end
end

|[gamewin_draw]| function(a)
    local el = (a.timers.gamewin.elapsed or 0) % 15
    cls(12)
    print_horiz_wobble_centered("you win",         64, 30-20-4, 7, 0, 1)
    print_wide_centered("turns: "..g_turn_count(),   64, 75-20-20-15, 7)
    print_wide_centered("deaths: "..g_death_count(), 64, 82-20-20-15, 7)

    spr(42, 150-el*30, 42, 2, 2)
    spr(4, 200-el*34, 44, 4, 2)
    spr(36, -270+el*34, 42, 4, 2)
    spr(46, -260+el*30, 42, 2, 2)
    spr(46, -270+el*30, 42-10, 2, 2)
    spr(46, -275+el*30, 42+11, 2, 2)
    spr(46, -280+el*30, 42, 2, 2)

    print_wide_centered("code/sfx by:",   64, 90, 7)
    print_wide_centered("@alanxoc3",      64, 97, 7)

    print_wide_centered("gfx/sfx by:",    64, 110, 7)
    print_wide_centered("@greatcadet",    64, 117, 7)

    print_press()
end $$

|[lvlwin_update]| function(a)
    if a.timers.lvlwin.elapsed and a.timers.lvlwin.elapsed >= 2.5 and not does_entity_exist'fader' then
        _g.fader_out(function()
            a:load'game'
        end)
    end
end $$

|[lvlwin_draw]| function(a)
    cls(12)
    local func = function()
        print_wide_centered("next level",              64, 53, 7)
        print_wide_centered("turns: "..g_turn_count(),   64, 75, 7)
        print_wide_centered("deaths: "..g_death_count(), 64, 83, 7)
    end

    func()
end $$

|[lvllose_update]| function(a)
    if a.timers.lvllose.elapsed and a.timers.lvllose.elapsed >= 2.5 and not does_entity_exist'fader' then
        _g.fader_out(function()
            a:load'game'
        end)
    end
end $$

|[lvllose_draw]| function(a)
    cls(12)
    local func = function()
        print_wide_centered("retry level",             64, 53, 7)
        print_wide_centered("turns: "..g_turn_count(),   64, 75, 7)
        print_wide_centered("deaths: "..g_death_count(), 64, 83, 7)
    end

    func()
end $$

|[title_update]| function(a)
    if (btnp(4) or btnp(5)) and not does_entity_exist'fader' then
        _g.fader_out(function()
            a:load'game'
        end)
    end
end $$

|[title_draw]| function(a)
    cls(12)
    local yoff = 48+8-2+1-20

    print_horiz_wobble_centered("stabby", 64, yoff-24, 7, 0, 1)
    print_horiz_wobble_centered("crabby", 64, yoff+18, 7, 0, 1)

    print_wide_centered("high score",   64, 90, 7)
    print_wide_centered("==========",      64, 97, 7)


    local turn, death = "n/a", "n/a"
    if hi_turn() > 0 then turn = hi_turn() death = hi_death() end
    print_wide_centered("turns: "..turn,    64, 110, 7)
    print_wide_centered("deaths: "..death,    64, 117, 7)

    print_press()
    zspr(202, 64, yoff, 4, 4)
end $$

|[game_state_init]| function(state)
    save()
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

--     -- DEBUG_BEGIN
--     if btn(5) and xbtnp() ~= 0 then
--         set_g_level(g_level()+xbtnp)
-- 
--         _g.fader_out(function()
--             g_tl:load'game'
--         end)
--     end
--     -- DEBUG_END
end

function _draw()
    cls()
    loop_entities('game_state', 'draw')
    fade(g_fade)
end
