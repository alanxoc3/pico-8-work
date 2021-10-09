function _g.nurse_draw(a)
    a.sind=66

    if a:any_timer_active"prepare" then
        a.sind=69
    elseif a:any_timer_active"attack" then
        a.sind=70
        if a:get_timer_percent"attack" > .50 then
            a.sind=71
        end
    elseif abs(a.dx) > .005 or abs(a.dy) > .005 then
        local loop = a.tl_tim % .5 / .5
        if loop < .25 then a.sind=66
        elseif loop < .5 then a.sind=67
        elseif loop < .75 then a.sind=66
        else a.sind=68
        end
    end

    if g_room.name == 'hospital' then
        a.sind += 32
    end
    scr_spr(a)
end

create_actor([[nurse_weapon;3;col,confined,rel,bad_attack|
    rel_actor:@1; x:@2; y:@3; i:@4;
    touchable:no; rx:.5; ry:1;

    tl_max_time=.16,;
]], function(a)
    a.rel_dx = zsgn(cos(a.rel_actor.dir))*.05
end)

create_actor([[bad_nurse;3;drawable,col,confined,mov,x_bounded,y_bounded,knockbackable,hurtable,spr_obj,bad_character,tcol|
    sind:66;
    x:@1; y:@2; enemy_id:@3; u:@4; damage:@5; destroyed:@6;
    d:%nurse_draw;
    health:%c_enemy_health; max_health:%c_enemy_health;
    sh:2; iyy:-5;
    rx:.375; ry:.375;
    touchable: no;
]], function(a)
    if not a:any_timer_active("cooldown", "walk", "prepare", "attack") then
        a.dir = atan2(g_pl.x - a.x, g_pl.y - a.y) + rnd(.125) - .125/2
        a:create_timer("walk", flr_rnd(10)+30, function()
            a:create_timer("cooldown", flr_rnd(120), function()
                a:create_timer("prepare", 40, function()
                    _g.nurse_weapon(a, a.x, a.y)
                    a:create_timer("attack", 10)
                end)
            end)
        end)
    end

    if a:any_timer_active"hurt_cooldown" then
       _g.powerup_particle(a.x, a.y+.5, _g.c_color_blood)
    end

    if a:any_timer_active"knockback" then
        a:apply_knockback()
    elseif a:any_timer_active"walk" then
        a.ax = cos(a.dir)*.01
        if a.ax > 0 then
            a.xf = false
        elseif a.ax < 0 then
            a.xf = true
        end
        a.ay = sin(a.dir)*.01
    else
        a.ax = 0
        a.ay = 0
    end
end, function(a, other)
    local had_timer = a:any_timer_active"hurt_cooldown"
    a:hurt(g_pl.strength)
    a:knockback(atan2(a.x-other.x, a.y-other.y))

    if other.rel_actor then
        other.rel_actor:knockback(atan2(g_pl.x-a.x, g_pl.y-a.y))

        if not had_timer then
            call_not_nil(other.rel_actor, "increment_strength", other.rel_actor)
        end
    end
end, function(a)
    create_cached_deadbody(a.enemy_id, a.x, a.y, a.xf, 96)
end)

create_actor([[nurse;3;captionable,drawable,col,confined,mov,x_bounded,y_bounded,spr_obj,tcol|
    sind:98;
    x:@1; y:@2; enemy_id:@3; u:@4; d:%nurse_draw;
    sh:2; iyy:-5;
    rx:.375; ry:.375;
    touchable: no;
]], function(a)
    if not a:any_timer_active("cooldown", "walk") then
        a.dir = atan2(g_pl.x - a.x, g_pl.y - a.y) + rnd(.125) - .125/2
        a:create_timer("walk", flr_rnd(10)+30, function()
            a:create_timer("cooldown", flr_rnd(120)+50)
        end)
    end

    if g_endgame_stats.enemy_kill_count > 0 then
        a.caption_text = "you monster!"
    else
        a.caption_text = "you're healed!"
    end

    if a:any_timer_active"walk" then
        a.ax = cos(a.dir)*.01
        if a.ax > 0 then
            a.xf = false
        elseif a.ax < 0 then
            a.xf = true
        end
        a.ay = sin(a.dir)*.01
    else
        a.ax = 0
        a.ay = 0
    end
end)
