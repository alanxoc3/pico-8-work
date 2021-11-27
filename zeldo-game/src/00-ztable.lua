-- Perl preprocessor replaces the constant below.

function nf()
end

function ztable(original_str, ...)
    local str = g_gunvals[0+original_str]
    local tbl, ops = unpack(g_ztable_cache[str] or {})

    -- Create the table if it isn't in the cache.
    if not tbl then
        tbl, ops = {}, {}

        -- Get first level of table in order.
        for item in all(split(str, ';')) do
            local k, v = split_kv(item, ':', tbl)

            local val_func = function(sub_val, sub_key, sub_tbl)
                return queue_operation(sub_tbl or tbl, sub_key or k, sub_val, ops)
            end

            local ret_val, items = {}, split(v, ',')
            for item in all(items) do
                local k, v = split_kv(item, '=', ret_val)

                if #items == 1 then
                    ret_val = val_func(v)
                else
                    ret_val[k] = val_func(v, k, ret_val)
                end
            end

            tbl[k] = ret_val
        end

        g_ztable_cache[str] = {tbl, ops}
    end

    -- Add the various parameters to the table.
    local params = {...}
    foreach(params, disable_tabcpy)
    foreach(ops, function(op)
        local t, k, f = unpack(op)
        t[k] = f(params)
    end)

    return tbl
end _g, g_ztable_cache, g_gunvals = {}, {}, split('ZTABLE_STRINGS', '|')

function split_kv(list, delim, tbl)
    local kvs = split(list, delim)
    return kvs[#kvs-1] or #tbl+1, kvs[#kvs]
end

function queue_operation(tbl, k, v, ops)
    local vlist = split(v, '/')
    local will_be_table, func_op, func_name = #vlist > 1

    if ord(v) == 33 then -- ! func
        will_be_table, func_name = true, deli(vlist, 1)

        func_op = {
            tbl, k, function()
                return _g[sub(func_name, 2)](unpack(vlist))
            end
        }
    end

    for i, x in ipairs(vlist) do
        local rest, closure_tbl = sub(x, 2), tbl

        if will_be_table then
            closure_tbl, k = vlist, i
        end

        if ord(x) == 64 then -- @ param
            add(ops, {
                closure_tbl, k, function(p)
                    return p[rest+0]
                end
            })
        elseif ord(x) == 36 then -- $ parent func value
            x = function(a, ...)
                a[rest](a, ...)
            end
        elseif ord(x) == 37 then -- % _g value
            x = _g[rest]
        elseif ord(x) == 126 then -- ~ tbl value
            add(ops, {
                closure_tbl, k, function()
                    return tbl[rest]
                end
            })
        elseif x == 'yes' or x == 'no' then x = x=='yes'
        elseif x == 'null' or x == '' then x = nil
        elseif x == 'nf' then x = nf
        end
        vlist[i] = x
    end

    -- nil func_op won't actually add.
    add(ops, func_op)

    if will_be_table then
        return vlist
    else
        return vlist[1]
    end
end

function disable_tabcpy(t)
    if type(t) == 'table' then
        t.is_tabcpy_disabled = true
    end
    return t
end

function new_ztable(original_str, ...)
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
