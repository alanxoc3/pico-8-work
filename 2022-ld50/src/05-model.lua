function zoomx(x) return (x - g_view.x) * g_view.zoom_factor + 64 end
function zoomy(y) return (y - g_view.y) * g_view.zoom_factor + 64 end

zclass[[model,mov,drawable,actor|
    model;,;
    hit,nop,
    collision_func,%bad_collision_circ,
    draw,%model_draw,
    explode,%model_explode,
    collide,%model_collide,
    model_init,%model_init
]]

function line_loop(points, color, linefunc)
    for i=1,#points-1,1 do
        local p1, p2 = points[i], points[i+1]
        linefunc(p1.x, p1.y, p2.x, p2.y, color)
    end
end

|model_draw| function(a)
    srand(t()*4\1) -- for nice wobbling
 
    local modelpoints = {}
    foreach(a.model.lines, function(lines)
        local points = get_points_from_shape(a.x, a.y, a.ang, lines)
        foreach(points, function(point) point.x = zoomx(point.x) point.y = zoomy(point.y) end)
        draw_polygon(points, lines[2], points.fill_color)
        add(modelpoints, {c=lines[1], points=points})
    end)

    foreach(modelpoints, function(points)
        line_loop(points.points, points.c, wobble_line)
    end)

    -- DEBUG_BEGIN
    if g_debug and a.field_radius then
        circ(zoomx(a.x), zoomy(a.y), a.field_radius*g_view.zoom_factor, 2)
    end
    -- DEBUG_END
end $$

|model_init| function(a, zobj_str)
    a.model = zobj(zobj_str)

    a.field_radius = a.model.field
    a.collisions = {}
    -- create collision rects
    foreach(a.model.collisions or {}, function(collision)
        a.collision_func(a, collision[1], collision[2], collision[3])
    end)
end $$

|model_collide| function(a, other_list)
    foreach(other_list, function(other)
        local should_check_fine_grained_collisions = false

        if a.field_radius and other.field_radius then
            local x, y = other.x-a.x, other.y-a.y
            local minimum_dist = a.field_radius + other.field_radius
            should_check_fine_grained_collisions = approx_dist(x, y) < minimum_dist
        else
            should_check_fine_grained_collisions = true
        end

        if should_check_fine_grained_collisions then
            foreach(a.collisions, function(b)
                b:check_collision(other.collisions)
            end)
        end
    end)
end $$

function get_points_from_shape(x, y, dir, shape)
    local points = {}
    for i=3,#shape/2\1*2,2 do
        local x1, y1 = shape[i], shape[i+1]
        local ang1 = atan2(x1, y1)
        local mag1 = approx_dist(x1, y1)

        add(points, {x=x+cos(ang1+dir)*mag1, y=y+sin(ang1+dir)*mag1})
    end
    return points
end

|model_explode| function(a)
    if a.alive then
        a:kill()
 
        foreach(a.model.lines, function(lines)
            local points = get_points_from_shape(a.x, a.y, a.ang, lines)
            line_loop(points, lines[1], function(x1, y1, x2, y2, color)
                local midx, midy = (x2-x1)/2+x1, (y2-y1)/2+y1
                x1, y1 = x1-midx, y1-midy
                x2, y2 = x2-midx, y2-midy
                _g.line_particle(atan2(midx-a.x, midy-a.y), midx, midy, x1, y1, x2, y2, color, a.dx, a.dy)
            end)

            _g.vanishing_shape(a.x, a.y, a.dx, a.dy, points, lines[2])
        end)
    end
end $$

zclass[[vanishing_shape,vec,actor,drawable|
    x,@, y,@, dx,@, dy,@, points,@, color,@,
    
    draw,%vanishing_shape_draw;
    start;duration,.25;
]]

|vanishing_shape_draw| function(a)
    local percent = a:get_elapsed_percent'state'
    local points = {}
    foreach(a.points, function(p)
        local dx, dy = a.x - p.x, a.y - p.y
        local dist = approx_dist(dx, dy)
        local ang = atan2(dx, dy)
        local x, y = dist*cos(ang)*percent, dist*sin(ang)*percent
        add(points, {x=zoomx(p.x+x), y=zoomy(p.y+y)})
    end)
    draw_polygon(points, a.color)
end $$

zclass[[line_particle,vec,actor,drawable|
    ang,@, x,@, y,@, x1,@, y1,@, x2,@, y2,@, color,@, dx,@, dy,@,

    draw,%line_particle_draw,
    update,%line_particle_update;
    start;duration,.5;
]]

|line_particle_update| function(a)
    a.dx += cos(a.ang)*.005
    a.dy += sin(a.ang)*.005
end $$

|line_particle_draw| function(a)
    local percent = 1 - a:get_elapsed_percent'state'
    line(zoomx(a.x+a.x1*percent), zoomy(a.y+a.y1*percent), zoomx(a.x+a.x2*percent), zoomy(a.y+a.y2*percent), a.color)
end $$
