create_actor([[heart_particle_spawner;3;particle_spawner/.125/.125/1/3/%slow_small_ui_particle,above_map_drawable_1|
    x:@1; y:@2; heart_number:@3; u:@4; d:@5; color: 8; 
]], function(a)
    a:update_particles()
    if g_pl.health < a.heart_number then
        a:kill()
    end
end, function(a)
    zspr(16, a.x*8, a.y*8+1)
end)

create_actor([[powerup_particle_spawner;5;particle_spawner/2/.125/1/1/%slow_medium_ui_particle,above_map_drawable_1|
    x:@1; y:@2; powerup_level:@3; color:@4; sind:@5; u:@6; d:@7
]], function(a)
    if g_pl.alive and g_pl.insane_level == a.powerup_level then
        a:update_particles()
    end
end, function(a)
    if g_pl.alive and g_pl.insane_level == a.powerup_level then
        zspr(a.sind, a.x*8, a.y*8, 2, 2, g_pl.is_facing_left, false)
    end
end)

create_actor([[genocide_tip;2;above_map_drawable,confined|
    x:@1; y:@2; d:@3; when_to_show_tip:%c_when_to_show_tip;
]], function(a)
    local killed_count = #_g.all_deadbody_templates
    local total_count = #_g.all_enemy_templates
    local enemies_left = total_count - killed_count

    -- if g_pl.insane_level ~= 1 and g_pl.insane_level ~= 2 and g_pl.insane_level ~= 3 then
        if enemies_left <= a.when_to_show_tip then
            scr_rectfill(.125, a.y-.5, 15.75, a.y+.5, 1)
            local number_str = ""..killed_count.."/"..total_count
            if killed_count == total_count then
                number_str = "all"
            end
            zprint("killed "..number_str.." enemies", a.x*8, a.y*8-2, 8, 0)
        end
    -- end
end)

