create_actor([[pl_monster_cpu;2;pl_monster,|
    touchable:no;
    x:@1; y:@2; u:@3;
    insane_level:4;
]], function(a)
    control_player(a, flr_rnd(3)-1, flr_rnd(3)-1, flr_rnd(3) == 0, flr_rnd(3) == 0, _g.bad_fist, a.insane_level)
end)
