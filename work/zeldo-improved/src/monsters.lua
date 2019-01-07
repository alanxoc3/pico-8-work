function get_buf_rect(buf_len)
   return {x=g_x+8, y=g_y+8, rx=buf_len, ry=buf_len}
end

function gen_spawner(x, y, func, buf_len, ...)
   local args = {...}
   return acts_attach("spawner,nil,{x,y,child,update},{@,@,nil,@},{dim}", x, y,
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

function gen_bullet(x, y, dx, dy, lifespan)
   return acts_attach("deku_bullet,nil,{x,y,dx,dy,rx,ry,sind,touchable,init,hit},{@,@,@,@,.3,.3,84,false,@,@},{spr_mid,tl,timed,spr,col}",
      x, y, dx, dy,
      function(a)
         return tl_init(
         { nil, lifespan*.0125 },
         { function() a.sind = 83 end, lifespan*.0042 },
         { function() a.alive = false end }
         )
      end,
      function(a, other)
         if other.pl and a.state.current == 1 then
            local ang = atan2(a.ax, a.ay)
            if other.pl then
               other.dx = .3 * sgn(a.dx)
            end
            tl_next(a.state, 2)
         end
      end)
end

function gen_deku(x, y, can_turn)
   return acts_attach("deku,nil,{x,y,rx,ry,sind,static,touchable,init},{@,@,.6,.6,5,true,true,@},{spr_mid,tl,timed,spr_out,col,tcol}",x,y,
      function(a)
         return tl_init(
            { nil, nil,
               function()
                  if axis_collide("y", g_pl, a) and (g_pl.x > a.x and a.xf or g_pl.x < a.x and not a.xf) then
                     gen_bullet(a.x, a.y+.125, a.xf and .25 or -.25, 0, 40)
                     tl_next(a.state)
                  else
                     a.xf = g_pl.x > a.x
                  end
               end
            },
            { function() a.xx, a.sind = a.xf and -1 or 1, 4 end, .833 },
            { function() a.sind = 5 end, .833 }
         )
      end)
end

function gen_top(x, y)
   -- x, y, init, tile_hit, hit
   return acts_attach("hobgoblin,nil,{x,y,rx,ry,xb,yb,sind,touchable,init,hit},{@,@,.6,.6,.4,.4,4,true,@,@},{spr_mid,tl,mov,timed,spr_out,col,tcol,stunnable}", x, y,
      -- init
      function(a)
         local rand_xxyy = function() a.xx, a.yy = rnd_one(), rnd_one() end
         return tl_init(
         {
            function()
               amov_to_actor(a, g_pl, .05)
               a.hit_other = false
            end, 1, function()
               if a.hit_other then tl_next(a.state) end
            end },
            { function() a.hit_other, a.ax, a.ay = true, 0, 0 end, 1.5},
            { nil, .5, rand_xxyy}
         )
      end,
      -- hit
      function(a, other, ...)
         if other.stunnable and not a.hit_other then
            a.hit_other = true
            if other.pl then other.hurt(1) end
            other.stun(.3, 30, ...)
         end
      end)
end
