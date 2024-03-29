-- todo: implement slow x, try coyote jump again, variable y jumps

-- for bomb, before you touch it, i could do the logic. or i could add an extra check for after you move. or the check could be on the bomb every frame.
-- bomb touch logic goes in should-combine thing. lava touch logic happens every frame

|[f_get_at_coord]| function(x, y)
  for obj in all(g_zclass) do
    if obj.alive and obj.id ~= 'lava' and obj.id ~= 'goal' and obj:get(x, y) then
      return obj
    end
  end
end $$

|[f_draw_pixelgroup]| function(_ENV)
  for coord in all(array) do
    pset((coord[1]+x)%32\1, (coord[2]+y)%32\1, col)
  end
end $$

-- give it screen coords, saves to local grid
|[f_pixelgroup_set_pixel]| function(_ENV, sx, sy)
  local rx, ry = (sx-x)%32, (sy-y)%32
  if not grid[ry]     then grid[ry] = {} end
  if not grid[ry][rx] then
    local coord = {rx, ry}
    grid[ry][rx] = coord
    add(array, coord)
  end
end $$

-- give it screen coords, gets the color
|[f_pixelgroup_get_pixel]| function(_ENV, sx, sy)
  -- todo: maybe more efficient to do mod somewhere else idk
  return _ENV.grid[(sy-y)%32] and _ENV.grid[(sy-y)%32][(sx-x)%32]
end $$

|[f_pixelgroup_get_local]| function(_ENV, lx, ly)
  return _ENV.grid[ly%32] and _ENV.grid[ly%32][lx%32]
end $$

|[f_pixelgroup_set_local]| function(_ENV, lx, ly, val)
  if _ENV.grid[ly%32] then _ENV.grid[ly%32][lx%32] = val end
end $$

|[f_pixelgroup_delete_pixel]| function(_ENV, sx, sy)
  local coords = _ENV:get(sx, sy)
  if coords then
    _ENV.alive = false
    _ENV.grid[coords[2]][coords[1]] = false
    del(_ENV.array, coords)

    local x_new, y_new = 0, 1
    for _=0,3 do -- var doesn't matter, 4 times to do all rotations of 90 degrees
      -- need to check all prev grids.
      x_new, y_new = -y_new, x_new
      if _ENV:getlocal(coords[1]+x_new, coords[2]+y_new) then
        -- do the create thing.....
        printh("x_new: "..(coords[1]+x_new).." | y_new "..(coords[2]+y_new))

        local group = f_create_pixelgroup(x, y, col, function(sx, sy)
          if _ENV:getlocal(sx, sy) then
            _ENV:setlocal(sx, sy, nil)
            return true
          end
        end)
      end
    end
  end
end $$

-- moves and pushes a thing, pass things that block and things that can be pushed
-- this was designed to be called in only 1 of 4 directions (udlr)
-- returns true if move was successful, false if not
-- my collision logic assumes that everything is already in a good state, then it moves and fixes the state it changed
|[f_pixelgroup_push]| function(_ENV, xoff, yoff, blockids, pushmap, objs)
  local is_root = not objs
  objs = objs or {[_ENV]=true} -- this is a map of objs, a map of ids, and an array in one table. it starts with this object in the map, so that this object doesn't get added
  local start = #objs+1
  for coord in all(_ENV:f_pixelgroup_get_dir_array(xoff, yoff)) do
    local obj = f_get_at_coord((x+coord[1]+xoff)%32, (y+coord[2]+yoff)%32)
    if obj and not objs[obj] then
      if blockids[obj.id] then
        return false
      elseif pushmap[obj.id] then
        if obj.id == _ENV.id and _ENV.alive and obj.alive then
          _ENV:combine(obj)
        end

        objs[obj.id] = true
        objs[obj] = true
        add(objs, obj)
      end
    end
  end

  for i=start,#objs do
    if not objs[i]:push(xoff, yoff, blockids, pushmap, objs) then
      return false
    end
  end

  if is_root then
    for thing in all(objs) do
      thing:move(xoff, yoff)
    end

    _ENV:move(xoff, yoff)
  end

  return true
end $$

-- checks for sticky things in all 4 directions, and combines if touching
|[f_pixelgroup_combine_moved]| function(_ENV)
  local xoff, yoff = 0, 1
  if (moved_x or moved_y) and alive then
    local x_new, y_new = xoff, yoff
    for _=0,3 do -- var doesn't matter, 4 times to do all rotations of 90 degrees
      x_new, y_new = -y_new, x_new -- efficient way to rotate by 90 degrees
      for coord in all(_ENV:f_pixelgroup_get_dir_array(x_new, y_new)) do
        local obj = f_get_at_coord((x+coord[1]+x_new)%32, (y+coord[2]+y_new)%32)
        if obj and obj ~= _ENV and obj.alive and obj.id == id then
          _ENV:combine(obj)
        end
      end
    end
  end
end $$

-- figures out all the objects currently touching in a different direction.
-- works even if one obj touches another which touches another...
|[f_pixelgroup_check]| function(_ENV, xoff, yoff, solidmap)
  for coord in all(_ENV:f_pixelgroup_get_dir_array(xoff, yoff)) do
    local obj = f_get_at_coord((x+coord[1]+xoff)%32, (y+coord[2]+yoff)%32)
    if obj and solidmap[obj.id] then
      return true
    end
  end

  return false
