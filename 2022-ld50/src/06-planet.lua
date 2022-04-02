zclass[[planet,actor,model|
    x,@,y,@,
    init,%planet_init,
    update,%planet_update;
]]

|planet_init| function(a)
    a.model = zobj[[lines;1;,3,0.5,0,-0.5,0]]
end $$

|planet_update| function(a)
    a.ang -= .001
end $$
