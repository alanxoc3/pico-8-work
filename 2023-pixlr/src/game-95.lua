-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
-- I need an object that has a list of pixels that can be applied to the screen.
-- i need to easily create a pixel list object

|[f_game_init]| function(_ENV)
  xytoggle = 0 -- this controls whether to update x or y for the frame

  local groups = f_initialize_groups()
  for group in all(groups) do
    if group.col == 12 then
      f_zobj_set(group, [[
        xstore,0, ystore,0,
        update,~f_ball_update,
        update_x,~f_ball_update_x,
        update_y,~f_ball_update_y
      ]])
      group:register()

    -- just visible pixels that do nothing
    elseif group.col%16 > 0 then
      -- f_zobj_set(group, [[
      -- ]])
      group:register()
    end
  end
end $$

-- what if there are 4 subpixel positions, 0,1,2,3... the screen could be the spritesheet.

|[f_game_update]| function(_ENV)
  xytoggle = (xytoggle+1)%2

  f_zclass_loop[[state]]

  if xytoggle == 1 then
    f_zclass_loop[[update_x]]
  else
    f_zclass_loop[[update_y]]
  end
end $$

|[f_ball_update]| function(_ENV)
  -- if the button was pressed inbetween frames, we want it to register
  xstore += f_xbtn()
  ystore += f_ybtn()
end $$

|[f_ball_update_x]| function(_ENV) x += mid(-1,1,xstore) xstore = 0 end $$
|[f_ball_update_y]| function(_ENV) y += mid(-1,1,ystore) ystore = 0 end $$

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
    sspr(0,0,32,32, 0,0,64,64)
end $$

|[f_zbtn]| function(f, a) return f(a) and f(a+1) and 0 or f(a) and -1 or f(a+1) and 1 or 0 end $$
|[f_xbtn]| function()     return f_zbtn(btn, 0) end $$
|[f_ybtn]| function()     return f_zbtn(btn, 2) end $$

|[f_draw]| function(callback)
end $$
