create_actor([[lane_jumper;0;pos,|
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

create_actor([[pl;0;drawable,spr,mov,x_bounded|
    x:4; y:4;
    ix:.96; iy:.92;
    sind:39; sh:2; iyy:-4;
    i:@1; u:@2; --d:@3;
]], function(a)
    a.lane_jumper = _g.lane_jumper()
end, function(a)
    a.ax = xbtn() * .005
    if a.dx > .05 and a.ax > 0 then
        a.sind = 38
    elseif a.dx < -.05 and a.ax < 0 then
        a.sind = 37
    else
        a.sind = 39
    end
    a.lane_jumper:switch_lane(ybtnp())
    amov_y(a, .02, a.lane_jumper.y)
end, function(a)
    scr_circ(a.x, a.y, .5, 12)
end)

create_actor([[truck;0;drawable,spr,mov|
    x:14.5; y:4;
    sind:26; sw:2; sh:3; iyy:-8;
    ix:.96; iy:.92;
    i:@1; u:@2;-- d:@3;
]], function(a)
    a.lane_jumper = _g.lane_jumper()
end, function(a)
    a.ax = 0
    amov_y(a, .02, a.lane_jumper.y)

    if flr_rnd(30) == 0 then
        a.lane_jumper:switch_lane(flr_rnd(3)-1)
    end
end, function(a)
    scr_circ(a.x, a.y, .5, 12)
end)
