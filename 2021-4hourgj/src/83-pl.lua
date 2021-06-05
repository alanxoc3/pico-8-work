create_actor([[pl;3;drawable,spr,mov,tcol,col,confined,bounded|
    x:@1; y:@2;
    sw:2;
    xf:no;
    ix:.90; iy:.98;
    touching_ground:no;
    jump_speed:.5;
    sind:6;
    ay:.01;
    u:@4;
    tile_hit:@5;
]], function(a)
    local above_water = a.y < 14

    a.ax = 0
    if above_water then
        a.ax = .02*xbtn()
        if xbtn() > 0 then a.xf = false end
        if xbtn() < 0 then a.xf = true end
        if a.touching_ground and btnp(4)  then
            a.dy = -a.jump_speed
        end
    end
    a.touching_ground = false
end, function(a, dir)
    if dir == 3 then a.touching_ground = true end
end)
