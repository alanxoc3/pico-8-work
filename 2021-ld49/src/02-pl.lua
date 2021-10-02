create_actor([[fist;3;col,confined,rel|
    rel_actor:@1; x:@2; y:@3; i:@4; d:@5;
    touchable:no; rx:.25; ry:.5;

    tl_max_time=.33,;
]], function(a)
    a.rel_dx = cos(a.rel_actor.dir)*.05
    a.rel_dy = sin(a.rel_actor.dir)*.05
end)

create_actor([[pl;2;drawable,pos,confined,mov,x_bounded,y_bounded,col,spr_obj,knockbackable,hurtable|
    x:@1; y:@2;
    health:3; max_health:3;

    insane_level:0;
    
    sh:2; sind:137;
    inertia_x:.90;
    inertia_y:.90;

    dir:0; is_facing_left:no;

    d:@3; u:@4; damage:@5;
]], function(a)
    a.sind = 128
    a.yy = 0
    if a:any_timer_active"punch" then
        local percent = a:get_timer_percent"punch"
        if percent >= .90 then a.sind = 133
        elseif percent >= .80 then a.sind = 132
        elseif percent >= .50 then a.sind = 131
        elseif percent >= .20 then a.sind = 130
        else a.sind = 129
        end
        a.yy = sin(percent/2)*5
    end
    a.xf = a.is_facing_left

    -- scr_circ(a.x, a.y, .5, 12)
    scr_spr(a)
end, function(a)
    if not a:any_timer_active("cooldown", "roll", "punch") then
        if btn(4) then
            a:create_timer("roll",  15, function() a.dx /= 3 a.dy /= 3 a:create_timer("cooldown", 20) end)
            
        elseif btn(5) then
            a:create_timer("punch", 20, function() a:create_timer("cooldown", 10) end)
            _g.fist(a, a.x, a.y)
        end
    end

    local is_moving = xbtn() ~= 0 or ybtn() ~= 0
    if a:any_timer_active"knockback" then
        a:apply_knockback()
    elseif a:any_timer_active"roll" then
        a.ax = cos(a.dir)*.03
        a.ay = sin(a.dir)*.03
    elseif a:any_timer_active"punch" then
        a.ax = cos(a.dir)*.01
        a.ay = sin(a.dir)*.01
    elseif is_moving then -- and not a:any_timer_active"punch" then
        if xbtn() ~= 0 then
            a.is_facing_left = xbtn() < 0
        end

        a.dir = atan2(xbtn() == 0 and (a.is_facing_left and -1 or 1) or xbtn(), ybtn())

        local dir = atan2(xbtn(), ybtn())
        a.ax = cos(dir)*.01
        a.ay = sin(dir)*.01
    else
        a.dir = atan2(a.is_facing_left and -1 or 1, 0)
        a.ax = 0
        a.ay = 0
    end
end, function(a, other)
    a:hurt()
    a:knockback(atan2(a.x-other.x, a.y-other.y))
end)
