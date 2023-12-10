function init() -- entry point for this compile script
  load_sprites("000-063.p8", 0x8000) load_sprites("064-127.p8", 0xa000)
  load_sprites("128-191.p8", 0xc000) load_sprites("192-255.p8", 0xe000)
  store_pack(function(...) return vget(0x8000, ...) end)
  log("Wrote Pokemon Sprites")
end

-- get pixels, but not limited to the graphics data section, can go beyond.
function vget(offset, x, y)
  x = min(max(0, x), 127)\1
  y = y\1

  local val = peek(y*64+offset+x\2)
  if x%2 == 1 then return (val & 0xf0) >>> 4
  else             return (val & 0x0f) end
end

function load_sprites(cartname, dest)
  reload(dest, 0x0000, 0x2000, cartname)
end

function store_pack(vget)
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

      offsetpoke(col)
    end
  end
end
