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
    pl.x = mid(0+pl.rx, pl.x, 127-pl.rx)
    pl.y = mid(0+pl.ry, pl.y, 127-pl.ry)

    foreach(enemies, function(enemy)
        enemy.x += enemy.dx
        enemy.y += enemy.dy
        enemy.x = mid(0+enemy.rx, enemy.x, 127-enemy.rx)
        enemy.y = mid(0+enemy.ry, enemy.y, 127-enemy.ry)
    end)

    foreach(bullets, function(bullet)
        bullet.x += bullet.dx
        bullet.y += bullet.dy
    end)
end

function _draw()
    cls()
    rect(0,0,127,127,8)
    pl:draw()
    foreach(walls, function(wall) wall:draw() end)
    foreach(enemies, function(enemy) enemy:draw() end)
    foreach(bullets, function(bullet) bullet:draw() end)
end
