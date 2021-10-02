create_actor([[pl;2;drawable,pos,confined,mov,x_bounded,y_bounded,timer|
    x:@1; y:@2;
    
    inertia_x:.90;
    inertia_y:.90;

    dir:0;

    timer:nil;

    d:@3; u:@4;
]], function(a)
    scr_circ(a.x, a.y, .5, 4)
end, function(a)
    -- roll
    if btn(4) and not a:is_timer_active"cooldown" and not a:is_timer_active"roll" then
        a:create_timer("roll", 10, function() a:create_timer("cooldown", 20) end)
    end

    local is_moving = xbtn() ~= 0 or ybtn() ~= 0
    if is_moving then
        a.dir = atan2(xbtn(), ybtn())
    end

    if a:is_timer_active"roll" then
        a.ax = cos(a.dir)*.05
        a.ay = sin(a.dir)*.05
    elseif is_moving then
        a.ax = cos(a.dir)*.01
        a.ay = sin(a.dir)*.01
    else
        a.ax = 0
        a.ay = 0
    end
end)
