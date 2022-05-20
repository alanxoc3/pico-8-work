-- just a position
zclass[[box,pos|
    rx,0, ry,0,
    touching,%box_touching,
    inside,%box_inside,
    outside,%box_outside,
    side,%box_side
]]

|box_touching| function(a, b)
    return not a:outside(b) and not a:inside(b)
end $$

|box_outside| function(a, b)
    local xp, yp, xr, yr = a:side(b)
    return xp < -1-xr or xp > 1+xr or yp < -1-yr or yp > 1+yr
end $$

|box_inside| function(a, b)
    local xp, yp, xr, yr = a:side(b)
    return xp > -1+xr and xp < 1-xr and yp > -1+yr and yp < 1-yr
end $$

|box_side| function(a, b)
    return (a.x-b.x)/b.rx, (a.y-b.y)/b.ry, a.rx/b.rx, a.ry/b.ry
end $$

-- DEBUG_BEGIN
function debug_boxes(a, b)
    local xs, ys = a:side(b)
    printh("in: "   ..(g_pl:inside(g_room_bounds) and "true, " or "false, ")
         .."out: "  ..(g_pl:outside(g_room_bounds) and "true, " or "false, ")
         .."touch: "..(g_pl:touching(g_room_bounds) and "true, " or "false, ")
         .."xs: "   ..xs..", "
         .."ys: "   ..ys..", "
    )
end
-- DEBUG_END
