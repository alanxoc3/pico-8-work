MAX_ENERGY=100

function create_pl(x, y)
    return {
        dx=0, dy=0,
        rx=4, ry=4,
        dir=0, -- 0=l, 1=r, 2=u, 3=d
        pressing=nil, -- nil=nothing, 0=l, 1=r, 2=u, 3=d
        energy=MAX_ENERGY,
        bullet_cooldown=0,
        x=x, y=y,
        friction=.925,
        draw=function(a)
            circ(a.x, a.y, 4, 8)
        end,
        update=function(a)
            a.bullet_cooldown += 1
            a.energy = min(MAX_ENERGY, a.energy+.25)
            a.dx -= pl_button_logic(a, 0, 1)
            a.dx += pl_button_logic(a, 1, 0)
            a.dy -= pl_button_logic(a, 2, 3)
            a.dy += pl_button_logic(a, 3, 2)

            if btn(4) and a.energy - 10 >= 0 and a.bullet_cooldown >= 15 then
                local dx = get_x_from_dir(a.dir, abs(a.dx)+2)
                local dy = get_y_from_dir(a.dir, abs(a.dy)+2)
                add(bullets, create_bullet(a.x, a.y, dx, dy))
                add(bullets, create_bullet(a.x, a.y, dx+dy*.25, dy+dx*.25))
                add(bullets, create_bullet(a.x, a.y, dx-dy*.25, dy-dx*.25))
                a.energy -= 10
                a.bullet_cooldown = 0
            end

            a.dx *= a.friction
            a.dy *= a.friction
        end
    }
end

function pl_button_logic(a, btn_1, btn_2)
    if btn(btn_1) then
        if not a.pressing or a.pressing == btn_1 or a.pressing == btn_2 then
            a.pressing=btn_1 a.dir=btn_1
        end
        return .1
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
        rx=2, ry=2,
        draw=function(a)
            rect(a.x-a.rx, a.y-a.ry, a.x+a.rx, a.y+a.ry, 10)
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
    local bar_drawn = energy/max_energy * 119
    if bar_drawn > 0 then

        rectfill(4, 119, 4 + bar_drawn, 124, 12)
        rect(4, 124, 4 + bar_drawn, 124, 1)
    end
end
