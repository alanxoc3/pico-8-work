function draw_pkmn(num, x, y, sw, sh)
    sw = sw or 1
    sh = sh or 1

    local row = (num-1)/8\1
    local col = (num-1)%8

    local w, h = 16*sw, 16*sh
    sspr(col*16, row*16, 16, 16, x-w/2, y-h/2, w, h)
end

function draw_pkmn_out(num, x, y, col, orad, prad)
    orad = orad or 1
    prad = prad or 1

    for c=1,15 do pal(c,col) end
    for i=-orad,orad,orad*2 do draw_pkmn(num, x-orad, y+i, prad, prad) end
    for i=-orad,orad,orad*2 do draw_pkmn(num, x+orad, y+i, prad, prad) end

    for c=1,15 do pal(c,1) end
    for i=-orad,orad,orad*2 do draw_pkmn(num, x+i, y, prad, prad) end
    for i=-orad,orad,orad*2 do draw_pkmn(num, x, y+i, prad, prad) end

    for c=1,15 do pal(c, c) end
    draw_pkmn(num, x, y, prad, prad)
end

c_bg_styles = {
    [0]={pc=6,  sc=13}, -- normal
    [1]={pc=13, sc=5},  -- darker/psychic/poison/ghost
    [2]={pc=9,  sc=4},  -- electric/ground
    [3]={pc=11, sc=3},  -- grass
    [4]={pc=12, sc=5},  -- water
    [5]={pc=8,  sc=2},  -- fire
    [6]={pc=10, sc=4},  -- electric/ground
}

g_palette_swap = {
  [0]  = 0, [1]  = 0, [2]  = 0, [3]  = 6,
  [4]  = 6, [5]  = 6, [6]  = 6, [7]  = 6,
  [8]  = 6, [9]  = 6, [10] = 6, [11] = 6,
  [12] = 6, [13] = 6, [14] = 6, [15] = 6,
}

g_xoff = 0
g_yoff = 0
g_meh = 0
g_scale = 1
g_bg = 0
function _update()
    if btnp(4) or btnp(5) then
      for y=0,127 do
        for x=0,127 do
          sset(x, y, g_palette_swap[sget(x, y)])
        end
      end

      cstore(0x0000, 0x0000, 0x2000, "bw.p8")
      cls()
      color(7)
      stop("bw saved to the bw.p8 file")
    end

    if btnp(2) then g_scale += .125 end
    if btnp(3) then g_scale -= .125 end

    g_scale = min(2, max(.125, g_scale))

    if btnp(0) then g_bg  = (g_bg - 1) % 7 end
    if btnp(1) then g_meh = (g_meh + 1) % 4 end

    g_xoff = g_meh % 2
    g_yoff = g_meh \ 2
end

function _draw()
    cls(c_bg_styles[g_bg].pc)
    print(""..g_meh.." | "..(g_scale*100).."% | bg: "..g_bg, 1, 1, c_bg_styles[g_bg].sc)

    for j=0,3 do
        for i=0,3 do
            local xoff = g_xoff*64
            local yoff = g_yoff*64
            local ind  = (j+g_yoff*4)*8+(i+g_xoff*4)+1
            local gap = 16
            local scale = 2
            local offset = 64-8-16-gap-gap/2
            draw_pkmn_out(ind, offset+i*(16+gap), offset+j*(16+gap), c_bg_styles[g_bg].sc, (g_scale == 2) and 2 or 1, g_scale)
        end
    end
end
