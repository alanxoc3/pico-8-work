|[f_create_cell]| function(...)
  return f_zobj([[
    disabled,@
  ]], ...)
end $$

|[f_create_gridpair]| function(name, first, second, selfunc, leavefunc)
  pair = {}

  for tab in all{first, second} do
    add(pair, f_zobj([[
      num,0, view,0,
      active,@, w,@, len,@, vh,@,
      x,@, y,@,
      cw,@, ch,@,
      selbg,@, bg,@,
      df,@
    ]], unpack(tab)))
  end

  add(pair, selfunc)
  add(pair, leavefunc)

  _g[name] = pair
end $$

-- pass in cell list.
-- each cell has: enabled, text
|[f_update_grid]| function(_ENV)
  if active then
    local evalfunc = function(num, mmin, mmax, b0, b1, l)
      local off = (b1 and l or 0) - (b0 and l or 0)
      local newnum = mid(mmin, min(len-1, mmin+mmax), num + off)
      if newnum == num and off ~= 0 then
        f_minisfx(SFX_ERROR)
      elseif newnum ~= num then
        f_minisfx(SFX_MOVE)
      end
      return newnum
    end

    local prevnum = num
    num = evalfunc(num, 0,     len-1,       btnp'0', btnp'1', 1)
    num = evalfunc(num, num%w, (len-1)\w*w, btnp'2', btnp'3', w)

    if num\w-vh+1 > view then view = (view+1)%((len-vh+1)\w) end
    if num\w           < view then view = (view-1)%((len-vh+1)\w) end
  end
end $$

|[f_draw_grid]| function(_ENV)
  for j=0,vh*w-1 do
    local i = j + view*w
    if i >= len then return end
    local xloc, yloc = x+i%w*cw, y+j\w*ch
    camera(-xloc-1, -yloc-1)

    local l, r, u, d = 0, 0, 0, 0

    if i == 0           then l = 1 u = 1 end
    if i == w-1         then r = 1 u = 1 end
    if i == len-1       then r = 1 d = 1 end
    if i == (len-1)\w*w then l = 1 d = 1 end

    rectfill(-1+l, -1,   cw-2-r, ch-2,   i == num and selbg or bg)
    rectfill(-1,   -1+u, cw-2,   ch-2-d, i == num and selbg or bg)

    -- clip(xloc, yloc, cw, ch) -- camera goes in one, but clip doesn't. dont want to go in for the title screen animation
    df(i, i == num)
    camera()
    -- clip()
  end
end $$
