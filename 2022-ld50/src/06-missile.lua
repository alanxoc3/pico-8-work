zclass[[missile,model,drawable|
    x,@,y,@,dx,@,dy,@,ang,@,     -- initial position & direction
    model,%MISSILE,
    speed,0.05,
    damage,1,
    inertia_x,1,inertia_y,1,
    destroyed,%missile_destroyed,
    init,%missile_init,
    hit,%missile_hit;
    start;duration,2;  -- disappear after 2 sec
]]

zclass[[missile_pop,model,drawable|
    x,@,y,@,
    model,%MISSILE_POP,
    init,%missile_pop_init
]]

|missile_init| function(a)
    sfx(23,3)
end $$

|missile_destroyed| function(a)
    _g.missile_pop(a.x, a.y)
end $$

|missile_hit| function(a, b, dx, dy)
    a.dx = -dx
    a.dy = -dy
    a:kill()
end $$

|missile_pop_init| function(a)
    a:explode(10)
end $$
