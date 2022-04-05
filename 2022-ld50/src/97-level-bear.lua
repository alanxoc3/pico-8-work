|level_bear_init| function()
    music(8,1000,7)
    clean_all_entities()

    g_pl = _g.pl(0, 0) -- add player
    g_view = _g.view(g_pl)
    local star_view = _g.star_view(g_pl) -- this view is just for stars, so they don't lose their position when the screen wraps
    for i=1,50 do
        _g.twinkle(rnd(256), rnd(256), rnd(), g_view, star_view)
    end

    create_level_focus_points()
    create_text("lvl", 0, -3, _g.drawable_model_post_temp)
    _g.drawable_model_post_temp(0, 0, _g.STARTING_CIRCLE, 1)
    create_text("bear", 0, 3, _g.drawable_model_post_temp)

    _g.fader_in(1) -- to show the level
    _g.alert_radar(g_pl)

    -- title
    local planet = _g.planet(0,-22,10,_g.BEAR)
    _g.level_state(planet)
    _g.stats_displayer(planet)
    _g.black_hole(0, 22)
    _g.game_checker(g_pl, planet, "level_bear_retry", "win_bear")
end $$
