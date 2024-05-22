g_cur_pkmn_cry = nil
|[f_minisfx]| function(num) -- plays a sfx with len of 4. num corresponds to pkmn numbers. 252, 253, 254, 255 are sfx.
  if num < 252 then -- we never call this function with -1, so this means it is a cry.
    g_cur_pkmn_cry = num
  end
  sfx(num\4, num < 252 and 0 or 1, num%4*8, 8)
end $$

|[f_draw_pkmn]| function(num, x, y, width, flip, sel, disabled, isoutline)
  -- the "min" is needed to draw trainers
  if not isoutline and stat'46' > -1 and g_cur_pkmn_cry == num then -- if a pkmn cry is currently playing and selected, shake!
    x += sin(g_shake_timer/4)
  end

  local in_c = isoutline and C_3 or sel and C_4 or disabled and C_2 or C_4
  local out_c = disabled and (sel and C_2 or C_3) or sel and C_3 or C_2 --  (sel or disabled) and C_3 or C_2

  if num == P_NONE then
    rectfill(x+width/2-1, y+width/2-1, x+width/2, y+width/2, out_c)
    return
  end

  local row = num/8\1
  local col = num%8
  local scale = max(width\16, 1)

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

    sspr(col*16, row%8*16, 16, 16, ix, iy, width, width, flip, false)

    palt()
    pal()
  end

  for yy=-scale,scale,scale do
    for xx=-scale,scale,scale do
      if not (xx == 0 and yy == 0) then
        colordrawfunc(x+xx, y+yy, out_c)
      end
    end
  end

  colordrawfunc(x, y, in_c) -- sprite

  --clip(-%0x5f28+x, -%0x5f2a+y+5, 16,6)
  --colordrawfunc(x, y, in_c+1) -- sprite
  --clip()
end $$
