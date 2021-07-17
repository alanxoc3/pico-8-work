create_actor([[lane_jumper;0;act,drawable,pos;update,|
    x:4; y:4;
    lane: 1; -- [0, 1, or 2]
    u:@1; d:@2;
]], function(a)
    a.lane = mid(0, a.lane + ybtnp(), 2)
    a.y = TOP_LANE_Y+a.lane*2
end, function(a)
    scr_circ(a.x, a.y, .5, 8)
end)

create_actor([[pl;0;act,drawable,mov;update,|
    x:4; y:4;
    ix:.96; iy:.92;
    i:@1; u:@2; d:@3;
]], function(a)
    a.lane_jumper = _g.lane_jumper()
end, function(a)
    a.ax = xbtn()*.01
    amov_y(a, .02, a.lane_jumper.y)
end, function(a)
    scr_circ(a.x, a.y, .5, 12)
end)
