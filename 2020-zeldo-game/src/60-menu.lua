function change_cur_ma(a)
   g_right_ma_view:change_ma(a)
end

function get_cur_ma()
   return g_right_ma_view.follow_act
end

function draw_bar(x1,y1,x2,y2,num,dem,align,fg,bg)
   -- TODO: Why these 3's?
   if x1 > x2 then x1 -= 3 x2 -= 3 end

   local bar_off = x2-x1-min(num/dem, 1)*(x2-x1)
   if align == 0 then bar_off /= 2 end

   if num > 0 then
      batch_call_new(rectfill, [[
         @1, @2, @1, @4, FG_UI;
         @3, @2, @3, @4, FG_UI;
         @5, @2, @6, @4, @7;
         @5, @4, @6, @4, @8;
      ]], x1, y1, x2, y2,
         ceil(x1+(align >= 0 and bar_off or 0)),
         flr(x2-(align <= 0 and bar_off or 0)),
         fg, bg)
   end
end

function draw_stat(x, y, align, view)
   local xyo, a = x - 10*align, view.follow_act
   if a and a.alive and a.ma_able then
      zprint(a.name or "", xyo, y-10, align, FG_WHITE, BG_WHITE)
      map_draw(view, (x-1)/8, y/8)

      if a.hurtable then
         batch_call_new(draw_bar, [[@1, @2, @3, @4, @5, @6, -1, FG_GREEN, BG_GREEN;]], xyo, y-2, xyo-35*align, y+1, a.health, a.max_health)
         zprint(flr(a.health)..'/'..a.max_health, xyo, y+4, align, FG_WHITE, BG_WHITE)
      elseif a.costable then
         draw_money(xyo, y+4, align, a.cost)
      end
   end
end

function draw_money(x, y, align, amount)
   local amount_str = '0'..amount
   zprint('$'..sub(amount_str, #amount_str-1, #amount_str), x, y, align, FG_WHITE, BG_WHITE)
end

function draw_status()
   if get(g_left_ma_view, [[follow_act;ma_able]]) then
      batch_call_new(draw_money, [[48, 119, -1, @1;]], g_money)
   end

   batch_call_new(draw_bar, [[
      10,3,117,7,@1,MAX_ENERGY,0,FG_RED,BG_RED;
   ]], g_energy)

   -- status panels
   batch_call_new(draw_stat, [[
      13,  115, -1, @1;
      117, 115, 1,  @2;
   ]], g_left_ma_view, g_right_ma_view)
end
