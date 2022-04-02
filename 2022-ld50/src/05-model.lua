function zoomx(x) return (x - g_view.x) * g_view.zoom_factor + 64 end
function zoomy(y) return (y - g_view.y) * g_view.zoom_factor + 64 end

zclass[[model,mov,drawable|
    model;,;
    draw,%model_draw;
]]
|model_draw| function(a)
    local dir = a.ang
    local x, y = a.x, a.y
    foreach(a.model, function(shape)
        local shape_type = shape[1]

        if shape_type == 'lines' then
            for i=3,#shape-2,2 do
                local x1, y1 = shape[i], shape[i+1]
                local x2, y2 = shape[i+2], shape[i+3]
                local ang1, ang2 = atan2(x1, y1), atan2(x2, y2)
                local mag1, mag2 = approx_dist(x1, y1), approx_dist(x2, y2)

                line(
                    zoomx(x+cos(ang1+dir)*mag1), zoomy(y+sin(ang1+dir)*mag1),
                    zoomx(x+cos(ang2+dir)*mag2), zoomy(y+sin(ang2+dir)*mag2), shape[2]
                )
            end
        end
    end)
end $$
