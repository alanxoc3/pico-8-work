g_menu_cursor_timer=0

g_selected=4
g_new_selected=4
g_was_selected=false

-- 0 = bottle
-- 1 = sword
-- 2 = bomb
-- 3 = boomerang
-- 4 = nothing
-- 5 = bow
-- 6 = banjo
-- 7 = shield
-- 8 = triforce

function menu_btn_helper(key_code, expr, add)
   if btnp(key_code) and expr then g_new_selected += add end
end

function menu_update()
   g_menu_open = btn(5)

   if g_menu_open then
      if g_pl.item then g_pl.item.holding = false end

      -- for some reason, negative values don't work here.
      batch_call(menu_btn_helper, "{0,@,0xffff},{1,@,1},{2,@,0xfffd},{3,@,3}", 
         g_new_selected%3 - 1 >= 0,
         g_new_selected%3 + 1 <= 2,
         g_new_selected   - 3 >= 0,
         g_new_selected   + 3 <= 8
      )
      g_was_selected=true
      g_menu_cursor_timer += 1

      if g_menu_cursor_timer % 6 == 0 then
         g_menu_pattern  = rotl(g_menu_pattern, 4)
      end

      if g_menu_cursor_timer % 9 == 0 then
         g_menu_pattern2 = rotr(g_menu_pattern2, 4)
      end
      printh("thing is: "..g_menu_pattern)
   else
      if g_was_selected then
         g_selected, g_new_selected, g_was_selected = g_new_selected, 4, false
      end
   end
end

g_menu_pattern=0b1001001101101100.1001001101101100
-- g_menu_pattern=0x1248.1248
g_menu_pattern2=0x8421
-- todo: make this work if item doesn't exist.
function draw_menu()
   pal()

   fillp(flr(g_menu_pattern)+0b0.1)
   rectfill(0,0,127,127,0x5d)

   rectfill(44,44,83,83,0x1001)
   rectfill(47,47,80,80,5)

   fillp(0x8421)
   rectfill(48,48,79,79,0xd6)
   rectfill(0,0,0,0,0x1000)

   for i=0,2 do
      for j=0,2 do
         local ind, x, y = (i*3 + j), (42 + j * 18), (42 + i * 18)
         local rel_func2 = function(x1, y1, x2, y2, ...)
            rectfill(x+x1,y+y1,x+x2,y+y2,...)
         end

         if ind == g_new_selected then
            batch_call(rel_func2, "{-3,-3,10,10,1}, {-2,-2,9,9,9}, {-2,-2,9,9,9}, {-1,-1,8,8,10}, {-4,-4,-2,-2,1}, {-2,9,-4,11,1}, {11,-4,9,-2,1}, {9,9,11,11,1}")
         else
            batch_call(rel_func2, "{-3,-3,10,10,1}, {-2,-2,9,9,5}, {-2,-2,9,9,5}, {-1,-1,8,8,13}, {-4,-4,-2,-2,1}, {-2,9,-4,11,1}, {11,-4,9,-2,1}, {9,9,11,11,1}")
         end

         if ind == g_new_selected then
            local spr_ind = (g_menu_cursor_timer % 60 > 40) and 68 or 69
            local rel_spr = function(x1, y1, ...) spr(spr_ind, x+x1, y+y1, ...) end
            batch_call(rel_spr, "{-5,-5,1,1,false,false}, {5,-5,1,1,true,false}, {5,5,1,1,true,true}, {-5,5,1,1,false,true}")
         else
            for i=1,15 do pal(i, g_pal_gray[i]) end
         end

         spr(7+ind, x, y)
         pal()
      end
   end
end
