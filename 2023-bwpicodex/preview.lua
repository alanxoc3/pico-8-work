cartdata"picodex_preview"
cls()
poke(0x5f2c, 3) -- enable 64x64

g_outline_in_progress = false
function outline(x, y, col1, col2, func)
  if not g_outline_in_progress then
    g_outline_in_progress = true

    for c=0,15 do pal(c,col2) end
    for c in all({{1, 1}, {1, -1}, {-1, -1}, {-1, 1}}) do
      func(x+c[1],y+c[2])
    end

    for c=0,15 do pal(c,col1) end
    for c in all({{0, 1}, {1, 0}, {-1, 0}, {0, -1}}) do
      func(x+c[1],y+c[2])
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
           --       0 1   2 3   4   5 6   7 8 9   a b   c  d  e  f
altpalette = {[0]=130,140,2,131,132,5,134,6,8,141,9,139,12,13,14,142}

pkmn_types={
  ghost   ={0x2, 0x0},
  bird    ={0x6, 0x0},
  dark    ={0x9, 0x0},
  poison  ={0x9, 0x0},
  fire    ={0x8, 0x2},
  flying  ={0xf, 0x2},
  psychic ={0xe, 0x2},
  normal  ={0xe, 0x2},
  ice     ={0xc, 0x1},
  water   ={0xc, 0x1},
  grass   ={0xb, 0x3},
  bug     ={0xb, 0x3},
  dragon  ={0xa, 0x4},
  electric={0xa, 0x4},
  fighting={0xf, 0x4},
  ground  ={0xf, 0x4},
  rock    ={0xf, 0x4},
  steel   ={0x6, 0x5},
}

-- a not used
-- 0x0
-- 0x1
-- 0x2
-- 0x3
-- 0x4
-- 0x5
-- 0x6
-- 0x7
-- 0x8
-- 0x9
-- 0xb
-- 0xc
-- 0xe
-- 0xf

pkmn_to_color = {[0]="bird", "grass", "grass", "grass", "fire", "fire", "fire", "water", "water", "water", "bug", "bug", "bug", "bug", "bug", "bug", "flying", "flying", "flying", "normal", "normal", "flying", "flying", "poison", "poison", "electric", "electric", "ground", "ground", "poison", "poison", "poison", "poison", "poison", "poison", "normal", "normal", "fire", "fire", "normal", "normal", "poison", "poison", "grass", "grass", "grass", "bug", "bug", "poison", "poison", "ground", "ground", "normal", "normal", "water", "water", "fighting", "fighting", "fire", "fire", "water", "water", "water", "psychic", "psychic", "psychic", "fighting", "fighting", "fighting", "grass", "grass", "grass", "water", "water", "rock", "rock", "rock", "fire", "fire", "water", "water", "steel", "steel", "flying", "flying", "flying", "water", "water", "poison", "poison", "water", "water", "ghost", "ghost", "ghost", "rock", "psychic", "psychic", "water", "water", "electric", "electric", "grass", "grass", "ground", "ground", "fighting", "fighting", "normal", "poison", "poison", "ground", "ground", "normal", "grass", "normal", "water", "water", "water", "water", "water", "water", "psychic", "bug", "ice", "electric", "fire", "bug", "normal", "water", "water", "water", "normal", "normal", "water", "electric", "fire", "normal", "rock", "rock", "rock", "rock", "rock", "normal", "ice", "electric", "fire", "dragon", "dragon", "dragon", "psychic", "psychic", "grass", "grass", "grass", "fire", "fire", "fire", "water", "water", "water", "normal", "normal", "flying", "flying", "bug", "bug", "poison", "poison", "poison", "water", "water", "electric", "normal", "normal", "normal", "normal", "psychic", "psychic", "electric", "electric", "electric", "grass", "water", "water", "rock", "water", "grass", "grass", "grass", "normal", "grass", "grass", "bug", "water", "water", "psychic", "dark", "dark", "water", "ghost", "psychic", "psychic", "normal", "bug", "bug", "normal", "ground", "steel", "normal", "normal", "water", "steel", "bug", "fighting", "dark", "normal", "normal", "fire", "fire", "ice", "ice", "water", "water", "water", "ice", "water", "steel", "dark", "dark", "water", "ground", "ground", "normal", "normal", "normal", "fighting", "fighting", "ice", "electric", "fire", "normal", "normal", "electric", "fire", "water", "rock", "rock", "rock", "psychic", "fire", "grass",}

