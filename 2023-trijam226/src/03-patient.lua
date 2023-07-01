function _g.patient_draw(a)
    a.sind=224

    a.sw = 1
    if a:any_timer_active'prepare' then
        a.sw = 2
        a.sind=226
    elseif a:any_timer_active'charge' then
        a.sw = 2
        local percent = a:get_timer_percent'charge'
        if     percent < .2 then a.sind=228
        elseif percent < .4 then a.sind=230
        elseif percent < .75 then a.sind=232
        else a.sind=226
        end
    end

    scr_spr(a)
end

create_actor([[patient_weapon;3;col,confined,rel,bad_attack|
    rel_actor:@1; x:@2; y:@3; i:@4;
    touchable:no; rx:.75; ry:.75;

    tl_max_time=.5,;
]])

create_actor([[bad_patient;3;drawable,col,confined,mov,x_bounded,y_bounded,knockbackable,hurtable,spr_obj,bad_character,tcol|
    sind:224;
    x:@1; y:@2; enemy_id:@3; u:@4; damage:@5; destroyed:@6;
    d:%patient_draw;
    health:3; max_health:3;
    sh:2; iyy:-5;
    rx:.375; ry:.375;
    touchable: no;
]], function(a)
    if not a:any_timer_active('cooldown', 'charge', 'prepare', 'attack') then
        a.dir = atan2(g_pl.x - a.x, g_pl.y - a.y) + rnd(.125) - .125/2
        _g.patient_weapon(a, a.x, a.y)
        a:create_timer('charge', 20, function()
            a:create_timer('cooldown', flr_rnd(60)+60, function()
                a:create_timer('prepare', 60)
            end)
        end)
    end

    if a:any_timer_active'hurt_cooldown' then
       _g.powerup_particle(a.x, a.y+.5, C_COLOR_BLOOD)
    end

    if a:any_timer_active'knockback' then
        a:apply_knockback()
    elseif a:any_timer_active'charge' then
        a.ax = cos(a.dir)*.03
        a.ay = sin(a.dir)*.03

        if a.ax > 0 then
            a.xf = false
        elseif a.ax < 0 then
            a.xf = true
        end
    else
        if abs(a.dx) < .01 then
            a.xf = a.x - g_pl.x > 0
        end

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
    create_cached_deadbody(a.enemy_id, a.x, a.y, a.xf, 215)
end)

create_actor([[patient;3;captionable,drawable,col,confined,mov,x_bounded,y_bounded,spr_obj,tcol|
    sind:41;
    x:@1; y:@2; enemy_id:@3; u:@4; d:@5;
    sind:41; sh:2; iyy:-5;
    rx:.375; ry:.375;
    touchable: no;
]], function(a)
    a.xf = a.x - g_pl.x > 0
    if t() % 5 < .5 then
        a.ixx = flr_rnd(3)-1
        a.sind = rnd_item{41,42,43}
    else
        a.ixx = 0
    end

    if g_endgame_stats.enemy_kill_count > 0 then
        a.caption_text = "don't kill me too!"
    else
        a.caption_text = "play with me!"
    end
end, scr_spr)
