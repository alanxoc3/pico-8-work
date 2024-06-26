cartdata"picodex_preview"
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
           --       0 1   2 3   4   5 6   7 8 9   a b   c  d  e  f
-- altpalette = {[0]=130,140,2,131,132,5,134,6,8,141,9,139,12,13,14,142}
-- 1, 3, 4
--                0 1   2   3 4   5 6   7 8   9 1011  12 13 14 15
altpalette = {[0]=1,143,136,4,138,5,134,6,141,8,9,139,12,13,14,142}

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

-- pkmn_to_color = {[0]="bird", "grass", "grass", "grass", "fire", "fire", "fire", "water", "water", "water", "bug", "bug", "bug", "bug", "bug", "bug", "flying", "flying", "flying", "normal", "normal", "flying", "flying", "poison", "poison", "electric", "electric", "ground", "ground", "poison", "poison", "poison", "poison", "poison", "poison", "normal", "normal", "fire", "fire", "normal", "normal", "poison", "poison", "grass", "grass", "grass", "bug", "bug", "poison", "poison", "ground", "ground", "normal", "normal", "water", "water", "fighting", "fighting", "fire", "fire", "water", "water", "water", "psychic", "psychic", "psychic", "fighting", "fighting", "fighting", "grass", "grass", "grass", "water", "water", "rock", "rock", "rock", "fire", "fire", "water", "water", "electric", "electric", "flying", "flying", "flying", "water", "water", "poison", "poison", "water", "water", "ghost", "ghost", "ghost", "rock", "psychic", "psychic", "water", "water", "electric", "electric", "grass", "grass", "ground", "ground", "fighting", "fighting", "normal", "poison", "poison", "ground", "ground", "normal", "grass", "normal", "water", "water", "water", "water", "water", "water", "psychic", "bug", "ice", "electric", "fire", "bug", "normal", "water", "water", "water", "normal", "normal", "water", "electric", "fire", "normal", "rock", "rock", "rock", "rock", "rock", "normal", "ice", "electric", "fire", "dragon", "dragon", "dragon", "psychic", "psychic", "grass", "grass", "grass", "fire", "fire", "fire", "water", "water", "water", "normal", "normal", "flying", "flying", "bug", "bug", "poison", "poison", "poison", "water", "water", "electric", "normal", "normal", "normal", "normal", "psychic", "psychic", "electric", "electric", "electric", "grass", "water", "water", "rock", "water", "grass", "grass", "grass", "normal", "grass", "grass", "bug", "water", "water", "psychic", "dark", "dark", "water", "ghost", "psychic", "psychic", "normal", "bug", "bug", "normal", "ground", "steel", "normal", "normal", "water", "steel", "bug", "bug", "dark", "normal", "normal", "fire", "fire", "ice", "ice", "water", "water", "water", "ice", "water", "steel", "dark", "dark", "water", "ground", "ground", "normal", "normal", "normal", "fighting", "fighting", "ice", "electric", "fire", "normal", "normal", "electric", "fire", "water", "rock", "rock", "rock", "psychic", "fire", "grass"}
-- pkmn_to_color = {[0]="bird", "grass", "grass", "grass", "fire", "fire", "fire", "water", "water", "water", "bug", "bug", "bug", "bug", "bug", "bug", "flying", "flying", "flying", "normal", "normal", "flying", "flying", "poison", "poison", "electric", "electric", "ground", "ground", "poison", "poison", "poison", "poison", "poison", "poison", "normal", "normal", "fire", "fire", "normal", "normal", "poison", "poison", "grass", "grass", "grass", "bug", "bug", "poison", "poison", "ground", "ground", "normal", "normal", "water", "water", "fighting", "fighting", "fire", "fire", "water", "water", "water", "psychic", "psychic", "psychic", "fighting", "fighting", "fighting", "grass", "grass", "grass", "water", "water", "rock", "rock", "rock", "fire", "fire", "water", "water", "electric", "electric", "flying", "flying", "flying", "water", "ice", "poison", "poison", "water", "ice", "ghost", "ghost", "ghost", "rock", "psychic", "psychic", "water", "water", "electric", "electric", "grass", "grass", "ground", "ground", "fighting", "fighting", "normal", "poison", "poison", "ground", "ground", "normal", "grass", "normal", "water", "water", "water", "water", "water", "water", "psychic", "bug", "ice", "electric", "fire", "bug", "normal", "water", "water", "ice", "normal", "normal", "water", "electric", "fire", "normal", "rock", "rock", "rock", "rock", "rock", "normal", "ice", "electric", "fire", "dragon", "dragon", "dragon", "psychic", "psychic", "grass", "grass", "grass", "fire", "fire", "fire", "water", "water", "water", "normal", "normal", "flying", "flying", "bug", "bug", "poison", "poison", "poison", "water", "water", "electric", "normal", "normal", "normal", "normal", "psychic", "psychic", "electric", "electric", "electric", "grass", "water", "water", "rock", "water", "grass", "grass", "grass", "normal", "grass", "grass", "bug", "water", "water", "psychic", "dark", "dark", "water", "ghost", "psychic", "psychic", "normal", "bug", "bug", "normal", "ground", "steel", "normal", "normal", "water", "steel", "bug", "bug", "dark", "normal", "normal", "fire", "fire", "ice", "ice", "water", "water", "water", "ice", "water", "steel", "dark", "dark", "water", "ground", "ground", "normal", "normal", "normal", "fighting", "fighting", "ice", "electric", "fire", "normal", "normal", "electric", "fire", "water", "rock", "rock", "rock", "psychic", "fire", "grass"}
pkmn_to_color = {[0]="bird", "grass", "grass", "grass", "fire", "fire", "fire", "water", "water", "water", "bug", "bug", "bug", "bug", "bug", "bug", "flying", "flying", "flying", "normal", "normal", "flying", "flying", "poison", "poison", "electric", "electric", "ground", "ground", "poison", "poison", "poison", "poison", "poison", "poison", "normal", "normal", "fire", "fire", "normal", "normal", "poison", "poison", "grass", "grass", "grass", "bug", "bug", "poison", "poison", "ground", "ground", "normal", "normal", "water", "water", "fighting", "fighting", "fire", "fire", "water", "water", "water", "psychic", "psychic", "psychic", "fighting", "fighting", "fighting", "grass", "grass", "grass", "water", "water", "rock", "rock", "rock", "fire", "fire", "psychic", "psychic", "steel", "steel", "flying", "flying", "flying", "water", "water", "poison", "poison", "water", "water", "ghost", "ghost", "ghost", "rock", "psychic", "psychic", "water", "water", "electric", "electric", "grass", "grass", "ground", "ground", "fighting", "fighting", "normal", "poison", "poison", "ground", "ground", "normal", "grass", "normal", "water", "water", "water", "water", "water", "water", "psychic", "bug", "psychic", "electric", "fire", "bug", "normal", "water", "water", "water", "normal", "normal", "water", "electric", "fire", "normal", "rock", "rock", "rock", "rock", "rock", "normal", "ice", "electric", "fire", "dragon", "dragon", "dragon", "psychic", "psychic", "grass", "grass", "grass", "fire", "fire", "fire", "water", "water", "water", "normal", "normal", "flying", "flying", "bug", "bug", "bug", "bug", "poison", "electric", "electric", "electric", "normal", "normal", "normal", "normal", "psychic", "psychic", "electric", "electric", "electric", "grass", "water", "water", "rock", "water", "grass", "grass", "grass", "normal", "grass", "grass", "bug", "water", "water", "psychic", "dark", "dark", "psychic", "ghost", "psychic", "psychic", "psychic", "bug", "bug", "normal", "ground", "steel", "normal", "normal", "water", "steel", "bug", "bug", "dark", "normal", "normal", "fire", "fire", "ground", "ground", "rock", "water", "water", "flying", "water", "steel", "dark", "dark", "water", "ground", "ground", "normal", "normal", "normal", "fighting", "fighting", "psychic", "electric", "fire", "normal", "normal", "electric", "fire", "water", "rock", "rock", "dark", "psychic", "fire", "grass", "bird", "bird", "bird"}

