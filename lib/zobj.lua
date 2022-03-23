-- 161 tokens

-- zobj specifies a template for how objects of a type are constructed. a
-- single string is passed in as a parameter. a pipe separates the two parts of
-- that string. the first part contains a list of strings, the first item in that
-- list is the name of this "class", while the remaining items are classes to
-- inherit from (parents). the second part of the string is a ztable definition
-- specifying values.

g_zobj_parents, g_zobj_arrs, g_zobj_register_queue = {}, {}, {}
function zobj(meta_and_att_str)
    local meta, template = unpack(split(meta_and_att_str, '|'))
    local parents = ztable(meta)
    local id = deli(parents, 1)

    g_zobj_parents[id] = function(a, ...)
        foreach(parents, function(parent)
            if not a[parent] then
                g_zobj_parents[parent](a)

                a[parent] = true
                add(g_zobj_register_queue, {parent, a})
            end
        end)
        return ztable_set(a, template, ...)
    end

    _g[id] = function(...)
        return g_zobj_parents[id]({}, ...)
    end
end

-- this function goes removes objects from the registration queue and adds the
-- objects waiting to be registered into global list of objects. this should
-- preferably be called near the beginning of each iteration of the game loop.
function register_zobjs()
    while #g_zobj_register_queue > 0 do
        local id, a = unpack(deli(g_zobj_register_queue))
        g_zobj_arrs[id] = g_zobj_arrs[id] or {}
        add(g_zobj_arrs[id], a)
    end
end

-- removes a zobj from all the array groups it was in when registered.
function deregister_zobj(a)
    for k, v in pairs(g_zobj_arrs) do
        if a[k] then del(v, a) end
    end
end

-- loop through all the actors of a certain type and call a method on each one if that method exists.
function loop_zobjs(id, method_name, ...)
    for a in all(g_zobj_arrs[id]) do
        call_not_nil(a, method_name, a, ...)
    end
end
