zclass[[view,model|
    following,@,
    model,%VIEW_COLLISION_CIRC,
    scale,5,
    zoom_factor,16,
    
    match_following, %view_match_following;

    start;duration,2, next,run;
    run;update,%view_update;
]]

|view_update| function(a)
    a.zoom_factor = max(12, a.zoom_factor - .1)
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
            if btn'4' then a.zoom_factor = min(30, a.zoom_factor + 1) end
            if btn'5' then a.zoom_factor = max(5,  a.zoom_factor - 5) end
        end
        -- DEBUG_END
   end
end $$
