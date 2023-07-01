create_actor([[bullet_bad; 4;police_weapon,bad_attack|   x:@1; y:@2; dx:@3; dy:@4; sind:198; col:8]])
create_actor([[bullet_good;4;police_weapon,good_attack|  x:@1; y:@2; dx:@3; dy:@4; sind:197; col:9]])

create_actor([[police_weapon;0;col,vec,confined,rel,post_drawable,tcol| -- bad_attack makes it do damage
    d:@1; tile_hit:@2; destroyed:@3;
    kill_when_hit:yes;
    touchable:no; rx:.375; ry:.25;
    iyy:-6;

    tl_max_time=1,;
]], function(a)
    a.flipped = not a.flipped
    a.xf = a.dx < 0
    scr_spr(a)
end, function(a)
    a.alive = false
end, function(a)
    _g.powerup_particle(a.x, a.y, a.col)
    _g.powerup_particle(a.x, a.y, a.col)
    _g.powerup_particle(a.x, a.y, a.col)
    _g.powerup_particle(a.x, a.y, a.col)
    _g.powerup_particle(a.x, a.y, a.col)
    _g.powerup_particle(a.x, a.y, a.col)
end)

create_actor([[bad_police;3;drawable,col,confined,mov,x_bounded,y_bounded,knockbackable,hurtable,spr_obj,bad_character,tcol|
    sind:192;
    x:@1; y:@2; enemy_id:@3; u:@4; damage:@5; destroyed:@6; d:@7;
    d:%police_draw;
    health:100; max_health:C_ENEMY_HEALTH;
    sh:2; iyy:-5;
    rx:.375; ry:.375;
    touchable: no;
]], function(a)
    local shoot_speed = .2
    -- walk, then wait, then shoot then wait
    if not a:any_timer_active('walk', 'wait', 'aim', 'shoot') then
        a:create_timer('walk', 120+rnd(60), function()
            a:create_timer('wait', flr_rnd(20)+10, function()
                a:create_timer('aim', 10, function()
                    _g.bullet_bad(a.x, a.y, a.xf and -shoot_speed or shoot_speed, 0)
                    a:create_timer('aim', 10, function() _g.bullet_bad(a.x, a.y-1, a.xf and -shoot_speed or shoot_speed, 0) end)
                    a:create_timer('shoot', 40, nf)
                end)
            end)
        end)
    end

    if a:any_timer_active'hurt_cooldown' then
       _g.powerup_particle(a.x, a.y+.5, C_COLOR_BLOOD)
    end

    if not a:any_timer_active'shoot' then
        if abs(a.dx) < .01 then
            a.xf = a.x - g_pl.x > 0
        end
    end

    if a:any_timer_active'knockback' then
        a:apply_knockback()
    elseif a:any_timer_active'walk' then
        a.dir = atan2(g_pl.x - a.x, g_pl.y - a.y) + rnd(.125) - .125/2
        a.ax = 0
        a.ay = sin(a.dir)*.03
    else
        a.ax = 0
        a.ay = 0
    end

end, function(a, other)
    local had_timer = a:any_timer_active'hurt_cooldown'
    a:hurt(g_pl.strength)
    a:knockback(atan2(a.x-other.x, a.y-other.y))

    if other.rel_actor then
        other.rel_actor:knockback(atan2(g_pl.x-a.x, g_pl.y-a.y))

        if not had_timer then
            call_not_nil(other.rel_actor, 'increment_strength', other.rel_actor)
        end
    end
end, function(a)
    create_cached_deadbody(a.enemy_id, a.x, a.y, a.xf, 227)
end, function(a) -- draw
    -- a.sind=192
    if a:any_timer_active'aim' then
        a.sind=195
    elseif a:any_timer_active'shoot' then
        a.sind=196
    elseif abs(a.dx) > .01 or abs(a.dy) > .01 then
        local loop = a.tl_tim % .5 / .5
        if loop < .25 then a.sind=193
        elseif loop < .5 then a.sind=192
        elseif loop < .75 then a.sind=193
        else a.sind=194
        end
    end
    scr_spr(a)
end)

create_actor([[police;3;captionable,drawable,col,confined,mov,x_bounded,y_bounded,spr_obj,tcol|
    x:@1; y:@2; enemy_id:@3; u:@4; d:@5;
    sind:224; sh:2; iyy:-5;
    rx:.375; ry:.375;
    touchable: no;
]], function(a)
    a.xf = t() % 10 > 5

    if t() % 7 < 1 then
        if a.xf then
            a.ax=.005
        else
            a.ax=-.005
        end
    else
        a.ax=0
    end

    if g_endgame_stats.enemy_kill_count > 0 then
        a.caption_text = "killer, thriller!"
    else
        a.caption_text = "abc, 123, you & me!"
    end

    local tim = t() % 5
    if     tim < 1 then a.sind = 224
    elseif tim < 2 then a.sind = 225
    elseif tim < 3 then a.sind = 226
    else a.sind = 225 end
end, scr_spr)
