create_actor([[nurse_weapon;3;col,confined,rel,enemy|
    rel_actor:@1; x:@2; y:@3; i:@4; hit:@5;
    touchable:no; rx:.5; ry:1;

    tl_max_time=.16,;
]], function(a)
    a.rel_dx = zsgn(cos(a.rel_actor.dir))*.05
end, function(a, other)
    if other.pl and not other:any_timer_active("roll") then
        other:damage(a)
    end
end)

create_actor([[simple_enemy;2;drawable,col,confined,mov,x_bounded,y_bounded,knockbackable,hurtable,spr_obj,enemy,tcol|
    x:@1; y:@2; u:@3; d:@4; hit:@5; destroyed:@6;
    health:3; max_health:3;
    sh:2;
    iyy:-5;
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

    if a:any_timer_active"attack" then
    end
end, function(a)
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
    scr_spr(a)
end, function(a, other)
    if other.pl and not other:any_timer_active("roll") then
        -- other:knockback(atan2(other.x-a.x, other.y-a.y))
        -- a:knockback(atan2(a.x-other.x, a.y-other.y))
    elseif other.fist then
        if not a:any_timer_active"hurt_cooldown" then
            g_pl:increment_insanity()
        end
        a:hurt(g_pl.strength)
        g_pl:knockback(atan2(g_pl.x-a.x, g_pl.y-a.y))
        a:knockback(atan2(a.x-other.x, a.y-other.y))
    end
end, function(a)
    _g.deadbody(a.x, a.y, a.xf, 96)
end)
