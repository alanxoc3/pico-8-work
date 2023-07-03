-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
-- I need an object that has a list of pixels that can be applied to the screen.
-- i need to easily create a pixel list object

|[f_game_init]| function(_ENV)
  local groups = f_initialize_groups()
  for group in all(groups) do
    if group.col == 12 then
      ball = group
      break
    end
  end

  -- ball:set(3,3,13)
  ball.xstore = 0
  ball.ystore = 0
  ball.update = f_ball_update
  ball.update_x = f_ball_update_x
  ball.update_y = f_ball_update_y

  xytoggle = 0
end $$

-- what if there are 4 subpixel positions, 0,1,2,3... the screen could be the spritesheet.

|[f_game_update]| function(_ENV)
  xytoggle = (xytoggle+1)%2

  ball:update()

  if xytoggle == 1 then
    ball:update_x()
  else
    ball:update_y()
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

    print("\^x5pIXL", 2,2, 7)
    print("\^x5......",  2,5, 7)
    print("\^x5bY",    2,3+10, 5)
    print("\^x5aMORG", 2,3+16, 13)
    print("\^x5gAMES", 2,3+22, 6)
    pset(8+t(),4,9)
    rect(0,0,31,31,9)
    ball:draw()

    -- END DRAWING OPERATIONS
    clip() poke(0x5f55, 0x60) -- screen is the actual screen
    sspr(0,0,32,32, 0,0,128,128)
end $$

|[f_zbtn]| function(f, a) return f(a) and f(a+1) and 0 or f(a) and -1 or f(a+1) and 1 or 0 end $$
|[f_xbtn]| function()     return f_zbtn(btn, 0) end $$
|[f_ybtn]| function()     return f_zbtn(btn, 2) end $$

|[f_draw]| function(callback)
end $$
