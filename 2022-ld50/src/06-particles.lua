zclass[[twinkle,drawable_pre|
    x,@, y,@, twinkle_offset,@,
    draw,%twinkle_draw
]]

|twinkle_draw| function(a)
    local factor = g_view.zoom_factor/16
    local x = ((-g_star_view.x+a.x)%256)*factor-128*factor+64
    local y = ((-g_star_view.y+a.y)%256)*factor-128*factor+64
    pset(x, y, sin(time() / 10 + a.twinkle_offset) > 0.5 and 6 or 5)
end $$

zclass[[star_view,vec|
    following, @,
    match_following, %star_view_match_following
]]

|star_view_match_following| function(a)
    if a.following then
        a.dx = a.following.dx
        a.dy = a.following.dy
    end
end $$
