create_parent([[particle_parent;0;confined,mov,;|
    draw_small_circle:@1;
    draw_medium_circle:@2;
    move_up:@3;
    move_slow:@4;
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

create_parent([[particle_spawner;5;dim,confined|
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
