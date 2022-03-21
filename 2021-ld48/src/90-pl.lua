function shared_pl_col_logic(a, other)
    if other.coin then
        other:obtain()
    end

    if other.balloon then
        other:pop()
    end
end

function get_direction_for_shooting(xf)
    local xdir = 0
    local ydir = 0

    if btn(1) then
        xdir = 1
    elseif btn(0) then
        xdir = -1
    end

    if btn(2) then
        ydir = -1
    elseif btn(3) then
        ydir = 1
    end

    if xdir == 0 and ydir == 0 then
        xdir = bool_to_num(xf)
    end

    return xdir, ydir
end

create_actor([[growing_circle;3;pre_drawable,drawable_obj,rel,confined|
    rel_actor:@1; color:@2; radius:@3;

    tl_max_time=.25,d=@4; -- init state
]], function(a)
    scr_circ(a.x, a.y, a.radius*a.tl_tim*6, a.color or 2)
end)

create_actor([[water_shot;4;post_drawable_2,mov,confined,col|
    x:@1; y:@2; xdir:@3; ydir:@4;
    touchable:no;

    ix:.85;
    iy:.85;
    i:@5;
    d:@6;
    tl_max_time=.5,;
    hit:@7;
]], function(a)
    if g_cur_level != 0 then
        g_stats.shots += 1
    end
    sfx'2'
    local ang = atan2(a.xdir, a.ydir)
    a.dx = cos(ang)*.8
    a.dy = sin(ang)*.8 + .2
end, function(a)
    scr_circfill(a.x, a.y, 1/(1.5+a.tl_tim*16), 12)
end, function(a, other)
    if other.balloon or other.boulder then
        local sign = zsgn(a.dx)
        if sign == 0 then
            sign = zsgn(other.x - a.x)
            if sign == 0 then
                sign = flr_rnd(2) == 0 and -1 or 1
            end
        end

        other.dx += sign*.05
        _g.growing_circle(other, 12, 1)
        a:kill()
    end
end)

create_actor([[pl_dead;3;post_drawable_1,spr,confined|
    x:@1; y:@2; xf:@3;
    sind:7;

    i=@4,u=@5,tl_max_time=3;
]], function(a)
    _g.fader_out(1,nf,resetlevel)
end, function(a)
    a.ixx = rnd_one()
    a.iyy = rnd_one()
end)

create_actor([[pl;3;post_drawable_1,spr,spr_obj,mov,x_bounded,tcol,popper,col,confined,y_bounded|
    x:@1; y:@2; xf:@3;
    ix:.85; iy:.85;
    touching_ground:no;
    jump_speed:.75;
    wall_jump_xspeed:.75;
    wall_jump_yspeed:.5;
    sind:1;
    iyy:-1;
    i:@4; u:@5; tile_hit:@6;
    destroyed:@8;
    d:@9;

    tl_max_time=.125,; -- time to wait before jumping in bucket.
    shooting=no,u=@5,i=nf,hit=@7,;
    shooting=yes,tl_max_time=.25;
    tl_next=2,;
]], function(a)
    a.dy = -a.jump_speed
end, function(a)
    if xbtn() != 0 then
        a.xf = xbtn() == -1
    end

    -- set the sind
    if not a.touching_ground then
        if a.touching_left_wall and btn(0) then
            a.sind = 6 a.iyy = -1 a.xf = false
        elseif a.touching_right_wall and btn(1) then
            a.sind = 6 a.iyy = -1 a.xf = true
        else
            a.sind = 1 a.iyy = -1
        end
    else
        if a.ax == 0 then
            a.sind = 2 a.iyy = -1
        elseif a.ax != 0 then
            if a.tl_tim*60 % 16 < 4 then
                a.sind = 3 a.iyy = -2
            elseif a.tl_tim*60 % 16 < 8 then
                a.sind = 2 a.iyy = -1
            elseif a.tl_tim*60 % 16 < 12 then
                a.sind = 4 a.iyy = -1
            else
                a.sind = 2 a.iyy = -1
            end
        end
    end

    if not a.shooting then
        a.ax = xbtn()*.05
        a.ay = .04

        if not a.touching_ground then
            if a.touching_left_wall and btn(0) then
                a.ay = .0117
            elseif a.touching_right_wall and btn(1) then
                a.ay = .0117
            end
        end

        if btnp(4) then
            if a.touching_ground then
                a.dy = -a.jump_speed
                sfx'25'
            elseif a.touching_left_wall then
                a.dx = a.wall_jump_xspeed
                a.dy = (btn(3) and 1 or -1) * a.wall_jump_yspeed
                sfx'25'
            elseif a.touching_right_wall then
                a.dx = -a.wall_jump_xspeed
                a.dy = (btn(3) and 1 or -1) * a.wall_jump_yspeed
                sfx'25'
            end
        end

        if btnp(5) and g_water_gauge:can_shoot() then
            xdir, ydir = get_direction_for_shooting(a.xf)
            if xdir != 0 and a.touching_left_wall then
                xdir = 1
            elseif xdir != 0 and a.touching_right_wall then
                xdir = -1
            end

            g_water_gauge:empty()
            _g.water_shot(a.x, a.y, xdir, ydir)

            local ang = atan2(-xdir, -ydir)
            a.dx += a.jump_speed * cos(ang)
            a.dy += a.jump_speed * sin(ang)
            a.ax, a.ay = 0, 0
            a:next()
        end
    end

    -- die if below screen
    local bot_of_screen = g_main_view.y + g_main_view.h/2
    if a.y > g_main_view.y + g_main_view.h/2 then
        g_card_shake_x = 4
        if a.y > bot_of_screen + 2 then
            a:kill()
        end
    end

    local top_of_screen = g_main_view.y - g_main_view.h/2 + 1.5
    if a.y < top_of_screen then
        a.dy += .05

        if a.y < top_of_screen - 1.5 then
            g_card_shake_x = 4
        end

        if a.y < top_of_screen - 3 then
            a:kill()
        end
    end

    a.touching_ground = false
    if not a.shooting then
        a.touching_left_wall = false
        a.touching_right_wall = false
    end
end, function(a, dir)
    if dir == 3 then a.touching_ground = true end

    if dir == 0 then
        a.touching_left_wall = true
    end

    if dir == 1 then
        a.touching_right_wall = true
    end
end, function(a, other)
    shared_pl_col_logic(a, other)

    if other.balloon then
        a.dy = -a.jump_speed/2
    end

    if other.bucket_parent then
        a.into_bucket = true
        a:kill()
        sfx'26'
        other.pl_in_bucket = true
        other.xf = a.xf
    elseif other.bad then
        a:kill()
    end
end, function(a)
    if not a.into_bucket then
        sfx'15'
        _g.pl_dead(a.x, a.y, a.xf)
        if g_cur_level != 0 then
            g_stats.deaths += 1
        end
    end
end, function(a)
    a:draw_spr()
end)
