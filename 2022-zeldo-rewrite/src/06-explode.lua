zclass[[explode,actor,drawlayer_50|
    x,@, y,@, draw,%explode_draw;
    start; duration, .25;
]]

|[explode_draw]| function(a)
    local percent = a:get_elapsed'start'*4
    for i=0,3 do
        scr_zrect(a.x+percent*cos(i/4+.125), a.y+percent*sin(i/4+.125), .125, .125, 1)
    end
end $$
