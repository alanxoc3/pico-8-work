G_DEATH_COUNT = 0
G_LEVEL_BEAR_WIN  = false
G_LEVEL_MOUSE_WIN = false
G_LEVEL_CAT_WIN   = false
G_LEVEL_PIG_WIN   = false
SCREEN_SHAKE = false

zclass[[game_state,actor|
    ecs_exclusions;actor,true; -- remove game_state from the actor group
    curr,logo;
    logo; init,%logo_init, update,%logo_update, draw,%logo_draw, duration,2.5, next,level_select;
    level_select; init,%level_select_init, update,%level_select_update, draw,%level_select_draw;

    level_bear;  init,%level_bear_init,  update,%level_update, draw,%level_draw;
    level_mouse; init,%level_mouse_init, update,%level_update, draw,%level_draw;
    level_cat;   init,%level_cat_init,   update,%level_update, draw,%level_draw;
    level_pig;   init,%level_pig_init,   update,%level_update, draw,%level_draw;

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
    -- DEBUG_BEGIN
    if btnp(4) and btnp(5) then g_debug = not g_debug end
    -- DEBUG_END

    loop_zobjs('actor',      'clean') -- delete any actors that were killed, and call their "destroy" callback
    register_zobjs()                  -- register all zobs from previous game loop iteration
    loop_zobjs('timer',      'tick')  -- update the timers
    loop_zobjs('game_state', 'state') -- game state controls the different overall states in the game
end

function _draw()
    camera(SCREEN_SHAKE and rnd_one() or 0, SCREEN_SHAKE and rnd_one() or 0)
    cls()
    
    fade(g_fade)
    loop_zobjs('game_state', 'draw')
    -- DEBUG_BEGIN
    if g_debug then rect(0, 0, 127, 127, 8) end
    -- DEBUG_END
    SCREEN_SHAKE = false
end

|level_select_draw| function()
    loop_zobjs_in_view(g_view, 'drawlayer_03', 'draw')
    loop_zobjs_in_view(g_view, 'drawlayer_05', 'draw')
    loop_zobjs_in_view(g_view, 'drawlayer_10', 'draw')
    loop_zobjs_in_view(g_view, 'drawlayer_20', 'draw')
    loop_zobjs_in_view(g_view, 'drawlayer_40', 'draw')
end $$

LEVEL_RADIUS = 28
|level_draw| function()
    circ(zoomx(0), zoomy(0), zoom(LEVEL_RADIUS-4), 1)
    _g.level_select_draw()
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

zclass[[stats_displayer,drawlayer_40|draw,%stats_displayer_draw]]

|stats_displayer_draw| function(a)
    print(""..g_zipper_count.."/"..g_zipper_goal, 4, 4, 11)
end $$

zclass[[game_checker,actor|
    pl,@, retry_level,@, win_level,@,
    update,%game_checker_update
]]

|game_checker_update| function(a)
    if not a.pl.alive then sfx(24, 3) a:kill() music(-1) _g.fader_out(1, function() g_game_state:load(a.retry_level) end)
    elseif #g_zclass_entities['planet'] == 0 then
        music(-1) a:kill() 
        if g_zipper_count >= g_zipper_goal then _g.fader_out(1, function() g_game_state:load(a.win_level) end)
        else _g.fader_out(1, function() g_game_state:load(a.retry_level) end) end
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
    loop_zobjs('drawlayer_40', 'draw')
end $$


|win_init| function(a)
    music(5,nil,1)
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
    loop_zobjs('drawlayer_40', 'draw')
end $$

|level_update| function()
    loop_zobjs('actor',     'state')
    loop_zobjs('view',      'match_following')
    loop_zobjs('star_view', 'match_following')

    loop_zobjs('missile', 'collide', g_zclass_entities['teammate'])
    loop_zobjs('teammate', 'collide', g_zclass_entities['missile'])
    loop_zobjs('teammate', 'collide', g_zclass_entities['teammate'])

    loop_zobjs('alert_radar', 'register', g_zclass_entities['planet'])
    loop_zobjs('alert_radar', 'register', g_zclass_entities['asteroid'])
    loop_zobjs('alert_radar', 'register', g_zclass_entities['view'])
    loop_zobjs('alert_radar', 'register', g_zclass_entities['black_hole'])
    loop_zobjs('alert_radar', 'register', g_zclass_entities['zipper'])

    loop_zobjs('view', 'collide', g_zclass_entities['focus_point'])
    loop_zobjs('view', 'collide', g_zclass_entities['black_hole'])
    loop_zobjs('view', 'collide', g_zclass_entities['planet'])
    loop_zobjs('view', 'collide', g_zclass_entities['asteroid'])
    loop_zobjs('view', 'collide', g_zclass_entities['chaser'])
    loop_zobjs('view', 'collide', g_zclass_entities['zipper'])

    loop_zobjs('alert_radar', 'register', g_zclass_entities['chaser'])
    loop_zobjs('alert_radar', 'register', g_zclass_entities['black_hole'])
    loop_zobjs('black_hole', 'tug', g_zclass_entities['teammate']) -- affects dx & dy of all 'teammate' objects

    loop_zobjs('collision_circ', 'follow_anchoring')
    loop_zobjs('mov', 'mov_update')
    loop_zobjs('acc', 'acc_update')
    loop_zobjs('vec', 'vec_update')
    loop_zobjs('anchor_pos', 'update_anchor')
    loop_zobjs('model', 'model_update')

    check_level_bounds()
end $$

zclass[[spawner,actor|
    spawn_func,@, target,@, spawn_delay,@, spawn_rate,@, min_ang,@, max_ang,@;
    start;duration,~spawn_delay, next,spawn;
    spawn;init,%spawn_init, duration,~spawn_rate, next,spawn;
]]

|spawn_init| function(a)
    local ang = rnd(a.max_ang-a.min_ang) + a.min_ang

    -- each level is 25 wide, so let's make sure they spawn outside the screen.
    local x,y = cos(ang)*30,sin(ang)*30
    a.spawn_func(x, y, a.target)
end $$

function level_init_shared(level_name, retry_state, win_state, music_index, zipper_goal, pl_x, pl_y)
    music(music_index,1000,7)
    clean_all_entities()

    -- used to determine if you beat the level or not
    g_zipper_count = 0
    g_zipper_goal = zipper_goal

    g_pl = _g.pl(pl_x, pl_y) -- add player
    g_view = _g.view(g_pl)
    local star_view = _g.star_view(g_pl) -- this view is just for stars, so they don't lose their position when the screen wraps
    for i=1,50 do
        _g.twinkle(rnd(256), rnd(256), rnd(), g_view, star_view)
    end

    create_level_focus_points()
    create_text("lvl", pl_x, pl_y-3, _g.drawable_model_post_temp)
    _g.drawable_model_post_temp(pl_x, pl_y, _g.STARTING_CIRCLE, 1)
    create_text(level_name, pl_x, pl_y+3, _g.drawable_model_post_temp)

    _g.fader_in(1) -- to show the level
    _g.alert_radar(g_pl)
    _g.game_checker(g_pl, retry_state, win_state)
    _g.stats_displayer()
end

