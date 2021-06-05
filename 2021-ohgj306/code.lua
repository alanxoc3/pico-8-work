-- neglected bear
-- by alan morgan

function btn_helper(f, a, b)
   return f(a) and f(b) and 0 or f(a) and 0xffff or f(b) and 1 or 0
end

function xbtn() return btn_helper(btn, 0, 1) end
function ybtn() return btn_helper(btn, 2, 3) end

function amov_to_point(a, spd, x, y)
   if abs(x - a.x) < .01 and abs(y - a.y) < .01 then
	spd = 0
   end
   local ang = atan2(x - a.x, y - a.y)
   a.ax, a.ay = spd*cos(ang), spd*sin(ang)
end

music(0)
high_score = 0

text_ind = 1

function _init()
   --0, 1, 2, 3, 4
   score=0
   time=0

   texts = {
      "remember me?",
      "i'm your old teddy bear",
      "you neglected me",
      "now you must die!"
   }

   pl = {
      ax = 0,
      ay = 0,
      dx = 0,
      dy = 0,
      x = 2,
      y = 4,
   }

   enemies = { }
   screen_shake = 0
end

function _update60()
   if t() % .5 == 0 then
       time += 1
       if time % 5 == 0 and text_ind < 5 then
           text_ind += 1
       end
   end

   if text_ind < 5 then
	return
   end

  local speed = .03+15/1500*min(100, score)*1/20
   if t() % .5 == 0 then
         score += 1

	local e1 = {
            x=2,
            y=1.80,
            dx=0,
            dy=speed,
            c=13,
            t=t(),
            r=rnd(3)+3
         }

       local ang = atan2(pl.x - e1.x, pl.y - e1.y)
       e1.dx, e1.dy = speed*cos(ang), speed*sin(ang)
         add(enemies, e1)

   end

   if t() % 8 == 0 then
       e1 = {
            x=-2,
            y=-2,
            dx=0,
            dy=speed*2,
            c=12,
            t=t(),
            r=rnd(4)+3
         }
       local ang = atan2(pl.x - e1.x, pl.y - e1.y)
       e1.dx, e1.dy = speed*cos(ang), speed*sin(ang)
         add(enemies, e1)
  end

   if t() % 8 == 2 then
       e1 = {
            x=7,
            y=-2,
            dx=0,
            dy=speed*2,
            c=12,
            t=t(),
            r=rnd(4)+3
         }
       local ang = atan2(pl.x - e1.x, pl.y - e1.y)
       e1.dx, e1.dy = speed*cos(ang), speed*sin(ang)
         add(enemies, e1)
  end

   if t() % 8 == 4 then
       e1 = {
            x=7,
            y=7,
            dx=0,
            dy=speed*2,
            c=12,
            t=t(),
            r=rnd(4)+3
         }
       local ang = atan2(pl.x - e1.x, pl.y - e1.y)
       e1.dx, e1.dy = speed*cos(ang), speed*sin(ang)
         add(enemies, e1)
  end

   if t() % 8 == 6 then
       e1 = {
            x=-2,
            y=7,
            dx=0,
            dy=speed*2,
            c=12,
            t=t(),
            r=rnd(4)+3
         }
       local ang = atan2(pl.x - e1.x, pl.y - e1.y)
       e1.dx, e1.dy = speed*cos(ang), speed*sin(ang)
         add(enemies, e1)
  end


   foreach(enemies, function(e)
      e.x += e.dx
      e.y += e.dy
      if t() - e.t > 10 then
         del(enemies, e)
      end
   end)

   -- collision
   foreach(enemies, function(e)
      local xdist = pl.x - e.x
      local ydist = pl.y - e.y
      if sqrt(xdist * xdist + ydist * ydist) < 4/20 + e.r/20 then
         screen_shake = 15
      end
   end)

   pl.ax = xbtn()*.01

   pl.ax = xbtn()*.01
   pl.ay = ybtn()*.01

   pl.dx += pl.ax
   pl.dy += pl.ay

   pl.dx *= .9
   pl.dy *= .9


   pl.x += pl.dx
   pl.y += pl.dy


   if abs(pl.dx) > .001 and abs(pl.dx) > abs(pl.dy) then
	pl.horiz = true
   elseif abs(pl.dy) > .001 and abs(pl.dy) > abs(pl.dx) then
	pl.horiz = false
   end

   if pl.x < -.425 then
	pl.x = -.425
   end

   if pl.x > 4.5 then
	pl.x = 4.5
   end

   if pl.y < -.425 then
	pl.y = -.425
   end

   if pl.y > 4.5 then
	pl.y = 4.5
   end

   if screen_shake > 0 then
      screen_shake -= 1
      if screen_shake == 0 then
         if score > high_score then
            high_score = score
         end
         _init()
      end
   end
end


function _draw()
   cls()

   if screen_shake > 0 then
      camera(rnd(2)-1, rnd(2)-1)
   end

   rect(14,14,114,114,2)
   clip(15,15,99,99)

   spr(pl.horiz and 6 or 5, pl.x*20 + 24-4, pl.y*20 + 24-4, 1, 1)
   spr(1, 2*20 + 24-16, 2*20 + 24-16, 4, 4)

   for e in all(enemies) do
       circ(e.x*20 + 24, e.y*20 + 24, e.r, 8)
   end

   if texts[text_ind] then
       print(texts[text_ind], 2*20 + 24 - #texts[text_ind]*2+1, 1*20 + 24 - 12, 7)
   end

   clip()
   camera()

   print("score: "..score, 14, 114+5, 7)
   print("high: "..high_score, 88-4-4, 114+5, 7)
   if text_ind > 4 and  t() % 3 > 2.5 then

   print("neglected bear", 64-14*2 + rnd(3)-1.5, 14-5-5, 8)
   else
   print("neglected bear", 64-14*2 , 14-5-5, 8)
   end

end
