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
zclass[[vec,pos|dx,0,dy,0,vec_update,%vec_update]]

|[vec_update]| function(a)
    a.x += a.dx
    a.y += a.dy
end $$

-- able to contribute to acceleration with direction and speed
zclass[[mov,vec|
    ax,0, ay,0,
    ix,.8, iy,1,
    mov_update,%mov_update,
    towards_point,%mov_towards_point
]]

MIN_SPEED=.0125
MAX_SPEED=.75

|[mov_update]| function(a)
    a.dx += a.ax
    a.dy += a.ay
    a.dx *= a.ix a.dy *= a.iy

    if abs(a.dx) < MIN_SPEED then a.dx = 0 end
    if abs(a.dy) < MIN_SPEED then a.dy = 0 end
    -- if abs(a.dx) > MAX_SPEED then a.dx = sgn(a.dx)*MAX_SPEED end
    if abs(a.dy) > MAX_SPEED then a.dy = sgn(a.dy)*MAX_SPEED end
    a.ax = 0 a.ay = 0
end $$
