poke(0x5f2c, 3)

g_outline_in_progress = false
function outline(x, y, col, func)
  if not g_outline_in_progress then
    g_outline_in_progress = true

    for c=0,15 do pal(c,col) end
    for yy=-1,1 do
      for xx=-1,1 do
        if not (xx == 0 and yy == 0) then
          func(x+xx,y+yy)
        end
      end
    end
    pal()

    g_outline_in_progress = false
  else
    for yy=-1,1 do
      for xx=-1,1 do
        if not (xx == 0 and yy == 0) then
          func(x+xx,y+yy)
        end
      end
    end
  end
end

function draw_pkmn(num, x, y, sw, sh)
    sw = sw or 1
    sh = sh or 1

    local row = num/8\1
    local col = num%8

    local w, h = 16*sw, 16*sh
    sspr(col*16, row*16, 16, 16, x-w/2, y-h/2, w, h)
end

-- {dark, light}
color_schemes = {
  {131, 3},
  -- {  3, 138},
  -- {  0, 131},
  {  4,   9},
  {141,  14},
  {  1, 140},
  {134,   7},
}

g_off = 0
g_scale = 1
view_y = 0
s_x = 0
s_y = 0
g_color=0
function _update()
  local top = 64\3
  if btnp(0) then s_x = mid(0, 2,   s_x-1) end
  if btnp(1) then s_x = mid(0, 2,   s_x+1) end
  if btnp(2) then s_y = mid(0, top, (s_y-1)%(top+1)) end
  if btnp(3) then s_y = mid(0, top, (s_y+1)%(top+1)) end

  if btnp(4) then g_color = (g_color-1)%#color_schemes end
  if btnp(5) then g_color = (g_color+1)%#color_schemes end

  if s_y-2 > view_y then view_y = mid(s_y-2, 0, top) end
  if s_y   < view_y then view_y = mid(s_y,   0, top) end
end

function _draw()
  --fillp(0b1000010110100001)
  rectfill(0,0,63,63,0)
  --fillp()

  for j=0,7 do
    for i=0,7 do
      local ind = j*8 + i
      if ind\3 >= view_y and ind\3 <= view_y+2 then
        local ii = ind % 3
        local jj = ind \ 3 - view_y
        local gap = 4
        local offset = 32-16-gap
        local sx, sy = offset+ii*(16+gap), offset+jj*(16+gap)
        if ind == s_x + s_y*3 then
          outline(sx, sy, 6, function(x, y)
            outline(x, y, 1, function(x, y)
              draw_pkmn(ind, x, y, g_scale, g_scale)
            end)
          end)
        end
        outline(sx, sy, 0, function(x, y)
          draw_pkmn(ind, x, y, g_scale, g_scale)
        end)
        draw_pkmn(ind, sx, sy, g_scale, g_scale)
      end
    end
  end

  for i=1,15 do
    pal(i, color_schemes[g_color+1][2], 1)
  end
  pal(0, color_schemes[g_color+1][1], 1)
end
