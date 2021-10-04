create_actor([[deadbody_parent;0;confined,pre_drawable|
    d:@1; i:@2; touchable:no; rx:.25; ry:.5; sind:0;
]], function(a)
    local sind = a.sind
    if g_room.name == "hospital" then sind += 16 end
    zspr(sind, a.x*8+a.xx, a.y*8+a.yy, 2, 1, a.xf, false)
end)

create_actor[[deadbody_nobleed;4;deadbody_parent,|
    x:@1; y:@2; xf:@3; sind:@4;
    touchable:no; rx:.25; ry:.5;
]]

create_actor([[deadbody;4;deadbody_parent,|
    x:@1; y:@2; xf:@3; sind:@4; i:@5; u:@6;
    touchable:no; rx:.25; ry:.5;
]], function(a)
    a:create_timer('bleeding', 30)
end, function(a)
    if a:any_timer_active'bleeding' then
        _g.powerup_particle(a.x, a.y, _g.c_color_blood)
        a.xx = flr_rnd(3)-2
        a.yy = flr_rnd(3)-2
    end
end)

-- enemy_id, x, y, xf, sind
-- sind's hospital form is always 16 sprite indexes away (right below)
function create_cached_deadbody(enemy_id, ...)
    add(_g.all_deadbody_templates[g_room.name], {...})
    _g.all_enemy_templates[g_room.name][enemy_id].alive = false
    _g.deadbody(...)
end
