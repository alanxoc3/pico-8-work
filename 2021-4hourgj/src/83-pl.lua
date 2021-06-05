create_actor([[pl;3;drawable,spr,mov,tcol,col,confined,x_bounded,y_bounded|
    x:@1; y:@2;
    xf:no;
    ix:.90; iy:.98;
    touching_ground:no;
    jump_speed:.5;
    sind:108;
    ay:.01;
    u:@4;
    d:@5;
]], function(a)
    a.ax = .02*xbtn()
    if btnp(4) then
        a.dy = -a.jump_speed
    end
end)
