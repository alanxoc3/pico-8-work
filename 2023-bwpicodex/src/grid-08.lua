|[f_refresh_top]| function()
  g_top_grid.op, g_top_grid.preview_op, g_top_grid.lrlist = {}, {}, {}
  g_top_grid:gridpofunc()
end $$

|[f_add_to_ui_stack]| function(grid)
  add(g_gridstack, {obj=grid})
  g_grid_called_init = false
end $$

|[f_pop_ui_stack]| function()
  -- if we pop, we should recompute the ops, because there may have been an operation.
  deli(g_gridstack)
  g_grid_called_init = false
end $$

|[f_getsel]| function(gridname)
  return @_ENV[gridname].g_cg_m.sel
end $$

|[f_setsel]| function(gridname, val)
  poke(_ENV[gridname].g_cg_m.sel, val)
end $$

-- "arg" is an optional param that can be used as something accessible in the op func, such as to change the parameter.
|[f_create_gridpair]| function(name, memloc, main_grid_spec, info_grid_spec, main_op_func, main_sel_func, main_leave_func, lrbasegrid, static, init, arg)
  -- zobj is needed so we can use an _ENV syntax
  _ENV[name] = f_zobj([[init,@, g_cg_m,@, g_cg_s,@, gridpofunc,@, arg,@]],
    init,
    f_zobj([[
      sel,@, view,@, name,@, selfunc,@, leavefunc,@, lrbasegrid,@, static,@, w,@,vh,@,x,@,y,@,cw,@,ch,@,selw,@,selh,@
    ]], memloc, memloc+1, name, main_sel_func, main_leave_func, lrbasegrid, static, unpack(main_grid_spec)),

    f_zobj([[
      sel,@, view,@, static,~c_no, disabled,~c_yes, name,@, w,@,vh,@,x,@,y,@,cw,@,ch,@,selw,@,selh,@
    ]], S_DEFAULT, S_DEFAULT+1, name, unpack(info_grid_spec)),

    main_op_func,
    arg
  )
end $$

-- pass in cell list.
-- each cell has: text, disabled
-- this only gets called for the current active grid
|[f_update_grid]| function(_ENV, gridobj)
  local evalfunc = function(num, mmin, mmax, b0, b1, l)
    local off = (b1 and l or 0) - (b0 and l or 0)
    local newnum = mid(mmin, min(#gridobj-1, mmin+mmax), num + (static and 0 or off))
    if newnum == num and off ~= 0 then
      f_minisfx(SFX_ERROR)
    elseif newnum ~= num then
      f_minisfx(SFX_MOVE)
    end
    return newnum
  end

  local prevsel = @sel
  if lrbasegrid then
    -- LR logic
    local dir = (btnp'1' and 1 or 0) - (btnp'0' and 1 or 0)
    local lst = _ENV[lrbasegrid].op
    local cur = f_getsel(lrbasegrid)
    local nxt = cur
    if dir > 0 then
      for i=cur+2,#lst,1 do -- +1 for zero index, +1 for next
        if lst[i].lrvalid then
          nxt = i-1
          break
        end
      end
    elseif dir < 0 then
      for i=cur-1,0,-1 do
        if lst[i+1].lrvalid then
          nxt = i
          break
        end
      end
    end

    if nxt ~= cur then
      f_minisfx(SFX_MOVE)
      f_setsel(lrbasegrid, nxt)
      f_refresh_top()
    elseif dir ~= 0 then
      f_minisfx(SFX_ERROR)
    end
  else
    poke(sel, evalfunc(@sel, @sel\w*w, w-selw, btnp'0', btnp'1', selw))
  end

  poke(sel, evalfunc(@sel, @sel%w,   (#gridobj-1)\w*w\(selh*selw)*selh*selw, btnp'2', btnp'3', w*selh))

  if @sel ~= prevsel then
    -- when the cursor has changed, make the ui change if needed
    f_refresh_top()
  end

  if @sel\w-vh+1 > @view then poke(view, (@sel\w-vh+1)\selh*selh+(selh-1)) end
  if @sel\w      < @view+selh-1 then poke(view, @sel\w\selh*selh) end
  -- end

  poke(view, mid(0, @view, (#gridobj-1)\w-vh+1))

  if btnp'4' then
    f_minisfx(leavefunc() or SFX_LEAVE)
  elseif btnp'5' then
    if (selw*selh > 1 or disabled or lrfunc or not gridobj[@sel+1].disabled) then
      f_minisfx(selfunc() or SFX_SELECT)
    else
      f_minisfx(SFX_ERROR)
    end
  end
end $$

|[f_draw_grid]| function(_ENV, gridobj, num, view, x, y, active) -- "active" is just needed to be able to draw the bright selection fill background (or not draw it)
  local draw_cell_bg = function(j, offx, offy, force)
    local i = j + view*w
    local obj = gridobj[i+1]
    if i >= #gridobj then return true end
    local xloc, yloc = x+i%w*cw, y+j\w*ch
    camera(-xloc-1, -yloc-1)

    local l, r, u, d = 0, 0, 0, 0

    if force or i == 0                then l, u = 1, 1 end
    if i == w-1              then r, u = 1, 1 end
    if force or i == #gridobj-1       then r, d = 1, 1 end
    if i == (#gridobj-1)\w*w then l, d = 1, 1 end

    local c = C_2
    if obj.disabled then
      c = C_1
    end

    -- This is not a roundrect, this is specific for rounding corners on the grid edge.
    -- TODO: try to combine with rounded rect func.
    rectfill(offx-1+l, offy-1,   offx+cw-2-r, offy+ch-2,   c)
    rectfill(offx-1,   offy-1+u, offx+cw-2,   offy+ch-2-d, c)
  end

  local draw_cell_fg = function(j)
    local i = j + view*w
    local obj = gridobj[i+1]
    if i >= #gridobj then return true end
    local xloc, yloc = x+i%w*cw, y+j\w*ch
    clip(xloc, yloc, cw, ch)
    camera(-xloc-1, -yloc-1)

    local c = C_1
    if obj.disabled then
      c = C_2
    end
    print(obj.text or "", 1, 1, c)

    if obj.draw then
      obj.draw(i, i == num, obj)
    end

    clip()
  end

  for j=0,vh*w-1 do if draw_cell_bg(j, 0, 0) then break end end
  for j=0,vh*w-1 do if draw_cell_fg(j) then break end end

  if not disabled then
    pal{C_3,C_3,C_3}
    for ss=0,selh-1 do
      for sw=0,selw-1 do
        for i=-1,1 do
          for j=-1,1 do
            draw_cell_bg(num-view*w+ss*selw+sw, i, j, static)
          end
        end
      end
    end
    pal()

    for ss=0,selh-1 do
      for sw=0,selw-1 do
        draw_cell_bg(num-view*w+ss*selw+sw, 0, 0, static)
      end
    end
    for ss=0,selh-1 do
      for sw=0,selw-1 do
        draw_cell_fg(num-view*w+ss*selw+sw)
      end
    end
  end
  camera()
end $$

|[f_addop_draw]| function(op, draw)
  add(op, {draw=draw}) -- todo use zobj?
end $$

|[f_addop_text]| function(op, text)
  f_addop_draw(op, function() print(text, 1, 1, C_1) end)
end $$

