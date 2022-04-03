zclass[[missile,model,drawable|
    x,@,y,@,ang,@,     -- initial position & direction
    speed,0.05,
    init,%missile_init;
    start;duration,2;  -- disappear after 2 sec
]]

|missile_init| function(a)
    a:model_init[[MISSILE]]
end $$
