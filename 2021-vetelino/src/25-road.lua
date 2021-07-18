ROAD_SPEED = -.125

create_actor([[popsicle;2;drawable,spr,vec,dim,col,confined|
    touchable:no;
    x:@1; variant:@2;
    i:@4;
    sind:70; sh:2;

    u=@3,;
    hit=@6,u=@7,i=@5,tl_max_time=5;
]], function(a)
    if g_pl and g_pl.x+4 > a.x then
        a:next()
    end
end, function(a)
    a.dx = ROAD_SPEED
    if a.variant then
        a.y = 13
        a.iyy = 4
    else
        a.y = 7
        a.iyy = -4
        a.yf = true
    end
end, function(a)
    if a.variant then
        a.dy = -.1
    else
        a.dy = .1
    end
    a.sind = 68
end, function(a, other)
    if other.vehicle then
        other:hurt(6, 0)
        a:kill()
    end
end, function(a)
    a.sind = t()*2 % 1 < .5 and 68 or 69
end)

create_actor([[cannon;2;drawable,spr,vec,dim,confined|
    x:@1; variant:@2;
    i:@3;

    sind:118;
    tl_max_time=12,;
]], function(a)
    a.dx = ROAD_SPEED
    if a.variant then
        a.y = 14
    else
        a.y = 6
        a.yf = true
    end
    _g.popsicle(a.x, a.variant, 1+rnd(1))
end)

create_actor([[smalltree;2;drawable,spr,vec,dim,confined|
    x:@1; variant:@2;
    i:@3;

    sind:46;
    sh:2;
    tl_max_time=12,;
]], function(a)
    a.dx = ROAD_SPEED
    a.y = a.variant and 13 or 5.5
end)

create_actor([[road_gen;0;act,vec,pre_drawable,timed,confined|
    x:0; i:@1; u:@2; d:@3;
]], function(a)
    a.dx = ROAD_SPEED
end, function(a)
    if a.t % 60 == 0 then
        local r_num = flr_rnd(3)
        local variant = flr_rnd(2) == 0
        if a.t > 240 and r_num == 0 then
            _g.cannon(18+a.x%1, variant)
        elseif r_num == 1 then
            _g.smalltree(18+a.x%1, variant)
        end
    end
end, function(a)
    for y=TOP_LANE_Y,BOT_LANE_Y,2 do
        for x=0,8 do
            zspr(96, ((a.x+x*2)%18)*8-8, y*8, 2, 2)
        end
    end

    for x=0,8 do
        zspr(128, ((a.x+x*2)%18)*8-8, 0*8, 2, 1)
        zspr(128, ((a.x+x*2)%18)*8-8, 1*8, 2, 1)
        zspr(128, ((a.x+x*2)%18)*8-8, 2*8, 2, 1)
        zspr(128, ((a.x+x*2)%18)*8-8, 3*8, 2, 1)
        zspr(128, ((a.x+x*2)%18)*8-8, 4*8, 2, 2)
    end
end)

