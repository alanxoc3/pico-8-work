-- Perl preprocessor replaces the constant below.
-- 414 - original
-- 366 - result
_g, g_ztable_cache, g_gunvals = {}, {}, split('ZTABLE_STRINGS', '|')
function ztable(original_str, ...)
    local str, index, params = g_gunvals[0+original_str], 0, {...}
    local tbl, ops = unpack(g_ztable_cache[str] or {})

    -- Create the table if it isn't in the cache.
    if not tbl then
        tbl, ops = {}, {}
        local base_path, relative_path, indextbl = {'#'}, {}, {}

        -- Get first level of table in order.
        for item in all(split(str, ';')) do
            local vals = split(item, ':')
            local key = deli(vals, 1)
            if key == '' then key = '#' end

            local path = split(key, '.')
            if path[1] == '' then
                deli(path, 1)
                relative_path = path
            else
                base_path, relative_path = path
            end
            
            for val in all(vals) do
                local subtbl, finalkey = {tbl}, 1

                for tmppath in all{base_path, relative_path} do
                    for i=1,#tmppath do
                        if type(subtbl[finalkey]) ~= "table" then
                            subtbl[finalkey] = {}
                        end

                        subtbl, finalkey = subtbl[finalkey], tmppath[i]
                        if finalkey == '#' then
                            indextbl[subtbl] = indextbl[subtbl] or 0
                            finalkey = indextbl[subtbl]+1
                            if tmppath == base_path and relative_path then
                                tmppath[i] = finalkey
                            else
                                indextbl[subtbl] = finalkey
                            end
                        end
                    end
                end

                local valchr, valcdr, func = sub(val, 1, 1), sub(val, 2)
                if val == '@' then
                    index += 1 local ind = index
                    func = function(p) return p[ind] end
                elseif val == 'yes' then val = true
                elseif val == 'no' then val = false
                elseif val == 'null' then val = nil
                elseif val == 'nf' then val = function() end
                elseif val == '' then val = subtbl[finalkey]
                elseif valchr == '~' then
                    func = function() return tbl[valcdr] end
                elseif sub(val, 1, 1) == '%' then
                    func = function() return _g[valcdr] end
                end

                subtbl[finalkey] = val

                if func then
                    add(ops, { subtbl, finalkey, func })
                end
            end
        end

        g_ztable_cache[str] = {tbl, ops}
    end

    foreach(params, function(t)
        if type(t) == 'table' then
            t.is_tabcpy_disabled = true
        end
    end)

    foreach(ops, function(op)
        local t, k, f = unpack(op)
        t[k] = f(params)
    end)

    return tbl
end
