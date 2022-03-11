-- 127 tokens
_g={}
function _g.array(...)
    return {...}
end

function eval(str, ...)
    local tokens, stack = split(str, " "), {}
    for _, token in ipairs(tokens) do
        if token == ")" then  -- replace the group with its result
            local prev, args = deli(stack), {}
            while prev ~= "(" do
                add(args, prev)
                prev = table.remove(stack)
            end
            local func = table.remove(args)
            for i = 1, #args / 2 do  -- reverse the args
                args[i], args[#args-i+1] = args[#args-i+1], args[i]
            end
            local result = _G[func](unpack(args))
            add(stack, result)
        else
            add(stack, token)
        end
    end
    return deli(stack)
end

eval("( array 1 2 3 4 5)")
