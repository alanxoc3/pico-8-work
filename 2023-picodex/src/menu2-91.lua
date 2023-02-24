-- todo: test xbtn & ybtn token count vs not having them
-- menu can be created or updated.
-- when updated, cursor position remains. entries change.
-- when created, cursor position is 0.

|[f_menu_state_callback]| function(game, entry)
    if entry.state then
        game:push(entry.state)
    else
        game:pop()
    end
end $$

-- maybe remove x&y? and w/h? -- those are only needed for 1 thing...
-- and replace with view bounds?
|[f_create_menu_view]| function(edraw, viewmin)
    return f_zobj([[
        edraw,@, viewmin,@, v,~viewmin, r,1,
        update,%f_menu_view_update,
        draw1,%f_menu_draw1,
        cancel,%f_menu_cancel,
        refresh,%f_menu_refresh
    ]], edraw, viewmin or 0)
end $$

-- entries: { {select=f(game, entry), disabled=bool} ... }
-- edraw: func(entry, selected)
|[f_create_menu]| function(edraw, r)
    return f_zobj_set(f_create_menu_view(edraw), [[
        c,0, -- cursor
        r,@,
        update,%f_menu_update,
        set,%f_menu_set
    ]], r or 1)
end $$

|[f_menu_refresh]| function(menu, data, mapfunc)
    while _deli(menu) do end
    for i=1,#data do
        _add(menu, (mapfunc or f_nop)(data[i], i))
    end
end $$

|[f_menu_cancel]| function(game) game:pop() end $$

-- cursor is between 0 and #menu-1. view is set too
|[f_menu_set]| function(menu, delta)
    local newval = menu.c+delta
    if newval == _mid(0, newval, #menu-1) then menu.c = newval end
    menu.c = _mid(0, menu.c, #menu-1) -- always ensure the cursor is within bounds

    -- view logic
    if menu.c\menu.r < menu.v   then menu.v = menu.c\menu.r   end
    if menu.c\menu.r > menu.v+2 then menu.v = menu.c\menu.r-2 end
    menu.v = _mid(0, menu.v, (#menu-1)\menu.r)
end $$

-- todo: remove bpl/bpr, they should have special logic instead (should it be overriden per thing?)
|[f_menu_view_update]| function(game)
    local menu = game.menu
    if g_bpo then menu.cancel(game) end
    if g_bpu then menu.v-=1 end
    if g_bpd then menu.v+=1 end
    menu.v = _mid(menu.viewmin, menu.v, #menu-3)
end $$

-- extra args are passed to callback, prob want to pass "game" there.
|[f_menu_update]| function(game)
    local menu = game.menu
    menu:set'0'
    if g_bpu then menu:set(-menu.r) end
    if g_bpd then menu:set( menu.r) end
    if g_bpl then menu:set'-1' end
    if g_bpr then menu:set'1' end

    if g_bpx then
        local entry = menu[menu.c+1]
        if entry.disabled   then f_beep()
        elseif entry.select then entry.select(game, entry)
        end
    end

    if g_bpo then menu.cancel(game) end
end $$

-- todo: try token crunching here
-- 4 styles: 13,1 6,13 2,1, 8,2
c_menustyles = f_zobj[[
    ;bg,13, fg,1,  out,5
   ;;bg,6,  fg,13, out,13
   ;;bg,5,  fg,1, out,1
   ;;bg,6,  fg,5,  out,5
   ;;bg,1,  fg,13,  out,5 -- this one is for credit/winmenu headers
]]

|[f_menu_draw1]| function(game)
    local menu = game.menu
    local c, v = menu.c, menu.v
    local y = -10
    local cellw = menu.r > 1 and 10 or 40
    local y1, y2 = 0, 39
    local xoff = 20-(menu.r * cellw)/2

    -- bg shadow
    _rectfill(0, y1, 39, y2, 1) -- bg shadow
    _rectfill(0, 0+5-menu.v*10, 39, 0+4+(_max(_ceil(#menu/menu.r), 40\10-1)-menu.v)*10, 13)

    -- selected bg
    --_rect    (x-2, y-7, x+cellw+1, y+6, 5)

    for i=-1,menu.r*5-1 do
        local index = (menu.v-1)*menu.r+i+1
        local entry = menu[index]
        local style_ind, x, y = (entry or {style=0}).style or 1, xoff+i%menu.r*10, 0+i\menu.r*10

        if entry then
            if entry.disabled then style_ind = 3 end
            if index-1 == menu.c then style_ind += 1 end
        end

        local style = c_menustyles[style_ind]

        if entry and not entry.hidden then
            _rectfill(x, y-5, x+cellw-1, y+4, style.bg)
            f_zcamera(i%menu.r*cellw+xoff+cellw/2, 0+i\menu.r*10-3, function()
                menu.edraw(entry, style)
            end)
        end
    end
end $$

-- requires a "name" field
|[f_menu_drawentry]| function(entry, style)
    if entry.pkmn then
        local pkmn = f_get_pokemon(entry.pkmn)
        local style = c_bg_styles[c_types[pkmn.type1].bg]
        _rectfill(0-20,    5-10+3, 39-20, 24-10+3,style.bg)
        _rectfill(0-20,   21-10+3, 39-20, 24-10+3,style.aa)
        pkmn.draw(20-20, -5+20-10+3, style.aa, 1, 1)
    else
        f_wobble_text(entry.name, 0, 0, style.fg)
    end
end $$

|[f_browse_drawentry]| function(entry, style)
    f_draw_pkmn_out(entry.num, 0, 3, style.out, .375, .375)
end $$
