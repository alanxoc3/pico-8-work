-- 667
cartdata("tweet-pulse")
but,r,score,pl=btn,rnd,0,{"웃",12,x=0,y=0}
things={pl}

-- sound!
poke(12801,26)

function _update60()
   hs=dget(0)
   circ_rad = sin(t())*16
   pl.x += (but(0) and -.5 or but(1) and .5 or 0)
   pl.y += (but(2) and -.5 or but(3) and .5 or 0)
   if t() % 1 == 0 then
      v=r(64)-32
      add(things, {v<0 and "🐱",r(4)+8,x=v+pl.x,y=r(64)-32+pl.y})
      score=score+1
      sfx'0'
   end
   for i=2,#things do
      thing=things[i]
      thing.x+=r(2)-1
      thing.y+=r(2)-1
      if abs(pl.x - thing.x) < circ_rad
      and abs(pl.y - thing.y) < circ_rad then
         things={pl}
         dset(0,score > hs and score or hs)
         score = 0
         break
      end
   end

   -- draw
   cls()
   for avatar in all(things) do
      circ(
         avatar.x-pl.x+60,
         avatar.y-pl.y+62,
         circ_rad/2,
         avatar[2]
      )
      ?avatar[1] or "😐",avatar.x-pl.x+57, avatar.y-pl.y+60, avatar[2]
   end

   y="+"..score.."/"..hs
   ?y, 60-#y*2, 9
end
