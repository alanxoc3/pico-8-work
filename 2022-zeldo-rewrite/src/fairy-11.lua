zclass[[fairy,actor,mov,drawlayer_50|
    x,@, y,@,
    update,%f_fairy_update,
    draw,%f_fairy_draw
]]

|[f_fairy_update]| function(a)
    local relact = g_rstat_right:get() or g_pl
    local offx, offy = relact.x+(t()\10 % 2 == 0 and 1 or -1)*cos(t()*.75), relact.y+sin(t()*.75)-.25
    a:towards_point(offx, offy)
    a.speed = a:dist_point(offx, offy)*.013
end $$

|[f_fairy_draw]| function(a)
    draw_tail(a.x, a.y, a.dx, a.dy, 6)
    scr_pset(a.x,a.y,13)
end $$

function draw_tail(x, y, dx, dy, mult)
    for i=-2,2 do
        local m = .125*sgn(i)
        scr_line(x+abs(i)\2*m, y+i%2*m, x-dx*mult, y-dy*mult, 1)
    end
end
