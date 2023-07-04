g_shadows = f_zobj[[
  0,0,
  1,1,
  2,2,
  3,3,
  4,4,
  5,5,
  6,5,
  7,6,
  8,8,
  9,4,
  10,10,
  11,11,
  12,12,
  13,2,
  14,14,
  15,15
]]

-- first draw is obj, second is shadow
|[f_draw_pixelgroup]| function(_ENV)
  for coord in all(_ENV.array) do
    local x, y = (coord[1]+x)%32\1, (coord[2]+y)%32\1
    pset(x, y, pget(x, y) == 1 and darkcol or col)
  end
end $$

|[f_draw_pixelgroup_shadow]| function(_ENV)
  --local darkcol = g_shadows[col] or col
  --for coord in all(_ENV.array) do
  --  local ox, oy = coord[1], coord[2]
  --  local x, y = (ox+x)%32\1, (oy+y)%32\1
  --  --if not _ENV.grid[oy]        or not _ENV.grid[oy][(ox-1)%32] then pset(x-1, y, _g.g_shadows[pget(x-1, y)]) end
  --  --if not _ENV.grid[(oy-1)%32] or not _ENV.grid[(oy-1)%32][ox] then pset(x, y-1, _g.g_shadows[pget(x, y-1)]) end
  --  if not _ENV.grid[(oy+1)%32] or not _ENV.grid[(oy+1)%32][ox] then pset(x, (y+1)%32, _g.g_shadows[pget(x, (y+1)%32)]) end
  --  if not _ENV.grid[oy]        or not _ENV.grid[oy][(ox+1)%32] then pset((x+1)%32, y, _g.g_shadows[pget((x+1)%32, y)]) end
  --end
end $$

-- give it screen coords, saves to local grid
|[f_pixelgroup_set_pixel]| function(_ENV, sx, sy, newcol)
  local rx, ry = (sx-x)%32, (sy-y)%32
  if not grid[ry]     then grid[ry] = {} end
  if not grid[ry][rx] then
    grid[ry][rx] = newcol or col
    add(array, {rx, ry})
  end
end $$

-- give it screen coords, gets the color
|[f_pixelgroup_get_pixel]| function(_ENV, sx, sy)
  -- todo: maybe more efficient to do mod somewhere else idk
  return _ENV.grid[(sy-y)%32] and _ENV.grid[(sy-y)%32][(sx-x)%32] or 0
end $$

-- moves and pushes a thing, pass things that block and things that can be pushed
-- this was designed to be called in only 1 of 4 directions (udlr)
-- returns true if move was successful, false if not
|[f_pixelgroup_push]| function(_ENV, xoff, yoff, blockids, pushmap)
  local things = _ENV:check(f_get_at_coord, xoff, yoff)
  for id in all(blockids) do
    if things[id] then return false end
  end

  for thing in all(things) do
    if pushmap[thing.id] then
      thing:move(xoff, yoff)
    end
  end

  _ENV:move(xoff, yoff)
  return true
end $$

-- figures out all the objects currently touching in a different direction.
-- works even if one obj touches another which touches another...
|[f_pixelgroup_check]| function(_ENV, getfunc, xoff, yoff, objs)
  objs = objs or {[_ENV]=true} -- this is a map of objs, a map of ids, and an array in one table. it starts with this object in the map, so that this object doesn't get added
  local start = #objs+1
  for coord in all(array) do
    local sx, sy = (x+coord[1]+xoff)%32, (y+coord[2]+yoff)%32
    if _ENV:get(sx, sy) == 0 then -- to improve efficiency, first check the local grid
      local obj = getfunc(sx, sy) -- if the pixel is not in the local grid, then check with getfunc
      if obj and not objs[obj] then
        if obj.id == _ENV.id then
          -- combine, because these are touching
          _ENV:combine(obj)
        else
          objs[obj.id] = true
          objs[obj] = true
          add(objs, obj)
        end
      end
    end
  end

  for i=start,#objs do
    objs[i]:check(getfunc, xoff, yoff, objs)
  end

  return objs
end $$

|[f_pixelgroup_combine]| function(_ENV, other)
  for coord in all(other.array) do
    local sx, sy = (other.x+coord[1])%32, (other.y+coord[2])%32
    if _ENV:get(sx, sy) == 0 then
      _ENV:set(sx, sy)
    end
  end
  other.alive = false
end $$

-- i have a check function that gives me all the objects
-- another function for if i delete a node, it needs to figure out whether or not to split into two objects
  -- can deleting 1 pixel possibly split into 3? Yes, if i have a T structure. 4 is only possible if something can teleport into it. over 4 is not possible
-- a function that tells me if there is a solid collision to the left/up/down/right
-- another function, given a pixel, tell me which pixel group it is a part ofjj

-- returns a 2d array of grid positions relative to start_x/y, and a single array with all
|[f_create_pixelgroup]| function(start_x, start_y)
  local col = sget(start_x, start_y)
  if col == 0 then return nil end -- shouldn't happen based on who is calling this, but doesn't hurt to check

  local queue = {{start_x, start_y}}

  local group = f_zclass([[
    id,default, -- this should be overridden
    draw,       ~f_draw_pixelgroup,
    drawshadow, ~f_draw_pixelgroup_shadow,
    set,        ~f_pixelgroup_set_pixel,
    get,        ~f_pixelgroup_get_pixel,
    combine,    ~f_pixelgroup_combine,
    check,      ~f_pixelgroup_check,
    move,       ~f_pixelgroup_move,
    push,       ~f_pixelgroup_push,

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

-- assumes you did a check first
|[f_pixelgroup_move]| function(_ENV, xdir, ydir)
  x = (x+mid(-1,1,xdir))%32
  y = (y+mid(-1,1,ydir))%32
end $$

-- reads the sprite sheet to create all the pixel groups
|[f_initialize_groups]| function()
  local grid, groups = {}, {}
  for y=0,31 do
    for x=0,31 do
      if not grid[x+y*32] then
        local group = f_create_pixelgroup(x, y)
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
