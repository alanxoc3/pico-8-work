zclass[[twinkle,drawlayer_10|
    x,@, y,@, twinkle_offset,@, view,@, star_view,@,
    draw,%twinkle_draw
]]

|[twinkle_draw]| function(a)
    local factor = a.view.zoom_factor/16
    local x = ((-a.star_view.x+a.x)%192)*factor-192/2*factor+64
    local y = ((-a.star_view.y+a.y)%192)*factor-192/2*factor+64
    pset(x, y, sin(time() / 10 + a.twinkle_offset) > 0.5 and 6 or 5)
end $$

zclass[[star_view,vec|
    following, @,
    match_following, %star_view_match_following
]]

|[star_view_match_following]| function(a)
    if a.following then
        a.dx = a.following.dx
        a.dy = a.following.dy
    end
end $$
