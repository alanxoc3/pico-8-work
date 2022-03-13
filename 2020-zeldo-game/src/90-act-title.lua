-- 936 chars
-- 824 chars

function spr_and_out(...)
   spr_out(...)
   zspr(...)
end

create_actor([[title;0;above_map_drawable,pos|
   d:@1;
   title_y:0;

   u=@2,;
   u=@3,tl_max_time=.5;
]], function(a)
   camera(-8*8, -7*8)
   -- (str, x, y, alignment, shadow_below)
   batch_call_new(tprint, [[@1, 0, !plus/-17/@2, 10, 4]], "that story about", a.title_y)

   for i=-2,2 do
      spr_and_out(226+i, i*10, cos(t()/2+i/4)/2+1+a.title_y, 1, 2, false, false, 1)
   end

   if ti(1,.5) and a.title_y == 0 then
      batch_call_new(tprint, [[@1, 0, 12, 7, 5]], "🅾️ or ❎ to play  ")
   end

   camera()
end, function(a)
   if btnp'4' or btnp'5' then
      a:next()
      g_pl = _g.pl(a.x, a.y)
      g_left_ma_view = _g.view(2.75, 3, 0, g_pl)
   end
end, function(a)
   a.title_y = cos(a.tl_tim/a.tl_max_time/4)*75-75
end)
