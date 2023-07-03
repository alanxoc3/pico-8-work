-- Creates an object with basic init/update logic.
-- defaults: when switching to a new state, these get loaded

g_zclass = {}

G_ZCLASS_TEMPLATE = [[
  timer, 0,

  state,    ~f_zclass_state,
  load,     ~f_zclass_load,
  elapsed,  ~f_zclass_get_elapsed_percent,
  register, ~f_zclass_register,

  alive,  ~c_yes,
  isnew,  ~c_yes,
  init,   ~f_nop,
  update, ~f_nop,
  curr,   begin;
  begin;,;
]]

|[f_zclass]| function(...)
  return f_zobj_set(f_zobj(G_ZCLASS_TEMPLATE), ...)
end $$

-- by default, a zclass object doesn't get added to the global array. you must manually register it.
-- useful for something like building up some objects then deciding not to use some of them.
|[f_zclass_register]| function(_ENV)
  del(_g.g_zclass, _ENV)
  add(_g.g_zclass, _ENV)
end $$

|[f_zclass_loop]| function(funcName)
  for obj in all(_g.g_zclass) do
    (obj[funcName] or function() end)(obj)
  end
end $$

|[f_zclass_clean]| function()
  for obj in all(_g.g_zclass) do
    if not obj.alive then
      del(_g.g_zclass, obj)
    end
  end
end $$

-- get the timer percentage for a state
|[f_zclass_get_elapsed_percent]| function(_ENV, key)
    if key == curr then
        return duration and timer/duration or 0
    end

    if _ENV[key] and _ENV[key].done then
        return 1
    end

    return 0
end $$

-- use this to load a new state
|[f_zclass_load]| function(_ENV, stateName)
    next_state = stateName or next
end $$

-- used by f_zclass_state
|[f_zclass_loadlogic]| function(_ENV, stateName)
    timer, next_state, isnew, next, duration = 0

    _ENV[curr].done = true
    for k, v in pairs(defaults) do _ENV[k] = v end
    for k, v in pairs(_ENV[stateName]) do _ENV[k] = v end

    curr = stateName

    _ENV:init()
end $$

-- calls init/update logic and increments timer
|[f_zclass_state]| function(_ENV)
    timer += 1/60

    if isnew then _ENV:f_zclass_loadlogic(curr) end
    if duration and timer >= duration then _ENV:f_zclass_load() end
    while next_state do _ENV:f_zclass_loadlogic(next_state) end

    _ENV:update()
end $$
