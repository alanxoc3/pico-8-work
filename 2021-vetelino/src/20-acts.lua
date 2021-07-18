create_actor([[lane_jumper;0;pos,confined|
    x:4; y:4;
    lane: 1; -- [0, 1, or 2]
    i:@1; switch_lane:@2;
]], function(a)
    a:switch_lane(0)
end, function(a, lane_dir) -- lane_dir: -1, 0, 1
    a.lane = mid(0, a.lane + lane_dir, 2)
    a.y = TOP_LANE_Y+a.lane*2
end, function(a)
    scr_circ(a.x, a.y, .5, 8)
end)

create_actor([[vehicle;0;drawable,spr,mov,x_bounded,col,anim,hurtable,confined|
    x:4; y:4;
    ix:.96; iy:.92;
    vehicle_logic:nf;
    i:@1; u:@2; move_x:@3; move_y:@4;
]], function(a)
    a.lane_jumper = _g.lane_jumper()
end, function(a)
    a:vehicle_logic()
    amov_y(a, .02, a.lane_jumper.y)
end, function(a, x) -- x: -1, 0, 1
    a.ax = x * .005
end, function(a, y) -- y: -1, 0, 1
    a.lane_jumper:switch_lane(y)
end)

create_actor([[pl;2;vehicle,|
    x:@1; y:@2;
    vehicle_logic:@3; anim_update:@4; destroyed:@5;

    x:4; y:4;
    sind:34; sh:2; iyy:-4;
]], function(a)
    a:move_x(xbtn())
    a:move_y(ybtnp())
    a:anim_update()
end, function(a)
    local toggle = a.tl_tim % .5 < .25

    if a.dx > .05 and a.ax > 0 then
        a.sind = toggle and 36 or 37
    elseif a.dx < -.05 and a.ax < 0 then
        a.sind = toggle and 32 or 33
    else
        a.sind = toggle and 34 or 35
    end
end, function(a)
    _g.fader_out(1,nf,reset_level)
end)

create_actor([[truck;2;vehicle,|
    x:@1; y:@2;
    rx:1;
    vehicle_logic:@3;
    health:119;
    max_health:119;

    sind:26; sw:2; sh:3; iyy:-8;
    horizontal_input:0;
]], function(a)
    if flr_rnd(15) == 0 then
        a.horizontal_input = flr_rnd(3)-1
    end
    a:move_x(a.horizontal_input)

    if flr_rnd(30) == 0 then
        a:move_y(flr_rnd(3)-1)
    end
end)

create_actor([[intro_truck;0;truck,|
    x:-5; y:10;
    check_bounds:nf;
    vehicle_logic:@1;
    destroyed:@2;
]], function(a)
    a:move_x(a.x < 10 and 1 or 0)
end, function(a)
    g_truck = _g.truck(a.x, a.y)
end)

create_actor([[intro_pl;0;pl,|
    x:-18; y:10;
    check_bounds:nf;
    vehicle_logic:@1;
    destroyed:@2;
]], function(a)
    a:move_x(a.x < 1 and 1 or 0)
    a:anim_update()
end, function(a)
    g_pl = _g.pl(a.x, a.y)
end)

create_actor([[mission_text;3;post_drawable,vec,timed, confined|
    text:@1; y:@2; callback:@3;
    u:@4; d:@5;
    destroyed:@6;

    ,;
    u=nf, tl_max_time=.5;
    dy=-1, u=nf, tl_max_time=.5;
]], function(a)
    a.cur_text = sub(a.text, 1, min(#a.text, a.tl_tim*10))
    if #a.cur_text >= #a.text then
        a:next()
    end
end, function(a)
    zprint(a.cur_text, 4, a.y, -1, 11, 1)
end, function(a)
    a.callback()
end)
