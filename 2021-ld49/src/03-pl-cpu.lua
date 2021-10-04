create_actor([[pl_monster_cpu;3;pl_monster,bad_character|
    touchable:no;
    x:@1; y:@2; enemy_id:@3; i:@4; u:@5; destroyed:@6;;
]], function(a)
    a:set_insanity(4)
end, function(a)
    if a.insane_level == 4 then
        control_player(a, flr_rnd(3)-1, flr_rnd(3)-1, flr_rnd(10) == 0, flr_rnd(4) == 0, _g.bad_fist, a.insane_level)
    else
        control_player(a, flr_rnd(3)-1, flr_rnd(3)-1, flr_rnd(5) == 0, flr_rnd(6) == 0, _g.bad_fist, a.insane_level)
    end
end, function(a)
    a:create_dead_body()
    _g.portal(118,27)
end)
