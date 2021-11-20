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
