|level_1_init| function()
    level_init_shared(1, "lvl 1", "mouse", 32, 0, 0, 9)

    local planet = _g.planet(15,0,_g.MOUSE)
    _g.asteroid(26,0)
    _g.black_hole(-20, 0)
    _g.spawner(_g.chaser, planet, 4, 4,  0, 0)
end $$

|level_2_init| function()
    level_init_shared(2, "lvl 2", "cat", 24, 0, 0, 12)

    local planet = _g.planet(0,-25,_g.CAT)
    _g.black_hole(0,22)

    _g.spawner(_g.chaser, planet, 4, 16, .83, .83)
    _g.spawner(_g.chaser, planet, 12, 16, .67, .67)
end $$

|level_3_init| function()
    level_init_shared(3, "lvl 3", "pig", 16, 0, 7, 13)

    local planet = _g.planet(0,0,_g.PIG)
    _g.black_hole(-50,0)
    _g.black_hole(50,0)

    _g.asteroid(0,-25)
    _g.asteroid(0,25)

    _g.spawner(_g.chaser, planet, 4, 8, .75, .75)
    _g.spawner(_g.chaser, planet, 8, 8, .25, .25)
end $$

|level_4_init| function()
    level_init_shared(4, "lvl 4", "bear", 8, 0, -9, 11)

    local planet = _g.planet(0,-25,_g.BEAR)
    _g.asteroid(25,0)
    _g.asteroid(-25,0)
    _g.asteroid(15,15)
    _g.asteroid(-15,15)
    _g.asteroid(22,8)
    _g.asteroid(-22,8)

    -- asteroids kinda protect you from enemies
    _g.spawner(_g.chaser, planet, 4, 2, .5, 1)
    _g.black_hole(0, 18)
end $$

|level_5_init| function()
    level_init_shared(5, "lvl 5", "rhino", 40, 10, 0, 11)

    -- title
    local planet = _g.planet(20,0,_g.PIG)
    _g.asteroid(17,-18)
    _g.asteroid(17,20)

    _g.spawner(_g.chaser, planet, 4, 4, -.125, .125)

    _g.black_hole(-22, 0)
end $$

|level_6_init| function()
    level_init_shared(6, "lvl 6", "croc", 44, -9, 0, 11)

    local planet = _g.planet(0,0,_g.MOUSE)
    _g.asteroid(cos(.25    )*35,sin(.25    )*35)
    _g.asteroid(cos(.25+1/3)*35,sin(.25+1/3)*35)
    _g.asteroid(cos(.25+2/3)*35,sin(.25+2/3)*35)

    _g.spawner(_g.chaser, planet, 6,  18, .25+0/3-.1, .25+0/3+.1)
    _g.spawner(_g.chaser, planet, 12, 18, .25+1/3-.1, .25+1/3+.1)
    _g.spawner(_g.chaser, planet, 18, 18, .25+2/3-.1, .25+2/3+.1)

    _g.black_hole(cos(.75    )*58,sin(.75    )*58)
    _g.black_hole(cos(.75+1/3)*58,sin(.75+1/3)*58)
    _g.black_hole(cos(.75+2/3)*58,sin(.75+2/3)*58)
end $$

|level_7_init| function()
    level_init_shared(7, "lvl 7", "dragon", 36, 8, 8, 13)

    local planet = _g.planet(0, 0, _g.MOUSE)
    _g.asteroid(23, -12)
    _g.asteroid(-12, 23)

    _g.spawner(_g.chaser, planet, 5, 10,   .75, 1)
    _g.spawner(_g.chaser, planet, 10, 10, .1762, .5738)

    _g.black_hole(-80, 40)
    _g.black_hole(80, 0)
    _g.black_hole(0, 80)
    _g.black_hole(40, -80)
end $$

|level_8_init| function()
    inc_level(1)
    level_init_shared(8, "the", "credits", 48, 0, 0)

    create_text("you win",       0,   -5)
    create_text(get_wob_text(),        0,   5)

    create_text("code,amorg,denial",        0,   -12)
    create_text("gfx,tigerwolf,greatcadet", -12, 0)
    create_text("sfx,amorg,greatcadet",     12,  0)
    create_text("made for,ludum dare,50",            0,   12)

    _g.spawner(_g.chaser, {x=0, y=0}, 5,  20,  .125, .125)
    _g.spawner(_g.chaser, {x=0, y=0}, 10,  20, .375, .375)
    _g.spawner(_g.chaser, {x=0, y=0}, 15,  20, .625, .625)
    _g.spawner(_g.chaser, {x=0, y=0}, 20, 20,  .875, .875)

    _g.asteroid(-10, -10)
    _g.asteroid(-10,  10)
    _g.asteroid( 10,  10)
    _g.asteroid( 10, -10)
end $$
