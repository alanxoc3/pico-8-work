|[f_minisfx]| function(num) -- plays a sfx with len of 4. num corresponds to pkmn numbers. 252, 253, 254, 255 are sfx.
  sfx(num\4, num < 252 and 0 or 1, num%4*8, 8)
end $$

|[f_draw_pkmn]| function(num, x, y, out_c, in_c, flip)
  local row = num/8\1
  local col = num%8

  local masks = {8, 4, 2, 1}
  local colordrawfunc = function(ix, iy, c)
    local mask = masks[num\64+1]
    for i=1,15 do
      if i & mask == 0 then
        palt(i, true)
      else
        pal(i, c)
      end
    end
    palt(mask, false)
    pal(mask, c)

    spr(col*2+row%8*32, ix, iy, 2, 2, flip, false)

    palt()
    pal()
  end

  for yy=-1,1 do
    for xx=-1,1 do
      if not (xx == 0 and yy == 0) then
        colordrawfunc(x+xx, y+yy, out_c)
      end
    end
  end

  colordrawfunc(x, y, in_c) -- sprite
end $$
