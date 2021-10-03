create_actor([[deadbody;4;pre_drawable,|
    x:@1; y:@2; xf:@3; sind:@4; i:@5; u:@6; d:@7;
    touchable:no; rx:.25; ry:.5;
]], function(a)
    a:create_timer('bleeding', 30)
end, function(a)
    if a:any_timer_active'bleeding' then
        _g.powerup_particle(a.x, a.y, COLOR_BLOOD)
        a.xx = flr_rnd(3)-2
        a.yy = flr_rnd(3)-2
    end
end, function(a)
    zspr(a.sind, a.x*8+a.xx, a.y*8+a.yy, 2, 1, a.xf, false)
end)

