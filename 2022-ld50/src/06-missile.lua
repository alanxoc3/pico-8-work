zclass[[missile,model|
    x,@,y,@,ang,@,     -- initial position & direction
    speed,0.1,
    init,%missile_init;
    start;duration,2;  -- disappear after 2 sec
]]

|missile_init| function(a)
    a:model_init[[lines;1;,7,0.2,0,0.1,0.1,-0.1,0.1,0,0,-0.1,-0.1,0.1,-0.1,0.2,0;collisions;1;,0.1,0,0.1;collisions;2;,0,0,0.1;]]
end $$
