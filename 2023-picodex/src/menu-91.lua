|[menu_state_callback]| function(entry, game)
    if entry.state then
        game:push(entry.state)
    else
        game:pop()
    end
end $$

-- entries is a list that looks like: { {name="displayname", state="mode-state", desc="description|3|lines"} ... }
-- mem is 2 bytes of memory. first byte is cursor, second byte is view.
function menu_update(game, key, entries, is_pop_disabled)
    local c, v = g_cursors[key], g_views[key]

    -- nowrap
    if g_bpu then c = max(0, c-1) end
    if g_bpd then c = min(#entries-1, c+1) end

    if c < v+1 then v = c-1 end
    if c > v+3 then v = c-3 end
    if #entries == 1 then v = -1 end
    if #entries == 2 then v = -1 end

    if g_bpx then
        if entries[c+1].func then
            entries[c+1]:func(game)
        end
    end

    if g_bpo and not is_pop_disabled then game:pop() end

    g_cursors[key] = c%#entries
    g_views[key] = v
end

function menu_draw1(game, key, entries)
    local c, v = g_cursors[key], g_views[key]
    local y = -10

    rectfill(0, 0, 39, 39, 1)
    rectfill(-1, -7-v*8+4, 40, (max(#entries, 3)-v)*10-6, 13)

    for i=1,#entries do
        local basey = y+(i-v)*10
        local yoff = 0

        if i == c+1 then
            rectfill(0, yoff+basey-5-3+1, 39-0, yoff+basey+5+1, 5)
            rectfill(0, yoff+basey-5-2+1, 39-0, yoff+basey+4+1, 1)
            rectfill(0, yoff+basey-5-1+1, 39-0, yoff+basey+3+1, 6)
            wobble_text(entries[i].name, 20+t()*2\1%2, yoff+basey-3, 13)
        else
            -- wobble_text(entries[i].name, 20+t()*2\1%2, yoff+basey-3, 13)
            wobble_text(entries[i].name, 20+i%2, basey-3+yoff, 1, 0)
        end
    end
end

function menu_draw3(game, key, entries)
    print_draw3_message(unpack(split(entries[g_cursors[key]+1].desc, '|')))
end