g_loaded_row = 0
function load_pkmn(num)
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

function load_watchmode_prev(num)
  load_pkmn(num)
  memcpy(0x0800, 0x0000, 0x800) -- copy first 2 rows to 3rd/4th rows
end

function draw_pkmn(num, x, y, sw, sh, highlighted, has_color, is_draft)
  local row = num/8\1
  local col = num%8

  load_pkmn(num)

  sw = sw or 1
  sh = sh or 1

  local w, h = 16*sw, 16*sh
  local drawfunc = function(ix, iy)
    local yoff = is_draft and 32 or 0
    sspr(col*16, yoff + (has_color and 0 or 16), 16, 16, ix-w/2, iy-h/2, w, h)
  end

  local colordrawfunc = function(ix, iy, c)
    if not has_color then
      pal(6, c)
      drawfunc(ix, iy)
      pal(6, 6)
    else
      drawfunc(ix, iy)
    end
  end

  if highlighted then
    if has_color then
      outline(x, y, 6, g_corners and 13 or 6, function(xx, yy)
        outline(xx, yy, 1, 1, drawfunc)
      end)
      outline(x, y, 1, g_corners and 5 or 1, drawfunc)
      colordrawfunc(x, y)
    else
      local c = {6, 1}
      if pkmn_to_color[num] and not has_color then
        -- c = pkmn_types[pkmn_to_color[num]]
      end

      outline(x, y, 7, g_corners and 13 or 7, function(xx, yy)
        outline(xx, yy, 1, 1, drawfunc)
      end)

      outline(x, y, c[2], g_corners and 13 or c[2], drawfunc)
      colordrawfunc(x, y, c[1])
    end
  else
    local c = {6, 1}
    if pkmn_to_color[num] and not has_color then
      -- c = pkmn_types[pkmn_to_color[num]]
    end

    outline(x, y, c[2], has_color and (g_corners and 5 or 1) or (g_corners and 5 or c[2]), drawfunc)
    colordrawfunc(x, y, c[1])
  end
