|[f_create_gridpair]| function(name, first, second, first_obj, second_obj)
  local pair = {}

  for tab in all{first, second} do
    add(pair, f_zobj([[
      num,0, view,0,
      active,@, vert,@, w,@, vh,@,
      x,@, y,@,
      cw,@, ch,@,
      df,@, lrfunc,@,
      selfunc,@, leavefunc,@, updatefunc,@
    ]], unpack(tab)))
  end

  add(pair, first_obj)
  add(pair, second_obj)

  _g[name] = pair
end $$

-- pass in cell list.
-- each cell has: enabled, text
|[f_update_grid]| function(_ENV, gridobj)
  updatefunc()
  if active then
    local evalfunc = function(num, mmin, mmax, b0, b1, l)
      local off = (b1 and l or 0) - (b0 and l or 0)
      local newnum = mid(mmin, min(#gridobj-1, mmin+mmax), num + off)
      if newnum == num and off ~= 0 then
        f_minisfx(SFX_ERROR)
      elseif newnum ~= num then
        -- if gridobj[newnum+1].header then
          -- f_minisfx(SFX_ERROR)
          -- return num
        -- end
        f_minisfx(SFX_MOVE)
      end
      return newnum
    end

    local prevnum = num
    if vert then
      num = -1
      local off = (btnp'3' and 1 or 0) - (btnp'2' and 1 or 0)

      local prevview = view
      view = mid(0, view+off, (#gridobj-1)\w-vh+1)
      if view == prevview and off ~= 0 then
        f_minisfx(SFX_ERROR)
      elseif off ~= 0 then
        f_minisfx(SFX_MOVE)
      end

      lrfunc((btnp'1' and 1 or 0) - (btnp'0' and 1 or 0))
    else
      num = evalfunc(num, 0,     #gridobj-1,       btnp'0', btnp'1', 1)
      num = evalfunc(num, num%w, (#gridobj-1)\w*w, btnp'2', btnp'3', w)

      if num\w-vh+1 > view then view = num\w-vh+1 end
      if num\w      < view then view = num\w      end
      view = mid(0, view, (#gridobj-1)\w-vh+1)
    end

    if btnp'4' then
      f_minisfx(leavefunc() or SFX_LEAVE)
    elseif btnp'5' then
      if (num < 0 or not gridobj[num+1].disabled) then
        f_minisfx(selfunc() or SFX_SELECT)
      else
        f_minisfx(SFX_ERROR)
      end
    end
  end
end $$

|[f_draw_grid]| function(_ENV, gridobj, x, y)
  clip(x, y, w*cw, vh*ch)

  for j=0,vh*w-1 do
    local i = j + view*w
    local isheader = gridobj[i\w*w+1].header
    local isnumheader = isheader and (num\w == i\w)
    local obj = gridobj[i+1]
    if i >= #gridobj then break end
    local xloc, yloc = x+i%w*cw, y+j\w*ch
    camera(-xloc-1, -yloc-1)

    local l, r, u, d = 0, 0, 0, 0

    if i == 0                then l = 1 u = 1 end
    if i == w-1              then r = 1 u = 1 end
    if i == #gridobj-1       then r = 1 d = 1 end
    if i == (#gridobj-1)\w*w then l = 1 d = 1 end

    local c = C_2
    if i ~= num and (obj.disabled or isheader) then
      c = C_1
    end

    if active and (i == num or isnumheader) then
      if obj.disabled or isnumheader then
        c = C_3
      else
        c = C_3
      end
    end

    rectfill(-1+l, -1,   cw-2-r, ch-2,   c)
    rectfill(-1,   -1+u, cw-2,   ch-2-d, c)
  end

  for j=0,vh*w-1 do
    local i = j + view*w
    local obj = gridobj[i+1]
    local isheader = gridobj[i\w*w+1].header
    local isnumheader = isheader and (num\w == i\w)
    if i >= #gridobj then break end
    local xloc, yloc = x+i%w*cw, y+j\w*ch
    camera(-xloc-1, -yloc-1)

    local c = C_1
    if i == num and not isnumheader then
      c = C_2
    end
    if (obj.disabled or isheader) then
      if isnumheader or i == num then
        c = C_4
      else
        c = C_2
      end
    end
    print(obj.text or "", 1, 1, c)

    df(i, i == num, obj)
  end

  clip()

  camera()
end $$
