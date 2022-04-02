-- just a position
zclass[[pos|x,0,y,0]]

-- position with a speed
zclass[[vec,pos|dx,0,dy,0,vec_update,%vec_update]]
|vec_update| function(a)
    a.x += a.dx
    a.y += a.dy
end $$

-- position with acceleration
zclass[[acc,vec|
   inertia_x,.95, inertia_y,.95,
   ax,0, ay,0,
   acc_update,%acc_update
]]
|acc_update| function(a)
    a.dx += a.ax a.dy += a.ay
    a.dx *= a.inertia_x a.dy *= a.inertia_y
    if a.ax == 0 and abs(a.dx) < .01 then a.dx = 0 end
    if a.ay == 0 and abs(a.dy) < .01 then a.dy = 0 end
end $$

-- able to contribute to acceleration with direction and speed
zclass[[mov,acc|
    ang,0,speed,0,
    mov_update,%mov_update
]]
|mov_update| function(a)
    a.ax = a.speed*cos(a.ang)
    a.ay = a.speed*sin(a.ang)
end $$