end

-- {dark, light}
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

      col = (col << 1) | (vget(x+1, y+128*0) > 2 and 1 or 0)
      col = (col << 1) | (vget(x+1, y+128*1) > 2 and 1 or 0)
      col = (col << 1) | (vget(x+1, y+128*2) > 2 and 1 or 0)
      col = (col << 1) | (vget(x+1, y+128*3) > 2 and 1 or 0)

      col = (col << 1) | (vget(x+0, y+128*0) > 2 and 1 or 0)
      col = (col << 1) | (vget(x+0, y+128*1) > 2 and 1 or 0)
      col = (col << 1) | (vget(x+0, y+128*2) > 2 and 1 or 0)
      col = (col << 1) | (vget(x+0, y+128*3) > 2 and 1 or 0)

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

  reload(0x8000, 0x0000, 0x2000, "./000-063.p8") -- reload(0x8000, 0x0000, 0x2000, "./color-000-063.p8")
  reload(0xa000, 0x0000, 0x2000, "./064-127.p8") -- reload(0xa000, 0x0000, 0x2000, "./color-064-127.p8")
  reload(0xc000, 0x0000, 0x2000, "./128-191.p8") -- reload(0xc000, 0x0000, 0x2000, "./color-128-191.p8")
  reload(0xe000, 0x0000, 0x2000, "./192-255.p8") -- reload(0xe000, 0x0000, 0x2000, "./color-192-255.p8")

  g_loaded_row = -1
end

g_maxnum = 255
g_corners = false

function _init()
  reload_sprites()

  menuitem(1, "toggle corners", function()
    g_corners = not g_corners
  end)

  menuitem(2, "reset to mono", function()
    for i=0,g_maxnum-1 do mydset(i, 0) end
  end)

  menuitem(3, "reset to color", function()
    for i=0,g_maxnum-1 do mydset(i, 1) end
  end)

  if stat(6) == "shot" then
    local old_g_num = g_num
    local old_g_view = g_view
    g_4_by_7 = true

    for i=0,252-1 do mydset(i, 1) end
    for i=0,252\3\3-1 do
      view_y = i*3
      g_num = -1
      _draw() flip()
      extcmd("set_filename", "col-"..i)
      extcmd("screen")
    end

    for i=0,252-1 do mydset(i, 0) end
    for i=0,252\3\3-1 do
      view_y = i*3
      g_num = -1
      _draw() flip()
      extcmd("set_filename", "bw-"..i)
      extcmd("screen")
    end

    g_num  = old_g_num
    g_view = old_g_view
    cls() flip()
    printh("done: desktop/(col|bw)-*")
    stop("done: desktop/(col|bw)-*")
  end
end

g_off = 0
g_scale = 1
view_y = mydget(254)
g_num  = mydget(255)
watch_mode = false
watch_mode_counter = 0
function _update60()
  local top = (g_maxnum-1)\3 -- 253, includes substitute/empty/?

  if watch_mode then
    watch_mode_counter = (watch_mode_counter + 1) % 60
    if watch_mode_counter == 0 then
      reload_sprites()
    elseif btnp(0) or btnp(1) or btnp(2) or btnp(3) or btnp(4) or btnp(5) then
      watch_mode = false
    end
  else
    if btnp(0) then g_num = (g_num-1)%g_maxnum end
    if btnp(1) then g_num = (g_num+1)%g_maxnum end
    if btnp(2) then g_num = (g_num-3)%g_maxnum end
    if btnp(3) then g_num = (g_num+3)%g_maxnum end
    if btnp(5) and not watch_mode then
      watch_mode = true
      watch_mode_counter = 0
      load_watchmode_prev(g_num)
    end

    if btnp(4) then
      mydset(g_num\3, mydget(g_num\3) > 0 and 0 or 1)
    end
  end

  if g_num\3-2 > view_y then view_y = mid(g_num\3-2, 0, top) end
  if g_num\3   < view_y then view_y = mid(g_num\3,   0, top) end

  mydset(254, view_y)
  mydset(255, g_num)
