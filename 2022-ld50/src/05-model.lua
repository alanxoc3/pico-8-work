zclass[[model,mov,actor|
    model_obj;,;
    hit,nop,
    scale,1,
    collision_func,%bad_collision_circ,
    draw,%model_draw,
    explode,%model_explode,
    collide,%model_collide,
    init,%model_init,
    model_init,%model_init
]]

function line_loop(points, color, linefunc)
    for i=1,#points-1,1 do
        local p1, p2 = points[i], points[i+1]
        linefunc(p1.x, p1.y, p2.x, p2.y, color)
    end
end

|model_init| function(a)
    local model = parse_model(a.model_obj, a.scale)

    a.shapes = model.shapes
    a.field_radius = model.field_radius

    -- create collision rects
    a.collisions = {}
    foreach(model.collisions or {}, function(collision)
        a.collision_func(a, collision.x, collision.y, collision.radius)
    end)
end $$

|model_draw| function(a)
    local modelpoints = {}
    foreach(a.shapes, function(shape)
        local points = translate_points(a.x, a.y, a.ang, shape)
        foreach(points, function(point) point.x = zoomx(point.x) point.y = zoomy(point.y) end)
        draw_polygon(points, shape.bg_color)
        add(modelpoints, {c=shape.fg_color, points=points})
    end)

    srand(t()*4\1) -- for nice wobbling
    foreach(modelpoints, function(points)
        line_loop(points.points, points.c, wobble_line)
    end)

    -- DEBUG_BEGIN
    if g_debug and a.field_radius then
        circ(zoomx(a.x), zoomy(a.y), a.field_radius*g_view.zoom_factor, 2)
    end
    -- DEBUG_END
end $$

function parse_model(template, scale, xoffset, yoffset)
    scale = scale or 1
    xoffset = xoffset or 0
    yoffset = yoffset or 0

    local model = {}

    model.shapes = {}
    foreach(template.lines or {}, function(line_components)
        local shape = {fg_color = line_components[1], bg_color = line_components[2]}
        for i=3,#line_components/2\1*2,2 do
            local x, y = line_components[i], line_components[i+1]
            add(shape, {x=(x+xoffset)*scale, y=(y+yoffset)*scale})
        end
        add(model.shapes, shape)
    end)

    model.field_radius = 0
    model.collisions = {}
    foreach(template.collisions or {}, function(collision)
        local x = (collision[1]+xoffset)*scale
        local y = (collision[2]+yoffset)*scale
        local radius = abs(collision[3]*scale)
        model.field_radius = max(model.field_radius, approx_dist(x, y)+radius)
        add(model.collisions, {x=x, y=y, radius=radius})
    end)

    return model
end

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

function translate_points(x, y, dir, shape)
    local points = {}
    foreach(shape, function(p)
        local ang = atan2(p.x, p.y)
        local mag = approx_dist(p.x, p.y)
        add(points, {x=x+cos(ang+dir)*mag, y=y+sin(ang+dir)*mag})
    end)
    return points
end

|model_explode| function(a, duration)
    if a.alive then
        a:kill()
 
        foreach(a.shapes, function(shape)
            local points = translate_points(a.x, a.y, a.ang, shape)
            line_loop(points, shape.fg_color, function(x1, y1, x2, y2, color)
                local midx, midy = (x2-x1)/2+x1, (y2-y1)/2+y1
                x1, y1 = x1-midx, y1-midy
                x2, y2 = x2-midx, y2-midy
                local particle = _g.line_particle(atan2(midx-a.x, midy-a.y), midx, midy, x1, y1, x2, y2, color, a.dx, a.dy)
                if duration then particle.start.duration = duration end
            end)

            _g.vanishing_shape(a.x, a.y, a.dx, a.dy, points, shape.bg_color)
        end)
    end
end $$

zclass[[vanishing_shape,vec,actor,drawable_pre|
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

zclass[[line_particle,vec,actor,drawable_post|
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
