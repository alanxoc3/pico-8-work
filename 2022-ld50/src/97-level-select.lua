zclass[[drawable_model_post,model,drawlayer_40|
    x,@, y,@, model,@
]]

zclass[[drawable_model_post_temp,model,drawlayer_40|
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

function create_level_selector(x, y, level, txt1, txt2, model, model_win)
    if G_LEVEL == level then
        create_text(txt1, x,  y-2.5)
        create_text(txt2, x, y+2.5)
        _g.level_entrance(x, y, model, level, 9)
    elseif G_LEVEL > level then
        create_text(txt1, x,  y-2.5)
        create_text(txt2, x, y+2.5)
        _g.level_entrance(x, y, model_win, level, 11)
    end
end

|level_select_init| function()
    local yoff = 8
    music(0,1000,7)
    clean_all_entities()

    g_pl = _g.pl(0, yoff) -- add player
    g_view = _g.view(g_pl)
    local star_view = _g.star_view(g_pl) -- this view is just for stars, so they don't lose their position when the screen wraps
    for i=1,50 do
        _g.twinkle(rnd(256), rnd(256), rnd(), g_view, star_view)
    end

    _g.fader_in(1) -- to show the level
    _g.alert_radar(g_pl)

    g_title_screen_coord = 40
    g_title_screen_dim = g_title_screen_coord*2

    create_level_selector(18,  yoff+0,   1, "lvl "..1, "bear",    _g.LEVEL_BEAR_MODEL,  _g.LEVEL_BEAR_CLEAR)
    create_level_selector(21,  yoff+-12, 2, "lvl "..2, "bear",    _g.LEVEL_BEAR_MODEL,  _g.LEVEL_BEAR_CLEAR)
    create_level_selector(12,  yoff+-21, 3, "lvl "..3, "bear",    _g.LEVEL_BEAR_MODEL,  _g.LEVEL_BEAR_CLEAR)
    create_level_selector(0,   yoff+-18, 4, "lvl "..4, "bear",    _g.LEVEL_BEAR_MODEL,  _g.LEVEL_BEAR_CLEAR)
    create_level_selector(-12, yoff+-21, 5, "lvl "..5, "cat",     _g.LEVEL_CAT_MODEL,   _g.LEVEL_CAT_CLEAR)
    create_level_selector(-21, yoff+-12, 6, "lvl "..6, "pig",     _g.LEVEL_PIG_MODEL,   _g.LEVEL_PIG_CLEAR)
    create_level_selector(-18, yoff+0,   7, "lvl "..7, "mouse",   _g.LEVEL_MOUSE_MODEL, _g.LEVEL_MOUSE_CLEAR)
    create_level_selector(0,   yoff+12,  8, "the",     "credits", _g.LEVEL_CAT_MODEL,   _g.LEVEL_CAT_MODEL)

    create_text("rewob", 0, yoff-3, _g.drawable_model_post_temp)
    _g.drawable_model_post_temp(0, yoff, _g.STARTING_CIRCLE)
    if G_DEATH_COUNT > 0 then
        create_text(get_wob_text(), 0, yoff+3, _g.drawable_model_post_temp)
    else
        create_text("by amorg", 0, yoff+3, _g.drawable_model_post_temp)
    end
end $$

|level_select_update| function()
    loop_zobjs('actor',     'state')
    loop_zobjs('view',      'match_following')
    loop_zobjs('star_view', 'match_following')

    loop_zobjs('view', 'collide', g_zclass_entities['level_entrance'])
    loop_zobjs('missile', 'collide', g_zclass_entities['level_entrance'])

    loop_zobjs('level_entrance', 'collide', g_zclass_entities['pl'])
    loop_zobjs('pl', 'collide', g_zclass_entities['level_entrance'])

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

zclass[[level_entrance,model,drawlayer_10|
    x,@, y,@, model,@, next_game_state,@, alert_color,@,
    circ_radius,1.5,
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
