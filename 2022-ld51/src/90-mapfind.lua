function find_in_room(sind, def_x, def_y)
    for y=g_bounds.ty_off,g_bounds.ty_off+g_bounds.h-1 do
        for x=g_bounds.tx_off,g_bounds.tx_off+g_bounds.w-1 do
            if mget(x, y) == sind then
                return x-g_bounds.tx_off+.5, y-g_bounds.ty_off+.5
            end
        end
    end
    return def_x, def_y
end
