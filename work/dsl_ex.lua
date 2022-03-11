_g={}

-- 78 tokens
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

-- 103 tokens
function ztable_no_cache(str, ...)
    local table, parameters, statements = {}, {...}, split(str, ";")
    foreach(statements, function(statement)
        local tokens = split(statement, "=")
        if #tokens > 1 then
            local val_str = deli(tokens) -- remove last item
            foreach(tokens, function(key)
                table[key] = ztable_eval(val_str, table, parameters)
            end)
        else
            tokens = split(statement, ":")
            if #tokens > 1 then
                table[deli(tokens, 1)] = tokens
                for key,val_str in pairs(tokens) do
                    tokens[key] = ztable_eval(val_str, table, parameters)
                end
            else
                add(table, ztable_eval(statement, table, parameters))
            end
        end
    end)
    return table
end

-- test (39 tokens)
local tbl = ztable_no_cache("1;2;3;4;5;a:hello:world;b=c=d=@", "yes", "it", "works")
foreach(tbl, function(val) print(val) end)
foreach(tbl.a, function(val) print(val) end)
print(tbl.b) print(tbl.c) print(tbl.d)
