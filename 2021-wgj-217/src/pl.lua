function create_pl(x, y)
    return {
        dx=0, dy=0,
        rx=4, ry=4,
        x=x, y=y,
        friction=.925,
        draw=function(p)
            circ(p.x, p.y, 4, 8)
        end,
        update=function(p)
            if btn(0) then p.dx -= .1 end
            if btn(1) then p.dx += .1 end
            if btn(2) then p.dy -= .1 end
            if btn(3) then p.dy += .1 end

            p.dx *= p.friction
            p.dy *= p.friction
        end
    }
end
