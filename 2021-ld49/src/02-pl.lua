create_actor([[pl;2;drawable,pos,confined,mov,x_bounded,y_bounded|
    x:@1; y:@2;
    
    inertia_x:.95;
    inertia_y:.95;

    d:@3; u:@4;
]], function(a)
    scr_circ(a.x, a.y, .5, 4)
end, function(a)
    a.ax = xbtn()*.01
    a.ay = ybtn()*.01
end)