end

poke(0x5f5f,0x10) -- allow pallette setting for sections of screen
function disable_alt_for_row(row)
  if row == 0 then
    poke(0x5f70, (@0x5f70) | 0b11111110)
    poke(0x5f71, (@0x5f71) | 0b11111111)
    poke(0x5f72, (@0x5f72) | 0b00111111)
  elseif row == 1 then
    poke(0x5f72, (@0x5f72) | 0b11000000)
    poke(0x5f73, (@0x5f73) | 0b11111111)
    poke(0x5f74, (@0x5f74) | 0b11111111)
    poke(0x5f75, (@0x5f75) | 0b00000111)
  elseif row == 2 then
    poke(0x5f75, (@0x5f75) | 0b11111000)
    poke(0x5f76, (@0x5f76) | 0b11111111)
    poke(0x5f77, (@0x5f77) | 0b11111111)
  end
end

pal({[0]=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}, 2)
pal(altpalette,1)

draw_watchmode_flip = true
watchcounter_draw = 0
function _draw()
  memset(0x5f70, 0, 16) -- enable secondary pallette for all lines
  -- fillp(0b1010111110100000)
  rectfill(0,0,63,63,0xd)
  -- fillp()

  local x_gap,    y_gap = 5, 5
  local x_offset, y_offset = 32-16-x_gap, 32-16-y_gap

  if not watch_mode then
    for j=0,32 do
      for i=0,7 do
        local ind = j*8 + i
        if not g_4_by_7 and ind\3 >= view_y and ind\3 <= view_y+2 then
          local ii = ind % 3
          local jj = ind \ 3 - view_y
          local sx, sy = x_offset+ii*(16+x_gap), y_offset+jj*(16+y_gap)
          if mydget(ind\3) > 0 then
            disable_alt_for_row(ind\3 - view_y)
          end

          draw_pkmn(ind, sx, sy, g_scale, g_scale, ind == g_num, mydget(ind\3) > 0)
        elseif g_4_by_7 and ind\3 >= view_y and ind\3 <= view_y+2 then
          local ii = ind % 3
          local jj = ind \ 3 - view_y
          local sx, sy = x_offset+ii*(16+x_gap), y_offset+jj*(16+y_gap)
          if mydget(ind\3) > 0 then
            disable_alt_for_row(ind\3 - view_y)
          end

          -- 0=0 1=1 2=2 9=3 10=4 11=5
          -- 0 12 24
          local corner = ind\36*36
          local subind = ind%36
          local subrow = subind%9\3
          local subgrd = subind\9
          local newind = corner + subrow*12 + subgrd*3 + subind%3

          draw_pkmn(newind, sx, sy, g_scale, g_scale, ind == g_num, mydget(ind\3) > 0)
        end
      end
    end
  else
    local m = function(x, y) return x_offset+x*(16+x_gap) end
    print("WATCH\nl:new\nr:old", 2, 23, 7)

    -- draw_pkmn(g_num, m(0), m(1), g_scale, g_scale, false, false)

    -- draw_pkmn(g_num, m(0), m(2), g_scale, g_scale, true,  draw_watchmode_flip)
    draw_pkmn(g_num, m(1), m(2), g_scale, g_scale, false, true)
    draw_pkmn(g_num, m(2), m(2), g_scale, g_scale, false, true, true)

    draw_pkmn(g_num, m(1), m(1), g_scale, g_scale, false, false)
    draw_pkmn(g_num, m(2), m(1), g_scale, g_scale, false, false, true)

    draw_pkmn(g_num, m(1), m(0), g_scale, g_scale, false, draw_watchmode_flip)
    draw_pkmn(g_num, m(2), m(0), g_scale, g_scale, false, draw_watchmode_flip, true)

    if draw_watchmode_flip then
      -- draw_pkmn(g_num, m(0), m(1), g_scale, g_scale, false, false)
      -- draw_pkmn(g_num, m(1), m(1), g_scale, g_scale, true, false)
      disable_alt_for_row(0)
    end
    disable_alt_for_row(2)

    if watchcounter_draw % 10 == 0 then
      draw_watchmode_flip = not draw_watchmode_flip
    end
    watchcounter_draw = (watchcounter_draw + 1 % 60)
  end

  -- for i=0, 63 do
  --   pset(i, 63, i%16)
  --   pset(63-i, 0, i%16)
  -- end
end
