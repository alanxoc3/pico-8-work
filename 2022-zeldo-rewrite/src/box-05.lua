-- just a position
zclass[[box,pos|
    rx,0, ry,0,
    touching,%box_touching,
    inside,%box_inside,
    outside,%box_outside,
    side,%box_side,
    abside,%box_abside,
    getdelta,%box_getdelta
]]

|[box_touching]| function(a, b)
    return not a:outside(b) and not a:inside(b)
end $$

|[box_outside]| function(a, b)
    local xp, yp, xr, yr = a:side(b)
    return xp <= -1-xr or xp >= 1+xr or yp <= -1-yr or yp >= 1+yr
end $$

|[box_inside]| function(a, b)
    local xp, yp, xr, yr = a:side(b)
    return xp > -1+xr and xp < 1-xr and yp > -1+yr and yp < 1-yr
end $$

|[box_side]| function(a, b)
    return (a.x-b.x)/b.rx, (a.y-b.y)/b.ry, a.rx/b.rx, a.ry/b.ry
end $$

function zsgn(num)
    return num == 0 and 0 or sgn(num)
end

|[box_abside]| function(a, b)
    local xp, yp = a:side(b)
    if abs(yp) > abs(xp)
    then return 0, sgn(yp)
    else return sgn(xp), 0 end
end $$

function get_delta_axis(dx, x, rx, tdx, tdrx)
    local xp = (x-tdx)/tdrx
    return abs(xp)-rx/tdrx < 1 and tdx+sgn(xp)*(rx+tdrx)-(x-dx) or dx
end

|[box_getdelta]| function(a, b, dx, dy)
    local b = {x=b.x-dx, y=b.y-dy, rx=b.rx, ry=b.ry}
    local abx, aby = a:abside(b)
    local xp, yp = a:side(b)

    if not a:outside(b) then
        if abx ~= 0 and zsgn(dx) == -abx then
            dx = get_delta_axis(dx, a.x, a.rx, b.x, b.rx)
        elseif aby ~= 0 and zsgn(dy) == -aby then
            dy = get_delta_axis(dy, a.y, a.ry, b.y, b.ry)

        elseif aby ~= 0 then
            dx = get_delta_axis(dx, a.x, a.rx, b.x, b.rx)
        elseif abx ~= 0 then
            dy = get_delta_axis(dy, a.y, a.ry, b.y, b.ry)
        end
    end

    return dx, dy
end $$
