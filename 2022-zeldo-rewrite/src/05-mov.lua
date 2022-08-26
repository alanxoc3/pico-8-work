-- just a position
zclass[[pos|
    x,0,
    y,0,
    dist_point,%pos_dist_point
]]

-- fast approximate distance formula (no need for sqrt & ^2)
-- stolen from a pico-8 forum
|[pos_dist_point]| function(a, x, y)
    local dx, dy = x-a.x, y-a.y
    local maskx,masky=dx>>31,dy>>31
    local a0,b0=(dx+maskx)^^maskx,(dy+masky)^^masky
    if a0>b0 then
        return a0*0.9609+b0*0.3984
    end
    return b0*0.9609+a0*0.3984
end $$

-- position with a speed
zclass[[vec,pos|dx,0,dy,0,vec_update_x,%vec_update_x,vec_update_y,%vec_update_y]]

|[vec_update_x]| function(a)
    a.x += a.dx
end $$

|[vec_update_y]| function(a)
    a.y += a.dy
end $$

-- able to contribute to acceleration with direction and speed
zclass[[mov,vec|
    ang,0, speed,0,
    mov_update,%mov_update,
    towards_point,%mov_towards_point
]]

|[mov_update]| function(a)
    local ax, ay = a.speed*cos(a.ang), a.speed*sin(a.ang)
    a.dx += ax a.dy += ay
    a.dx *= DEFAULT_INERTIA a.dy *= DEFAULT_INERTIA
    if ax == 0 and abs(a.dx) < MIN_SPEED then a.dx = 0 end
    if ay == 0 and abs(a.dy) < MIN_SPEED then a.dy = 0 end
    a.speed = 0
end $$

|[mov_towards_point]| function(a, x, y)
    a.ang = atan2(x-a.x, y-a.y)
end $$
