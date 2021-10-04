create_parent([[pl_patient;0;pl/yes,|
    damage:@1;
]], function(a, other)
    a:hurt(other.strength or 1)
    a:knockback(atan2(a.x-other.x, a.y-other.y))
end)

create_actor([[pl_patient_control_fight;2;pl_patient,|
    x:@1; y:@2; u:@3;
]], function(a)
    control_player(a, xbtn(), ybtn(), btn(4), btn(5), true)
end)

create_actor([[pl_patient_control_passive;2;pl_patient,|
    x:@1; y:@2; u:@3;
]], function(a)
    control_player(a, xbtn(), ybtn(), btn(4), btn(5), false)
end)
