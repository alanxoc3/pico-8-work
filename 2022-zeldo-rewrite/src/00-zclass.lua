-- 266 tokens

-- zclass specifies a template for how objects of a type are constructed. A
-- single string is passed in as a parameter. A pipe separates the two parts of
-- that string. The first part contains a csv list of strings, the first item
-- in that list is the name of this "class", while the remaining items are
-- classes to inherit from (parents). The second part of the string is a zobj
-- definition specifying values.

-- a zclass has a few special attributes that should only be overidden in special cases:
-- * id: a string of the class name of the zclass
-- * parents: a list of all the ancestors of the zclass
-- * ecs_exclusions: a list of class lists that this zclass should not be added to
-- * deregistered: an optional function that should be called when "" is called

g_zclass_constructors, g_zclass_entities, g_zclass_new_entities = {}, {}, {}
function zclass(meta_and_att_str)
    local meta, template, memloc, expected_memloc_value = unpack(split(meta_and_att_str, '|'))
    local parents = split(meta)
    local class = deli(parents, 1)

    -- ensure that entity lists are not nil, useful to always be able to assume this
    g_zclass_entities[class] = g_zclass_entities[class] or {}

    g_zclass_constructors[class] = function(inst, done, ...)
        foreach(parents, function(parent)
            if not done[parent] then g_zclass_constructors[parent](inst, done) end
        end)
        done[class] = true -- avoid initializing class twice
        inst.parents[class] = true -- useful for checking if instance inherits from this class (should not be overridden!)
        add(g_zclass_new_entities, {class, inst}) -- mark for addition to ECS (may be overridden by templates).
        return zobj_set(inst, template, ...)
    end

    _g[class] = function(...) if not memloc or peek(memloc) == expected_memloc_value then return g_zclass_constructors[class]({ id=class, parents={}, ecs_exclusions={} }, {}, ...) end end
end

-- This function drains newly-created entities into the ECS. It should preferably
-- be called near the beginning of each iteration of the game loop.

-- You can make a class inherit the information of parents but NOT be added to that
-- parent's ECS group by setting an exclusion in the template. Ex, instances of this
-- actorwithoutparent zclass will be in the actorwithoutparent group, but not the
-- actor group: zclass[[actorwithoutparent,actor|ecs_exclusions;actor,true]]

function register_entities()
    while #g_zclass_new_entities > 0 do
        local class, inst = unpack(deli(g_zclass_new_entities))
        if not inst.ecs_exclusions[class] then add(g_zclass_entities[class], inst) end
    end
end

-- Removes an entity from all the entity groups it was in when registered.
function deregister_entity(inst, ...)
    call_not_nil(inst, 'deregistered', inst, ...)
    for class, entities in pairs(g_zclass_entities) do
        del(entities, inst)
    end
end

-- Call a function if the table and the table value are not nil.
function call_not_nil(table, key, ...)
    if table and table[key] then
        return table[key](...)
    end
end

-- Check if an entity exists.
function does_entity_exist(entity_name)
    return #g_zclass_entities[entity_name] > 0
end

-- Loop through all the entities of a certain type and call a method on each one if that method exists.
function loop_entities(class, method_name, ...)
    for inst in all(g_zclass_entities[class]) do
        call_not_nil(inst, method_name, inst, ...)
    end
end

-- cleans all zclasses
function clean_all_entities(...)
    local objs_to_clean, exclusions = {}, {}
    foreach({...}, function(exclusion) exclusions[exclusion] = true end)
    
    for class,entities in pairs(g_zclass_entities) do
        for entity in all(entities) do
            objs_to_clean[entity] = entity.id
        end
    end

    for obj,id in pairs(objs_to_clean) do
        if not exclusions[id] then
            deregister_entity(obj)
        end
    end
end
