create_parent([[pl;1;drawable,pos,confined,mov,x_bounded,y_bounded,col,spr_obj,knockbackable,hurtable,tcol;|
    passive_mode:@1; d:@2;
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
        elseif loop >= .5 then a.sind = 142
        elseif loop >= .3 then a.sind = 134
        else a.sind = 143
        end
    else
        local loop = (a.tl_tim % 1)
        if loop < .25 then a.sind = 141 end
    end
    a.xf = a.is_facing_left

    if a.passive_mode then a.sind += 32 end

    scr_spr(a)
end)

create_actor([[pl_monster;2;pl/yes,|
    x:@1; y:@2;

    health:3; max_health:3;
    sh:2; iyy:-5;
    dir:0; is_facing_left:no;
    insane_level:0;

    u:@3;
    damage:@4; hurt_start:@5; destroyed:@6;
    increment_insanity:@7; decrement_insanity:@8; set_insanity:@9;
]], function(a)
    -- DEBUG_BEGIN
    if g_debug and btnp(4) then a:set_insanity((a.insane_level + 1) % 5) end
    -- DEBUG_END

    control_player(a, xbtn(), ybtn(), btn(4), btn(5), true)
end, function(a, other)
    if a.insane_level < 4 then a:hurt() end
    a:knockback(atan2(a.x-other.x, a.y-other.y))
end, function(a)
    a:set_insanity(4)
end, function(a)
    _g.deadbody(a.x, a.y, a.xf, 64)
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
