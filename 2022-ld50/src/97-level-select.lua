zclass[[drawable_model_post,model,drawable_post|
    x,@, y,@, model,@
]]

zclass[[drawable_model_post_temp,model,drawable_post|
    x,@, y,@, model,@;
    start;duration,1.5, next,dying;
    dying;init,%model_explode;
]]

function create_text(original_text, original_x, y, func, ...)
    func = func or _g.drawable_model_post
    local l = split(original_text, ",", false)
    local params = {...}

    y = y-#l/2 + .5
    foreach(l, function(text)
        local x = original_x
        local new_text = ""
        for i=1,#text,1 do
            local letter = sub(text, i, i)
            if g_font[letter] then
                new_text = new_text..letter
            end
        end

        x = x-#new_text/2 + .5
        for i=1,#new_text,1 do
            local letter = sub(text, i, i)
            func(x, y, g_font[letter], unpack(params))
            x+=1
        end
        y+=1
    end)
end

function loop_zobjs_in_view(view, class, method_name, ...)
    for inst in all(g_zclass_entities[class]) do
        if inst.parents.model and dist_between_circles(view, inst) < 0 or not inst.parents.model then
            call_not_nil(inst, method_name, inst, ...)
        end
    end
end

|level_select_init| function()
    music(0,1000,7)
    clean_all_entities()
    -- [0,0] is the center of the level
    g_pl = _g.pl(0, 0) -- add player
    g_view = _g.view(g_pl)
    local star_view = _g.star_view(g_pl) -- this view is just for stars, so they don't lose their position when the screen wraps
    for i=1,50 do
        _g.twinkle(rnd(256), rnd(256), rnd(), g_view, star_view)
    end

    _g.fader_in(1) -- to show the level
    _g.alert_radar(g_pl)

    g_title_screen_coord = 30
    g_title_screen_dim = g_title_screen_coord*2

    -- title
    create_text("rewob", 0, -3, _g.drawable_model_post_temp)
    _g.drawable_model_post_temp(0, 0, _g.STARTING_CIRCLE)
    create_text("ldjam50", 0, 3, _g.drawable_model_post_temp)

    -- level entrances
    create_text("lvl",    -12,  -2.5)  create_text("cat",   -12, 2.5)  _g.level_entrance(-12, 0, _g.LEVEL_LEFT, "level_cat")
    create_text("lvl",    12,   -2.5)  create_text("pig",   12,  2.5)  _g.level_entrance(12,  0, _g.LEVEL_RIGHT, "level_pig")
    create_text("lvl",    0,    9.5)   create_text("mouse", 0,   14.5) _g.level_entrance(0,  12, _g.LEVEL_DOWN, "level_mouse")
    create_text("lvl",    0,   -14.5)  create_text("bear",  0,   -9.5) _g.level_entrance(0, -12, _g.LEVEL_UP, "level_bear")

    create_text("code,amorg,denial", -12, -12)
    create_text("gfx,tigerwolf,greatcadet", 12, -12) _g.focus_point(12,-12)
    create_text("sfx,amorg", -12, 12)
    create_text("made,with,pico8", 12, 12)

end $$

|level_select_update| function()
    loop_zobjs('actor',     'state')
    loop_zobjs('view',      'match_following')
    loop_zobjs('star_view', 'match_following')

    loop_zobjs('level_entrance', 'collide', g_zclass_entities['view'])
    loop_zobjs('level_entrance', 'collide', g_zclass_entities['pl'])
    loop_zobjs('focus_point', 'collide', g_zclass_entities['view'])

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
    x,@, y,@, model,@, next_game_state,@,
    circ_radius,1.5,
    alert_color,9,
    draw, %level_entrance_draw,
    d_ang, .001,
    hit, %level_entrance_hit
]]

|level_entrance_draw| function(a)
    _g.model_draw(a)
end $$

|level_entrance_hit| function(a, other)
    if other.id == 'pl' then
        a:explode()
        music(-1)
        sfx(22, 3)
        _g.fader_out(1, function()
            g_game_state:load(a.next_game_state)
        end)
    end
end $$

zclass[[focus_point,model|
    model,%FOCUS_POINT, x,@, y,@, radius,1
]]
