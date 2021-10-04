-- this file has objects that appear in rooms

create_actor([[portal;2;col,pre_drawable,confined|
    x:@1; y:@2; u:@3; d:@4;
    touchable:no;
]], function(a)
    if approx_dist(g_pl.x - a.x, g_pl.y - a.y) < 12 then
        _g.powerup_particle(a.x+rnd(2)-1, a.y+rnd(2)-1, rnd_item{2,1})
    end
end, function(a)
    scr_circfill(a.x, a.y, .5, 1)
end)
