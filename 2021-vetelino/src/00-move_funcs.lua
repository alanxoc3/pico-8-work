function amov_to_actor(a1, a2, spd, off_x, off_y)
   off_x = off_x or 0
   off_y = off_y or 0
   if a1 and a2 then
      amov_to_point(a1, spd, a2.x+off_x, a2.y+off_y)
   end
end

function amov_to_point(a, spd, x, y)
   local ang = atan2(x - a.x, y - a.y)
   a.ax, a.ay = spd*cos(ang), spd*sin(ang)
end

function amov_y(a, spd, y)
    local diff = y - a.y
    local dy = zsgn(diff)*spd
    local _, next_y = a:calc_next_pos(0, dy)
    if zsgn(y - next_y) != zsgn(diff) then
        a.ay = -a.dy + diff/a.iy
    else
        a.ay = dy
    end
end

-- returns true or false
-- function point_in_rect(a, b)
   -- return a.x < b.x+b.rx and a.x > b.x-b.rx and a.y < b.y+b.ry and a.y > b.y-b.ry
-- end
--

function do_actors_intersect(a, b)
   return a and b
      and abs(a.x-b.x) < a.rx+b.rx
      and abs(a.y-b.y) < a.ry+b.ry
end

function does_a_contain_b(a, b)
   return a and b
      and b.x-b.rx >= a.x-a.rx
      and b.x+b.rx <= a.x+a.rx
      and b.y-b.ry >= a.y-a.ry
      and b.y+b.ry <= a.y+a.ry
end

-- tile-collision module
-- assumes the attachment module

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
