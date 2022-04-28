function _init()
    poke(0x5f2d, 1) -- enable keyboard

    g_sub_modes = { "config", "tile" }
    g_sub_mode_index = 1

    g_modes = {
        link = {
            name = "link", update = link_update, draw = link_draw,
            help = {
                "arrow: switch room",
                "space: edit room",
                "backspace: delete room",
                "u: undo",
                "r: redo"
            }
        },
        edit = {
            name = "edit", update = edit_update, draw = edit_draw,
            help = {
                "w: edit"
            }
        },
        help = {
            name = "help", update = help_update, draw = help_draw
        }
    }

    g_mode = g_modes.link
end

function get_mode()
    return g_help_on and g_modes.help or g_mode
end

function _update60()
    local is_keydown, char = stat(30)
    if is_keydown then char = stat(31) end

    if char == "h"     then char = nil g_help_on = not g_help_on
    end

    get_mode().update(char)
end

function _draw()
    cls()
    get_mode().draw()

    rectfill(0, 0, 127, 10, 1)
    zprint("mode: "..g_mode.name, 5, 3, -1, 7)
    zprint("["..g_link_x..","..g_link_y.."]", 127-5, 3, 1, 7)
end

g_rooms = {} -- array
g_link_map = {} -- double array
g_link_x, g_link_y = 0, 0
g_zoom_default = 1.5
g_link_zoom = g_zoom_default
function get_room(x, y) return g_link_map[y] and g_link_map[y][x] and g_rooms[g_link_map[y][x]] end
function del_room(x, y) local room = get_room(x, y) if room then del(g_rooms, room) g_link_map[y][x] = nil end end
function new_room(room) add(g_rooms, room) g_link_map[g_link_y] = g_link_map[g_link_y] or {} g_link_map[g_link_y][g_link_x] = #g_rooms end

function link_update(key)
    if key == ' ' then
        if not get_room(g_link_x, g_link_y) then
            new_room{ w=flr(rnd(8))*2+8, h=flr(rnd(8))*2+8, c=rnd(16) }
        end

        g_mode = g_modes.edit
    elseif key == '⁸' then -- backspace
        del_room(g_link_x, g_link_y)
    elseif key == '+' then -- backspace
        g_link_zoom = min(g_link_zoom+.25, 3)
    elseif key == '-' then -- backspace
        g_link_zoom = max(g_link_zoom-.25, 1)
    elseif key == '=' then -- backspace
        g_link_zoom = g_zoom_default
    else
        if xbtnp() ~= 0 then
            g_link_x += xbtnp()
        elseif ybtnp() ~= 0 then
            g_link_y += ybtnp()
        end
    end
end

function link_draw()
    local rooms_visited = {}
    local spacing = 30
    local cx, cy = 64, (127-10)/2+10

    for y=g_link_y-2,g_link_y+2 do
        for x=g_link_x-2,g_link_x+2 do
            local room = get_room(x, y)
            if room then
                zrectfill_outline(cx+(x-g_link_x)*g_link_zoom*spacing, cy+(y-g_link_y)*g_link_zoom*spacing, (room.w/2)*g_link_zoom, (room.h/2)*g_link_zoom, 1, room.c)
            else
                pset(cx+(x-g_link_x)*g_link_zoom*spacing, cy+(y-g_link_y)*g_link_zoom*spacing, 1)
            end
        end
    end

    fillp(t() % 1 < .25 and 0b1100011000111001 or
          t() % 1 < .5  and 0b0110001110011100 or
          t() % 1 < .75 and 0b0011100111000110 or 0b1001110001100011)
    
    zrect(cx, cy, g_link_zoom*spacing/2-1, g_link_zoom*spacing/2-1, 7)
    fillp()
end

function edit_update(key)
    if key == ' ' then
        g_mode = g_modes.link
    end
end
function edit_draw() return g_mode.name end

function help_update() end
function help_draw()
    local top_align, left_align = 16, 5
    local texts = {
        "h: toggle help",
        "------------------------------"
    }

    for _, helptext in pairs(g_mode.help) do
        add(texts, helptext)
    end

    for i, t in pairs(texts) do
        zprint(t, left_align, (i-1)*8+top_align, -1, 7)
    end

    return "help "..g_mode.name
end

-- UTIL
function btn_helper(f, a, b) return f(a) and f(b) and 0 or f(a) and 0xffff or f(b) and 1 or 0 end
function xbtn() return btn_helper(btn, 0, 1) end
function ybtn() return btn_helper(btn, 2, 3) end
function xbtnp() return btn_helper(btnp, 0, 1) end
function ybtnp() return btn_helper(btnp, 2, 3) end

function zrect(x, y, rx, ry, c)
    rect(x-rx, y-ry, x+rx, y+ry, c)
end

function zrectfill(x, y, rx, ry, c)
    rectfill(x-rx, y-ry, x+rx, y+ry, c)
end

function zrectfill_outline(x, y, rx, ry, fg, bg)
    rectfill(x-rx, y-ry, x+rx, y+ry, bg)
    rect(x-rx, y-ry, x+rx, y+ry, fg)
end

function zspr(sind, x, y, sw, sh, ...)
   sw, sh = sw or 1, sh or 1
   spr(sind, x-sw*4, y-sh*4, sw, sh, ...)
end

function zprint(str, x, y, align, color)
    if align == 0    then x -= #str*2
    elseif align > 0 then x -= #str*4+1 end
    print(str, x, y, color)
end