g_loaded_row = 0
function draw_pkmn(num, x, y, sw, sh, highlighted)
  local row = num/8\1
  local col = num%8

  if row ~= g_loaded_row then
    g_loaded_row = row
    -- loaded_row for color
    memcpy(0x0000, 0x8000+0x400*row, 0x400)

    -- loaded_row for monochrome (row below is monochrome for current row)
    memcpy(0x0400, 0x2000+0x400*(row%8), 0x400)

    local shift = row\8
    local bits = 0b10001000 >> shift

    local col = 6
    for i=0,0x400-1 do
      local loc = 0x400+i
      local val = (peek(loc) & bits) << shift
      if (val & 0b00001111) > 0 then val = (val & 0b11110000) | (col        & 0b00001111) end
      if (val & 0b11110000) > 0 then val = (val & 0b00001111) | ((col << 4) & 0b11110000) end
      poke(loc, val)
    end
  end

  sw = sw or 1
  sh = sh or 1

  local iscolor = mydget(num) > 0
  local w, h = 16*sw, 16*sh
  local drawfunc = function(ix, iy)
    sspr(col*16, iscolor and 0 or 16, 16, 16, ix-w/2, iy-h/2, w, h)
  end

  local colordrawfunc = function(ix, iy, c)
    if not iscolor then
      pal(6, c)
      drawfunc(ix, iy)
      pal(6, 6)
    else
      drawfunc(ix, iy)
    end
  end

  if highlighted then
    if iscolor then
      outline(x, y, 7, 13, function(xx, yy)
        outline(xx, yy, 1, 1, drawfunc)
      end)
      outline(x, y, 1, 5, drawfunc)
      colordrawfunc(x, y)
    else

      local c = {6, 1}
      if pkmn_to_color[num] and not iscolor then
        c = pkmn_types[pkmn_to_color[num]]
      end

      outline(x, y, 7, 7, function(xx, yy)
        outline(xx, yy, 1, 1, drawfunc)
      end)
      outline(x, y, c[2], c[2], drawfunc)
      colordrawfunc(x, y, c[1])
    end
  else
    local c = {6, 1}
    if pkmn_to_color[num] and not iscolor then
      c = pkmn_types[pkmn_to_color[num]]
    end

    outline(x, y, c[2], iscolor and 5 or c[2], drawfunc)
    colordrawfunc(x, y, c[1])
  end

  -- if highlighted then
  --   -- rectfill(1+ii*20-1, 1+jj*20-1, 1+ii*20+20+2, 1+jj*20+20+2, 6)
  --   outline(sx, sy, selcol, function(x, y)
  --     outline(x, y, 1, function(x, y)
  --       draw_pkmn(ind, x, y, g_scale, g_scale)
  --     end)
  --   end)
  -- end

  -- if mydget(num) > 0 then
  --   sspr(col*16, 0, 16, 16, x-w/2, y-h/2, w, h)
  -- else
  --   sspr(col*16, 16, 16, 16, x-w/2, y-h/2, w, h)
  -- end
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

function mydget(num) -- 0-255
  num = mid(0, num\1, 255)
  return peek(0x5e00+num)
end

function mydset(num, val) -- 0-255
  num = mid(0, num\1, 255)
  poke(0x5e00+num, val)
end

function vget(offset, x, y)
  x = min(max(0, x), 127)\1
  y = y\1

  local val = peek(y*64+offset+x\2)
  if x%2 == 1 then return (val & 0xf0) >>> 4
  else             return (val & 0x0f) end
end

-- w=128, h=512 (4 spritesheets). 16x16 squares
-- this function will simply pack all the spritesheets one after another with a single bit per pixel.
-- better compression ratio to just save the data than trying rle or px9.
function store_pack(offset, vget)
  for y=0,127 do
    for x=0,127,2 do
      local col = 0

      col = (col << 1) | (vget(x+1, y+128*0) > 0 and 1 or 0)
      col = (col << 1) | (vget(x+1, y+128*1) > 0 and 1 or 0)
      col = (col << 1) | (vget(x+1, y+128*2) > 0 and 1 or 0)
      col = (col << 1) | (vget(x+1, y+128*3) > 0 and 1 or 0)

      col = (col << 1) | (vget(x+0, y+128*0) > 0 and 1 or 0)
      col = (col << 1) | (vget(x+0, y+128*1) > 0 and 1 or 0)
      col = (col << 1) | (vget(x+0, y+128*2) > 0 and 1 or 0)
      col = (col << 1) | (vget(x+0, y+128*3) > 0 and 1 or 0)

      poke(offset, col)
      offset += 1
    end
  end
end

