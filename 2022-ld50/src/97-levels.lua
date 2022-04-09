|level_cat_init| function()
    level_init_shared(5, "cat", 24, 0, -9, 11)

    local planet = _g.planet(0,-22,_g.CAT)
    _g.asteroid(25,0,_g.ASTEROID)
    _g.asteroid(-25,0,_g.ASTEROID)
    _g.asteroid(15,15,_g.ASTEROID)
    _g.asteroid(-13,13,_g.ASTEROID)
    _g.asteroid(22,8,_g.ASTEROID)
    _g.asteroid(-22,8,_g.ASTEROID)

    -- asteroids kinda protect you from enemies
    _g.spawner(_g.chaser, planet, 4, 2, .5, 1)
    _g.black_hole(0, 0)
end $$

|level_pig_init| function()
    level_init_shared(6, "pig", 16, 0, 0, 11)

    -- title
    local planet = _g.planet(20,0,_g.PIG)
    _g.asteroid(17,-15,_g.ASTEROID)
    _g.asteroid(17,15,_g.ASTEROID)

    _g.spawner(_g.chaser, planet, 4, 4, -.125, .125)

    _g.black_hole(-22, 0)
    _g.black_hole(-22, 0)
end $$

|level_bear_init| function()
    level_init_shared(3, "bear", 8, 0, 0, 12)

    local planet = _g.planet(0,-22,_g.BEAR)
    _g.black_hole(0,22)
    _g.black_hole(0,22)
    _g.spawner(_g.chaser, planet, 8, 8, .825-.125/2, .825+.125/2)
    _g.spawner(_g.chaser, planet, 4, 8, .625+.125/2, .625+.125/2)
end $$

|level_mouse_init| function()
    level_init_shared(7, "mouse", 32, -9, 0, 13)

    local planet = _g.planet(0,0,_g.MOUSE)
    _g.asteroid(cos(.25    )*10,sin(.25    )*10,_g.ASTEROID)
    _g.asteroid(cos(.25+1/3)*20,sin(.25+1/3)*20,_g.ASTEROID)
    _g.asteroid(cos(.25+2/3)*30,sin(.25+2/3)*30,_g.ASTEROID)

    _g.spawner(_g.chaser, planet, 5, 5, 0, 1)

    _g.black_hole(cos(.75    )*50,sin(.75    )*40)
    _g.black_hole(cos(.75+1/3)*50,sin(.75+1/3)*40)
    _g.black_hole(cos(.75+2/3)*50,sin(.75+2/3)*40)
end $$

|level_credits_init| function()
    level_init_shared("credits", "level_credits", "level_credits", 32, 0, 0)

    create_text("code,amorg,denial",        0,   -12)
    create_text("gfx,tigerwolf,greatcadet", -12, 0)
    create_text("sfx,amorg,greatcadet",     12,  0)
    create_text("made,with,pico8",          0,   12)

    _g.spawner(_g.chaser, {x=0, y=0}, 2,  20, .0625, .1875)
    _g.spawner(_g.chaser, {x=0, y=0}, 7,  20, .3125, .4375)
    _g.spawner(_g.chaser, {x=0, y=0}, 12, 20, .5625, .6875)
    _g.spawner(_g.chaser, {x=0, y=0}, 17, 20, .8125, .9375)
end $$
