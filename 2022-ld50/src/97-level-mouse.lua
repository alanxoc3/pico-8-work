
zclass[[mouse_level_state,actor|
    planet,@,
    chasers_spawned,0;
    start;duration,10,next,spawn;
    spawn;init,%spawn_init,duration,8,next,spawn;
    done_spawning;,;
]]

|spawn_init| function(a)
    printh('here')
    local ang = rnd()
    local x,y = cos(ang)*20,sin(ang)*20
    _g.chaser(x, y, a.planet)
    a.chasers_spawned += 1
    if a.chasers_spawned == 9 then a.next = 'done_spawning' end
end $$

|level_mouse_init| function()
    music(32,1000,7)
    clean_all_entities()

    g_pl = _g.pl(0, 0) -- add player
    g_view = _g.view(g_pl)
    local star_view = _g.star_view(g_pl) -- this view is just for stars, so they don't lose their position when the screen wraps
    for i=1,50 do
        _g.twinkle(rnd(256), rnd(256), rnd(), g_view, star_view)
    end

    _g.pl_checker(g_pl, "level_mouse_retry")

    create_level_focus_points()
    create_text("lvl", 0, -3, _g.drawable_model_post_temp)
    _g.drawable_model_post_temp(0, 0, _g.STARTING_CIRCLE, 1)
    create_text("mouse", 0, 3, _g.drawable_model_post_temp)

    _g.fader_in(1) -- to show the level
    _g.alert_radar(g_pl)

    -- title

    local planet = _g.planet(0,-22,10,_g.MOUSE)
    _g.mouse_level_state(planet)
    _g.chaser(0, 2, planet)
    _g.black_hole(0, 22)
end $$

|level_mouse_update| function()
    loop_zobjs('actor',     'state')
    loop_zobjs('view',      'match_following')
    loop_zobjs('star_view', 'match_following')

    loop_zobjs('missile', 'collide', g_zclass_entities['teammate'])
    loop_zobjs('teammate', 'collide', g_zclass_entities['teammate'])

    loop_zobjs('alert_radar', 'register', g_zclass_entities['planet'])
    loop_zobjs('alert_radar', 'register', g_zclass_entities['view'])
    loop_zobjs('focus_point', 'collide', g_zclass_entities['view'])
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
