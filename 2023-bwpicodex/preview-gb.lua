cls()
poke(0x5f2c, 3) -- enable 64x64
-- poke(0x5f5c, 255) -- never repeat btnp

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

    pal(0)

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

pkmn_types={ -- 0xd and 0x8 are unused
  fighting={0x1, 0x0},
  rock    ={0x1, 0x0},
  ghost   ={0x8, 0x0},
  poison  ={0x2, 0x0},
  ground  ={0x3, 0x0},
  bug     ={0x4, 0x0},
  dark    ={0x5, 0x0},
  steel   ={0x6, 0x0},
  normal  ={0x7, 0x0},
  bird    ={0x7, 0x0},
  fire    ={0x9, 0x0},
  electric={0xa, 0x0},
  grass   ={0xb, 0x0},
  ice     ={0xc, 0x0},
  water   ={0xc, 0x0},
  psychic ={0xe, 0x0},
  flying  ={0xf, 0x0},
  dragon  ={0xf, 0x0},
}

g_loaded_row = 0
function load_pkmn(num)
  local row = num/8\1
  local col = num%8

  if row ~= g_loaded_row then
    g_loaded_row = row
    -- loaded_row for monochrome (row below is monochrome for current row)
    memcpy(0x0400, 0x2000+0x400*(row%8), 0x400)

    local shift = row\8
    local bits = 0b10001000 >> shift

    local col = 6 -- set all pixels to one color... this may not actually be needed, but whatever
    for i=0,0x400-1 do
      local loc = 0x400+i
      local val = (peek(loc) & bits) << shift
      if (val & 0b00001111) > 0 then val = (val & 0b11110000) | (col        & 0b00001111) end
      if (val & 0b11110000) > 0 then val = (val & 0b00001111) | ((col << 4) & 0b11110000) end
      poke(loc, val)
    end
  end
end

function draw_pkmn(num, x, y, sw, sh, highlighted, is_draft)
  local row = num/8\1
  local col = num%8

  load_pkmn(num)

  sw = sw or 1
  sh = sh or 1

  local w, h = 16*sw, 16*sh
  local drawfunc = function(ix, iy)
    local yoff = is_draft and 32 or 0
    sspr(col*16, yoff + 16, 16, 16, ix-w/2, iy-h/2, w, h)
  end

  local colordrawfunc = function(ix, iy, c)
    pal(6, c)
    drawfunc(ix, iy)
    pal(6, 6)
  end

  if highlighted then
    outline(x, y, 2, 1, function(xx, yy) -- light outline
      outline(xx, yy, 1, 1, drawfunc)
    end)

    outline(x, y, 5, 5, drawfunc) -- dark outline
    colordrawfunc(x, y, 3) -- sprite
  else
    outline(x, y, 6, 6, drawfunc)
    colordrawfunc(x, y, 1)
  end
end

-- {dark, light}
function mydget(num) -- 0-255
  num = mid(0, num\1, 255)
  return peek(0x5e00+num)
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

function reload_sprites()
  reload(0x8000, 0x0000, 0x2000, "./000-063.p8")
  reload(0xa000, 0x0000, 0x2000, "./064-127.p8")
  reload(0xc000, 0x0000, 0x2000, "./128-191.p8")
  reload(0xe000, 0x0000, 0x2000, "./192-255.p8")

  store_pack(0x2000, function(...) return vget(0x8000, ...) end)

  g_loaded_row = -1
end

g_maxnum = 255

function _init()
  reload_sprites()
end

cols = {
  {1,   131, 3,   139, 11},
  {130, 132, 4,   143, 15},
  {129, 1,   140, 12,  12},
  {133, 5,   13,  6,   7},
}

