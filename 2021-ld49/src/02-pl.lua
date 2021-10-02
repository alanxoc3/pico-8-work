create_actor([[fist;3;drawable,col,confined,rel|
    rel_actor:@1; x:@2; y:@3; i:@4; d:@5;
    touchable:no; rx:.25; ry:.25;

    tl_max_time=.125,;
]], function(a)
    a.rel_dx = cos(a.rel_actor.dir)*.2
    a.rel_dy = sin(a.rel_actor.dir)*.2
end, function(a)
    scr_circ(a.x, a.y, .3, 8)
end)

create_actor([[pl;2;drawable,pos,confined,mov,x_bounded,y_bounded,timer,col,knockbackable|
    x:@1; y:@2;
    
    inertia_x:.90;
    inertia_y:.90;

    dir:0;

    timer:nil;

    d:@3; u:@4;
]], function(a)
    scr_circ(a.x, a.y, .5, 4)
end, function(a)
    if not a:any_timer_active("cooldown", "roll", "punch") then
        if btn(4) then
            a:create_timer("roll",  12, function() a.dx /= 3 a.dy /= 3 a:create_timer("cooldown", 20) end)
            
        elseif btn(5) then
            a:create_timer("punch", 10, function() a:create_timer("cooldown", 10) end)
            _g.fist(a, a.x, a.y)
        end
    end

    local is_moving = xbtn() ~= 0 or ybtn() ~= 0
    if is_moving then
        a.dir = atan2(xbtn(), ybtn())
    end

    if a:any_timer_active"knockback" then
        a:apply_knockback()
    elseif a:any_timer_active"roll" then
        a.ax = cos(a.dir)*.05
        a.ay = sin(a.dir)*.05
    elseif is_moving then -- and not a:any_timer_active"punch" then
        a.ax = cos(a.dir)*.01
        a.ay = sin(a.dir)*.01
    else
        a.ax = 0
        a.ay = 0
    end
end)
