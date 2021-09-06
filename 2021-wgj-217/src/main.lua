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
    update_player(pl, walls)
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

    p.x += p.dx
    p.y += p.dy

    p.x = mid(0+p.rx, p.x, 127-p.rx)
    p.y = mid(0+p.ry, p.y, 127-p.ry)
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
