zclass[[planet,actor,model,drawable|
    x,@,y,@,
    init,%planet_init
]]

|planet_init| function(a)
    a:model_init[[PLANET_SMALL]]
    a.d_ang = .001
end $$

zclass[[wall|]]
 
zclass[[cateroid,model,wall,drawable|
    x,@, y,@,
    init,%cateroid_init
]]
 
|cateroid_init| function(a)
    a:model_init[[CATEROID]]
    a.d_ang = .001
end $$
