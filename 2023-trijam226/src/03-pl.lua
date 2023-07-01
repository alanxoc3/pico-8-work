-- this file has the base parent for both patient and monster players.
create_parent([[fist_parent;0;col,confined,rel|
    i:@1; touchable:no; rx:.375; ry:.75;
    tl_max_time=.33,;
]], function(a)
    a.rel_dx = cos(a.rel_actor.dir)*.03
    a.rel_dy = sin(a.rel_actor.dir)*.03
end)

create_actor[[good_fist;3;fist_parent,good_attack|
    rel_actor:@1; x:@2; y:@3;
]]

create_actor[[bad_fist;3;fist_parent,bad_attack|
    rel_actor:@1; x:@2; y:@3;
]]

create_parent([[pl;1;drawable,pos,confined,mov,x_bounded,y_bounded,col,spr_obj,knockbackable,hurtable,tcol;|
    hurt_cooldown_time:90;
    passive_mode:@1; create_dead_body:@2; destroyed:@2; d:@3;

    strength:4; -- amount of damage you do to enemies
    dir:0; is_facing_left:yes; xf:yes;
    health:C_PL_HEALTH; max_health:C_PL_HEALTH;

    -- some methods that could be implemented on sub-actors:
    damage:nf; increment_strength:nf; decrement_strength:nf; set_strength:nf;

    sh:2; iyy:-5;
]], function(a)
    local sind = a.passive_mode and 80 or 64
    _g.deadbody(a.x, a.y, a.xf, sind)
end, function(a)
    a.sind = 134
    a.yy = 0
    if a:any_timer_active'punch' then
        local percent = a:get_timer_percent'punch'
        if percent >= .90 then a.sind = 133
        elseif percent >= .80 then a.sind = 132
        elseif percent >= .50 then a.sind = 131
        elseif percent >= .30 then a.sind = 130
        elseif percent >= .10 then a.sind = 129
        else a.sind = 128
        end
        a.yy = sin(percent/2)*5
    elseif a:any_timer_active'roll' then
        local percent = a:get_timer_percent'roll'
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
    damage:@1; hurt_start:@2; hurt_end:@3;
    increment_strength:@4; decrement_strength:@5; set_strength:@6;

    strength:4;
]], function(a, other)
    if not a:any_timer_active'roll' then
        a:hurt()
        a:knockback(atan2(a.x-other.x, a.y-other.y))
    end
end, function(a)
    a:set_strength(4)
end, function(a)
    a:set_strength(0)
end, function(a)
end, function(a)
end, function(a, level)
end)

create_parent([[pl_patient;0;pl/yes,|
    damage:@1;
]], function(a, other)
    if not a:any_timer_active'roll' then
        if not a:any_timer_active'hurt_cooldown' then
            if other.rel_actor then
                other.rel_actor:increment_strength()
            end
        end
        a:hurt()
        a:knockback(atan2(a.x-other.x, a.y-other.y))
    end
end)

-- use this for the player with button logic, or for the boss with ai logic.
function control_player(a, x_dir, y_dir, is_z_pressed, is_x_pressed, punch_func)
    if not a.pl then return end

    if a.teleporting then
        a.iyy -= .25
        a.ax=0 a.ay=0
        return
    end

    -- no speed or power multiplier for the non insane
    local speed_multiplier = 1

    -- if not insane, getting hurt can spawn particles
    if a:any_timer_active('hurt_cooldown') then
        _g.powerup_particle(a.x, a.y+.5, C_COLOR_BLOOD)
    end

    -- amount of damage you do to enemies

    if not a:any_timer_active('cooldown', 'roll', 'punch') then
        if is_z_pressed then
            a:create_timer('roll',  20, function() a.dx /= 3 a.dy /= 3 a:create_timer('cooldown', 20) end)
        elseif is_x_pressed then
            -- if punch is not enabled, assume that talking is enabled.
            if punch_func then
                a:create_timer('punch', 20, function() a:create_timer('cooldown', 10) end)
                if g_objective_arrow and g_objective_arrow.objective then
                    _g.police_weapon(a.x, a.y, a.xf and -.2 or .2, 0)
                end
                -- punch_func(a, a.x, a.y)
            end
        end
    end

    local is_moving = x_dir ~= 0 or y_dir ~= 0
    if a:any_timer_active'knockback' then
        a:apply_knockback()
    elseif a:any_timer_active'roll' then
        a.ax = cos(a.dir)*.03
        a.ay = sin(a.dir)*.03
    elseif a:any_timer_active'punch' then
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
