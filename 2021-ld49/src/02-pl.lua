-- this file has the base parent for both patient and monster players.
create_parent([[fist_parent;0;col,confined,rel|
    i:@1; hit:@2; touchable:no; rx:.25; ry:.75;
    tl_max_time=.33,;
]], function(a)
    a.rel_dx = cos(a.rel_actor.dir)*.03
    a.rel_dy = sin(a.rel_actor.dir)*.03
end, function(a, other)
    if other.hurtable and other ~= a.rel_actor then
        other:damage(a)
    end
end)

create_actor[[good_fist;3;fist_parent,|
    rel_actor:@1; x:@2; y:@3;
]]

create_actor[[bad_fist;3;fist_parent,enemy|
    rel_actor:@1; x:@2; y:@3;
]]

create_parent([[pl;1;drawable,pos,confined,mov,x_bounded,y_bounded,col,spr_obj,knockbackable,hurtable,tcol;|
    passive_mode:@1; create_dead_body:@2; destroyed:@2; d:@3;

    strength:1; -- amount of damage you do to enemies
    dir:0; is_facing_left:no;
    health:%c_pl_health; max_health:%c_pl_health;

    -- some methods that could be implemented on sub-actors:
    damage:nf; increment_insanity:nf; decrement_insanity:nf; set_insanity:nf;

    sh:2; iyy:-5;
]], function(a)
    _g.deadbody(a.x, a.y, a.xf, a.passive_mode and 80 or 64)
end, function(a)
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
        elseif loop >= .5 then a.sind = 142
        elseif loop >= .3 then a.sind = 134
        else a.sind = 143
        end
    else
        local loop = a.tl_tim and (a.tl_tim % 1) or 0
        if loop < .25 then a.sind = 141 end
    end
    a.xf = a.is_facing_left

    if a.passive_mode then a.sind += 32 end

    scr_spr(a)
end)

create_parent([[pl_monster;0;pl/no,|
    damage:@1; hurt_start:@2;
    increment_insanity:@3; decrement_insanity:@4; set_insanity:@5;

    insane_level:0;
]], function(a, other)
    if a.insane_level < 4 then a:hurt() end
    a:knockback(atan2(a.x-other.x, a.y-other.y))
end, function(a)
    a:set_insanity(4)
end, function(a)
    if a.insane_level < 3 then
        a:set_insanity(a.insane_level + 1)
    end
end, function(a)
    if a.insane_level > 3 then
        a:set_insanity(0)
    elseif a.insane_level > 0 then
        a:set_insanity(a.insane_level - 1)
    end
end, function(a, level)
    if level ~= a.insane_level then
        a.insane_level = level
        a:create_timer("insane_timeout", 60*5, function()
            a:decrement_insanity()
        end)
    end
end)

create_parent([[pl_patient;0;pl/yes,|
    damage:@1;
]], function(a, other)
    a:hurt(other.strength or 1)
    a:knockback(atan2(a.x-other.x, a.y-other.y))
end)

-- use this for the player with button logic, or for the boss with ai logic.
function control_player(a, x_dir, y_dir, is_z_pressed, is_x_pressed, punch_func, insane_level)
    if not a.pl then return end

    -- no speed or power multiplier for the non insane
    local speed_multiplier = 1

    -- if insane level is not nil, insanity is enabled.
    if insane_level then
        speed_multiplier = 1 + a.insane_level/10

        -- anger emotion particle is used instead of blood
        if     insane_level == 4 then _g.powerup_particle(a.x, a.y+.5, _g.c_color_angry)
        elseif insane_level == 3 then _g.powerup_particle(a.x, a.y+.5, _g.c_color_insane_3)
        elseif insane_level == 2 then _g.powerup_particle(a.x, a.y+.5, _g.c_color_insane_2)
        elseif insane_level == 1 then _g.powerup_particle(a.x, a.y+.5, _g.c_color_insane_1)
        -- no color for normal
        -- elseif insane_level == 0 then _g.powerup_particle(a.x, a.y+.5, _g.c_color_normal)
        end

    -- if not insane, getting hurt can spawn particles
    elseif a:any_timer_active("hurt_cooldown") then
        _g.powerup_particle(a.x, a.y+.5, _g.c_color_blood)
    end

    -- amount of damage you do to enemies
    if insane_level == 4 then a.stregth = 2
    else a.stregth = 1 end

    if not a:any_timer_active("cooldown", "roll", "punch") then
        if is_z_pressed then
            a:create_timer("roll",  20, function() a.dx /= 3 a.dy /= 3 a:create_timer("cooldown", 20) end)
        elseif is_x_pressed then
            -- if punch is not enabled, assume that talking is enabled.
            if punch_func then
                a:create_timer("punch", 20, function() a:create_timer("cooldown", 10) end)
                punch_func(a, a.x, a.y)
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
