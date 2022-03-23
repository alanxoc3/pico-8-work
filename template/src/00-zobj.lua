-- 199 tokens

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
        local a = g_zobj_parents[id]({}, ...)
        a[id] = true
        add(g_zobj_register_queue, {id, a})
        return a
    end
end

-- this function removes objects from the registration queue and adds the
-- objects waiting to be registered into global list of objects as long as that
-- object has a true value for the id of the global list it wants to be added to.
-- this should preferably be called near the beginning of each iteration of the
-- game loop.

-- you can make an object inherit the information of parents but not be added
-- to that parent's array group by setting the parrent to nil. ex, this
-- actorwithoutparent zobj will be in the actorwithoutparent list, but not the
-- actor list: zobj[[,actorwithoutparent,actor|actor, null]]

function register_zobjs()
    while #g_zobj_register_queue > 0 do
        local id, a = unpack(deli(g_zobj_register_queue))
        g_zobj_arrs[id] = g_zobj_arrs[id] or {}
        if a[id] then add(g_zobj_arrs[id], a) end
    end
end

-- removes a zobj from all the array groups it was in when registered.
function deregister_zobj(a)
    for k, v in pairs(g_zobj_arrs) do
        if a[k] then del(v, a) end
    end
end

-- call a function if the table and the table value are not nil.
function call_not_nil(table, key, ...)
    if table and table[key] then
        return table[key](...)
    end
end

-- loop through all the actors of a certain type and call a method on each one if that method exists.
function loop_zobjs(id, method_name, ...)
    for a in all(g_zobj_arrs[id]) do
        call_not_nil(a, method_name, a, ...)
    end
end
