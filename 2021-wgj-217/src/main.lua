SCR_MIN_X, SCR_MAX_X = 0+4,  127-4
SCR_MIN_Y, SCR_MAX_Y = 0+4, 127-20

function _init()
    music(0)
    high_score_rounds=1
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
    print_centered("by @alanxoc3 and @davery22", 64, 64, 12)
    print_centered("press x or z to play", 64, 64+10, 11)
    print_centered("high score: "..high_score_rounds, 64, 64+20, 10)
end

function game_init()
    global_rounds = 0
    global_framecount = 0
    pl = create_pl(64, 64)
    walls = {}
    enemies = {}
    bullets = {}
    shake_timer=0
end

function game_update()
    shake_timer = max(0, shake_timer - 1)
    -- ensure things are alive
    bullets = filter_out_dead_things(bullets)
    enemies = filter_out_dead_things(enemies)
    walls = filter_out_dead_things(walls)

    if global_framecount % 120 == 0 then
        global_rounds += 1
        add(enemies, create_enemy())
        add(enemies, create_enemy())
    end

    -- step 1: speeds
    pl:update()
    foreach(enemies, function(enemy)
        enemy:update()
        if not enemy:is_spawning() and not pl:is_split() and collide_obj(enemy, pl) then
            enemy.alive = false
            pl.alive = false
        end
    end)
    foreach(bullets, function(bullet) bullet:update() end)
    foreach(walls, function(wall) wall:update() end)

    foreach(bullets, function(bullet)
        foreach(enemies, function(enemy)
            if collide_obj(enemy, bullet) and not enemy:is_spawning() then
                bullet.alive = false
                enemy.alive = false
            end
        end)
    end)

    if pl:is_split() and pl.split_cooldown == SPLIT_COOLDOWN_FRAMECOUNT-1 then
        -- Explosion! Kills le enemies..
        local em_wave = {x=pl.x, y=pl.y, rx=30, ry=30}
        foreach(enemies, function(enemy)
            if collide_obj(enemy, em_wave) then -- Kills even if enemies are spawning
                enemy.alive = false
            end
        end)
    end

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
        -- detect_collisions(enemy)
    end)

    foreach(bullets, function(bullet)
        bullet.x += bullet.dx
        bullet.y += bullet.dy
    end)

    global_framecount += 1

    -- step 5: update pos with other objects
    detect_collisions(pl)

    if not pl.alive then
        current_update=title_update
    end
end

function game_draw()
    if shake_timer > 0 then
        camera(rnd(3)-1, rnd(3)-1)
    end

    cls()
    rect(SCR_MIN_X,SCR_MIN_Y,SCR_MAX_X,SCR_MAX_Y,8)
    foreach(walls, function(wall) wall:draw() end)
    foreach(enemies, function(enemy) enemy:draw() end)
    foreach(bullets, function(bullet) bullet:draw() end)
    pl:draw()
    camera()

    draw_energy_bar(pl.energy, MAX_ENERGY)
    print("round: "..global_rounds, SCR_MIN_X, SCR_MAX_Y+12, 8)
    
    if not pl.alive then
        current_draw=title_draw
    end
end
