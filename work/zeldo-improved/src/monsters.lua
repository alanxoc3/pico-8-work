function get_buf_rect(buf_len)
   return {x=g_x+8, y=g_y+8, rx=buf_len, ry=buf_len}
end

function gen_spawner(x, y, func, buf_len, ...)
   local args = {...}
   return acts_attach([[
         $spawner$,,
         {
            x=@,
            y=@,
            child=,
            update=@
         },{$dim$}
      ]], x, y,
      function(a)
         local acol = dim_collide(a, get_buf_rect(buf_len))
         if not a.child and acol then
            a.child = func(a.x, a.y, munpack(args))
         elseif a.child and not acol and not dim_collide(a.child, get_buf_rect(buf_len)) then
            a.child.alive = false
            a.child = nil
         end
      end)
end

function gen_bullet(x, y, xdir)
   return acts_attach([[
      $deku_bullet$,,
      {
         x=@,
         y=@,
         dx=@,
         dy=0,
         rx=.3,
         ry=.3,
         sind=84,
         touchable=false,
         init=@,
         hit=@
      },{$tl$,$timed$,$spr$,$col$}
      ]],
      x, y, xdir and .25 or -.25,
      function(a)
         return tl_init(
            { nil, .5 },
            { function() a.sind = 83 end, .15 },
            { function() a.alive = false end }
         )
      end,
      function(a, other, ...)
         if other.pl then
            other.hurt(.5)
            other.stun(30)
            other.knockback(.3, ...)

            tl_next(a.state, 3)
         end
      end)
end

function gen_deku(x, y, can_turn)
   return acts_attach([[
      $deku$,,
      {
         x=@,
         y=@,
         rx=.5,
         ry=.5,
         sind=59,
         static=true,
         touchable=true,
         init=@
      },
      {$tl$,$timed$,$spr_out$,$col$,$tcol$}
      ]],
      x,y,
      -- init
      function(a)
         return tl_init(
            { nil, nil,
               function()
                  if axis_collide("y", g_pl, a) and (g_pl.x > a.x and a.xf or g_pl.x < a.x and not a.xf) then
                     gen_bullet(a.x, a.y+.125, a.xf)
                     tl_next(a.state)
                     a.xf = g_pl.x < a.x
                  end
               end
            },
            { function() a.xx, a.sind = a.xf and -1 or 1, 4 end, .833 },
            { function() a.sind = 5 end, .833 }
         )
      end)
end

function gen_top(x, y)
   return acts_attach([[
      $hobgoblin$,,
      {
         x=@,
         y=@,
         rx=.375,
         ry=.375,
         iyy=-2,
         xb=.4,
         yb=.4,
         sind=58,
         touchable=true,
         init=@,
         hit=@
      },
      {$tl$,$mov$,$timed$,$spr_out$,$col$,$tcol$,$knockable$}
      ]],x,y,
      -- init
      function(a)
         return tl_init(
            {function() a.ax, a.ay = 0, 0 end, 1.5},
            {nil, .5, function()
               a.xx = rnd_one()
               a.xf = g_pl.x < a.x
            end},
            {function() amov_to_actor(a, g_pl, .05) end, 1}
         )
      end,
      -- hit
      function(a, other, ...)
         if a.state.current == 3 then
            if other.pl then other.hurt(1) other.stun(30) end
            if other.knockable then other.knockback(.2, ...) end

            tl_next(a.state)
         end
      end)
end
