|[f_create_gridpair]| function(name, mem, main_grid_spec, info_grid_spec, info_grid_draw, main_op_func, main_sel_func, main_leave_func, main_lr_func, ...)
  _g[name] = {
    f_zobj([[
      name,@, mem,@, memview,@, selfunc,@, leavefunc,@, lrfunc,@,
      w,@,vh,@,x,@,y,@,cw,@,ch,@
    ]], name, mem, mem+1, main_sel_func, main_leave_func, main_lr_func, unpack(main_grid_spec)),

    f_zobj([[
      name,@, mem,@, memview,@, df,@,
      w,@,vh,@,x,@,y,@,cw,@,ch,@
    ]], name, -1, -1, info_grid_draw, unpack(info_grid_spec)),

    main_op_func,
    {...}
  }
end $$

-- pass in cell list.
-- each cell has: text, disabled
-- this only gets called for the current active grid
|[f_update_grid]| function(_ENV, gridobj)
  local evalfunc = function(num, mmin, mmax, b0, b1, l)
    local off = (b1 and l or 0) - (b0 and l or 0)
    local newnum = mid(mmin, min(#gridobj-1, mmin+mmax), num + off)
    if newnum == num and off ~= 0 then
      f_minisfx(SFX_ERROR)
    elseif newnum ~= num then
      f_minisfx(SFX_MOVE)
    end
    return newnum
  end

  local num, view = @mem, @memview
  if lrfunc then
    local off = (btnp'3' and 1 or 0) - (btnp'2' and 1 or 0)

    local prevview = view
    view = mid(0, view+off, (#gridobj-1)\w-vh+1)
    if view == prevview and off ~= 0 then
      f_minisfx(SFX_ERROR)
    elseif off ~= 0 then
      f_minisfx(SFX_MOVE)
    end

    if lrfunc then lrfunc((btnp'1' and 1 or 0) - (btnp'0' and 1 or 0)) end
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
    if (num < 0 or lrfunc or not gridobj[num+1].disabled) then
      f_minisfx(selfunc() or SFX_SELECT)
    else
      f_minisfx(SFX_ERROR)
    end
  end
  poke(mem, num, view)
end $$

|[f_draw_grid]| function(_ENV, gridobj, num, view, x, y, active) -- "active" is just needed to be able to draw the bright selection fill background (or not draw it)
  clip(x, y, w*cw, vh*ch)

  for j=0,vh*w-1 do
    local i = j + view*w
    local obj = gridobj[i+1]
    if i >= #gridobj then break end
    local xloc, yloc = x+i%w*cw, y+j\w*ch
    camera(-xloc-1, -yloc-1)

    local l, r, u, d = 0, 0, 0, 0

    if i == 0                then l = 1 u = 1 end
    if i == w-1              then r = 1 u = 1 end
    if i == #gridobj-1       then r = 1 d = 1 end
    if i == (#gridobj-1)\w*w then l = 1 d = 1 end

    local c = C_3
    if (lrfunc or i ~= num) and obj.disabled then
      c = C_2
    end

    if not lrfunc and active and i == num then
      c = C_4
    end

    rectfill(-1+l, -1,   cw-2-r, ch-2,   c)
    rectfill(-1,   -1+u, cw-2,   ch-2-d, c)
  end

  for j=0,vh*w-1 do
    local i = j + view*w
    local obj = gridobj[i+1]
    if i >= #gridobj then break end
    local xloc, yloc = x+i%w*cw, y+j\w*ch
    camera(-xloc-1, -yloc-1)

    local c = C_2
    if i == num and not lrfunc then
      c = C_3
    end
    if obj.disabled then
      if i == num and not lrfunc then
        c = C_2
      else
        c = C_3
      end
    end
    print(obj.text or "", 1, 1, c)

    if obj.draw then
      obj.draw(i, i == num, obj)
    end
  end

  clip()

  camera()
end $$

|[f_addop_text]| function(op, text)
  add(op, {draw=function() print(text, 1, 1, C_2) end}) -- todo use zobj?
end $$
