create_parent([[pl_monster;0;pl/no,|
    damage:@1; hurt_start:@2;
    increment_insanity:@3; decrement_insanity:@4; set_insanity:@5;

    insane_level:0;
]], function(a, other)
    if a.insane_level < 4 then a:hurt() end
    a:knockback(atan2(a.x-other.x, a.y-other.y))
end, function(a)
    a:set_insanity(4)
end, function(a)
    if a.insane_level < 3 then
        a:set_insanity(a.insane_level + 1)
    end
end, function(a)
    if a.insane_level > 3 then
        a:set_insanity(0)
    elseif a.insane_level > 0 then
        a:set_insanity(a.insane_level - 1)
    end
end, function(a, level)
    if level ~= a.insane_level then
        a.insane_level = level
        a:create_timer("insane_timeout", 60*5, function()
            a:decrement_insanity()
        end)
    end
end)

create_actor([[pl_monster_control;2;pl_monster,|
    x:@1; y:@2; u:@3;
]], function(a)
    -- DEBUG_BEGIN
    if g_debug and btnp(4) then a:set_insanity((a.insane_level + 1) % 5) end
    -- DEBUG_END

    control_player(a, xbtn(), ybtn(), btn(4), btn(5), true, a.insane_level)
end)

create_actor([[pl_monster_cpu;2;pl_monster,|
    x:@1; y:@2; u:@3;
    insane_level:4;
]], function(a)
    control_player(a, flr_rnd(3)-1, flr_rnd(3)-1, flr_rnd(3) == 0, flr_rnd(3) == 0, true, a.insane_level)
end)
