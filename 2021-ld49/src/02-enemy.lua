create_actor([[simple_enemy;2;drawable,col,confined,mov,x_bounded,y_bounded,knockbackable,hurtable|
    x:@1; y:@2; u:@3; d:@4; hit:@5;
    health:3; max_health:3;
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
        a.ay = sin(a.dir)*.01
    else
        a.ax = 0
        a.ay = 0
    end
end, function(a)
    scr_circ(a.x, a.y, .4, 10)
end, function(a, other)
    if other.pl and not other:any_timer_active("roll") then
        other:hurt()
        other:knockback(atan2(other.x-a.x, other.y-a.y))
        a:knockback(atan2(a.x-other.x, a.y-other.y))
    elseif other.fist then
        a:hurt()
        g_pl:knockback(atan2(g_pl.x-a.x, g_pl.y-a.y))
        a:knockback(atan2(a.x-other.x, a.y-other.y))
    end
end)
