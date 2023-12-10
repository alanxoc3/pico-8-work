poke(0x5f2c, 3) -- enable 64x64

-- {dark, light}
color_schemes = {
  {131, 3},
  {  4,   9},
  {141,  14},
  {  1, 140},
  {134,   7},
}

g_color= 0
function _update60()
  if btnp(4) then g_color = (g_color-1)%#color_schemes end
  if btnp(5) then g_color = (g_color+1)%#color_schemes end
end

g_anim=0
function _draw()
  rectfill(0,0,63,63,0)

  for j=-4,4 do
    for i=-4,4 do
      local x, y = i*16+g_anim\1, j*16+8+g_anim\1
      if (j+i) % 2 == 0 then
        local r = j % 2 == 0 and 3 or 5
        if g_color == 0 then
          local r1, r2 = r-2, r+2
          rectfill(x-r1, y-r2, x+r1, y+r2, 6)
          rectfill(x-r2, y-r1, x+r2, y+r1, 6)
        elseif g_color == 1 then
          for l=-3,3 do
            line(x+r+1, y+l, x-r, y+l-r-1, 6)
          end
        elseif g_color == 2 then
          local r1, r2 = r-2, r+2
          ovalfill(x-r1, y-r2, x+r1, y+r2, 6)
          ovalfill(x-r2, y-r1, x+r2, y+r1, 6)
        elseif g_color == 3 then
          circfill(x, y, r, 6)
        elseif g_color == 4 then
          rectfill(x-r, y-r, x+r, y+r, 6)
        end
      end
    end
  end

  for i=1,15 do
    pal(i, color_schemes[g_color+1][2], 1)
  end
  pal(0, color_schemes[g_color+1][1], 1)

  g_anim = (g_anim + .5) % 64
end
