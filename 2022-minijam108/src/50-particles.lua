|[draw_circle]| function(a)
    circfill(scr_x(a.x), scr_y(a.y), a.r, a.color)
end $$

|[move_up]| function(a)
    a.dx =  rnd(.2)-.1
    a.dy = -rnd(.2)-.1
end $$

|[move_slow]| function(a)
    a.dx = rnd(.5)-.25
    a.dy = rnd(.5)-.25
end $$

zclass[[powerup_particle,vec,drawlayer_25|
    x,@, y,@, color,@, r,@,
    draw,%draw_circle,
    init,%move_up;

    start; duration,.25;
]]

zclass[[particle_spawner|
    rx,.25, ry,.25, rate,1, chance,3, create_func,%powerup_particle,
    update_particles,%update_particles, color,7;
]]

|[update_particles]| function(a)
    for i=1,a.rate do
        if flr_rnd(a.chance) == 0 then
            a.create_func(
                a.x + rnd(a.rx*2)-a.rx,
                a.y + rnd(a.ry*2)-a.ry,
                a.color,
                1+rnd(2)
            )
        end
    end
end $$
