-- 198 tokens
function ztable_eval(val, table, parameters)
    -- 37: %, 126: ~
    if     ord(val) == 37               then return _g[sub(val, 2)]
    elseif ord(val) == 126              then return table[sub(val, 2)]
    elseif val == "@"                   then return deli(parameters, 1)
    elseif val == 'yes'  or val == 'no' then return val=='yes'
    elseif val == 'null' or val == ''   then return -- nil is inferred
    elseif val == 'nop'                 then return function() end
    end                                      return val
end

function ztable_set(table, str, ...)
    local params, statements, dest = {...}, split(str, ";"), table
    foreach(statements, function(statement)
        local cmd, next_dest = ord(statement), table
        if cmd == 58 then -- 58: ":"
            local tokens = split(statement, ":")
            for i=2,#tokens,2 do
                dest[tokens[i]] = ztable_eval(tokens[i+1], table, params)
            end
        elseif cmd == 44 then -- 44: ","
            -- split below defaults to ","
            -- val will always be '' for the first loop iteration. this then evaluates to nil in ztable_eval.
            -- the "add" function will not add anything if the value passed to it is nil.
            foreach(split(statement), function(val)
                add(dest, ztable_eval(val, table, params))
            end)
        elseif cmd then -- cmd == nil when statement == ""
            if type(dest[statement]) ~= "table" then
                dest[statement] = {}
            end
            next_dest = dest[statement]
        end
        dest = next_dest
    end)
    return table
end

function ztable(...)
    return ztable_set({}, ...)
end
