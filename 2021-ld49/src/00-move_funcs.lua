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
