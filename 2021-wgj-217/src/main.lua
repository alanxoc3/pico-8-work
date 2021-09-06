function _init()
    pl = {
        dx=0, dy=0,
        rx=4, ry=4,
        x=64, y=64,
        friction=.925
    }

    walls = {
        create_wall(50,50)
    }
end

function _update60()
    -- step 1: speeds
    update_player(pl, walls)

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
end

function _draw()
    cls()
    rect(0,0,127,127,8)
    draw_player(pl)
    foreach(walls, function(wall)
        wall:draw()
    end)
end

function draw_player(p)
    circ(p.x, p.y, 4, 8)
end

function update_player(p, walls)
    if btn(0) then p.dx -= .1 end
    if btn(1) then p.dx += .1 end
    if btn(2) then p.dy -= .1 end
    if btn(3) then p.dy += .1 end

    p.dx *= p.friction
    p.dy *= p.friction
end

function create_wall(x, y)
    return {
        x=x, y=y,
        rx=4, ry=4,
        draw=function(self)
            rect(self.x-self.rx, self.y-self.ry, self.x+self.rx, self.y+self.ry, 8)
        end
    }
end
