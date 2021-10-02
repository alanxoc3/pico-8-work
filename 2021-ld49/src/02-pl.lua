create_actor([[angry_particle;5;pre_drawable,mov|
    x:@1; y:@2; beg_color:@3; end_color:@4;

    i:@6; d:@7;
    inertia_x:.90;
    inertia_y:.90;

    tl_max_time=@5,;
]], function(a)
    a.dx = rnd(.2) - .1
    a.dy = -rnd(.2)-.1
end, function(a)
    local color = a.beg_color
    if a.tl_tim then
        if a.tl_tim / a.tl_max_time > .5 then
            color = a.end_color
        end
        scr_circfill(a.x, a.y, .125, color)
    end
end)

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

    d:@3; u:@4; damage:@5; hurt_start:@6; hurt_end:@7;
]], function(a)
    a.sind = 134
    a.yy = 0
    if a:any_timer_active"punch" then
        local percent = a:get_timer_percent"punch"
        if percent >= .90 then a.sind = 133
        elseif percent >= .80 then a.sind = 132
        elseif percent >= .50 then a.sind = 131
        elseif percent >= .30 then a.sind = 130
        elseif percent >= .10 then a.sind = 129
        else a.sind = 128
        end
        a.yy = sin(percent/2)*5
    elseif a:any_timer_active"roll" then
        local percent = a:get_timer_percent"roll"
        if percent >= .90 then a.sind = 140
        elseif percent >= .80 then a.sind = 139
        elseif percent >= .50 then a.sind = 138
        elseif percent >= .30 then a.sind = 137
        else a.sind = 136
        end
    elseif abs(a.dx) > .005 or abs(a.dy) > .005 then
        local loop = (a.tl_tim % .4) / .4
        if loop >= .8 then a.sind = 134
        elseif loop >= .5 then a.sind = 167
        elseif loop >= .3 then a.sind = 134
        else a.sind = 168
        end
    else
        local loop = (a.tl_tim % 1)
        if loop < .25 then a.sind = 166 end
    end
    a.xf = a.is_facing_left

    scr_spr(a)
end, function(a)
    -- DEBUG_BEGIN
    if g_debug and btnp(5) then a.insane_level = (a.insane_level + 1) % 5 end
    -- DEBUG_END

    local speed_multiplier = 1 + a.insane_level / 10
    if a.insane_level == 4 then
        _g.angry_particle(a.x, a.y+.5, 8, 8, rnd(.25)+.25)
    elseif a.insane_level == 3 then
        _g.angry_particle(a.x, a.y+.5, 14, 14, rnd(.2))
    elseif a.insane_level == 2 then
        _g.angry_particle(a.x, a.y+.5, 2, 2, rnd(.2))
    elseif a.insane_level == 1 then
      _g.angry_particle(a.x, a.y+.5, 1, 1, rnd(.2))
    end

    if not a:any_timer_active("cooldown", "roll", "punch") then
        if btn(5) then
            a:create_timer("roll",  20, function() a.dx /= 3 a.dy /= 3 a:create_timer("cooldown", 20) end)
        elseif btn(4) then
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
        a.ax = cos(a.dir)*.015
        a.ay = sin(a.dir)*.015
    elseif is_moving then -- and not a:any_timer_active"punch" then
        if xbtn() ~= 0 then
            a.is_facing_left = xbtn() < 0
        end

        a.dir = atan2(xbtn() == 0 and (a.is_facing_left and -1 or 1) or xbtn(), ybtn())

        local dir = atan2(xbtn(), ybtn())
        a.ax = cos(dir)*.015
        a.ay = sin(dir)*.015
    else
        a.dir = atan2(a.is_facing_left and -1 or 1, 0)
        a.ax = 0
        a.ay = 0
    end
    a.ax *= speed_multiplier
    a.ay *= speed_multiplier
end, function(a, other)
    a:hurt()
    a:knockback(atan2(a.x-other.x, a.y-other.y))
end, function(a)
    a.insane_level = 4
end, function(a)
    a.insane_level = 0
end)
