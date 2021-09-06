SPAWN_MAX_FRAMECOUNT = 60

function create_enemy()
    local mid_x = (SCR_MAX_X + SCR_MIN_X) / 2
    local mid_y = (SCR_MAX_Y + SCR_MIN_Y) / 2
    local x = rnd(SCR_MAX_X-SCR_MIN_X)+SCR_MIN_X
    local y = rnd(SCR_MAX_Y-SCR_MIN_Y)+SCR_MIN_Y

    local color = 2
    local rand_sign = sgn(flr(rnd(2))-.5)
    local movement_func = function(a)
        a.dx = cos(rand_sign*a.time/2)
        a.dy = sin(rand_sign*a.time/2)
    end

    local rand_num = flr(rnd(5))
    if rand_num == 0 then
        color = 14
        movement_func = function(a)
            a.dx = 0
            a.dy = cos(a.time/4)*1 + rnd(.25)-.125
        end
    elseif rand_num == 1 then
        color = 4
        movement_func = function(a)
            a.dx = cos(a.time/4)*1 + rnd(.25)-.125
            a.dy = 0
        end
    elseif rand_num == 2 then
        color = 3
        local base_speed = rnd(.25)+.25
        movement_func = function(a)
            local ang = atan2(pl.x - a.x, pl.y - a.y)
            a.dx = cos(ang) * base_speed
            a.dy = sin(ang) * base_speed
        end
    elseif rand_num == 3 then
        color = 10
        movement_func = function(a)
            a.dx += rnd(.25)-.125
            a.dy += rnd(.25)-.125
            a.dx *= a.friction
            a.dy *= a.friction
        end
    end

    return {
        dx=0, dy=0,
        alive=true,
        rx=3, ry=3,
        friction=.95,
        time=rnd(1),
        x=x, y=y,
        is_spawning=function(a) return a.spawn_timer < SPAWN_MAX_FRAMECOUNT end,
        color=color,
        spawn_timer=0,
        draw=function(a)
            if a:is_spawning() then
                local percent = a.spawn_timer / SPAWN_MAX_FRAMECOUNT
                rect(a.x-a.rx*percent, a.y-a.ry*percent, a.x+a.rx*percent, a.y+a.ry*percent, 5)
            else
                rect(a.x-a.rx, a.y-a.ry, a.x+a.rx, a.y+a.ry, a.color)
            end
        end,
        update=function(a)
            a.time += 1/60
            a.spawn_timer = min(SPAWN_MAX_FRAMECOUNT, a.spawn_timer + 1)
            if not a:is_spawning() then
                movement_func(a)
            end
        end
    }
end
