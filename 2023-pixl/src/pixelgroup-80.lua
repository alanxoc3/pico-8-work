|[f_draw_pixelgroup]| function(_ENV)
  -- todo: wrapping and maybe centering?
  for coord in all(_ENV.array) do
    pset((coord[1]+x)%32\1, (coord[2]+y)%32\1, col)
  end
end $$

|[f_pixelgroup_set_pixel]| function(_ENV, x, y)
  x%=32 y%=32
  if not _ENV[y] then _ENV[y] = {} end
  if not _ENV[y][x] then _ENV[y][x] = _ENV.color end
end $$

|[f_pixelgroup_get_pixel]| function(_ENV, x, y)
  -- todo: maybe more efficient to do mod somewhere else idk
  return _ENV.grid[y%32] and _ENV.grid[y%32][x%32] or 0
end $$

-- its a destructive operation. as pixels are read, they become black.

-- i need a function that initially calculates the shape and creates the group
-- another function for if i delete a node, it needs to figure out whether or not to split into two objects
  -- can deleting 1 pixel possibly split into 3? Yes, if i have a T structure. 4 is only possible if something can teleport into it. over 4 is not possible
-- another function for checking if pixelgroup can move. or this can both be movement and collision checking
-- a function that tells me if there is a solid collision to the left/up/down/right
-- another function, given a pixel, tell me which pixel group it is a part ofjj

-- returns a list of nodes as well as the root node

-- returns a 2d array of grid positions relative to start_x/y, and a single array with all
|[f_create_pixelgroup]| function(start_x, start_y)
  local col = sget(start_x, start_y)
  if col == 0 then return nil end -- shouldn't happen based on who is calling this, but doesn't hurt to check

  local queue = {{start_x, start_y}}

  local group = f_zclass([[
    draw, ~f_draw_pixelgroup,
    set,  ~f_pixelgroup_set_pixel,
    get,  ~f_pixelgroup_get_pixel,

    x,@, y,@, col,@,
    grid,@, array,@
  ]], start_x, start_y, col, {}, {})

  -- test {x, y} vs (x%32)+y%32*32, which is faster?
  while #queue > 0 do
    local current_pos = deli(queue)
    local  x,  y = current_pos[1]%32, current_pos[2]%32
    local gx, gy = (x-start_x)%32, (y-start_y)%32

    -- if we hit the color and we didn't go here before
    if sget(x, y) == col and not (group.grid[gy] and group.grid[gy][gx]) then
      if not group.grid[gy] then group.grid[gy] = {} end
      group.grid[gy][gx] = true
      add(group.array, {gx, gy})

      add(queue, {x - 1, y}) add(queue, {x, y - 1})
      add(queue, {x + 1, y}) add(queue, {x, y + 1})
    end
  end

  return group
end $$

-- reads the sprite sheet to create all the pixel groups
|[f_initialize_groups]| function(blah)
  local grid, groups = {}, {}
  for y=0,31 do
    for x=0,31 do
      if not grid[x+y*32] then
        local group = f_create_pixelgroup(x, y)
        if group then
          for coord in all(group.array) do
            grid[coord[1]+coord[2]*32] = true
          end
          add(groups, group)
        end
      end
    end
  end
  return groups
end $$
