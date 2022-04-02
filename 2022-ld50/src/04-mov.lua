-- note: in order for collisions to work well, never change the x, y, or ang of an object directly.
-- instead, use dx, dy, ax, ay, speed and d_ang

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
    ang,0, speed,0, d_ang,0,
    mov_update,%mov_update
]]
|mov_update| function(a)
    a.ang += a.d_ang

    a.ax = a.speed*cos(a.ang)
    a.ay = a.speed*sin(a.ang)
end $$

-- basically, copies all the speed/movement properties of something
zclass[[collision_circ,acc,actor
-- DEBUG_BEGIN
,drawable
-- DEBUG_END
|
    anchoring,@, offset_x,@, offset_y,@, radius,@,
    inertia_x,1, inertia_y,1,
    follow_anchoring,%collision_follow_anchoring

    -- DEBUG_BEGIN
    ,draw,%collision_draw_debug
    -- DEBUG_END
]]
|collision_follow_anchoring| function(a)
    local b = a.anchoring

    local ang, spd = b.ang + b.d_ang, b.speed
    local off_magnitude = approx_dist(a.offset_x, a.offset_y)
    local off_ang_old = atan2(a.offset_x, a.offset_y) + b.ang
    local off_ang_new = off_ang_old + b.d_ang

    a.ax = spd*cos(ang)
    a.ay = spd*sin(ang)
    a.alive, a.dx, a.dy, a.x, a.y = b.alive, b.dx, b.dy, b.x+off_magnitude*cos(off_ang_new), b.y+off_magnitude*sin(off_ang_new)

    -- this accounts for the momentum from turning.
    -- if check is to save cpu cycles for the common case of no offset.
    if offset_x ~= 0 or offset_y ~= 0 then
        a.ax += spd*cos(ang) + (cos(off_ang_new) - cos(off_ang_old))*off_magnitude
        a.ay += spd*sin(ang) + (sin(off_ang_new) - sin(off_ang_old))*off_magnitude
    end
end $$

-- DEBUG_BEGIN
|collision_draw_debug| function(a)
    line(zoomx(a.x), zoomy(a.y), zoomx(a.x+a.ax*5), zoomy(a.y+a.ay*5), 3)
    -- line(zoomx(a.x), zoomy(a.y), zoomx(a.x+a.dx*3), zoomy(a.y+a.dy*3), 2)
    circ(zoomx(a.x), zoomy(a.y), a.radius*g_view.zoom_factor, 8)
end $$
-- DEBUG_BEGIN
