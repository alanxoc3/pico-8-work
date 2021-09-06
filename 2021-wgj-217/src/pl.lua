MAX_ENERGY=100
SPLIT_COOLDOWN_FRAMECOUNT=60
BULLET_COOLDOWN_FRAMECOUNT=15
SPLIT_COST=33
BULLET_COST=10

function create_pl(x, y)
    return {
        dx=0, dy=0,
        rx=3, ry=3,
        dir=0, -- 0=l, 1=r, 2=u, 3=d
        color=11,
        pressing=nil, -- nil=nothing, 0=l, 1=r, 2=u, 3=d
        energy=MAX_ENERGY,
        bullet_cooldown=0,
        split_cooldown=SPLIT_COOLDOWN_FRAMECOUNT,
        is_split=function(a) return a.split_cooldown < SPLIT_COOLDOWN_FRAMECOUNT end,
        x=x, y=y,
        friction=.925,
        draw=function(a)
            draw_split_pl(a.split_cooldown, SPLIT_COOLDOWN_FRAMECOUNT, a.x, a.y, a.rx, a.ry, a.color)
        end,
        update=function(a)
            a.bullet_cooldown = min(BULLET_COOLDOWN_FRAMECOUNT, a.bullet_cooldown+1)
            a.split_cooldown = min(SPLIT_COOLDOWN_FRAMECOUNT, a.split_cooldown+1)

            a.dx -= pl_button_logic(a, 0, 1)
            a.dx += pl_button_logic(a, 1, 0)
            a.dy -= pl_button_logic(a, 2, 3)
            a.dy += pl_button_logic(a, 3, 2)

            a.dx *= a.friction
            a.dy *= a.friction

            if a:is_split() then
                if a.split_cooldown == SPLIT_COOLDOWN_FRAMECOUNT-1 then
                    a.energy -= SPLIT_COST
                end
                a.color = 12
                return
            end

            a.color = 11
            a.energy = min(MAX_ENERGY, a.energy+.25)
            if btn(4) and a.energy - BULLET_COST >= 0 and a.bullet_cooldown >= BULLET_COOLDOWN_FRAMECOUNT then
                local dx = get_x_from_dir(a.dir, abs(a.dx)+2)
                local dy = get_y_from_dir(a.dir, abs(a.dy)+2)
                add(bullets, create_bullet(a.x, a.y, dx, dy))
                add(bullets, create_bullet(a.x, a.y, dx+dy*.25, dy+dx*.25))
                add(bullets, create_bullet(a.x, a.y, dx-dy*.25, dy-dx*.25))
                a.energy -= BULLET_COST
                a.bullet_cooldown = 0
            end

            if btn(5) and a.energy - SPLIT_COST >= 0 and a.bullet_cooldown >= BULLET_COOLDOWN_FRAMECOUNT then
                a.split_cooldown = 0
            end
        end
    }
end

function pl_button_logic(a, btn_1, btn_2)
    if btn(btn_1) then
        if not a.pressing or a.pressing == btn_1 or a.pressing == btn_2 then
            a.pressing=btn_1 a.dir=btn_1
        end
        return a:is_split() and .2 or .1
    elseif a.pressing == btn_1 then
        a.pressing = nil
    end
    return 0
end

function get_x_from_dir(dir, spd) return dir == 0 and -spd or dir == 1 and spd or 0 end
function get_y_from_dir(dir, spd) return dir == 2 and -spd or dir == 3 and spd or 0 end

function create_bullet(x, y, dx, dy)
    return {
        frames_alive=0,
        alive=true,
        x=x, y=y,
        dx=dx, dy=dy,
        rx=1, ry=1,
        draw=function(a)
            rect(a.x-a.rx, a.y-a.ry, a.x+a.rx, a.y+a.ry, 12)
        end,
        update=function(a)
            a.frames_alive += 1
            if a.frames_alive >= 60 then
                a.alive = false
            end
        end
    }
end

function draw_energy_bar(energy, max_energy)
    local bar_drawn = energy/max_energy * (SCR_MAX_X - SCR_MIN_X)
    if bar_drawn > 0 then
        rectfill(4, SCR_MAX_Y+4, 4 + bar_drawn, SCR_MAX_Y+9, 12)
        rect(4, SCR_MAX_Y+9, 4 + bar_drawn, SCR_MAX_Y+9, 1)
    end
end

function draw_split_pl(time, max_time, x, y, rx, ry, color)
    local percent = time/max_time
    if percent < .10 then
        local crx = rx * (.75 - percent/.10*.75) + .25
        local cry = ry * (.75 - percent/.10*.75) + .25
        rect(x-crx, y-cry, x+crx, y+cry, color)
        pset(x-3, y-3, color) pset(x+3, y-3, color) pset(x+3, y+3, color) pset(x-3, y+3, color)
    elseif percent < .9 then
        rx = rx * .25
        ry = ry * .25
        rect(x-rx, y-ry, x+rx, y+ry, color)
        pset(x-3, y-3, color) pset(x+3, y-3, color) pset(x+3, y+3, color) pset(x-3, y+3, color)
    elseif percent < 1 then
        local new_percent = (percent-.9)/.10
        rx = rx * new_percent
        ry = ry * new_percent
        pset(x-3, y-3, color) pset(x+3, y-3, color) pset(x+3, y+3, color) pset(x-3, y+3, color)
        rect(x-rx, y-ry, x+rx, y+ry, color)
        rect(x-2*8*new_percent, y-2*8*new_percent, x+2*8*new_percent, y+2*8*new_percent, color)
    else
        rect(x-rx, y-ry, x+rx, y+ry, color)
    end
end
