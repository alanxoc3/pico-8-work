-- TEMPLATE TOKEN COUNT: 1045
zclass[[game_state,actor|
    ecs_exclusions;actor,true; -- remove game_state from the actor group
    init,%game_state_init, curr,game;

    logo; state_init,%logo_init, update,nop,          draw,%logo_draw, duration,2.5, next,game;
    game; state_init,%game_init, update,%game_update, draw,%game_draw;
]]

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
