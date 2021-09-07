function create_wall(x, y)
    return {
        x=x, y=y,
        rx=3, ry=3,
        -- timer=rnd(480)+240,
        alive=true,
        update=function(a)
            -- a.timer -= 1
            -- if a.timer <= 0 then
                -- a.alive = false
            -- end
        end,
        draw=function(self)
            rect(self.x-self.rx, self.y-self.ry, self.x+self.rx, self.y+self.ry, 8)
        end
    }
end
