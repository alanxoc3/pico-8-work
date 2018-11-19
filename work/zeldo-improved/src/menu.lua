g_menu_cursor_timer=0

-- todo: minimize this!!!
-- todo: make this work if item doesn't exist.
function draw_menu()
   batch_call(rectfill, "{44,44,83,83,0x1001}, {47,47,80,80,5}, {48,48,79,79,0x10d6.8421}, {0,0,0,0,0x1000}")

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
            local spr_ind = (g_menu_cursor_timer % 60 > 40) and 26 or 27
            local rel_spr = function(x1, y1, ...) spr(spr_ind, x+x1, y+y1, ...) end
            batch_call(rel_spr, "{-5,-5,1,1,false,false}, {5,-5,1,1,true,false}, {5,5,1,1,true,true}, {-5,5,1,1,false,true}")
         else
            for i=1,15 do pal(i, g_grayscale[i]) end
         end

         spr(7+ind, x, y);
         for i=1,15 do pal(i) end
      end
   end
   g_menu_cursor_timer += 1
end
