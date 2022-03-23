-- 197 tokens
function ztable_eval(val, table, parameters)
    -- 37: %, 126: ~
    if     ord(val) == 37               then return _g[sub(val, 2)]
    elseif ord(val) == 126              then return table[sub(val, 2)]
    elseif val == '@'                   then return deli(parameters, 1)
    elseif val == '#'                   then return {}
    elseif val == 'yes'  or val == 'no' then return val=='yes'
    elseif val == 'null' or val == ''   then return -- nil is inferred
    elseif val == 'nop'                 then return function() end
    end                                      return val
end

-- has an extra split call no matter key or val, but token & character count goes down from ztable-ord
function ztable_set(table, str, ...)
    local params, statements, dest = {...}, split(str, ";"), table
    foreach(statements, function(statement)
        local tokens = split(statement)
        if #tokens > 1 then
            if tokens[1] ~= '' then -- map
                for i=1,#tokens,2 do
                    dest[tokens[i]] = ztable_eval(tokens[i+1], table, params)
                end
            else -- array (started with ',')
                foreach(tokens, function(val)
                    add(dest, ztable_eval(val, table, params))
                end)
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

function ztable(...)
    return ztable_set({}, ...)
end
