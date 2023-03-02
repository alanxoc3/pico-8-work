-- used everywhere. this is the identity function
-- 193 tokens
function f_zobj_eval(val, table, parameters)
    -- 37: %, 126: ~
    if     _ord(val) == 37  then return _g[_sub(val, 2)]
    elseif val == '~'       then return table
    elseif _ord(val) == 126 then return table[_sub(val, 2)]
    elseif val == '@'       then return _deli(parameters, 1)
    elseif val == '#'       then return {} end
    return val ~= '' and val or nil
end

-- has an extra split call %c_no matter key or val, but token & character count goes down from ztable-_ord
function f_zobj_set(table, str, ...)
    local params, statements, dest = {...}, _split(str, ";"), table
    _foreach(statements, function(statement)
        local tokens = _split(statement)
        if #tokens > 1 then
            if tokens[1] == '' then -- array (started with ',')
                _foreach(tokens, function(val)
                    _add(dest, f_zobj_eval(val, table, params))
                end)
            else -- map
                for i=1,#tokens,2 do
                    dest[tokens[i]] = f_zobj_eval(tokens[i+1], table, params)
                end
            end
            dest = table
        else
            if statement == '' then statement = #dest+1 end
            if _type(dest[statement]) ~= "table" then
                dest[statement] = {}
            end
            dest = dest[statement]
        end
    end)
    return table
end

function f_zobj(...)
    return f_zobj_set(_setmetatable({}, {__index=_g}), ...)
end

-- first, set the basic constants/values used by global things.
f_zobj_set(_g, [[c_yes,@, c_no,@, c_empty,@, f_nop,@]], true, false, "", function(...) return ... end)

-- then set the global things.
-- set the initial state of _g. _g is needed for ztable "%" references to work.
-- see the perl preprocessor script for more info on G_TABLE_INITIALIZATION.
-- technically, f_zobj sets the metatable to _g. That's recursive and bad, so we overwrite it to the global scope. This way we can access pico-8 api functions.
f_zobj_set(_g, _G_ZOBJ_PARAMS)

-- need to add the functions in this file to the _g scope too, so other things can access them!
|[f_zobj]|      f_zobj      $$
|[f_zobj_set]|  f_zobj_set  $$
|[f_zobj_eval]| f_zobj_eval $$

-- if something isn't in global scope, it goes to _g... so pico8 api functions will take precedence over g. But table takes over api.
-- i like this idea:

-- api is just so i don't confuse myself when using api functions, though technically isn't needed if i don't use the same function name as a library function.
-- api, _g.api = _ENV, _ENV

-- scopes:
-- _ENV - pico8 api and global functions/variables
-- _g   - most functions in the game
-- obj  - the f_zobj table

-- how do I manage the complexity of the different scopes?
-- global could be just pico8 functions, but that means I can't have an "_add" function on things.
-- also if a new api function comes out, it could break me.

-- naming scheme:
--  _blah - api func
-- c_blah - global constant
-- t_blah - global object template (class)
-- f_blah - global function
-- g_blah - global variable
