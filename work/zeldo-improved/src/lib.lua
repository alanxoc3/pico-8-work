function rnd_one() return flr(rnd(3))-1 end

-- for debugging
-- converts anything to string, even nested tables
-- function tostring(any)
--     if type(any)=="function" then 
--         return "function" 
--     end
--     if any==nil then 
--         return "nil" 
--     end
--     if type(any)=="string" then
--         return any
--     end
--     if type(any)=="boolean" then
--         if any then return "true" end
--         return "false"
--     end
--     if type(any)=="table" then
--         local str = "{ "
--         for k,v in pairs(any) do
--             str=str..tostring(k).."->"..tostring(v).." "
--         end
--         return str.."}"
--     end
--     if type(any)=="number" then
--         return ""..any
--     end
--     return "unkown" -- should never show
-- end
-- 
function batch_call(func, str, ...)
   local arr = gun_vals(str,...)
   for i=1,#arr do func(munpack(arr[i])) end
end

-- i should cache this too.
-- https://gist.github.com/josefnpat/bfe4aaa5bbb44f572cd0
function munpack(t, from, to)
  from, to = from or 1, to or #t
  if from > to then return end
  return t[from], munpack(t, from+1, to)
end

-- returns the parsed table, the current position, and the parameter locations
function gun_vals_helper(val_str,i,new_params)
   local val_list, val, val_ind, isnum, val_key = {}, "", 1

   while i <= #val_str do
      local x = sub(val_str, i, i)

      if x == "{" then val, i = gun_vals_helper(val_str,i+1,new_params)
      elseif x == "#" then isnum = true
      elseif x == "=" then
         val_key, val = val, ""
      elseif x == "," or x == "}" then
         if val_key then
            key = val_key
         else
            key = val_ind
            val_ind = val_ind+1
         end

         if     val == "@"                then add(new_params, {val_list, key})
         elseif val == "true"             then val = true
         elseif val == "false"            then val = false
         elseif val == "nil"              then val = nil
         end

         val_list[key] = isnum and 0+val or val
         val, isnum, val_key = ""
         if x == "}" then return val_list, i end
      elseif x != " " and x != "\n" then
   		val=val..x
   	end
      i += 1
   end

   return val_list, i, new_params
end

-- supports variable arguments, true, false, nil, numbers, and strings.
param_cache = {}
function gun_vals(val_str, ...)
   -- there is global state logic in here. you have been warned.
   if not param_cache[val_str] then
      param_cache[val_str] = { gun_vals_helper(val_str..",",1,{}) }
   end

   local params, lookup = {...}, param_cache[val_str]

   for i=1,#lookup[3] do
      local cur = lookup[3][i]
      cur[1][cur[2]] = params[i]
   end

   return lookup[1]
end
