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

create_actor([[pl;3;vehicle,timed|
    x:@1; y:@2;
    vehicle_logic:@4; anim_update:@5; destroyed:@6;

    x:4; y:4;
    sind:@3; sh:2; iyy:-4;
]], function(a)
    a:move_x(xbtn())
    a:move_y(ybtnp())
    a:anim_update()
    if a.t > 30 and (btn(4) or btn(5)) then
        a.t = 0
        _g.throwing_star(a.x, a.y)
    end
end, function(a)
    local toggle = a.tl_tim % .5 < .25

    if a.dx > .01 and a.ax > 0 then
        a.sind = toggle and 36 or 37
    elseif a.dx < -.01 and a.ax < 0 then
        a.sind = toggle and 32 or 33
    else
        a.sind = toggle and 34 or 35
    end

    if g_codename == "popguin" then
        a.sind -= 32
    end
end, function(a)
    _g.dead_pl(a.x, a.y, g_codename == "popguin" and 24 or 56)
    _g.dead_unicycle(a.x, a.y, g_codename == "popguin" and 8 or 40)
    _g.fader_out(.5,nf,reset_level)
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
    g_pl = _g.pl(a.x, a.y, g_codename == "popguin" and 2 or 34)
end)

create_actor([[mission_text;3;post_drawable,vec,timed, confined|
    text:@1; y:@2; callback:@3;
    u:@4; d:@5;

    ,;
    u=nf, tl_max_time=.5;
    i=@6,u=nf;
]], function(a)
    a.cur_text = sub(a.text, 1, min(#a.text, a.tl_tim*10))
    if #a.cur_text >= #a.text then
        a:next()
    end
end, function(a)
    rectfill(0, 0, 127, a.y + 17, 0)
    rect(0, 0, 127, a.y + 17, 2)
    zprint(a.cur_text, 4, a.y, -1, 8, 2)
end, function(a)
    a.callback()
end)

create_actor([[dead_pl;3;drawable,spr,mov,x_bounded,timed,confined|
    x:@1; y:@2; sind:@3;
    ix:.95;
    dx:-.25;
    u:@4;
]], function(a)
    if a.t > 5 then
        a.sind = 55
        if a.t > 10 then
            a.sind = 54
        end
        if g_codename == "popguin" then
            a.sind -= 32
        end
    end
end)

create_actor([[dead_unicycle;3;drawable,spr,mov,x_bounded,timed,confined|
    x:@1; y:@2; sind:@3;
    ix:.95;
    dx:.125;
    u:@4;
]], function(a)
    if a.t > 5 then
        a.sind = 39
        if a.t > 10 then
            a.sind = 38
        end
        if g_codename == "popguin" then
            a.sind -= 32
        end
    end
end)

create_actor([[throwing_star;2;drawable,vec,spr,col,confined|
    x:@1; y:@2;
    touchable:no;
    sind:28;
    u:@3; hit:@4;
    iyy:-4;
    dx:.25;
    tl_max_time=10,;
]], function(a)
    local val = t() % 1
    if val < .25 then
        a.sind = 28
    elseif val < .5 then
        a.sind = 29
    elseif val < .75 then
        a.sind = 30
    else
        a.sind = 31
    end
end, function(a, o)
    if o.truck then
        o:hurt(5, 0)
        a:kill()
    end
end)
