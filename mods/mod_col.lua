-- collision module
-- assumes the attachment module

-- an attachment!
function acts_col_attach (a)
   return acts_attach("col",  a,
      {"static", "solid", "touchable", "xb", "yb", "hit", "tile_hit",
      "move_check"},

      {false,    true,    true,        .1,   .1,   nf,    nf,
      function(a, acts)
         local other_list = {}
         local move_check = function(dx, dy)
            local touched = false

            -- using nested closures :)
            local col_help = function(axis, spd_axis, a, b, pos, spd)
               if spd != 0 and pos < abs(a[axis]-b[axis]) then
                  if a.touchable and b.touchable then
                     v=a[spd_axis] + b[spd_axis]
                     local s_f = function(c) if not c.static then c[spd_axis] = v/2 end end
                     s_f(a) s_f(b)
                     touched = true
                  end

                  other_list[b][axis]=spd>0 and 1 or 0 + spd<0 and 0xffff or 0
               end
            end

            foreach(acts, function(b)
               if a != b then
                  local x,y = abs(a.x+dx-b.x), abs(a.y+dy-b.y)
                  if x < (a.w+b.w) and y < (a.h+b.h) then 
                     if not other_list[b] then other_list[b] = {x=0, y=0} end

                     col_help("x", "dx", a, b, x, dx)
                     col_help("y", "dy", a, b, y, dy)
                  end
               end
            end)

            if touched then
               dx *= -a.xb
               dy *= -a.yb
            end

            return dx + dy
         end

         a.dx = move_check(a.dx, 0)
         a.dy = move_check(0, a.dy)

         -- hitting all the acts in the list.
         -- actor b, dirs d
         for b, d in pairs(other_list) do
            a.hit(a, b,  d.x,  d.y)
            b.hit(b, a, -d.x, -d.y)
         end
      end}, acts_vec_attach, acts_dim_attach)
end
