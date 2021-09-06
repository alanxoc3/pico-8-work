function create_wall(x, y)
    return {
        x=x, y=y,
        rx=4, ry=4,
        draw=function(self)
            rect(self.x-self.rx, self.y-self.ry, self.x+self.rx, self.y+self.ry, 8)
        end
    }
end
