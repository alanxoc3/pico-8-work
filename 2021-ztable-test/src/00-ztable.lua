-- Perl preprocessor replaces the constant below.
-- 1224 is original
-- 1159 is next
-- 1313 is next i think
-- 1286 is next i think
-- 1375 is next i think
-- 1368 is next i think

function nf()
end

_g, g_ztable_cache, g_gunvals = {}, {}, split('ZTABLE_STRINGS', '|')
function ztable(original_str, ...)
    local str, index, params = g_gunvals[0+original_str], 0, {...}
    local tbl, ops = unpack(g_ztable_cache[str] or {})

    -- Create the table if it isn't in the cache.
    if not tbl then
        tbl, ops = {}, {}
        local path, relative_path, indextbl = {'#'}, {}, {}
        local is_relative = true

        -- Get first level of table in order.
        for item in all(split(str, ';')) do
            local vals = split(item, ':')
            local key = deli(vals, 1)
            if key == '' then key = '#' end

            if not is_relative then
                path = relative_path
            end

            local newpath = split(key, '.')
            if newpath[1] == '' then
                deli(newpath, 1)
                is_relative = true
            else
                path = {}
                is_relative = false
            end
            
            relative_path = newpath

            for val in all(vals) do
                local finalkey
                local prevtbl, subtbl = tbl, tbl

                for i=1,#path do
                    finalkey = path[i]
                    if finalkey == '#' then
                        indextbl[subtbl] = (indextbl[subtbl] or 1)
                        path[i] = indextbl[subtbl]
                        finalkey = indextbl[subtbl]
                    end

                    if type(subtbl[finalkey]) ~= "table" then
                        subtbl[finalkey] = {}
                    end

                    prevtbl = subtbl
                    subtbl = subtbl[finalkey]
                end

                for i=1,#relative_path do
                    finalkey = relative_path[i]
                    if finalkey == '#' then
                        indextbl[subtbl] = (indextbl[subtbl] or 0) + 1
                        finalkey = indextbl[subtbl]
                    end

                    if type(subtbl[finalkey]) ~= "table" then
                        subtbl[finalkey] = {}
                    end

                    prevtbl = subtbl
                    subtbl = subtbl[finalkey]
                end

                if val == '@' then
                    local ind = index + 1
                    add(ops, {
                        prevtbl, finalkey, function(p)
                            return p[ind]
                        end
                    })
                    index += 1
                elseif val == 'yes'  then val = true
                elseif val == 'no'   then val = false
                elseif val == '' or val == 'null' then val = nil
                elseif val == 'nf'   then val = nf
                end

                prevtbl[finalkey] = val
            end
        end

        g_ztable_cache[str] = {tbl, ops}
    end

    foreach(params, disable_tabcpy)
    foreach(ops, function(op)
        local t, k, f = unpack(op)
        t[k] = f(params)
    end)

    return tbl
end

function disable_tabcpy(t)
    if type(t) == 'table' then
        t.is_tabcpy_disabled = true
    end
    return t
end
