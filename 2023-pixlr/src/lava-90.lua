|[G_STR_LAVA]| [[
  id,lava,
  lavacheck,~f_lava_check
]] $$

|[f_lava_check]| function(_ENV)
  for coord in all(array) do
    -- delete at grid positions
    local sx, sy = x+coord[1], y+coord[2]
    local obj = f_get_at_coord(sx, sy)
    if obj then
      obj:delete(sx, sy)
    end
  end
end $$
