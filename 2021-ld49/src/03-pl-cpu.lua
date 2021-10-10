create_actor([[pl_monster_cpu;3;pl_monster,bad_character|
    health:4;
    max_health:4;
    touchable:no; hurt_end:nf;
    x:@1; y:@2; enemy_id:@3; i:@4; u:@5; destroyed:@6;;
]], function(a)
    a:set_strength(3)
end, function(a)
    local x = zsgn(g_pl.x-a.x)
    local y = zsgn(g_pl.y-a.y)

    control_player(a
    , x
    , y
    , flr_rnd(80) == 0 -- 4
    , flr_rnd(20) == 0 -- 5
    , _g.bad_fist
    , a.strength
    )
end, function(a)
    a:create_dead_body()
    _g.portal(118,8)
end)
