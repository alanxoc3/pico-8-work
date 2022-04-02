function zoomx(x) return (x - g_view.x) * g_view.zoom_factor + 64 end
function zoomy(y) return (y - g_view.y) * g_view.zoom_factor + 64 end

zclass[[model,mov,drawable,actor|
    model;,;
    hit,nop,
    collision_func,%bad_collision_circ,
    draw,%model_draw,
    explode,%model_explode,
    model_init,%model_init
]]

|model_draw| function(a)
    foreach(get_line_coords(a.x, a.y, a.ang, a.model.lines), function(l)
        wobble_line(zoomx(l.x1), zoomy(l.y1), zoomx(l.x2), zoomy(l.y2), l.color)
    end)
end $$

|model_init| function(a, zobj_str)
    a.model = zobj(zobj_str)

    -- create collision rects
    foreach(a.model.collisions or {}, function(collision)
        a.collision_func(a, collision[1], collision[2], collision[3])
    end)
end $$

function get_line_coords(x, y, dir, model_lines)
    local lines = {}
    foreach(model_lines or {}, function(shape)
        for i=2,#shape-2,2 do
            local x1, y1 = shape[i], shape[i+1]
            local x2, y2 = shape[i+2], shape[i+3]
            local ang1, ang2 = atan2(x1, y1), atan2(x2, y2)
            local mag1, mag2 = approx_dist(x1, y1), approx_dist(x2, y2)

            add(lines, { x1=x+cos(ang1+dir)*mag1, y1=y+sin(ang1+dir)*mag1,
                         x2=x+cos(ang2+dir)*mag2, y2=y+sin(ang2+dir)*mag2,
                         color=shape[1] })
        end
    end)
    return lines
end

|model_explode| function(a)
    if a.alive then
        a:kill()

        foreach(get_line_coords(a.x, a.y, a.ang, a.model.lines), function(l)
            local midx, midy = (l.x2-l.x1)/2+l.x1, (l.y2-l.y1)/2+l.y1
            local x1, y1 = l.x1-midx, l.y1-midy
            local x2, y2 = l.x2-midx, l.y2-midy
            _g.line_particle(atan2(midx-a.x, midy-a.y), midx, midy, x1, y1, x2, y2, l.color, a.dx, a.dy)
        end)
    end
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

function wobble_line(x1, y1, x3, y3, color)
    srand(t()*4\1)
    local x2, y2 = (x3-x1)/2+x1+flr_rnd(3)-1, (y3-y1)/2+y1+flr_rnd(3)-1
    line(x1, y1, x2, y2, color)
    line(x2, y2, x3, y3, color)
end
