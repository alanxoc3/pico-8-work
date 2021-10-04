create_parent([[pl_control;0;col,|
    hit:@1;
]], function(a, other)
    if other.portal then
        -- do something
    end
end)

create_actor([[pl_patient_control_fight;2;pl_patient,good_character,pl_control|
    x:@1; y:@2; u:@3; destroyed:@4;
]], function(a)
    control_player(a, xbtn(), ybtn(), btn(4), btn(5), _g.good_fist)
end, function(a)
    a:create_dead_body()
    _g.fader_out(1,nf,g_reset_room)
end)

create_actor([[pl_patient_control_passive;2;pl_patient,good_character,pl_control|
    x:@1; y:@2; u:@3; destroyed:@4;
]], function(a)
    control_player(a, xbtn(), ybtn(), btn(4), btn(5))
end, function(a)
    a:create_dead_body()
    _g.fader_out(1,nf,g_reset_room)
end)

create_actor([[pl_monster_control;2;pl_monster,good_character,pl_control|
    x:@1; y:@2; u:@3; destroyed:@4;
]], function(a)
    -- DEBUG_BEGIN
    if g_debug and btnp(4) then a:set_insanity((a.insane_level + 1) % 5) end
    -- DEBUG_END

    control_player(a, xbtn(), ybtn(), btn(4), btn(5), _g.good_fist, a.insane_level)
end, function(a)
    a:create_dead_body()
    _g.fader_out(1,nf,g_reset_room)
end)
