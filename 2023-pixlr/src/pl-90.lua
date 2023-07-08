|[G_STR_MOVABLEWALL]| [[
  id,movablewall;
]] $$

|[G_STR_WALL]| [[
  id,wall;
]] $$

|[G_STR_BOMB]| [[
  id,bomb;
]] $$

|[G_STR_LAVA]| [[
  id,lava;
]] $$

|[G_STR_PL]| [[
  id,pl,
  xstore,0, ystore,0, jumpstore,0,
  jump,#, coyote,~c_no, -- false: on ground, 0: disabled, 1: enabled
  update,~f_ball_update,
  x_prev_dir,0, x_prev_len,0,
  update_x,~f_ball_update_x,
  update_y,~f_ball_update_y;
]] $$

|[f_ball_update]| function(_ENV)
  -- if the button was pressed inbetween frames, we want it to register
  xstore += f_xbtn()
  ystore += f_ybtn()

  if btn'4' then
    jumpstore = 1
  end
end $$

|[f_ball_update_x]| function(_ENV)
--  -- true false trues
--  local nx = mid(-1,1,xstore)
--
--  if not moved_x and nx ~= 0 then
--    if x_prev_dir ~= nx and x_prev_dir ~= 0 then -- if you were moving in the opposite direction
--      x_prev_len = 0
--    else -- if you were moving in the same direction or not moving at all
--      x_prev_len = min(3,x_prev_len+1)
--    end
--
--    _ENV:push(nx, 0, {wall=true}, {movablewall=true, pl=true})
--
--    x_prev_dir = nx
--  else
--    x_prev_len = 0
--    x_prev_dir = 0
--  end
--
--  xstore = 0








  -- true false trues
  local nx = mid(-1,1,xstore)

  if not moved_x and nx ~= 0 then
    if x_prev_dir ~= nx and x_prev_dir ~= 0 then -- if you were moving in the opposite direction
      x_prev_len = 0
    else -- if you were moving in the same direction or not moving at all
      x_prev_len = min(3,x_prev_len+1)
    end

    if x_prev_len == 1 or x_prev_len == 3 then
      _ENV:push(nx, 0, {wall=true}, {movablewall=true, pl=true})
    end

    x_prev_dir = nx
  else
    x_prev_len = 0
    x_prev_dir = 0
  end

  xstore = 0
end $$

|[f_ball_update_y]| function(_ENV)
  -- TODO: jump shouldn't push blocks. up and down should
  -- todo: need a non-recursive check

  local ny = mid(-1,1,ystore)

  if #jump == 0 and jumpstore > 0 and (coyote and coyote > 0 or _ENV:check(0, 1, {wall=true, movablewall=true})) then
    add(jump, false) add(jump, false) add(jump, true)
    add(jump, false) add(jump, true)  add(jump, true)
    coyote = 0
  end

  if #jump > 0 and jumpstore > 0 then -- if jumping
    if deli(jump) then
      if not moved_y and not _ENV:push(0, -1, {wall=true}, {movablewall=true, pl=true}) then
        jump = {}
      end
    end

  elseif not _ENV:check(0, 1, {wall=true, movablewall=true, pl=true}) then -- if falling
    if #jump > 0 then
      deli(jump) deli(jump)
    elseif not coyote then
      coyote = 1
    else
      _ENV:push(0, 1, {wall=true}, {movablewall=true, pl=true})
      coyote = 0
    end

  else -- if on the ground
    jump = {}
    coyote = false
  end

  jumpstore = 0
end $$

