-- used everywhere
_g=setmetatable({}, {___index=_ENV})
_ENV = _g

function nop() end

-- 193 tokens
function f_zobj_eval(val, table, parameters)
    -- 37: %, 126: ~
    if     ord(val) == 37               then return _g[sub(val, 2)]
    elseif val == '~'                   then return table
    elseif ord(val) == 126              then return table[sub(val, 2)]
    elseif val == '@'                   then return deli(parameters, 1)
    elseif val == 'yes'  or val == 'no' then return val=='yes'
    elseif val == 'null' or val == ''   then return -- nil is inferred
    elseif val == 'nop'                 then return nop
    end                                      return val
end

-- has an extra split call no matter key or val, but token & character count goes down from ztable-ord
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
            if type(dest[statement]) ~= "table" then
                dest[statement] = {}
            end
            dest = dest[statement]
        end
    end)
    return table
end

function f_zobj(...)
    return f_zobj_set({}, ...)
end

-- set the initial state of _g. _g is needed for ztable "%" references to work.
-- see the perl preprocessor script for more info on G_TABLE_INITIALIZATION.
_G_ZOBJ
