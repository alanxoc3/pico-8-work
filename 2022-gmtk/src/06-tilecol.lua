-- a: vec,box -- b: box --
zclass[[room_bounds,box|x,@,y,@,rx,@,ry,@,tx_off,@,ty_off,@]]

function get_solid_tile(room, index)
    local t2 = room.tiles_2[index]
    if t2 then return fget(t2, 0) and t2 end
    t2 = room.tiles_1[index]
    return fget(t2, 0) and t2
end

zclass[[collidable,box,vec|
    calc_deltas,%calc_deltas,
    should_collide_with_screen_edge,yes,

    adjust_deltas_for_solids,%adjust_deltas_for_solids,
    adjust_deltas_for_tiles, %adjust_deltas_for_tiles,
    adjust_deltas_for_screen,%adjust_deltas_for_screen
]]

|[calc_deltas]| function(a, b)
    local box = {x=b.x-a.dx, y=b.y-a.dy, rx=b.rx, ry=b.ry}
    return a:getdelta(box, a.dx, a.dy)
end $$

|[adjust_deltas_for_solids]| function(a, list)
    foreach(list, function(b)
        local box = {x=b.x-a.dx, y=b.y-a.dy, rx=b.rx, ry=b.ry}
        a.dx, a.dy = a:getdelta(box, a.dx, a.dy)
    end)
end $$

|[adjust_deltas_for_tiles]| function(a)
    for tx=flr(a.x-a.rx)-1,ceil(a.x+a.rx) do
        for ty=flr(a.y-a.ry)-1,ceil(a.y+a.ry) do
            if fget(mget(g_room_bounds.tx_off+tx, g_room_bounds.ty_off+ty), 0) then
                local rx, ry = .5, .5
                a.dx, a.dy = a:calc_deltas{x=tx+.5, y=ty+.5, rx=rx, ry=ry}
            end
        end
    end
end $$

function get_delta_axis2(dx, x, rx, tdx, tdrx)
    local xp = (x-tdx)/tdrx
    if abs(xp)+rx/tdrx > 1 then
        return tdx+sgn(xp)*(tdrx-rx)-(x-dx)
    else
        return dx
    end
end

|[adjust_deltas_for_screen]| function(a)
    if a.should_collide_with_screen_edge then
        local box = {
            x =g_room_bounds.x-a.dx,
            y =g_room_bounds.y-a.dy,
            rx=g_room_bounds.rx,
            ry=g_room_bounds.ry
        }

        a.dx = get_delta_axis2(a.dx, a.x, a.rx, box.x, box.rx)
        a.dy = get_delta_axis2(a.dy, a.y, a.ry, box.y, box.ry)
    end
end $$

zclass[[tcol,vec,box|
   tile_solid,yes,
   tile_hit,nop,
   coll_tile,%tcol_coll_tile
]]

|[tcol_coll_tile]| function(a, solid_func)
   local x, dx = coll_tile_help(a.x, a.y, a.dx, a.rx, a.ry, 0, a, a.tile_hit, solid_func)
   local y, dy = coll_tile_help(a.y, a.x, a.dy, a.ry, a.rx, 2, a, a.tile_hit, function(y, x) return solid_func(x, y) end)
   if a.tile_solid then
      a.x, a.y, a.dx, a.dy = x, y, dx, dy
   end
end $$

function coll_tile_help(pos, per, spd, pos_rad, per_rad, dir, a, hit_func, solid_func)
   local coll_tile_bounds = function(pos, rad)
      return flr(pos - rad), -flr(-(pos + rad)) - 1
   end

   local pos_min, pos_max = coll_tile_bounds(pos + spd, pos_rad)
   local per_min, per_max = coll_tile_bounds(per, per_rad)

   for j=per_min, per_max do
      if spd < 0 and solid_func(pos_min, j) then
         hit_func(a, dir)
         return pos_min + pos_rad + 1, 0
      elseif spd > 0 and solid_func(pos_max, j) then
         hit_func(a, dir+1)
         return pos_max - pos_rad, 0
      end
   end

   return pos, spd
end
