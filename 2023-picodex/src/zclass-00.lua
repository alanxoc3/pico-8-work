-- 266 tokens

-- f_zclass specifies a template for how objects of a type are constructed. A
-- single string is passed in as a parameter. A pipe separates the two parts of
-- that string. The first part contains a csv list of strings, the first item
-- in that list is the name of this "class", while the remaining items are
-- classes to inherit from (parents). The second part of the string is a f_zobj
-- definition specifying values.

-- a f_zclass has a few special attributes that should only be overidden in special cases:
-- * id: a string of the class name of the f_zclass
-- * parents: a list of all the ancestors of the f_zclass
-- * deregistered: an optional function that should be called when "" is called
|[f_zclass]| function(template, class, ...)
    local parents = {...}
    _g[class] = function(tbl)
        foreach(parents, function(parent)
            _g[parent](tbl)
        end)
        return f_zobj_set(tbl, template)
    end
end $$

-- Call a function if the table and the table value are not nil.
|[f_call_not_nil]| function(table, key, ...)
    if table and table[key] then
        return table[key](...)
    end
end $$
