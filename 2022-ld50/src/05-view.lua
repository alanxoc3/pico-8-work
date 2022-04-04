zclass[[view,model|
    following,@,
    model,%VIEW_COLLISION_CIRC,
    scale,5,
    zoom_factor,16,
    zooming,false,
    
    update,%view_update,
    hit,%view_hit,

    match_following, %view_match_following
]]

|view_update| function(a)
    if not a.zooming then
        a.zoom_factor = min(16, a.zoom_factor + .1)
    end
    a.zooming = false
end $$

|view_hit| function(a, other)
    a.zoom_factor = max(12, a.zoom_factor - .1)
    a.zooming = true
end $$

|view_match_following| function(a)
    if a.following then
        local x, y = a.following.x - a.x, a.following.y - a.y
        local dir = atan2(x, y)

        local dist = approx_dist(x, y)
        a.dx = cos(dir)*dist*.25
        a.dy = sin(dir)*dist*.25

        -- DEBUG_BEGIN
        if g_debug then
            if btn'4' then a.zoom_factor = min(20, a.zoom_factor + 1) end
            if btn'5' then a.zoom_factor = max(8,  a.zoom_factor - 1) end
        end
        -- DEBUG_END
   end
end $$
