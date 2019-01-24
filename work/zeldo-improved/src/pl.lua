function btn_to_dir()
   return (btn(0) and 0b0001 or 0) +
          (btn(1) and 0b0010 or 0) +
          (btn(2) and 0b0100 or 0) +
          (btn(3) and 0b1000 or 0)
end

g_item = nil
function gen_pl(x, y)
   return acts_attach(
      [[pl,nil,
         {
            x=@,
            y=@,
            sinds={#54, #55, #56, #57},
            rx=#.375,
            ry=#.375,
            iyy=#-2,
            spd=#.02,
            anim_len=#3,
            anim_spd=#5,
            hit=@,
            max_hearts=#7,
            hearts=#3,
            update=@
         },{spr_top,anim,col,mov,tcol,hurtable,knockable,stunnable,spr_out}
      ]], x, y,
      function(self, other, xdir, ydir)
      end, function(a)
         -- movement logic
         if a.stun_countdown == 0 then
            if not (btn(0) and btn(1)) then
               if btn(0) then
                  if not a.item then a.xf = true end
                  a.ax = -a.spd
               elseif btn(1) then
                  if not a.item then a.xf = false end
                  a.ax =  a.spd
               else a.ax = 0 end
            else
               a.ax = 0
            end

            if btn(2) then a.ay = -a.spd end
            if btn(3) then a.ay =  a.spd end
            if not (btn(2) or btn(3)) or btn(2) and btn(3) then a.ay = 0 end
         end

         -- item logic
         if btn(4) and not a.item then
            a.item = gen_pl_item(a, g_selected)
            if g_selected == 4 then -- speed up!
               a.ax *= 1.6 a.ay *= 1.6
            end
         end

         local item = a.item
         if (not btn(4) or btn(5)) then
            if item then item.holding = false end
         end

         if item then
            if item.movable then
               a.ax /= 2 a.ay /= 2
            else
               a.ax, a.ay = 0, 0
            end

         end

         a.anim_sind = item and item.lank_banjo and (btn(0) or btn(1) or btn(2) or btn(3)) and 57

         -- walking animation logic
         if flr((abs(a.dx) + abs(a.dy))*50) > 0 then
            a.anim_len = 3
         else
            a.anim_len = 1
         end

         -- shaking logic
         if a.stun_countdown != 0 then
            if a.item then
               a.item.xx = a.xx
            end
         end
      end)
end

function gen_pl_item(pl, item_type)
   if item_type == 1 then
      return acts_attach([[
         lank_sword,nil,
         {
            movable=true,
            holding=true,
            rx=.5,
            ry=.375,
            rel_y=#-.125,
            iyy=#-1,
            sind=8,
            xf=@,
            touchable=false,
            init=@,
            hit=@
         },{spr_top,rel,tl,timed,spr,col}
         ]],
         pl.xf,
         function(a)
            return tl_init(
            { function() 
                  a.rel_dx = a.xf and -.125 or .125
               end, .4,
               function()
                  local neg_one = -1
                  if abs(a.rel_dx + a.rel_x) > 1 then
                     a.rel_dx, a.rel_x = 0, a.xf and neg_one or 1
                  else
                     a.rel_x += a.rel_dx
                  end
               end
            },
            { nil, nil, function()
               if not a.holding then
                  a.alive, pl.item = false
               end
            end }
            )
         end, function(a, other)
            if not other.pl then
               if other.knockable then other.knockback(.4, a.xf and -1 or 1, 0) end
               if other.stunnable then other.stun(30) end
               if other.hurtable  then other.hurt(.5) end
            end
         end)

   elseif item_type == 0 then
      return acts_attach([[
         lank_banjo,nil,
         {
            holding=true,
            rx=.3,
            ry=.3,
            sind=7,
            xf=@,
            touchable=false,
            init=@
         },{spr_top,rel,tl,timed,spr,col}
         ]],
         pl.xf,
         function(a)
            return tl_init(
            { function() 
               a.rel_x=a.xf and 1/8 or -1/8
            end, nil,
            function()
               if not a.holding then
                  a.alive, pl.item = false
               end
            end  }
            )
         end)

   elseif item_type == 7 then
      return acts_attach([[
         lank_shield,nil,
         {
            movable=true,
            holding=true,
            rx=.25,
            ry=.5,
            iyy=#-2,
            sind=65,
            xf=@,
            touchable=false,
            init=@
         },{spr_top,rel,tl,timed,spr,col}
      ]],
         pl.xf,
         function(a)
            return tl_init(
            { function() 
               a.rel_x = a.xf and -.625 or .625
               a.ixx = a.xf and -2 or 2
            end, nil,
            function()
               if not a.holding then
                  a.alive, pl.item = false
               end
            end  }
            )
         end)
   else
      return nil
   end
end