cols_ind = 0
g_off = 0
g_scale = 1
view_y = 0
g_num  = 0
function _update60()
  local top = (g_maxnum-1)\3 -- 253, includes substitute/empty/?

  if btnp(0) then g_num = (g_num-1)%g_maxnum end
  if btnp(1) then g_num = (g_num+1)%g_maxnum end
  if btnp(2) then g_num = (g_num-3)%g_maxnum end
  if btnp(3) then g_num = (g_num+3)%g_maxnum end

  if btnp(4) then
    cols_ind = (cols_ind - 1)%#cols
  end
  if btnp(5) then
    cols_ind = (cols_ind + 1)%#cols
  end

  if g_num\3-2 > view_y then view_y = mid(g_num\3-2, 0, top) end
  if g_num\3   < view_y then view_y = mid(g_num\3,   0, top) end
end

poke(0x5f5f,0x10) -- allow pallette setting for sections of screen
function _draw()
  memset(0x5f70, 0, 16) -- enable secondary pallette for all lines
  rectfill(0,-1,63,63,0)
  camera(0,-1)

  rectfill(1,1,62,42,0x01)
  pset(1,1,0)
  pset(62,1,0)
  pset(62,42,0)
  pset(1,42,0)

  rectfill(0,scannum2-6,63,scannum2-2,1)
  rectfill(0,scannum2-5,63,scannum2-3,7)
  rectfill(0,64-scannum+15,63,64-scannum+5,1)
  rectfill(0,64-scannum+12,63,64-scannum+8,7)

  local x_gap,    y_gap = 4, 4
  local x_offset, y_offset = 32-16-x_gap, 32-16-y_gap

  for j=0,32 do
    for i=0,7 do
      local ind = j*8 + i
      if ind\3 >= view_y and ind\3 <= view_y+2 then
        local ii = ind % 3
        local jj = ind \ 3 - view_y
        local sx, sy = x_offset+ii*(16+x_gap), y_offset+jj*(16+y_gap)

        draw_pkmn(ind, sx, sy, g_scale, g_scale, ind == g_num)
      end
    end
  end

  local chance2 = flr(rnd()*(60))
  local one, two = 0xaa, 0x55
  for i=0,7 do poke(0x5f70+i,0b10101010) end
  --rectfill(0,scannum2-4,63,scannum2-4,7)
  scannum += 3
  scannum %= 64+20+1
  scannum2 += 1
  scannum2 %= 64+8+1

  rectfill(0, 43, 63, 63, 0)
--  rectfill(0, 44, 63, 44, 6)

  local texts = {
    { "bulbasaur",
      "uses leechsed" },
    { "bulbasaur",
      "super efective" },
  }

  local r, y, h = 31, 45, 15
  rectfill(31-r+1, y,   32+r-1, y+h,6)
  --rectfill(31-r+1, y+9, 32+r-1, y+h,9)
  pset(31-r+1, y, 0) pset(31-r+1, y+h, 0)
  pset(32+r-1, y, 0) pset(32+r-1, y+h, 0)
  pset(    31-r,y, 0)
  pset(    32+r,y, 0)
  print(texts[t()\1%#texts+1][1],3, y+2,  2)
  print(texts[t()\1%#texts+1][2],3, y+8+1,1)
  -- print(texts[t()\1%#texts+1][3],-2, y+12,9)

  -- another style
  --print("  PICODEX DUAL",   0, 63-5,   10)
  --local r, y, h = 31, 45, 17-5
  --rectfill(31-r+1, y, 32+r-1, y+h,9)
  ----rectfill(31-r+1, y,   32+r-1, y+6,2)
  --pset(31-r+1, y, 0) pset(31-r+1, y+h, 0)
  --pset(32+r-1, y, 0) pset(32+r-1, y+h, 0)
  --pset(    31-r,y, 0)
  --pset(    32+r,y, 0)
  --print("    missingno.", -2, y+1,   6)
  --print("  USES TAKEDOWN",    -2, y+7, 6)

  local col = cols[cols_ind+1]
  pal({[0]=col[1], col[2], col[3], col[4], col[5], col[2], 129, col[3], col[3], col[2], 0}, 2)
  pal({[0]=col[1], col[2], col[3], col[4], col[5], col[2], 129, col[2], col[2], col[2], 0}, 1)
end
scannum = 0
scannum2 = 0
