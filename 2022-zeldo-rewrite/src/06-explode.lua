zclass[[explode,actor,drawlayer_50|
    x,@, y,@, len,@, mod,@, destroyed,@, draw,%explode_draw;
    start; duration, .25;
]]

|[explode_draw]| function(a)
    for i=0,a.len-1 do
        scr_zrect(a.x+sin(a:get_elapsed_percent'start'/2)*cos(i/a.len+.125), a.y+sin(a:get_elapsed_percent'start'/2)*sin(i/a.len+.125), i%a.mod*.125+.125, i%a.mod*.125+.125, 1)
    end
end $$
