SCR_MIN_X, SCR_MAX_X = 0+4,  127-4
SCR_MIN_Y, SCR_MAX_Y = 0+4, 127-12

function _init()
    pl = create_pl(64, 64)
    walls = { create_wall(50,50) }
    enemies = { create_enemy(10,10) }
    bullets = {}
end

function _update60()
    -- ensure things are alive
    bullets = filter_out_dead_things(bullets)

    -- step 1: speeds
    pl:update()
    foreach(enemies, function(enemy) enemy:update() end)
    foreach(bullets, function(bullet) bullet:update() end)

    -- step 2: update pos with other objects
    foreach(walls, function(wall)
        -- pl:collide_with_wall(wall)
    end)

    -- step 3: update pos with speed
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
    end)

    foreach(bullets, function(bullet)
        bullet.x += bullet.dx
        bullet.y += bullet.dy
    end)
end

function _draw()
    cls()
    rect(SCR_MIN_X,SCR_MIN_Y,SCR_MAX_X,SCR_MAX_Y,8)
    pl:draw()
    foreach(walls, function(wall) wall:draw() end)
    foreach(enemies, function(enemy) enemy:draw() end)
    foreach(bullets, function(bullet) bullet:draw() end)
    draw_energy_bar(pl.energy, MAX_ENERGY)
end
