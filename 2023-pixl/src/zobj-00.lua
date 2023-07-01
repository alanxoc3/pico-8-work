-- This part must go first!
_g=setmetatable({}, {__index=_ENV})
_ENV = _g

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
f_zobj_set(_g, [[c_yes,@, c_no,@, c_empty,@, f_nop,@]], true, false, "", function(...) return ... end)

-- then set the global things.
-- set the initial state of _g. _g is needed for ztable "%" references to work.
-- see the perl preprocessor script for more info on G_TABLE_INITIALIZATION.
-- technically, f_zobj sets the metatable to _g. That's recursive and bad, so we overwrite it to the global scope. This way we can access pico-8 api functions.
_G_ZOBJ

-- need to add the functions in this file to the _g scope too, so other things can access them!
|[f_zobj]|      f_zobj      $$
|[f_zobj_set]|  f_zobj_set  $$
|[f_zobj_eval]| f_zobj_eval $$
