SCREEN_SHAKE = false

menuitem(1, "reset save data", function()
    memset(0x5e00, 0, 64)
    extcmd'reset'
end)

zclass[[game_state,actor|
    ecs_exclusions;actor,true; -- remove game_state from the actor group
    curr,logo;
    -- curr,1;
    logo; init,%logo_init, update,%logo_update, draw,%logo_draw, duration,2.5, next,level_select;
    level_select; init,%level_select_init, update,%level_select_update, draw,%level_select_draw;

    1; init,%level_1_init, update,%level_update, draw,%level_draw;
    2; init,%level_2_init, update,%level_update, draw,%level_draw;
    3; init,%level_3_init, update,%level_update, draw,%level_draw;
    4; init,%level_4_init, update,%level_update, draw,%level_draw;
    5; init,%level_5_init, update,%level_update, draw,%level_draw;
    6; init,%level_6_init, update,%level_update, draw,%level_draw;
    7; init,%level_7_init, update,%level_update, draw,%level_draw;
    8; init,%level_8_init, update,%level_update, draw,%level_draw;

    retry; init,%retry_init, update,%retry_update, draw,%retry_draw;
    win; init,%win_init, update,%win_update, draw,%win_draw;
]]

function _init()
    memset(0x5e00, 0, 64) -- clear the memory just in case
    cartdata"rewob"
    G_DEATH_COUNT = dget(4)
    G_LEVEL = dget(5)
    G_LEVEL = 8
    G_CUR_LEVEL = nil

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

    dset(4, G_DEATH_COUNT)

    inc_level(0) dset(5, G_LEVEL)

    if (btn(4) or btn(5)) and g_zclass_entities["missile"] and #g_zclass_entities["missile"] > 0 then
        sfx(-1, 2)
    else
        sfx(62, 2)
    end
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
    loop_zobjs_in_view(g_view, 'drawlayer_10', 'draw')
    loop_zobjs_in_view(g_view, 'drawlayer_20', 'draw')
    loop_zobjs_in_view(g_view, 'drawlayer_30', 'draw')
    loop_zobjs_in_view(g_view, 'drawlayer_40', 'draw')
end $$

LEVEL_RADIUS = 26
LEVEL_VIEW_RADIUS = LEVEL_RADIUS-2
|level_draw| function()
    circ(zoomx(0), zoomy(0), zoom(LEVEL_VIEW_RADIUS), 1)
    _g.level_select_draw()
end $$

function check_level_bounds()
    if approx_dist(g_pl.x, g_pl.y) > LEVEL_RADIUS and (not CHECK_LEVEL_BOUND_FADER or not CHECK_LEVEL_BOUND_FADER.alive)then
        CHECK_LEVEL_BOUND_FADER = _g.fader_out(1, function()
            g_game_state:load'level_select'
        end)
    end
end

zclass[[stats_displayer,drawlayer_40|draw,%stats_displayer_draw]]

|stats_displayer_draw| function(a)
    if g_zipper_goal then
        print(""..g_zipper_count.."/"..g_zipper_goal, 4, 4, 11)
    end
end $$

zclass[[game_checker,actor|
    pl,@, update,%game_checker_update
]]

|game_checker_update| function(a)
    if g_zipper_goal and g_zipper_count >= g_zipper_goal then
        if #g_zclass_entities['planet'] == 0 then
            music(-1) a:kill() 
            _g.fader_out(1, function()
                g_game_state:load"win"
            end)
        end
    elseif g_zipper_goal and #g_zclass_entities['planet'] == 0 then
        music(-1) a:kill() 
        _g.fader_out(1, function()
            g_game_state:load"retry"
        end)
    elseif not a.pl.alive then
        a:kill() music(-1)
        sfx(24, 3)
        _g.fader_out(1, function()
            g_game_state:load"retry"
        end)
    end
end $$

function get_wob_text()
    if G_DEATH_COUNT == 0 then
        return "rewob"
    else
        return "wob "..G_DEATH_COUNT\1
    end
end

|retry_init| function(a)
    music(4,nil,1)
    clean_all_entities()
    G_DEATH_COUNT = max(0, min(100, G_DEATH_COUNT+1))

    _g.fader_in(1)
    g_view = _g.view()
    
    create_text(get_wob_text(), 0, 0)

    g_game_state:start_timer("retry", 1, function()
        _g.fader_out(1, function()
            g_game_state:load(G_CUR_LEVEL)
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

function inc_level(inc)
    G_LEVEL = max(1, min((G_LEVEL+inc)\1, 8))
end

|win_init| function(a)
    music(5,nil,1)
    clean_all_entities()

    _g.fader_in(1) g_view = _g.view()
    
    inc_level(1)
    create_text("win", 0, 0)

    g_game_state:start_timer("win", 1, function()
        _g.fader_out(1, function()
            g_game_state:load"level_select"
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
    if g_zipper_goal and g_zipper_count >= g_zipper_goal then
        if g_zclass_entities['planet'] and #g_zclass_entities['planet'] == 1 then
            g_view.following = g_zclass_entities['planet'][1]
        end
    end

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
    local x,y = cos(ang)*(LEVEL_RADIUS+7),sin(ang)*(LEVEL_RADIUS+7)
    a.spawn_func(x, y, a.target)
end $$

function level_init_shared(level_num, txt1, txt2, music_index, pl_x, pl_y, zipper_goal)
    G_CUR_LEVEL = level_num
    music(music_index,1000,7)
    clean_all_entities()

    g_pl = _g.pl(pl_x, pl_y) -- add player
    g_view = _g.view(g_pl)
    local star_view = _g.star_view(g_pl) -- this view is just for stars, so they don't lose their position when the screen wraps
    for i=1,50 do
        _g.twinkle(rnd(256), rnd(256), rnd(), g_view, star_view)
    end

    create_text(txt1, pl_x, pl_y-3, _g.drawable_model_post_temp)
    _g.drawable_model_post_temp(pl_x, pl_y, _g.STARTING_CIRCLE, 1)
    create_text(txt2, pl_x, pl_y+3, _g.drawable_model_post_temp)

    _g.fader_in(1) -- to show the level
    _g.alert_radar(g_pl)

    g_zipper_count = 0
    g_zipper_goal = zipper_goal

    _g.game_checker(g_pl)

    -- used to determine if you beat the level or not
    _g.stats_displayer()
end
