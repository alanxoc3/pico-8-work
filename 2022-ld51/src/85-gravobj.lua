|[grav_x_tile_check]| function(a, tx, ty, loc)
    if fget(loc, 0) then
        local tile_box_left  = {x=tx+.125, y=ty, rx=.5, ry=.375}
        local tile_box_right = {x=tx-.125, y=ty, rx=.5, ry=.375}

        if a:touching(tile_box_left) then
            a.touching_left_wall = true
        end

        if a:touching(tile_box_right) then
            a.touching_right_wall = true
        end

        local predx = a.dx
        a.dx, _ = a:getdelta({x=tx, y=ty, rx=.5, ry=.5}, a.dx, 0)
        printh("predx: "..predx.." | dx: "..a.dx)
    end
end $$

|[grav_y_tile_check]| function(a, tx, ty, loc)
    if fget(loc, 0) then
        local tile_box_ground = {x=tx, y=ty-.125, rx=.5, ry=.5}
        if a:touching(tile_box_ground) then
            a.touching_ground = true
        end

        _, a.dy = a:getdelta({x=tx, y=ty, rx=.5, ry=.5}, 0, a.dy)
    elseif fget(loc, 2) then -- slant right
        local b = {x=tx, y=ty, rx=.5, ry=.5}
        local xp, yp, magx, magy = _g.box_side2(a, b)
        if a.dy >= 0 and xp > -(b.rx-a.rx)/magx and xp <= 1 then
            if a.y >= (b.y-(-xp+1)*magy)*8\1/8+.125 then
                a.touching_ground = true
                a.y = (b.y-(-xp+1)*magy)*8\1/8+.125
                a.dy = 0
            end
        end
    elseif fget(loc, 3) then -- platform
        local b = {x=tx, y=ty, rx=.5, ry=.5}
        local xp, yp, magx, magy = _g.box_side2(a, b)
        if not a:is_active'djump' and  abs(xp) <= 1 and a.y <= ty-.5 and a.dy >= 0 then
            _, a.dy = a:getdelta(b, 0, a.dy)
            a.touching_ground = true
        end
    end
end $$
