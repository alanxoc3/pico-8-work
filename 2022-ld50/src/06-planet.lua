zclass[[wall|]]

zclass[[planet,actor,model,drawable|
    x,@, y,@,
    d_ang,.001,
    model_obj,%PLANET_SMALL
]]

zclass[[cateroid,model,wall,drawable|
    x,@, y,@,
    d_ang,.001,
    scale,2,
    model_obj,%CATEROID,
    hit,%cateroid_hit
]]

|cateroid_hit| function(a, b, dx, dy)
    a:explode()
end $$
