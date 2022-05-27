zclass[[fairy,actor,mov,drawlayer_50|
    x,@, y,@,
    update,%fairy_update,
    draw,%fairy_draw
]]

|[fairy_update]| function(a)
    local relact = g_rstat_right:get() or g_pl
    local offx, offy = relact.x+(t()\10 % 2 == 0 and 1 or -1)*cos(t()*.75), relact.y+sin(t()*.75)-.25
    a:towards_point(offx, offy)
    a.speed = a:dist_point(offx, offy)*.013
end $$

|[fairy_draw]| function(a)
    for i=-2,2 do
        local m = .125*sgn(i)
        scr_line(a.x+abs(i)\2*m, a.y+i%2*m, a.x-a.dx*6, a.y-a.dy*6, 1)
    end
    scr_pset(a.x,a.y,12)
end $$