function _init()
  reload(0x8000, 0x0000, 0x2000, "./000-063.p8")
  reload(0xa000, 0x0000, 0x2000, "./064-127.p8")
  reload(0xc000, 0x0000, 0x2000, "./128-191.p8")
  reload(0xe000, 0x0000, 0x2000, "./192-255.p8")

  store_pack(0x2000, function(...) return vget(0x8000, ...) end)

  reload(0x8000, 0x0000, 0x2000, "./color-000-063.p8")
  reload(0xa000, 0x0000, 0x2000, "./color-064-127.p8")
  reload(0xc000, 0x0000, 0x2000, "./color-128-191.p8")
  reload(0xe000, 0x0000, 0x2000, "./color-192-255.p8")
  -- memcpy(0x0000, 0xe000, 0x2000)
  memcpy(0x0000, 0x2000, 0x2000)
end

g_off = 0
g_scale = 1
view_y = mydget(252)
s_x    = mydget(253)
s_y    = mydget(254)
g_color= mydget(255)
function _update60()
  local top = 251\3
  if btnp(0) then s_x = mid(0, 2,   s_x-1) end
  if btnp(1) then s_x = mid(0, 2,   s_x+1) end
  if btnp(2) then s_y = mid(0, top, (s_y-1)%(top+1)) end
  if btnp(3) then s_y = mid(0, top, (s_y+1)%(top+1)) end

  -- if btnp(4) then g_color = (g_color-1)%#color_schemes end
  if btnp(5) then g_color = (g_color+1)%#color_schemes end

  if btnp(4) then
    local ind = s_x + s_y*3
    mydset(ind, mydget(ind) > 0 and 0 or 1)
  end

  if s_y-2 > view_y then view_y = mid(s_y-2, 0, top) end
  if s_y   < view_y then view_y = mid(s_y,   0, top) end

  mydset(252, view_y)
  mydset(253, s_x)
  mydset(254, s_y)
  mydset(255, g_color)
end

-- 13
color_schemes = {
  {1, 13, 6, 7}
  -- {131, 3},
  -- {  3, 138},
  -- {  0, 131},
  -- {  4,   9},
  -- {141,  14},
  -- {  1, 140},
  -- {134,   7},
}

g_anim=0
function _draw()
  -- fillp(0b1000010110100001)
  rectfill(0,0,63,63,13)
  -- fillp()

--   {131, 3},
--   -- {  3, 138},
--   -- {  0, 131},
--   {  4,   9},
--   {141,  14},
--   {  1, 140},
--   {134,   7},

  --fillp()

  -- this is a cool line pattern
  --  for j=-2,7 do
  --    local y = j*16-g_anim\1 +32
  --    for l=0,7 do
  --      line(0, y+l, 127, y-63+l, 6)
  --    end
  --  end

  local patcol = 14
  local selcol = 4
  local outcol = 1
  --for j=-4,4 do
  --  for i=-4,4 do
  --    break
  --    local x, y = i*16+g_anim\1, j*16+8+g_anim\1
  --    if (j+i) % 2 == 0 then
  --      local r = j % 2 == 0 and 3 or 5
  --      if g_color == 0 then
  --        local r1, r2 = r-2, r+2
  --        rectfill(x-r1, y-r2, x+r1, y+r2, patcol)
  --        rectfill(x-r2, y-r1, x+r2, y+r1, patcol)
  --      elseif g_color == 1 then
  --        for l=-3,3 do
  --          line(x+r+1, y+l, x-r, y+l-r-1, patcol)
  --        end
  --      elseif g_color == 2 then
  --        local r1, r2 = r-2, r+2
  --        ovalfill(x-r1, y-r2, x+r1, y+r2, patcol)
  --        ovalfill(x-r2, y-r1, x+r2, y+r1, patcol)
  --      elseif g_color == 3 then
  --        circfill(x, y, r, patcol)
  --      elseif g_color == 4 then
  --        rectfill(x-r, y-r, x+r, y+r, patcol)
  --      end
  --    end
  --  end
  --end

  local has_color = false
  for j=0,31 do
    for i=0,7 do
      local ind = j*8 + i
      if ind\3 >= view_y and ind\3 <= view_y+2 then
        local ii = ind % 3
        local jj = ind \ 3 - view_y
        local gap = 4
        local offset = 32-16-gap
        local sx, sy = offset+ii*(16+gap), offset+jj*(16+gap)
        if mydget(ind) > 0 then has_color = true end
        draw_pkmn(ind, sx, sy, g_scale, g_scale, ind == s_x + s_y*3)
      end
    end
  end

  for i=1,15 do
    -- pal(i, color_schemes[g_color+1][2], 1)
  end
  -- pal(0, color_schemes[g_color+1][1], 1)

  for i=0, 63 do
    pset(i, 63, i%16)
  end

  if not has_color then
    pal(altpalette,1)
  else
    pal({[0]=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}, 1)
  end

  g_anim = (g_anim + .5) % 64
end