end $$

|[f_pixelgroup_combine]| function(_ENV, other)
  for coord in all(other.array) do
    local sx, sy = (other.x+coord[1])%32, (other.y+coord[2])%32
    if not _ENV:get(sx, sy) then
      _ENV:set(sx, sy)
    end
  end

  _ENV:f_pixelgroup_set_dir_arrs()

  other.alive = false
end $$

-- i have a check function that gives me all the objects
-- another function for if i delete a node, it needs to figure out whether or not to split into two objects
  -- can deleting 1 pixel possibly split into 3? Yes, if i have a T structure. 4 is only possible if something can teleport into it. over 4 is not possible
-- a function that tells me if there is a solid collision to the left/up/down/right
-- another function, given a pixel, tell me which pixel group it is a part ofjj

-- returns a 2d array of grid positions relative to start_x/y, and a single array with all

-- i need to pass a gridcheck func
|[f_create_pixelgroup]| function(start_x, start_y, col, gridcheck_func)
  if col == 0 then return nil end -- shouldn't happen based on who is calling this, but doesn't hurt to check

  local queue = {{0, 0}}

  local group = f_zclass([[
    id,default, -- this should be overridden
    draw,       ~f_draw_pixelgroup,
    set,        ~f_pixelgroup_set_pixel,
    get,        ~f_pixelgroup_get_pixel,
    combine,    ~f_pixelgroup_combine,
    check,      ~f_pixelgroup_check,
    move,       ~f_pixelgroup_move,
    push,       ~f_pixelgroup_push,
    getlocal,   ~f_pixelgroup_get_local,
    setlocal,   ~f_pixelgroup_set_local,

    delete,     ~f_pixelgroup_delete_pixel,
    x,@, y,@, col,@,
    grid,#, array,#,
    array_l,#, array_r,#,
    array_u,#, array_d,#
  ]], start_x, start_y, col)

  -- the max number for x/y even possible is 1024 since the screen is 32x32, which probably isn't actually even possible...
  while #queue > 0 do
    local lx, ly = unpack(deli(queue))              -- local  xy - can be negative
    local gx, gy = lx%32, ly%32                     -- grid   xy - between 0-31
    local sx, sy = (gx+start_x)%32, (gy+start_y)%32 -- screen xy - between 0-31

    -- if we hit the color and we didn't go here before
    if gridcheck_func(sx, sy) and not (group.grid[gy] and group.grid[gy][gx]) then
      if not group.grid[gy] then group.grid[gy] = {} end
      -- todo: combine with the "set" function logic sometime
      local coord = {gx, gy}
      group.grid[gy][gx] = coord
      add(group.array, coord)

      add(queue, {lx-1, ly}) add(queue, {lx, ly-1})
      add(queue, {lx+1, ly}) add(queue, {lx, ly+1})
    end
  end

  group:f_pixelgroup_set_dir_arrs()

      if col ==  3 then f_zobj_set(group, G_STR_GOAL)        group:register()
  elseif col ==  6 then f_zobj_set(group, G_STR_MOVABLEWALL) group:register()
  elseif col ==  7 then f_zobj_set(group, G_STR_WALL)        group:register()
  elseif col ==  8 then f_zobj_set(group, G_STR_BOMB)        group:register()
  elseif col ==  9 then f_zobj_set(group, G_STR_LAVA)        group:register()
  elseif col == 12 then f_zobj_set(group, G_STR_PL)          group:register()
  end

  return group
end $$

|[f_pixelgroup_set_dir_arrs]| function(_ENV)
  array_l, array_d, array_r, array_u = {}, {}, {}, {}
  for coord in all(array) do
    local gx, gy = unpack(coord)

    if not grid[(gy-1)%32] or not grid[(gy-1)%32][gx] then add(array_u, coord) end
    if not grid[(gy+1)%32] or not grid[(gy+1)%32][gx] then add(array_d, coord) end
    if not grid[gy][(gx+1)%32] then add(array_r, coord) end -- don't need to check y, because the y already exists
    if not grid[gy][(gx-1)%32] then add(array_l, coord) end
  end
end $$

|[f_pixelgroup_get_dir_array]| function(_ENV, xoff, yoff)
  if     xoff < 0 then return array_l
  elseif xoff > 0 then return array_r
  elseif yoff < 0 then return array_u
  else                 return array_d end
end $$

-- assumes you did a check first
|[f_pixelgroup_move]| function(_ENV, xdir, ydir)
  x = (x+mid(-1,1,xdir))%32
  y = (y+mid(-1,1,ydir))%32
  if xdir~=0 then
    moved_x = true
  end

  if ydir~=0 then
    moved_y = true
  end
end $$

-- reads the sprite sheet to create all the pixel groups
|[f_initialize_groups]| function()
  local grid, groups = {}, {}
  for y=0,31 do
    for x=0,31 do
      if not grid[x+y*32] then
        local col = sget(x, y)
        local group = f_create_pixelgroup(x, y, col, function(sx, sy)
          return sget(sx, sy) == col
        end)

        if group then
          for coord in all(group.array) do
            grid[(x+coord[1])%32+(y+coord[2])%32*32] = true
          end
          add(groups, group)
        end
      end
    end
  end
  return groups
end $$
