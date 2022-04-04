zclass[[drawable_model_post,model,drawable_post|
    x,@, y,@, model_obj,@
]]

|level_select_draw| function()
    loop_zobjs('drawable_pre',  'draw')
    loop_zobjs('drawable',      'draw')
    loop_zobjs('drawable_post', 'draw')
end $$

|level_select_init| function()
    -- [0,0] is the center of the level
    -- add player
    g_pl = _g.pl(0, 0)
    _g.drawable_model_post(0, 0, _g.STARTING_CIRCLE)
    g_view = _g.view(g_pl)

    -- this view is just for stars, so they don't lose their position when the screen wraps
    g_star_view = _g.star_view(g_pl)

    _g.fader_in(1)

    g_title_screen_coord = 30
    g_title_screen_dim = g_title_screen_coord*2

    -- title
    _g.drawable_model_post(-3,   -3, _g.TEST_LET_R)
    _g.drawable_model_post(-1.5, -3, _g.TEST_LET_E)
    _g.drawable_model_post(0,    -3, _g.TEST_LET_W)
    _g.drawable_model_post(1.5,  -3, _g.TEST_LET_O)
    _g.drawable_model_post(3,    -3, _g.TEST_LET_B)

    -- level entrances
    _g.level_entrance(-12, 0, _g.LEVEL_CATEROID, .75, .001)
    _g.level_entrance(12,  0, _g.LEVEL_CATEROID, .75, .001)
    _g.level_entrance(0,  12, _g.LEVEL_CATEROID, .75, .001)
    _g.level_entrance(0, -12, _g.LEVEL_CATEROID, .75, .001)

    -- add planets
    -- _g.planet(1,3)
    -- _g.cateroid(0, -11)

    -- add background stars
    for i=1,50 do
        _g.twinkle(rnd(256), rnd(256), rnd())
    end
end $$

|level_select_update| function()
    loop_zobjs('actor',     'state')
    loop_zobjs('view',      'match_following')
    loop_zobjs('star_view', 'match_following')

    loop_zobjs('wall', 'collide', g_zclass_entities['pl'])
    loop_zobjs('wall', 'collide', g_zclass_entities['missile'])
    loop_zobjs('wall', 'collide', g_zclass_entities['view'])
    loop_zobjs('level_entrance', 'collide', g_zclass_entities['view'])
    loop_zobjs('collision_circ', 'follow_anchoring')
    loop_zobjs('mov', 'mov_update')
    loop_zobjs('acc', 'acc_update')
    loop_zobjs('vec', 'vec_update')

    -- wrap the level select screen
    if g_pl.x >  g_title_screen_coord then g_pl.x -= g_title_screen_dim-1 g_view.x -= g_title_screen_dim-1 end
    if g_pl.y >  g_title_screen_coord then g_pl.y -= g_title_screen_dim-1 g_view.y -= g_title_screen_dim-1 end
    if g_pl.x < -g_title_screen_coord then g_pl.x += g_title_screen_dim-1 g_view.x += g_title_screen_dim-1 end
    if g_pl.y < -g_title_screen_coord then g_pl.y += g_title_screen_dim-1 g_view.y += g_title_screen_dim-1 end
end $$

zclass[[level_entrance,model,drawable_post|
    x,@, y,@, model_obj,@, scale,@, d_ang,@,
    circ_radius,1.5,
    draw, %level_entrance_draw
]]

|level_entrance_draw| function(a)
    _g.model_draw(a)
end $$
