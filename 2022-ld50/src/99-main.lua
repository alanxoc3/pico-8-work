G_DEATH_COUNT = 0
G_LEVEL_BEAR_WIN  = false
G_LEVEL_MOUSE_WIN = false
G_LEVEL_CAT_WIN   = false
G_LEVEL_PIG_WIN   = false



zclass[[game_state,actor|
    ecs_exclusions;actor,true; -- remove game_state from the actor group
    -- curr,level_select;
    -- curr,logo;
    curr,level_mouse;
    logo; init,%logo_init, update,%logo_update, draw,%logo_draw, duration,2.5, next,level_select;
    level_select; init,%level_select_init, update,%level_select_update, draw,%level_select_draw;

    level_bear;  init,%level_bear_init,  update,%level_bear_update,  draw,%level_draw;
    level_mouse; init,%level_mouse_init, update,%level_mouse_update, draw,%level_draw;
    level_cat;   init,%level_cat_init,   update,%level_cat_update,   draw,%level_draw;
    level_pig;   init,%level_pig_init,   update,%level_pig_update,   draw,%level_draw;

    level_bear_retry;  init,%retry_init, update,%retry_update, draw,%retry_draw;
    level_mouse_retry; init,%retry_init, update,%retry_update, draw,%retry_draw;
    level_cat_retry;   init,%retry_init, update,%retry_update, draw,%retry_draw;
    level_pig_retry;   init,%retry_init, update,%retry_update, draw,%retry_draw;

    win_bear; init,%win_init, update,%win_update, draw,%win_draw;
    win_mouse; init,%win_init, update,%win_update, draw,%win_draw;
    win_cat; init,%win_init, update,%win_update, draw,%win_draw;
    win_pig; init,%win_init, update,%win_update, draw,%win_draw;
]]

function _init()
    g_game_state = _g.game_state()
    g_fade = 0
end

function _update60()
            if btnp(4) then
            G_LEVEL_BEAR_WIN  = true G_LEVEL_MOUSE_WIN = true G_LEVEL_CAT_WIN   = true G_LEVEL_PIG_WIN   = true
             _g.fader_out(1, function() g_game_state:load("win_mouse") end)
            end
    -- DEBUG_BEGIN
    if btnp(4) and btnp(5) then g_debug = not g_debug end
    -- DEBUG_END

    loop_zobjs('actor',      'clean') -- delete any actors that were killed, and call their "destroy" callback
    register_zobjs()                  -- register all zobs from previous game loop iteration
    loop_zobjs('timer',      'tick')  -- update the timers
    loop_zobjs('game_state', 'state') -- game state controls the different overall states in the game
end

function _draw()
    cls()
    fade(g_fade)
    loop_zobjs('game_state', 'draw')
    -- DEBUG_BEGIN
    if g_debug then rect(0, 0, 127, 127, 8) end
    -- DEBUG_END
end

|level_select_draw| function()
    loop_zobjs_in_view(g_view, 'drawable_pre',  'draw')
    loop_zobjs_in_view(g_view, 'drawable',      'draw')
    loop_zobjs_in_view(g_view, 'drawable_post', 'draw')
end $$

LEVEL_RADIUS = 25
|level_draw| function()
    circ(zoomx(0), zoomy(0), zoom(LEVEL_RADIUS-1), 1)
    _g.level_select_draw()
end $$

|title_screen_draw| function()
    loop_zobjs_in_view(g_view, 'drawable_pre',  'draw')
    loop_zobjs_in_view(g_view, 'drawable',      'draw')
    loop_zobjs_in_view(g_view, 'drawable_post', 'draw')
end $$

function check_level_bounds()
    if approx_dist(g_pl.x, g_pl.y) > LEVEL_RADIUS and (not CHECK_LEVEL_BOUND_FADER or not CHECK_LEVEL_BOUND_FADER.alive)then
        CHECK_LEVEL_BOUND_FADER = _g.fader_out(1, function()
            g_game_state:load'level_select'
        end)
    end
end

function create_level_focus_points()
    local num = LEVEL_RADIUS \ 2
    for i=0,num-1 do
        _g.focus_point(cos(i/num)*LEVEL_RADIUS, sin(i/num)*LEVEL_RADIUS)
    end
end

zclass[[pl_checker,actor|
    pl,@, retry_level,@,
    update,%pl_checker_update
]]

|pl_checker_update| function(a)
    if not g_pl.alive then
        a:kill()
        music(-1) sfx(24, 3)
        _g.fader_out(1, function() g_game_state:load(a.retry_level) end)
    end
end $$

|retry_init| function(a)
    music(4,nil,1)
    clean_all_entities()
    G_DEATH_COUNT = min(100, G_DEATH_COUNT+1)

    _g.fader_in(1)
    g_view = _g.view()
    
    local txt = "???"
    if G_DEATH_COUNT == 1     then txt = "wob"
    elseif G_DEATH_COUNT == 2 then txt = "wob,again"
    elseif G_DEATH_COUNT == 3 then txt = "wob,again?"
    elseif G_DEATH_COUNT < 100 and G_DEATH_COUNT >= 3 then
        if G_DEATH_COUNT % 10 == 0 then
            txt = "rewob,"..(G_DEATH_COUNT\10)
        else
            txt = "wob,"..G_DEATH_COUNT
        end
    end
    create_text(txt, 0, 0)

    g_game_state:start_timer("retry", 1, function()
        _g.fader_out(1, function()
            if g_game_state.curr == "level_mouse_retry" then g_game_state:load("level_mouse")
            elseif g_game_state.curr == "level_cat_retry" then g_game_state:load("level_cat")
            elseif g_game_state.curr == "level_bear_retry" then g_game_state:load("level_bear")
            elseif g_game_state.curr == "level_pig_retry" then g_game_state:load("level_pig")
            end
        end)
    end)
end $$

|retry_update| function(a)
    loop_zobjs('actor',     'state')
    loop_zobjs('model', 'model_update')
end $$

|retry_draw| function(a)
    loop_zobjs('drawable_post', 'draw')
end $$


|win_init| function(a)
    music(4,nil,1)
    clean_all_entities()

    _g.fader_in(1) g_view = _g.view()
    
    if a.curr == "win_bear" then G_LEVEL_BEAR_WIN = true
    elseif a.curr == "win_mouse" then G_LEVEL_MOUSE_WIN = true
    elseif a.curr == "win_cat" then G_LEVEL_CAT_WIN = true
    elseif a.curr == "win_pig" then G_LEVEL_PIG_WIN = true
    end

    create_text("win", 0, 0)

    g_game_state:start_timer("win", 1, function()
        _g.fader_out(1, function()
            g_game_state:load("level_select")
        end)
    end)
end $$

|win_update| function(a)
    loop_zobjs('actor',     'state')
    loop_zobjs('model', 'model_update')
end $$

|win_draw| function(a)
    loop_zobjs('drawable_post', 'draw')
end $$
