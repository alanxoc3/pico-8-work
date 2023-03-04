-- menu can be created or updated.
-- when updated, cursor position remains. entries change.
-- when created, cursor position is 0.

-- entry has:
-- - name|pkmn
-- - select
-- - disabled
-- - hidden
-- - state

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

|[f_menu_cancel]| function(game)
    game:pop()
    f_beep_back()
end $$

-- cursor is between 0 and #menu-1. view is set too
|[f_menu_set]| function(menu, delta, is_ud)
    if is_ud then
        local newval = menu.c+delta*menu.r
        if newval == _mid(0, newval, #menu-1) then
            menu.c = newval
            if 0+delta ~= 0 then f_beep_back() end
        else
            f_beep()
        end
    else
        local newval = menu.c+delta
        local left = menu.c - menu.c%menu.r
        if newval == _mid(left, newval, left + menu.r-1) then
            menu.c = newval
            if 0+delta ~= 0 then f_beep_back() end
        else
            f_beep()
        end
    end

    menu.c = _mid(0, menu.c, #menu-1) -- always ensure the cursor is within bounds

    -- view logic
    if menu.c\menu.r < menu.v   then menu.v = menu.c\menu.r   end
    if menu.c\menu.r > menu.v+2 then menu.v = menu.c\menu.r-2 end
    menu.v = _mid(0, menu.v, (#menu-1)\menu.r)
end $$

|[f_menu_view_update]| function(game)
    local menu = game.menu
    if g_bpo then menu.cancel(game) end
    if g_bpx then game:xfunc() end
    menu.v+=g_bpv
    if g_bph ~= 0 then game:lrfunc(g_bph) end

    local oldview = menu.v
    menu.v = _mid(menu.viewmin, menu.v, #menu-3)
    if menu.v ~= oldview then
        f_beep()
    elseif g_bpv ~= 0 then
        f_beep_back()
    end
end $$

-- extra args are passed to callback, prob want to pass "game" there.
|[f_menu_update]| function(game)
    local menu = game.menu
    menu:set'0'
    menu:set(g_bpv, true)
    menu:set(g_bph)

    if g_bpx then
        local entry = menu[menu.c+1]
        if entry.disabled then
            f_beep()
        elseif entry.select then
            f_beep_okay()
            entry.select(game, entry)
        end
    end

    if g_bpo then menu.cancel(game) end
end $$

-- 4 styles: 13,1 6,13 2,1, 8,2
c_menustyles = f_zobj[[
    ;bg,13, fg,1,  out,5
   ;;bg,6,  fg,13, out,13
   ;;bg,5,  fg,1,  out,5
   ;;bg,6,  fg,5,  out,5
   ;;bg,1,  fg,13, out,5 -- this one is for credit/winmenu headers
]]

|[f_menu_draw1]| function(game)
    local menu = game.menu
    local cellw = menu.r > 1 and 10 or 40
    local xoff = 20-(menu.r * cellw)/2

    -- bg shadow
    f_zcall(_rectfill, [[
       ;,0,0,39,39,1 -- bg shadow
      ;;,0,@,39,@,13 -- fg grey
    ]], 5-menu.v*10, 4+(_max(_ceil(#menu/menu.r), 3)-menu.v)*10)

    for i=-1,menu.r*5-1 do
        local index = (menu.v-1)*menu.r+i+1
        local entry = menu[index]

        if entry then
            local style_ind, x, y = entry.style or 1, xoff+i%menu.r*10, i\menu.r*10
            if entry.disabled then style_ind = 3 end
            if index-1 == menu.c then style_ind += 1 end

            if not entry.hidden then
                _rectfill(x, y-5, x+cellw-1, y+4, c_menustyles[style_ind].bg)
                f_zcamera(i%menu.r*cellw+xoff+cellw/2, i\menu.r*10-3, function()
                    menu.edraw(entry, c_menustyles[style_ind])
                end)
            end
        end

    end
end $$

-- requires a "name" field
|[f_menu_drawentry]| function(entry, style)
    if entry.pkmn then
        local style = c_bg_styles[c_types[entry.pkmn.type1].bg]

        f_zcall(_rectfill, [[
           ;,-20,-2,19,17,@
          ;;,-20,14,19,17,@
        ]], style.bg, style.aa)

        entry.pkmn:draw(0,8,style.aa,1,1)
    else
        f_wobble_text(entry.name, 0, 0, style.fg)
    end
end $$

|[f_browse_drawentry]| function(entry, style)
    entry.pkmn:draw(0, 3, style.out, .375, .375)
end $$
