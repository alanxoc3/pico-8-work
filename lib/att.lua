-- 76 tokens
g_parent, g_act_arrs = {}, {}
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
        local a = g_parent[id]({}, ...)

        g_act_arrs[id] = g_act_arrs[id] or {}
        add(g_act_arrs[id], a)

        a.delete = function()
            for k, v in pairs(g_act_arrs) do
                if a[k] then del(v, a) end
            end
        end

        return a
    end
end
