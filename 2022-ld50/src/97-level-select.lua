zclass[[drawable_model_post,model,drawable_post|
    x,@, y,@, model,@
]]

function create_text(text, x, y, spacing)
    local new_text = ""
    for i=1,#text,1 do
        local letter = sub(text, i, i)
        if g_font[letter] then
            new_text = new_text..letter
        end
    end

    x = x-#new_text/2*spacing + spacing/2
    for i=1,#new_text,1 do
        local letter = sub(text, i, i)
        _g.drawable_model_post(x, y, g_font[letter])
        x+=spacing
    end

end

function loop_zobjs_in_view(class, method_name, ...)
    for inst in all(g_zclass_entities[class]) do
        if inst.parents.model and dist_between_circles(g_view, inst) < 0 or not inst.parents.model then
            call_not_nil(inst, method_name, inst, ...)
        end
    end
end

|level_select_draw| function()
    loop_zobjs_in_view('drawable_pre',  'draw')
    loop_zobjs_in_view('drawable',      'draw')
    loop_zobjs_in_view('drawable_post', 'draw')
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

    _g.alert_radar(g_pl)

    -- title
    create_text("rewob", 0, -2, 1)

    -- level entrances
    _g.level_entrance(-12, 0, _g.LEVEL_LEFT,  .75, .001)
    _g.level_entrance(12,  0, _g.LEVEL_RIGHT, .75, .001)
    _g.level_entrance(0,  12, _g.LEVEL_DOWN,  .75, .001)
    _g.level_entrance(0, -12, _g.LEVEL_UP,    .75, .001)

    -- add planets
    -- _g.planet(1,3)
    _g.chaser(0, -11).target = g_pl
    _g.black_hole(-11, -5)

    -- add background stars
    for i=1,50 do
        _g.twinkle(rnd(256), rnd(256), rnd())
    end
end $$

|level_select_update| function()
    loop_zobjs('actor',     'state')
    loop_zobjs('view',      'match_following')
    loop_zobjs('star_view', 'match_following')

    loop_zobjs('chaser', 'collide', g_zclass_entities['pl'])
    loop_zobjs('chaser', 'collide', g_zclass_entities['missile'])
    loop_zobjs('chaser', 'collide', g_zclass_entities['view'])
    loop_zobjs('black_hole', 'collide', g_zclass_entities['pl'])
    loop_zobjs('black_hole', 'collide', g_zclass_entities['view'])
    loop_zobjs('level_entrance', 'collide', g_zclass_entities['view'])

    loop_zobjs('alert_radar', 'register', g_zclass_entities['chaser'])
    loop_zobjs('alert_radar', 'register', g_zclass_entities['black_hole'])
    loop_zobjs('alert_radar', 'register', g_zclass_entities['level_entrance'])

    loop_zobjs('collision_circ', 'follow_anchoring')
    loop_zobjs('mov', 'mov_update')
    loop_zobjs('acc', 'acc_update')
    loop_zobjs('vec', 'vec_update')
    loop_zobjs('anchor_pos', 'update_anchor')

    loop_zobjs('model', 'model_update')

    -- wrap the level select screen
    if g_pl.x >  g_title_screen_coord then g_pl.x -= g_title_screen_dim-1 g_view.x -= g_title_screen_dim-1 end
    if g_pl.y >  g_title_screen_coord then g_pl.y -= g_title_screen_dim-1 g_view.y -= g_title_screen_dim-1 end
    if g_pl.x < -g_title_screen_coord then g_pl.x += g_title_screen_dim-1 g_view.x += g_title_screen_dim-1 end
    if g_pl.y < -g_title_screen_coord then g_pl.y += g_title_screen_dim-1 g_view.y += g_title_screen_dim-1 end
end $$

zclass[[level_entrance,model,drawable_pre|
    x,@, y,@, model,@, scale,@, d_ang,@,
    circ_radius,1.5,
    draw, %level_entrance_draw
]]

|level_entrance_draw| function(a)
    _g.model_draw(a)
end $$
