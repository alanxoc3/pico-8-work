create_actor([[fist;3;col,confined,rel|
    rel_actor:@1; x:@2; y:@3; i:@4; d:@5;
    touchable:no; rx:.25; ry:.75;

    tl_max_time=.33,;
]], function(a)
    a.rel_dx = cos(a.rel_actor.dir)*.03
    a.rel_dy = sin(a.rel_actor.dir)*.03
end)

function control_player(a, x_dir, y_dir, is_z_pressed, is_x_pressed, punch_enabled)
    if not a.pl then return end

    local speed_multiplier = 1 + a.insane_level / 10
    if a.insane_level == 4 then _g.powerup_particle(a.x, a.y+.5, COLOR_ANGRY)
    elseif a.insane_level == 3 then _g.powerup_particle(a.x, a.y+.5, COLOR_INSANE_3)
    elseif a.insane_level == 2 then _g.powerup_particle(a.x, a.y+.5, COLOR_INSANE_2)
    elseif a.insane_level == 1 then _g.powerup_particle(a.x, a.y+.5, COLOR_INSANE_1)
    -- no color for normal
    -- elseif a.insane_level == 0 then _g.powerup_particle(a.x, a.y+.5, COLOR_NORMAL)
    end

    if not a:any_timer_active("cooldown", "roll", "punch") then
        if is_z_pressed then
            a:create_timer("roll",  20, function() a.dx /= 3 a.dy /= 3 a:create_timer("cooldown", 20) end)
        elseif is_x_pressed then
            -- if punch is not enabled, assume that talking is enabled.
            if punch_enabled then
                a:create_timer("punch", 20, function() a:create_timer("cooldown", 10) end)
                _g.fist(a, a.x, a.y)
            end
        end
    end

    local is_moving = x_dir ~= 0 or y_dir ~= 0
    if a:any_timer_active"knockback" then
        a:apply_knockback()
    elseif a:any_timer_active"roll" then
        a.ax = cos(a.dir)*.03
        a.ay = sin(a.dir)*.03
    elseif a:any_timer_active"punch" then
        a.ax = cos(a.dir)*.005
        a.ay = sin(a.dir)*.005
    elseif is_moving then
        if x_dir ~= 0 then
            a.is_facing_left = x_dir < 0
        end

        a.dir = atan2(x_dir == 0 and (a.is_facing_left and -1 or 1) or x_dir, y_dir)

        local dir = atan2(x_dir, y_dir)
        a.ax = cos(dir)*.015
        a.ay = sin(dir)*.015
    else
        a.dir = atan2(a.is_facing_left and -1 or 1, 0)
        a.ax = 0
        a.ay = 0
    end
    a.ax *= speed_multiplier
    a.ay *= speed_multiplier
end
