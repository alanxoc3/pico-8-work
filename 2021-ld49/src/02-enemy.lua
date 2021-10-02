create_actor([[simple_enemy;2;drawable,col,confined,mov,x_bounded,y_bounded,knockbackable,hurtable,spr_obj|
    x:@1; y:@2; u:@3; d:@4; hit:@5;
    health:3; max_health:3;
    sh:2;
    rx:.375; ry:.375;
    touchable: no;
    inertia_x:.90;
    inertia_y:.90;
]], function(a)
    if not a:any_timer_active("cooldown", "walk") then
        a.dir = atan2(g_pl.x - a.x, g_pl.y - a.y) + rnd(.125) - .125/2
        a:create_timer("walk",  flr_rnd(10)+10, function() a:create_timer("cooldown", flr_rnd(80)+120) end)
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
end, function(a)
    a.sind=66
    if abs(a.dx) > .005 or abs(a.dy) > .005 then
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
        other:damage(a)
        a:knockback(atan2(a.x-other.x, a.y-other.y))
    elseif other.fist then
        a:hurt(g_pl.insane_level == 4 and 2 or 1)
        g_pl:knockback(atan2(g_pl.x-a.x, g_pl.y-a.y))
        a:knockback(atan2(a.x-other.x, a.y-other.y))
    end
end)
