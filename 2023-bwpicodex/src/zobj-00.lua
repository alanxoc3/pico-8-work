-- This part must go first!
_g=setmetatable({}, {__index=_ENV})
_ENV = _g -- todo: try removing this line... wonder if things work...

function f_zobj_eval(val, table, parameters)
  if     ord(val) == 126 then return table[sub(val, 2)] -- 126 means "~"
  elseif val == '@'       then return deli(parameters, 1)
  elseif val == '#'       then return {} end
  return val ~= '' and val or nil
end

-- has an extra split call ~c_no matter key or val, but token & character count goes down from ztable-ord
function f_zobj_set(table, str, ...)
  local params, statements, dest = {...}, split(str, ";"), table
  foreach(statements, function(statement)
    local tokens = split(statement)
    if #tokens > 1 then
      if tokens[1] == '' then -- array (started with ',')
        foreach(tokens, function(val)
          add(dest, f_zobj_eval(val, table, params))
        end)
      else -- map
        for i=1,#tokens,2 do
          dest[tokens[i]] = f_zobj_eval(tokens[i+1], table, params)
        end
      end
      dest = table
    else
      if statement == '' then statement = #dest+1 end
      if type(dest[statement]) ~= "table" then
        dest[statement] = {}
      end
      dest = dest[statement]
    end
  end)
  return table
end

function f_zobj(...)
  return f_zobj_set(setmetatable({}, {__index=_g}), ...)
end

-- first, set the basic constants/values used by global things.
f_zobj_set(_g, [[
  c_pokemon,#, c_moves,#, c_trainers,#,
  g_init_peek_loc,L_DATASTART,
  c_yes,@, c_no,@, c_empty,@, f_nop,@
]], true, false, "", function(...) return ... end)

-- then set the global things.
-- set the initial state of _g. _g is needed for ztable "%" references to work.
-- see the perl preprocessor script for more info on G_TABLE_INITIALIZATION.
-- technically, f_zobj sets the metatable to _g. That's recursive and bad, so we overwrite it to the global scope. This way we can access pico-8 api functions.
_G_ZOBJ

-- need to add the functions in this file to the _g scope too, so other things can access them!
|[f_zobj]|      f_zobj      $$
|[f_zobj_set]|  f_zobj_set  $$
|[f_zobj_eval]| f_zobj_eval $$

-- used everwhere
|[f_zcall]| function(func, text, ...)
  foreach(f_zobj(text, ...), function(params)
    func(unpack(params))
  end)
end $$

-- BELOW IS JUST FOR DEBUGGING
-- Just for debugging
-- basic sort for tostring. tostring for debugging.
function debug_sort(t, compare_func)
  compare_func = compare_func or function(a, b) return a < b end
  if t then
    for n=2,#t do
      local i=n
      while i>1 and compare_func(t[i], t[i-1]) do
        t[i],t[i-1]=t[i-1],t[i]
        i=i-1
      end
    end
  end
end

-- converts anything to a string
function debug(any)
  if type(any)~="table" then return tostr(any) end
  local str = "{"
  local keys = {}
  for i=1,#any do
    if str~="{" then str=str.."," end
    keys[i] = true
    str=str..debug(any[i])
  end
  local sortedkeys = {}
  for k,v in pairs(any) do
    if not keys[k] then
      add(sortedkeys, k)
    end
  end

  debug_sort(sortedkeys)
  for k in all(sortedkeys) do
    if str~="{" then str=str.."," end
    str=str..debug(k).."="..debug(any[k])
  end
  return str.."}"
end

