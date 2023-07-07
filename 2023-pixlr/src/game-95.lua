-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
-- I need an object that has a list of pixels that can be applied to the screen.
-- i need to easily create a pixel list object

|[f_game_init]| function(_ENV)
  xytoggle = 0 -- this controls whether to update x or y for the frame

  local groups = f_initialize_groups()
  for group in all(groups) do
    if group.col == 12 then
      f_zobj_set(group, [[
        id,pl,
        xstore,0, ystore,0, jumpstore,0,
        jump,#, coyote,~c_no,
        update,~f_ball_update,
        update_x,~f_ball_update_x,
        update_y,~f_ball_update_y;
      ]])
      group:register()

    -- just visible pixels that do nothing
    elseif group.col == 7 then
      f_zobj_set(group, [[
        id,wall;
      ]])
      group:register()

    elseif group.col%16 > 0 then
      f_zobj_set(group, [[
        id,movablewall;
      ]])
      group:register()
    end
  end
end $$

-- what if there are 4 subpixel positions, 0,1,2,3... the screen could be the spritesheet.

|[f_game_update]| function(_ENV)
  -- reset the game
  if btnp'5' then
    f_zclass_loop[[kill]]
    f_zclass_clean()
    reload(0x0, 0x0, 0x2000)
    _ENV:f_game_init()
  end

  xytoggle = (xytoggle+1)%2

  -- block-specific logic
  f_zclass_loop[[state]]

  -- move x/y logic, only move logic goes here
  if xytoggle == 0 then
    f_zclass_loop[[update_x]]
  elseif xytoggle == 1 then
    f_zclass_loop[[update_y]]
  end

  -- todo: combines work with check/movement rn. but they don't work if just touching... need to fix that
  --       i could do a check in all 4 directions, and that would fix it. probably want something a little smarter though.

  f_zclass_clean()

  -- one possibility:
  -- for everything that moved, recalculate the shape of the moved object, deleting the thing that didn't move if it collides.
  -- or once moved, check the moved direction again?
  -- or divide screen into 4 sections
end $$

|[f_ball_update]| function(_ENV)
  -- if the button was pressed inbetween frames, we want it to register
  xstore += f_xbtn()
  ystore += f_ybtn()

  if btn'4' then
    jumpstore = 1
  end
end $$

|[f_get_at_coord]| function(x, y)
  for obj in all(g_zclass) do
    if obj:get(x, y) ~= 0 then
      return obj
    end
  end
end $$

|[f_ball_update_x]| function(_ENV)
  local nx = mid(-1,1,xstore)
  if nx ~= 0 then
    _ENV:push(nx, 0, {wall=true}, {movablewall=true})
  end
  xstore = 0
end $$

|[f_ball_update_y]| function(_ENV)
  local ny = mid(-1,1,ystore)

  -- TODO: jump shouldn't push blocks. up and down should
  if #jump == 0 and jumpstore > 0 and (coyote or _ENV:check(0, 1, {wall=true, movablewall=true})) then
    add(jump, false) add(jump, false) add(jump, true)
    add(jump, false) add(jump, true) add(jump, true)
    coyote = false
  end

  if #jump > 0 then
    if deli(jump) then
      if not _ENV:push(0, -1, {wall=true}, {movablewall=true}) then
        jump = {}
      end
    end

  -- todo: need a non-recursive check
  elseif not _ENV:check(0, 1, {wall=true, movablewall=true}) then
    if coyote then
      coyote = false
    else
      _ENV:move(0, 1)
    end
  else
    coyote = true
  end

  jumpstore = 0
end $$

|[f_game_draw]| function(_ENV)
    poke(0x5f55, 0x00) clip(0,0,32,32) cls(0) -- screen is spritesheet, so drawing operations happen there
    -- BEGIN DRAWING OPERATIONS

    f_zclass_loop[[draw]]

    -- save the screen to spritesheet if i need to
    -- if btnp(4) or btnp(5) then
    --   cstore(0, 0, 0x1000, "img.p8")
    -- end

    -- END DRAWING OPERATIONS
    clip() poke(0x5f55, 0x60) -- screen is the actual screen

    --pal(1,0)
    sspr(0,0,32,32, 0,0,64,64)
    --pal(1,1)
end $$

|[f_zbtn]| function(f, a) return f(a) and f(a+1) and 0 or f(a) and -1 or f(a+1) and 1 or 0 end $$
|[f_xbtn]| function()     return f_zbtn(btn, 0) end $$
|[f_ybtn]| function()     return f_zbtn(btn, 2) end $$

|[f_draw]| function(callback)
end $$
