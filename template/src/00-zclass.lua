-- 190 tokens

-- zclass specifies a template for how objects of a type are constructed. A
-- single string is passed in as a parameter. A pipe separates the two parts of
-- that string. The first part contains a csv list of strings, the first item
-- in that list is the name of this "class", while the remaining items are
-- classes to inherit from (parents). The second part of the string is a zobj
-- definition specifying values.

g_zclass_constructors, g_zclass_entities, g_zclass_new_entities = {}, {}, {}
function zclass(meta_and_att_str)
    local meta, template = unpack(split(meta_and_att_str, '|'))
    local parents = split(meta)
    local class = deli(parents, 1)

    g_zclass_constructors[class] = function(inst, done, ...)
        foreach(parents, function(parent)
            if not done[parent] then g_zclass_constructors[parent](inst, done) end
        end)

        done[class] = true -- Mark to avoid initializing this class twice.
        add(g_zclass_new_entities, {class, inst}) -- Mark for addition to ECS (may be overridden by templates).

        return zobj_set(inst, template, ...)
    end

    _g[class] = function(...) return g_zclass_constructors[class]({}, {}, ...) end
end

-- This function drains newly-created entities into the ECS. It should preferably
-- be called near the beginning of each iteration of the game loop.

-- You can make a class inherit the information of parents but NOT be added to that
-- parent's class group by setting the parent key to 'ignore'. Ex, instances of this
-- actorwithoutparent zclass will be in the actorwithoutparent group, but not the
-- actor group: zclass[[actorwithoutparent,actor|actor,ignore]]

function register_zobjs()
    while #g_zclass_new_entities > 0 do
        local class, inst = unpack(deli(g_zclass_new_entities))
        g_zclass_entities[class] = g_zclass_entities[class] or {}
        if inst[class] ~= 'ignore' then add(g_zclass_entities[class], inst) end
    end
end

-- Removes a zobj from all the entity groups it was in when registered.
function deregister_zobj(inst)
    for class, entities in pairs(g_zclass_entities) do
        if inst[class] then del(entities, inst) end
    end
end

-- Call a function if the table and the table value are not nil.
function call_not_nil(table, key, ...)
    if table and table[key] then
        return table[key](...)
    end
end

-- Loop through all the entities of a certain type and call a method on each one if that method exists.
function loop_zobjs(class, method_name, ...)
    for inst in all(g_zclass_entities[class]) do
        call_not_nil(inst, method_name, inst, ...)
    end
end
