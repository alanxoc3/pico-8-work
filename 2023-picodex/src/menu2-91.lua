-- menu can be created or updated.
-- when updated, cursor position remains. entries change.
-- when created, cursor position is 0.

|[menu_state_callback]| function(entry, game)
    if entry.state then
        game:push(entry.state)
    else
        game:pop()
    end
end $$

-- entries: { {select=f(entry, game), disabled=bool} ... }
-- edraw: func(entry, selected)
function create_menu(edraw, disable_cursor, r, w, h, x, y)
    return zobj([[
        edraw,@,
        c,0, v,0, has_cursor,@, r,@,      -- cursor, view, per-row
        w,@, h,@, x,@, y,@, -- camera dimensions
        update,%menu_update,
        draw1,%menu_draw1,
        set,%menu_set,
        cancel,%menu_cancel,
        refresh,%menu_refresh
    ]], edraw, not disable_cursor, r or 1, w or 40, h or 40, x or 0, y or 0)
end

|[menu_refresh]| function(menu, data, mapfunc)
    while deli(menu) do end
    foreach(data, function(thing) add(menu, (mapfunc or nop)(thing)) end)
end $$

|[menu_cancel]| function(game) game:pop() end $$

-- cursor is between 0 and #menu-1. view is set too
|[menu_set]| function(menu, delta)
    local newval = menu.c+delta
    if newval == mid(0, newval, #menu-1) then menu.c = newval end
    menu.c = mid(0, menu.c, #menu-1) -- always ensure the cursor is within bounds

    -- view logic
    if menu.c\menu.r < menu.v   then menu.v = menu.c\menu.r   end
    if menu.c\menu.r > menu.v+2 then menu.v = menu.c\menu.r-2 end
    menu.v = mid(0, menu.v, (#menu-1)\menu.r)
end $$

-- extra args are passed to callback, prob want to pass "game" there.
|[menu_update]| function(menu, game)
    menu:set'0'
    if g_bpu then menu:set(-menu.r) end
    if g_bpd then menu:set( menu.r) end
    if g_bpl then menu:set'-1' end
    if g_bpr then menu:set'1' end

    if g_bpx then
        local entry = menu[menu.c+1]
        if entry.disabled then
            sfx'60'
        elseif entry.select then
            entry.select(entry, game)
        end
    end

    if g_bpo then menu.cancel(game) end
end $$

-- todo: try token crunching here
|[menu_draw1]| function(menu)
    local c, v = menu.c, menu.v
    local y = -10
    local cellw = menu.w\menu.r
    local x1, y1, x2, y2 = menu.x, menu.y, menu.x+menu.w-1, menu.y+menu.h-1

    -- bg shadow
    rectfill(0, y1, 39, y2, 1) -- bg shadow
    rectfill(0, menu.y+5-menu.v*8, 39, menu.y+4+(max(ceil(#menu/menu.r), menu.h\10-1)-menu.v)*10, 5)

    -- selected bg
    --rect    (x-2, y-7, x+cellw+1, y+6, 5)

    for i=0,menu.r*5-1 do
        local entry = menu[(menu.v-1)*menu.r+i+1]
        if entry then
            local x, y = menu.x+i%menu.r*10, menu.y+i\menu.r*10
            rectfill(x, y-5, x+cellw-1, y+4, entry.disabled and 2 or 13)
            zcamera(i%menu.r*cellw+menu.x+cellw/2, menu.y+i\menu.r*10-3, function()
                menu.edraw(entry, false, i%2 == 0)
            end)
        end
    end

    local ii = menu.c
    local x, y = menu.x+ii%menu.r*10, menu.y+(ii\(menu.r)-menu.v)*10+10
    rectfill(x, y-5, x+cellw-1, y+4, menu[ii+1].disabled and 8 or 6)
    zcamera(x+cellw/2, y-3, function()
        menu.edraw(menu[ii+1], true)
    end)
    --rect(x-1, y-6, x+cellw, y+5, 5)
end $$

-- requires a "name" field
|[menu_drawentry]| function(entry, selected)
    wobble_text(entry.name, 0, 0, selected and (entry.disabled and 2 or 13) or (entry.disabled and 1 or 1))
end $$

|[browse_drawentry]| function(entry, selected)
    local pkmn = get_pokemon(entry.num)

    if pkmn then -- todo, is this if check needed?
        pkmn.draw(0, 3, selected and 13 or 5, .375, .375)
    end
end $$
