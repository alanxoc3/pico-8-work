-- this file has the base parent for both patient and monster players.
create_actor([[fist;3;col,confined,rel|
    rel_actor:@1; x:@2; y:@3; i:@4; d:@5;
    touchable:no; rx:.25; ry:.75;

    tl_max_time=.33,;
]], function(a)
    a.rel_dx = cos(a.rel_actor.dir)*.03
    a.rel_dy = sin(a.rel_actor.dir)*.03
end)

create_parent([[pl;1;drawable,pos,confined,mov,x_bounded,y_bounded,col,spr_obj,knockbackable,hurtable,tcol;|
    passive_mode:@1; destroyed:@2; d:@3;

    strength:1; -- amount of damage you do to enemies
    dir:0; is_facing_left:no;
    health:%c_pl_health; max_health:%c_pl_health;

    -- some methods that could be implemented on sub-actors:
    damage:nf; increment_insanity:nf; decrement_insanity:nf; set_insanity:nf;

    sh:2; iyy:-5;
]], function(a)
    _g.deadbody(a.x, a.y, a.xf, a.passive_mode and 80 or 64)
    _g.fader_out(1,nf,g_reset_room)
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
