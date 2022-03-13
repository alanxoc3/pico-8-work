-- 76 tokens
g_parent = {}
function zactor(meta_and_att_str)
    local meta, template = unpack(split(meta_and_att_str, '|'))
    local parents = ztable(meta)
    local id = deli(parents, 1)

    g_parent[id] = function(actor, ...)
        foreach(parents, function(parent)
            if not actor[parent] then
                g_parent[parent](actor)
                actor[parent] = true
            end
        end)
        return ztable_set(actor, template, ...)
    end

    _g[id] = function(...)
        return g_parent[id]({}, ...)
    end
end
