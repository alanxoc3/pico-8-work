-- just a position
zclass[[box,pos|
    rx,0, ry,0,
    touching_point,%box_touching_point
]]

|box_touching_point| function(a, x, y)
    return x > a.x-a.rx and x < a.x+rx and y > a.y-ry and y < a.y+ry
end $$
