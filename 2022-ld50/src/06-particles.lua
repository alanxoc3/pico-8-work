zclass[[twinkle,actor,drawable|
    x,0,y,0,
    draw,%twinkle_draw,
    init,%twinkle_init,
]]

|twinkle_draw| function(a)
    local x = (-g_star_view.x+flr(a.x*g_view.zoom_factor))%128
    local y = (-g_star_view.y+flr(a.y*g_view.zoom_factor))%128
    pset(x, y, sin(time() / 10 + a.twinkle_offset) > 0.5 and 6 or 5)
end $$

|twinkle_init| function(a)
    a.twinkle_offset = rnd()
    a.x = rnd(256)
    a.y = rnd(256)
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
