g_cur_pkmn_cry = nil
|[f_minisfx]| function(num) -- plays a sfx with len of 4. num corresponds to pkmn numbers. 252, 253, 254, 255 are sfx.
  if num < P_NONE then
    g_cur_pkmn_cry = num
  end
  sfx(num\4, num < P_NONE and 0 or 1, num%4*8, 8)
end $$

|[f_flr_rnd]| function(n) return flr(rnd(n)) end $$

|[f_in_split]| function(val, str)
  for m in all(split(str)) do
    if m == val then
      return true
    end
  end
end $$

|[f_roundrect]| function(x1, y1, x2, y2, c)
  rectfill(x1, y1+1, x2, y2-1, c)
  if x2-x1 > 2 then -- if check is for the hp bar, so it looks good when small.
    rectfill(x1+1, y1, x2-1, y2, c)
  end
end $$

|[f_draw_pkmn]| function(num, x, y, style, flip, selected, disabled)
  local in_c  = disabled and C_2 or selected and C_3 or C_2
  local out_c = disabled and C_1 or C_1
  local row = num/8\1
  local col = num%8
  local width = style == STYLE_SMALL and 6 or 16

  if (style ~= STYLE_SHAKE or disabled) and num == P_NONE then
    rectfill(x+width/2-1, y+width/2-1, x+width/2, y+width/2, disabled and C_2 or out_c)
    return
  end

  -- the "min" is needed to draw trainers
  if style == STYLE_SHAKE and selected and not disabled and stat'46' > -1 and g_cur_pkmn_cry == num then -- if a pkmn cry is currently playing and selected, shake!
    x += sin(g_shake_timer/4)
  end

  local row = num/8\1
  local col = num%8
  local width = style == STYLE_SMALL and 6 or 16

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

  for yy=-1,1,1 do
    for xx=-1,1,1 do
      colordrawfunc(x+xx, y+yy, out_c)
    end
  end

  colordrawfunc(x, y, in_c) -- sprite

  --clip(-%0x5f28+x, -%0x5f2a+y+5, 16,6)
  --colordrawfunc(x, y, in_c+1) -- sprite
  --clip()
end $$

-- Turn a string into a question marks with the same length
|[f_strtoq]| function(s)
  local ns = ""
  for i=1,#s do ns ..= "?" end
  return ns
end $$
