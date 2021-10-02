create_actor([[pl;2;drawable,pos,confined,mov,x_bounded,y_bounded,timer|
    x:@1; y:@2;
    
    inertia_x:.95;
    inertia_y:.95;

    timer:nil;

    d:@3; u:@4;
]], function(a)
    scr_circ(a.x, a.y, .5, 4)
end, function(a)
    if not a:is_timer_active"cooldown" and not a:is_timer_active"speedup" and btn(4) then
        a:create_timer("speedup", 30, function() a:create_timer("cooldown", 60) end)
    end

    if a:is_timer_active"speedup" then
        a.ax = xbtn()*.05
        a.ay = ybtn()*.05
    else
        a.ax = xbtn()*.01
        a.ay = ybtn()*.01
    end
end)
