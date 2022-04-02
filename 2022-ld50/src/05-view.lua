zclass[[view,vec|
    following, @,
    zoom_factor, 16,
    match_following, %view_match_following
]]

|view_match_following| function(a)
    if a.following then
        local x, y = a.following.x - a.x, a.following.y - a.y
        local dir = atan2(x, y)

        local dist = approx_dist(x, y)
        a.dx = cos(dir)*dist*.25
        a.dy = sin(dir)*dist*.25

        if btn'4' then a.zoom_factor = max(1, a.zoom_factor + 1) end
        if btn'5' then a.zoom_factor = max(1, a.zoom_factor - 1) end
   end
end $$
