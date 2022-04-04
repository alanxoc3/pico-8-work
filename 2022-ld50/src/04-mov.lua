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
    if a.ax == 0 and abs(a.dx) < .00001 then a.dx = 0 end
    if a.ay == 0 and abs(a.dy) < .00001 then a.dy = 0 end
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

zclass[[anchor_pos,pos|anchoring;x,0,y,0;update_anchor,%anchor_pos_update_anchor]]
|anchor_pos_update_anchor| function(a)
    a.x = a.anchoring.x
    a.y = a.anchoring.y
end $$

-- basically, copies all the speed/movement properties of something
zclass[[collision_circ,vec,actor
-- DEBUG_BEGIN
,drawable
-- DEBUG_END
|
    anchoring,@, offset_x,@, offset_y,@, radius,@,
    inertia_x,1, inertia_y,1,
    follow_anchoring,%collision_follow_anchoring,
    check_collision,%check_collision,
    init,%collision_init,

    -- DEBUG_BEGIN
    draw,%collision_draw_debug
    -- DEBUG_END
]]

|collision_init| function(a)
    add(a.anchoring.collision_circs, a)
    a:follow_anchoring()
end $$

|collision_follow_anchoring| function(a)
    local b = a.anchoring
    local off_magnitude = approx_dist(a.offset_x, a.offset_y)
    local off_ang_new = atan2(a.offset_x, a.offset_y) + b.ang + b.d_ang
    a.alive, a.dx, a.dy, a.x, a.y = b.alive, b.dx, b.dy, b.x+off_magnitude*cos(off_ang_new), b.y+off_magnitude*sin(off_ang_new)
end $$

-- requires x, y, and radius
function dist_between_circles(a, b)
    local x, y = b.x-a.x, b.y-a.y
    local minimum_dist = a.radius + b.radius
    return approx_dist(x, y) - minimum_dist
end

|check_collision| function(a, others)
    foreach(others, function(other)
        if a == other then return end
        local dist = dist_between_circles(a, other)
        
        if dist < 0 then
            local ang = atan2(x, y)
            local dx, dy = cos(ang)*dist, sin(ang)*dist
            a.anchoring:hit(other.anchoring, dx, dy)
            other.anchoring:hit(a.anchoring, -dx, -dy)
        end
    end)
end $$

-- DEBUG_BEGIN
|collision_draw_debug| function(a)
    if g_debug then
        circ(zoomx(a.x), zoomy(a.y), a.radius*g_view.zoom_factor, 8)
    end
end $$
-- DEBUG_BEGIN

zclass[[bad_collision_circ,collision_circ|
    anchoring,@, offset_x,@, offset_y,@, radius,@
]]

zclass[[good_collision_circ,collision_circ|
    anchoring,@, offset_x,@, offset_y,@, radius,@
]]
