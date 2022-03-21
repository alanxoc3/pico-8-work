create_actor([[rope;2;post_drawable,rel,x_bounded,confined|
    rel_actor:@1;
    control:@2;
    sind:1;
    rel_y:-.625;
    d:@3;
]], function(a)
    local x1, y1, x2, y2 = a.x+a.dx, a.y+a.dy, a.control.pivot_x, a.control.y - a.control.pivot_y
    scr_line(x1, y1, x2, y2, 2)
    scr_line(x1-.125, y1, x2-.125, y2, 2)
end)

create_parent([[bucket_parent;0;post_drawable,spr,spr_obj,dim,x_bounded,rel,tcol,col,popper,confined|
    sw:2;sh:2;
    tile_solid:no;
    touchable:no;
    ang:.75;
    xf:no;
    sind:32;

    eject_player_out_of_bucket:@2;
    tile_hit:$eject_player_out_of_bucket;
    bucket_update:@1;
    hit:@3;
]], function(a)
    if btnp(4) then
        a:eject_player_out_of_bucket()
    end

    local gravity = .1
    if btn(3) or btn(2) then
        gravity = .2
    end

    if a.pl_in_bucket and xbtn() != 0 then
        a.xf = xbtn() == -1
    end

    local pivot = a.rel_actor.pivot_y
    a.ang = atan2(cos(a.ang), sin(a.ang)+gravity)
    a.rel_x = round(pivot*cos(a.ang)*8)/8
    a.rel_y = round(pivot*sin(a.ang)*8 - pivot*8)/8

   if a.pl_in_bucket then
       a.sind = 32
   else
       a.sind = 34
   end
end, function(a)
    if a.pl_in_bucket then
        sfx'25'
        a.pl_in_bucket = false
        a.pl = _g.pl(a.x, a.y, a.xf)
        _g.growing_circle(a.pl, 2, 1)
    end
end, function(a, other)
    if a.pl_in_bucket then
        shared_pl_col_logic(a, other)
    end

    if other.knock then
        a:eject_player_out_of_bucket()
    end
end)

create_actor([[bucket;3;bucket_parent,|
    x:@1;y:@2;
    rel_actor:@3;
    pl_in_bucket:yes;
    ang_speed:.001;
    entry_time:0;

    tl_max_time=.625,;
    u=@4,;
]], function(a)
    if a.pl_in_bucket and xbtn() != 0 then
        a.ang += xbtn()*a.ang_speed
    end

    if btn(5) and a.pl_in_bucket and g_water_gauge:can_shoot() then
        g_water_gauge:empty()

        local xdir, ydir = get_direction_for_shooting(a.xf)
        --a.ang += -xdir*.002
        _g.water_shot(a.x, a.y, xdir, ydir)
    end

    if a.pl_in_bucket then
        g_water_gauge:fill()
    end

    a:bucket_update()
end)

create_actor([[bucket_control;2;drawable_obj,vec,confined|
    x:@1;y:@2;
    sw:2;sh:2;

    pivot_x:@1;
    pivot_y:30;
    sind:34;
    i:@3;
    u:@4;
    destroyed:@5;
]], function(a)
    a.bucket = _g.bucket(a.x, a.y, a)
    a.rope = _g.rope(a.bucket, a)
end, function(a)
    a.dy = .1

    local bounds_bottom = g_cur_room.y + g_cur_room.h - 1.75
    if a.y + a.dy >= bounds_bottom then
        a.y = bounds_bottom - a.dy
        if not a.next_lvl_checker then
            a.next_lvl_checker = _g.next_lvl_control(a)
        end
    end
end, function(a)
    a.rope:kill()
    a.bucket:kill()
    a.next_lvl_checker:kill()
end)

