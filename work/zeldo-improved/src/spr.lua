function restore_pal()
   for i=1,15 do pal(i,g_pal[i]) end
end

-- this is zeldo specific
-- function scr_spr10(a)
   -- sspr(
      -- 48+a.sind%8*10,
      -- 24+flr(a.sind/8)*10,
      -- 10, 10,
      -- scr_x(a.x-a.sw*.625)+a.xx,
      -- scr_y(a.y-a.sh*.625)+a.yy,
      -- 10, 10,
      -- a.xf,
      -- a.yf
   -- )
-- end

function scr_spr(a)
   spr(a.sind, scr_x(a.x-a.sw*.5)+a.xx, scr_y(a.y-a.sh*.5)+a.yy, a.sw, a.sh, a.xf, a.yf)
end

function outline_sprite(a)
   -- reset palette to black
   for c=1,15 do
      pal(c,col_outline)
   end
   -- draw outline
   for xx=-1,1 do
      for yy=-1,1 do
         spr(a.sind, scr_x(a.x-a.sw*.5)+a.xx+xx, scr_y(a.y-a.sh*.5)+a.yy+yy, a.sw, a.sh, a.xf, a.yf)
      end
   end
   -- reset palette
   pal()
   -- draw final sprite
   spr(a.sind, scr_x(a.x-a.sw*.5)+a.xx, scr_y(a.y-a.sh*.5)+a.yy, a.sw, a.sh, a.xf, a.yf)
end

g_spr_out_cache = {}
function gen_sprite_outline(a)
   -- {10, 10, 20, 20, 1},
   -- {10, 10, 20, 20, 1},
   -- {10, 10, 20, 20, 1},
   -- {10, 10, 20, 20, 1},
   -- {10, 10, 20, 20, 1},
   -- {10, 10, 20, 20, 1},
   local sind = a.sind
   if not g_spr_out_cache[sind] then
      local sx, sy = (sind % 16)*8, (flr(sind / 16))*8
      g_spr_out_cache[sind] = {}
      local pre_out = {}

      for col=0,7 do
         local top, bot = 0, 0
         for i=0,7 do
            if sget(sx+col,sy+i) != 0 then
               top = i-1
               break
            end
         end

         for i=7,0,-1 do
            if sget(sx+col,sy+i) != 0 then
               bot = i+1
               break
            end
         end

         add(pre_out, {top, bot})
      end

      pre_out[0] = {10, 0}
      pre_out[9] = {10, 0}
      for i=1,8 do
         local new_out = {}

         new_out[1] = min(min(pre_out[i-1][1], pre_out[i][1]), pre_out[i+1][1])
         new_out[2] = max(max(pre_out[i-1][2], pre_out[i][2]), pre_out[i+1][2])

         add(g_spr_out_cache[sind], {i-1,new_out[1],i-1,new_out[2],1})

         if i == 1 then
            new_out[1] = min(pre_out[i-1][1], pre_out[i][1])
            new_out[2] = max(pre_out[i-1][2], pre_out[i][2])
            add(g_spr_out_cache[sind], {-1,new_out[1],-1,new_out[2],1})
         end

         if i == 8 then
            new_out[1] = min(pre_out[i+1][1], pre_out[i][1])
            new_out[2] = max(pre_out[i+1][2], pre_out[i][2])
            add(g_spr_out_cache[sind], {8,new_out[1],8,new_out[2],1})
         end
      end
   end

   local x = scr_x(a.x-a.sw*.5)+a.xx
   local y = scr_y(a.y-a.sh*.5)+a.yy
   for i=1,#g_spr_out_cache[sind] do
      rectfill(x+g_spr_out_cache[sind][i][1],y+g_spr_out_cache[sind][i][2],x+g_spr_out_cache[sind][i][3],y+g_spr_out_cache[sind][i][4],g_spr_out_cache[sind][i][5])
   end

   spr(a.sind, scr_x(a.x-a.sw*.5)+a.xx, scr_y(a.y-a.sh*.5)+a.yy, a.sw, a.sh, a.xf, a.yf)
end


-- .2604 (bad outline)
-- .2537 (working on outline, should get to be smaller).
-- .2388 (no outline)
