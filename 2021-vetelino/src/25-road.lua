create_actor([[road_gen;0;act,vec,drawable;update,|
    x:0; u:@1; d:@2;
]], function(a)
    a.dx = -.14
end, function(a)
    for y=TOP_LANE_Y,BOT_LANE_Y,2 do
        for x=0,8 do
            zspr(96, ((a.x+x*2)%18)*8-8, y*8, 2, 2)
        end
    end
end)
