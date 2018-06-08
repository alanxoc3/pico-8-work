-- tile-collision module
-- assumes the attachment module

function coll_tile_help(pos, per, spd, pos_rad, per_rad, dir, hit_func, solid_func)
   local coll_tile_bounds = function(pos, rad)
      return flr(pos - rad), -flr(-(pos + rad)) - 1
   end

   local pos_min, pos_max = coll_tile_bounds(pos + spd, pos_rad)
   local per_min, per_max = coll_tile_bounds(per, per_rad)

   for j=per_min, per_max do
      if spd < 0 and solid_func(pos_min, j) then
         hit_func(dir)
         return pos_min + pos_rad + 1, 0
      elseif spd > 0 and solid_func(pos_max, j) then
         hit_func(dir+1)
         return pos_max - pos_rad, 0
      end
   end

   return pos, spd
end

function acts_tcol_attach(a)
   return acts_attach("tcol",  a,
      {"tile_hit", "coll_tile"},

      {nf,
      function(a, solid_func)
         a.x, a.dx = coll_tile_help(a.x, a.y, a.dx, a.w, a.h, 0, a.tile_hit, solid_func)
         a.y, a.dy = coll_tile_help(a.y, a.x, a.dy, a.h, a.w, 2, a.tile_hit, function(y, x) return solid_func(x, y) end)
      end}, acts_vec_attach, acts_dim_attach)
end
