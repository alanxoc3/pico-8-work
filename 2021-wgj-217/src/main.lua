SCR_MIN_X, SCR_MAX_X = 0+4,  127-4
SCR_MIN_Y, SCR_MAX_Y = 0+4, 127-12

function _init()
    music(0)
    current_update=title_update
    current_draw=title_draw
end

function _update60()
    current_update()
end

function _draw()
    current_draw()
end

function title_update()
    if btnp(4) or btnp(5) then
        game_init()
        current_update = game_update
    end
end

function title_draw()
    cls()
    if btnp(4) or btnp(5) then
        current_draw = game_draw
    end

    print_centered("a cool game", 64, 64-10, 8)
    print_centered("by @alanxoc3 and @davery", 64, 64, 12)
    print_centered("press x or z to play", 64, 64+10, 11)
end

function game_init()
    global_framecount = 0
    pl = create_pl(64, 64)
    walls = { create_wall(50,50) }
    enemies = {}
    bullets = {}
end

function game_update()
    -- ensure things are alive
    bullets = filter_out_dead_things(bullets)
    enemies = filter_out_dead_things(enemies)

    if global_framecount % 120 == 0 then
        add(enemies, create_enemy())
        add(enemies, create_enemy())
        add(enemies, create_enemy())
    end

    -- step 1: speeds
    pl:update()
    foreach(enemies, function(enemy)
        enemy:update()
        if not pl:is_split() and collide_obj(enemy, pl) then
            enemy.alive = false
            if pl.energy > 33 then
                pl.energy -= 33
            else
                pl.alive = false
            end
        end
    end)
    foreach(bullets, function(bullet) bullet:update() end)

    foreach(bullets, function(bullet)
        foreach(enemies, function(enemy)
            if collide_obj(enemy, bullet) and not enemy:is_spawning() then
                bullet.alive = false
                enemy.alive = false
            end
        end)
    end)

    -- step 2: update pos with speed
    pl.x += pl.dx
    pl.y += pl.dy

    -- step 4: update pos with screen collision
    pl.x = mid(SCR_MIN_X+pl.rx, pl.x, SCR_MAX_X-pl.rx)
    pl.y = mid(SCR_MIN_Y+pl.ry, pl.y, SCR_MAX_Y-pl.ry)

    foreach(enemies, function(enemy)
        enemy.x += enemy.dx
        enemy.y += enemy.dy
        enemy.x = mid(SCR_MIN_X+enemy.rx, enemy.x, SCR_MAX_X-enemy.rx)
        enemy.y = mid(SCR_MIN_Y+enemy.ry, enemy.y, SCR_MAX_Y-enemy.ry)
        detect_collisions(enemy)
    end)

    foreach(bullets, function(bullet)
        bullet.x += bullet.dx
        bullet.y += bullet.dy
    end)

    global_framecount += 1

    -- step 5: update pos with other objects
    detect_collisions(pl)
end

function game_draw()
    cls()
    rect(SCR_MIN_X,SCR_MIN_Y,SCR_MAX_X,SCR_MAX_Y,8)
    pl:draw()
    foreach(walls, function(wall) wall:draw() end)
    foreach(enemies, function(enemy) enemy:draw() end)
    foreach(bullets, function(bullet) bullet:draw() end)
    draw_energy_bar(pl.energy, MAX_ENERGY)
end
