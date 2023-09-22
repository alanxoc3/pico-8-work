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

    local row = (num-1)/8\1
    local col = (num-1)%8

    local w, h = 16*sw, 16*sh
    sspr(col*16, row*16, 16, 16, x-w/2, y-h/2, w, h)
end

g_xoff = 0
g_yoff = 0
g_meh = 0
g_scale = 1
function _update()
    if btnp(2) then g_scale += .125 end
    if btnp(3) then g_scale -= .125 end

    g_scale = min(2, max(.125, g_scale))

    if btnp(0) then g_meh = (g_meh - 1) % 4 end
    if btnp(1) then g_meh = (g_meh + 1) % 4 end

    g_xoff = g_meh % 2
    g_yoff = g_meh \ 2
end

function _draw()
    cls()
    --fillp(0b1010010110100101)
    --rectfill(0,0,127,127,0x60)
    --fillp()

    for i=-1,1 do print((g_scale*100).."%", 1+i, 1, 6) end
    for i=-1,1 do print((g_scale*100).."%", 1, 1+i, 6) end
    print((g_scale*100).."%", 1, 1, 0)

    for j=0,3 do
        for i=0,3 do
            local ind  = (j+g_yoff*4)*8+(i+g_xoff*4)+1
            local gap = 16
            local offset = 64-8-16-gap-gap/2
            local sx, sy = offset+i*(16+gap), offset+j*(16+gap)
            --if i == 3 then
              outline(sx, sy, 6, function(x, y)
                outline(x, y, 1, function(x, y)
                  draw_pkmn(ind, x, y, g_scale, g_scale)
                end)
              end)
            --end
            outline(sx, sy, 0, function(x, y)
              draw_pkmn(ind, x, y, g_scale, g_scale)
            end)
            draw_pkmn(ind, sx, sy, g_scale, g_scale)
        end
    end
end
