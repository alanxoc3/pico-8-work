cartdata"picodex_preview"
poke(0x5f2c, 3) -- enable 64x64

function _update60()
  if btnp(1) then dset(50, (dget(50)+1)%16) end
  if btnp(0) then dset(50, (dget(50)-1)%16) end
end

function drawpkmn(ind, x, y, w)
  x+=4*w y+=4*w

  for c=1,15 do pal(c,5) end
  for c in all{{w, w}, {w, -w}, {-w, -w}, {-w, w}} do
    sspr(ind%16*8, ind\16*8, 8, 8, x+c[1],y+c[2], 8*w, 8*w)
  end

  for c=1,15 do pal(c,1) end
  for c in all{{0, w}, {w, 0}, {-w, 0}, {0, -w}} do
    sspr(ind%16*8, ind\16*8, 8, 8, x+c[1],y+c[2], 8*w, 8*w)
  end

  pal()
  sspr(ind%16*8, ind\16*8, 8, 8, x,y, 8*w, 8*w)
end

function _draw()
  cls(13)
  for i=0,3 do
    drawpkmn(dget(50)*4+i, i%2*32, i\2*32, 2)
  end
end
