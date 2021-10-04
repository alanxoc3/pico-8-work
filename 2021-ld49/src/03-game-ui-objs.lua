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
    if g_endgame_stats.enemy_total_count - g_endgame_stats.enemy_kill_count <= a.when_to_show_tip then
        scr_rectfill(.125, a.y-.5, 15.75, a.y+.5, 1)
        local number_str = ""..g_endgame_stats.enemy_kill_count.."/"..g_endgame_stats.enemy_total_count
        if g_endgame_stats.enemy_kill_count == g_endgame_stats.enemy_total_count then
            number_str = "all"
        end
        zprint("killed "..number_str.." enemies", a.x*8, a.y*8-2, 8, 0)
    end
end)

create_actor([[objective_arrow;2;post_drawable_2,confined|
    x:@1; y:@2; u:@3; d:@4;
    ry:.25;
    radius:.2;
    touchable:no;
    smallest_dist:0;
]], function(a)
    local smallest_dist
    local objective

    for g_ind in all{'bad_character', 'portal'} do
        for b in all(g_act_arrs[g_ind]) do
            local dist = approx_dist(g_pl.x-b.x, g_pl.y-b.y)
            if not smallest_dist or dist < smallest_dist then
                smallest_dist = dist
                objective = b
            end
        end
    end

    a.smallest_dist = smallest_dist
    a.objective = objective
end, function(a)
    if a.objective and a.smallest_dist > 3.5 then
        local dir = atan2(a.objective.x - g_pl.x, a.objective.y - g_pl.y)
        dir = round(dir*16)/16
        local dx = cos(dir)
        local dy = sin(dir)
        local offy = -.5
        local color = 1

        local len_multiplier = 1.75
        if t() % .5 < .25 then
            len_multiplier *= 1.125
        end

        local x1=g_pl.x+dx
        local y1=offy+g_pl.y+dy
        local x2=g_pl.x+dx*len_multiplier
        local y2=offy+g_pl.y+dy*len_multiplier

        scr_line(x1, y1, x2, y2, color)

        local turn=.375
        local length=.375
        local x3=x2+cos(dir+turn)*length
        local y3=y2+sin(dir+turn)*length
        local x4=x2+cos(dir-turn)*length
        local y4=y2+sin(dir-turn)*length
        scr_line(x2, y2, x3, y3, color)
        scr_line(x2, y2, x4, y4, color)
    end
end)
