|level_cat_init| function()
    level_init_shared("cat", "level_cat_retry", "win_cat", 24, 10, 0, 0)

    local planet = _g.planet(0,-22,_g.CAT)
    _g.black_hole(0, 22)
end $$

|level_pig_init| function()
    level_init_shared("pig", "level_pig_retry", "win_pig", 16, 7, 0, 0)

    -- title
    local planet = _g.planet(20,0,_g.PIG)
    _g.asteroid(17,-15,_g.ASTEROID)
    _g.asteroid(17,15,_g.ASTEROID)

    _g.spawner(_g.chaser, planet, 4, 4, -.125, .125)

    _g.black_hole(-22, 0)
    _g.black_hole(-15, -15)
    _g.black_hole(-15, 15)

end $$

|level_bear_init| function()
    level_init_shared("bear", "level_bear_retry", "win_bear", 8, 10, 0, 0)

    local planet = _g.planet(0,-22,_g.BEAR)
    _g.black_hole(0, 22)
end $$

|level_mouse_init| function()
    level_init_shared("mouse", "level_mouse_retry", "win_mouse", 32, 16, -7, 3)

    local planet = _g.planet(0,0,_g.MOUSE)
    _g.asteroid(-15, 0,_g.ASTEROID)
    _g.asteroid( 0,-25,_g.ASTEROID)
    _g.asteroid( 35, 0,_g.ASTEROID)
    _g.asteroid( 0, 45,_g.ASTEROID)

    _g.spawner(_g.chaser, planet, 4, 3, 0, 1)

    _g.black_hole( 50, -50)
    _g.black_hole( 50,  50)
    _g.black_hole(-50,  50)
    _g.black_hole(-50, -50)
end $$
