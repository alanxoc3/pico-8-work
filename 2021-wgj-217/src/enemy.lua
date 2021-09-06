function create_enemy(x, y)
    return {
        dx=0, dy=0,
        rx=4, ry=4,
        x=x, y=y,
        draw=function(a)
            rect(a.x-a.rx, a.y-a.ry, a.x+a.rx, a.y+a.ry, 2)
        end,
        update=function(a)
            a.dx = cos(t()/10)/2
            a.dy = sin(t()/10)/2
        end
    }
end
