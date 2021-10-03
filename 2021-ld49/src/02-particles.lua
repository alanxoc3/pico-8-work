create_parent([[particle_parent;0;mov,;|
    draw_small_circle:@1;
    draw_medium_circle:@2;
    move_up:@3;
    move_slow:@4;
    inertia_x:.90;
    inertia_y:.90;
]], function(a)
    scr_circfill(a.x, a.y, .125, a.color)
end, function(a)
    scr_circfill(a.x, a.y, .375, a.color)
end, function(a)
    a.dx = rnd(.2)-.1
    a.dy = -rnd(.2)-.1
end, function(a)
    a.dx = rnd(.05)-.025
    a.dy = rnd(.05)-.025
end)

-- particles
create_actor[[powerup_particle;3;pre_drawable_2,particle_parent|
    x:@1; y:@2; color:@3; d:$draw_small_circle;
    i:$move_up;
    tl_max_time=.25,;
]]

create_actor[[slow_small_ui_particle;3;above_map_drawable,particle_parent|
    x:@1; y:@2; color:@3; d:$draw_small_circle;
    i:$move_slow;
    tl_max_time=.25,;
]]

create_actor[[slow_medium_ui_particle;3;above_map_drawable,particle_parent|
    x:@1; y:@2; color:@3; d:$draw_medium_circle;
    i:$move_slow;
    tl_max_time=.25,;
]]


create_parent([[particle_spawner;5;dim,|
    color: 8;
    rx:@1; ry:@2; rate:@3; chance:@4; create_func:@5; update_particles:@6;
]], function(a)
    for i=1,a.rate do
        if flr_rnd(a.chance) == 0 then
            a.create_func(
                a.x + rnd(a.rx*2)-a.rx,
                a.y + rnd(a.ry*2)-a.ry,
                a.color
            )
        end
    end
end)

create_actor([[heart_particle_spawner;3;particle_spawner/.125/.125/1/3/%slow_small_ui_particle,above_map_drawable_1|
    x:@1; y:@2; heart_number:@3; u:@4; d:@5; color: 8; 
]], function(a)
    a:update_particles()
    if g_pl.health < a.heart_number then
        a:kill()
    end
end, function(a)
    zspr(4, a.x*8, a.y*8+1)
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
