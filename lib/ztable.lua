function ztable_eval(val, table, parameters)
    -- 37: %, 126: ~
    if     ord(val) == 37               then return _g[sub(val, 2)]
    elseif ord(val) == 126              then return table[sub(val, 2)]
    elseif val == "@"                   then return deli(parameters, 1)
    elseif val == 'yes'  or val == 'no' then return val=='yes'
    elseif val == 'null' or val == ''   then return nil
    elseif val == 'nop'                 then return function() end
    end                                      return val
end

function ztable_set(table, str, ...)
    local params, statements = {...}, split(str, ";")
    foreach(statements, function(statement)
        local tokens = split(statement) -- defaults to comma
        _g[deli(tokens, 1)](tokens, table, params)
    end)
    return table
end

function ztable(...)
    return ztable({}, ...)
end

-- _g = {
--     "=" = function(tokens, table, params)
--         local val_str = deli(tokens)
--         foreach(tokens, function(key)
--             table[key] = ztable_eval(val_str, table, params)
--         end)
--     end,
-- 
--     ":" = function(tokens, table, params)
--         table[deli(tokens, 1)] = tokens
--         for key,val_str in pairs(tokens) do
--             tokens[key] = ztable_eval(val_str, table, params)
--         end
--     end,
-- 
--     "#" = function(tokens, table, params)
--         foreach(tokens, function(val_str)
--             add(table, ztable_eval(val_str, table, params))
--         end)
--     end
-- }
