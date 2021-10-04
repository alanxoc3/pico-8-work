create_parent([[pl_control;0;col,|
    hit:@1; teleporting:no;
]], function(a, other)
    if other.portal and not a.teleporting then
        a.teleporting = true
        _g.fader_out(1,nf,function()
            if g_room.name == "dungeon" then
                g_reset_room = reset_the_bossroom
                g_reset_room()
            elseif g_room.name == "bossroom" then
                g_reset_room = reset_the_hospital
                g_reset_room()
            elseif g_room.name == "hospital" then
                g_tl:next() -- go to the credits!
            end
        end)
    end
end)

create_actor([[pl_patient_control_fight;2;pl_patient,good_character,pl_control|
    x:@1; y:@2; u:@3; destroyed:@4;
]], function(a)
    control_player(a, xbtn(), ybtn(), btn(4), btn(5), _g.good_fist)
end, function(a)
    a:create_dead_body()
    g_endgame_stats.deaths = g_endgame_stats.deaths + 1
    _g.fader_out(1,nf,g_reset_room)
end)

create_actor([[pl_patient_control_passive;2;pl_patient,good_character,pl_control|
    x:@1; y:@2; u:@3; destroyed:@4;
]], function(a)
    control_player(a, xbtn(), ybtn(), btn(4), btn(5))
end, function(a)
    a:create_dead_body()
    g_endgame_stats.deaths = g_endgame_stats.deaths + 1
    _g.fader_out(1,nf,g_reset_room)
end)

create_actor([[pl_monster_control;2;pl_monster,good_character,pl_control|
    x:@1; y:@2; u:@3; destroyed:@4;
]], function(a)
    -- DEBUG_BEGIN
    if g_debug and btnp(4) then a:set_strength((a.strength + 1) % 5) end
    -- DEBUG_END

    control_player(a, xbtn(), ybtn(), btn(4), btn(5), _g.good_fist, a.strength)
end, function(a)
    a:create_dead_body()
    g_endgame_stats.deaths = g_endgame_stats.deaths + 1
    _g.fader_out(1,nf,g_reset_room)
end)
