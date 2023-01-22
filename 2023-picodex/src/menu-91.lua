|[menu_state_callback]| function(a, game)
    if a.state then
        game:push(a.state)
    else
        game:pop()
    end
end $$

-- entries is a list that looks like: { {name="displayname", state="mode-state", desc="description|3|lines"} ... }
-- mem is 2 bytes of memory. first byte is cursor, second byte is view.
function menu_update(game, mem, entries, is_pop_disabled)
    local c, v = peek(mem), peek(mem+1)

    -- wrap
    --if g_bpu then c = (c - 1) % #entries end
    --if g_bpd then c = (c + 1) % #entries end

    -- nowrap
    if g_bpu then c = max(0, c-1) end
    if g_bpd then c = min(#entries-1, c+1) end

    if c < v then v = c end
    if c > v+4 then v = c-4 end

    if g_bpx then
        if entries[c+1].func then
            entries[c+1]:func(game)
        end
    end

    if g_bpo and not is_pop_disabled then game:pop() end

    poke(mem, c%#entries) poke(mem+1, v)
end

function menu_draw1(game, mem, entries)
    local c, v = peek(mem), peek(mem+1)
    local y = (5-min(#entries, 5))*3.5\1

    rectfill(0, y+1+(c-v)*7-(c==0 and 1 or 0), 39, y+10+(c-v)*7+(c==#entries-1 and 1 or 0), 1)

    for i=1,#entries do
        local basey = y+(i-v)*7
        local yoff = 0
        if i < c+1 then yoff -= 2 end
        if i > c+1 then yoff += 1 end
        if i == c+1 then
            wobble_text(entries[i].name, 20, basey-4, 13)
        else
            zprint(entries[i].name, 20, basey-3+yoff, i == c+1 and 13 or 1, 0)
        end
    end
end

function menu_draw3(game, mem, entries)
    print_draw3_message(unpack(split(entries[@mem+1].desc, '|')))
end
