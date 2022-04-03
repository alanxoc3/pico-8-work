zclass[[missile,model,drawable|
    x,@,y,@,ang,@,     -- initial position & direction
    model_obj,%MISSILE,
    speed,0.05,
    hit,%missile_hit;
    start;duration,2;  -- disappear after 2 sec
]]

zclass[[missile_pop,model,drawable|
    x,@,y,@,
    model_obj,%MISSILE_POP,
    init,%missile_pop_init
]]

|missile_hit| function(a, b, dx, dy)
    a:kill()
    _g.missile_pop(a.x, a.y)
end $$

|missile_pop_init| function(a)
    a:model_init()
    a:explode(.2)
end $$
