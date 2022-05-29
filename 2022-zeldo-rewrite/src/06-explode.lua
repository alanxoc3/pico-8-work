zclass[[explode,actor,drawlayer_50|
    x,@, y,@, draw,%explode_draw;
    start; duration, .25;
]]

|[explode_draw]| function(a)
    if not a:get_elapsed_percent'start' then printh(g_state:get_elapsed_percent'room') printh"NOOO" end
    local percent = a:get_elapsed_percent'start' or 1

    for i=0,7 do
        scr_zrect(a.x+sin(percent/2)*cos(i/8+.125), a.y+sin(percent/2)*sin(i/8+.125), i%2*.125+.125, i%2*.125+.125, 1)
    end
end $$
