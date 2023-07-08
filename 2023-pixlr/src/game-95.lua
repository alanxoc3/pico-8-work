-- BASIC EXAMPLE FOR SIMPLE GAME BELOW:
-- I need an object that has a list of pixels that can be applied to the screen.
-- i need to easily create a pixel list object

|[f_game_init]| function(_ENV)
  xytoggle = 0 -- this controls whether to update x or y for the frame

  local groups = f_initialize_groups()
  for group in all(groups) do
        if group.col ==  6 then f_zobj_set(group, G_STR_MOVABLEWALL) group:register()
    elseif group.col ==  7 then f_zobj_set(group, G_STR_WALL)        group:register()
    elseif group.col ==  8 then f_zobj_set(group, G_STR_BOMB)        group:register()
    elseif group.col ==  9 then f_zobj_set(group, G_STR_LAVA)        group:register()
    elseif group.col == 12 then f_zobj_set(group, G_STR_PL)          group:register()
    end
  end
end $$

|[f_game_update]| function(_ENV)
  -- STEP 1: Reset game if btn is pressed. (TODO: make this more smooth)
  if btnp'5' then
    f_zclass_loop[[kill]]
    f_zclass_clean()
    reload(0x0, 0x0, 0x2000)
    _ENV:f_game_init()
  end

  -- STEP 2: Call update/init functions.
  f_zclass_loop[[state]]

  -- STEP 3: Move X, then Y for everything.
  xytoggle = (xytoggle+1)%2
  if xytoggle == 0 then
    f_zclass_loop[[update_x]]
    f_zclass_loop[[update_y]]
  end

  -- STEP 4: After moved, check if things that moved should be combined
  f_zclass_loop[[f_pixelgroup_combine_moved]]

  -- STEP 5: Check if moved things touched lava and destroy them if so.

  -- STEP 6: Reset "moved".
  for obj in all(g_zclass) do
    obj.moved_x = false
    obj.moved_y = false
  end

  -- STEP 7: Cleanup things that died.
  f_zclass_clean()
end $$

|[f_game_draw]| function(_ENV)
    poke(0x5f55, 0x00) clip(0,0,32,32) cls(0) -- screen is spritesheet, so drawing operations happen there
    rect(0,0,31,31,1) -- visible screen edge so you know where screen wraps
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
