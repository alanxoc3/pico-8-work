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

-- w=128, h=512 (4 spritesheets). 16x16 squares
-- this function will simply pack all the spritesheets one after another with a single bit per pixel.
-- better compression ratio to just save the data than trying rle or px9.
function store_pack(vget)
  for y=0,511 do
    for x=0,127,8 do
      local col = 0
      for v=0,7 do
        col = col << 1
        col = col | (vget(x+v, y) > 0 and 1 or 0)
      end
      offsetpoke(col)
    end
  end
end
