zclass[[explode,actor,drawlayer_50|
    x,@, y,@, draw,%explode_draw;
    start; duration, .25;
]]

|[explode_draw]| function(a)
    for i=0,7 do
        scr_zrect(a.x+sin(a:get_elapsed_percent'start'/2)*cos(i/8+.125), a.y+sin(a:get_elapsed_percent'start'/2)*sin(i/8+.125), i%2*.125+.125, i%2*.125+.125, 1)
    end
end $$
