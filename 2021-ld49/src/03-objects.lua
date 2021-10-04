-- this file has objects that appear in rooms

create_actor([[portal;2;col,pre_drawable,confined|
    x:@1; y:@2; u:@3; d:@4;
    rx:.125;
    ry:.125;
    radius:.2;
    touchable:no;
]], function(a)
    if approx_dist(g_pl.x - a.x, g_pl.y - a.y) < 16 then
        _g.powerup_particle(a.x+rnd(.5)-.25, a.y+rnd(.5)-.25, rnd_item{1,2})
        a.radius=(sin(t())*.2+.5)
    end
end, function(a)
    scr_ovalfill(a.x-a.radius, a.y-.2, a.x+a.radius, a.y+.2, 1)
end)
