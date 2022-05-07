ROOM_H=10 ROOM_W=12
Y_OFFSET=-14
function update_mouse() 
    g_mouse_x, g_mouse_y = stat(32), stat(33)
end

function load_assets() reload(0, 0, 0x4300, 'game.p8') end
function _init()
    poke(0x5f2d, 1) -- enable keyboard
    load_assets()
    update_mouse()
    g_mouse_enabled = false
    g_sub_modes = { "config", "tile" }
    g_sub_mode_index = 1

    g_modes = {
        link = {
            name = "link", update = link_update, draw = link_draw,
            help = {
                "arrow: switch room",
                "space: tile mode",
                "m: toggle mouse",
                "d: delete room",
                "tab: switch active",
                "r: reload cart data"
            }
        },
        tile = {
            name = "tile", update = tile_update, draw = tile_draw,
            help = {
                "arrow: switch tile",
                "backspace: link mode",
                "m: toggle mouse",
                "tab: switch active",
                "r: reload cart data"
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
    update_mouse()

    local is_keydown, char = stat(30)
    if is_keydown then char = stat(31) end

    if char == "h"     then char = nil g_help_on = not g_help_on
    elseif char == "m" then char = nil g_mouse_enabled = not g_mouse_enabled
    elseif char == "r" then char = nil load_assets()
    end

    get_mode().update(char)
end

function _draw()
    cls()
    get_mode().draw()

    rectfill(0, 0, 127, 6, 1)
    zprint("mode: "..g_mode.name, 1, 1, -1, 7)
    zprint("["..g_link_x..","..g_link_y.."]", 129, 1, 1, 7)

    if g_mouse_enabled then
        line(g_mouse_x-2, g_mouse_y-2, g_mouse_x+2, g_mouse_y+2, 7)
        line(g_mouse_x-2, g_mouse_y+2, g_mouse_x+2, g_mouse_y-2, 7)
    end
end

g_rooms = {} -- array
g_link_map = {} -- double array
g_link_min_x, g_link_min_y, g_link_max_x, g_link_max_y = 0, 0, 15, 15
g_link_x, g_link_y = 4, 3
g_link_cx, g_link_cy = 4, 3
g_link_zoom_default = 1
g_link_zoom = g_link_zoom_default
g_mouse_frame_limit = 0
g_mouse_frame_limit_max = 6
function get_room(x, y) return g_link_map[y] and g_link_map[y][x] and g_rooms[g_link_map[y][x]] end
function del_room(x, y) local room = get_room(x, y) if room then del(g_rooms, room) g_link_map[y][x] = nil end end
function new_room(room) add(g_rooms, room) g_link_map[g_link_y] = g_link_map[g_link_y] or {} g_link_map[g_link_y][g_link_x] = #g_rooms end

function link_update(key)
    g_mouse_frame_limit = (g_mouse_frame_limit+1) % g_mouse_frame_limit_max
    local new_link_x, new_link_y = g_link_x, g_link_y
    if key == ' ' then
        if not get_room(g_link_x, g_link_y) then
            new_room{ c=rnd(16) }
        end

        g_mode = g_modes.tile
    elseif key == '⁸' then -- backspace
        del_room(g_link_x, g_link_y)
    else
        if g_mouse_enabled then
            if g_mouse_frame_limit == 0 then
                new_link_x = g_link_cx+flr((g_mouse_x-63)/14+.5)
                new_link_y = g_link_cy+flr((-Y_OFFSET+g_mouse_y-63)/14+.5)
            end
        else
            new_link_x += xbtnp()
            new_link_y += ybtnp()
        end
    end

    -- update link x
    g_link_x = min(g_link_max_x, max(g_link_min_x, new_link_x))
    local dist, sign = abs(g_link_cx - g_link_x), sgn(g_link_cx - g_link_x)
    if dist > 3 then g_link_cx = g_link_x + sign*3 end
    g_link_cx = max(min(g_link_cx, g_link_max_x-3), g_link_min_x+3)

    -- update link y
    g_link_y = min(g_link_max_y, max(g_link_min_y, new_link_y))
    local dist, sign = abs(g_link_cy - g_link_y), sgn(g_link_cy - g_link_y)
    if dist > 2 then g_link_cy = g_link_y + sign*2 end
    g_link_cy = max(min(g_link_cy, g_link_max_y-2), g_link_min_y+2)
end

g_link_zoom = 1
function link_draw()
    local rooms_visited = {}
    local rw, rh = g_link_zoom*6, g_link_zoom*5
    local x_spacing = g_link_zoom*14
    local y_spacing = g_link_zoom*12
    local cx, cy = 64, 64+Y_OFFSET
    local hx_spacing, hy_spacing = x_spacing/2, y_spacing/2

    fillp(0b0111101111011110)
    rectfill(cx-g_link_cx*x_spacing-hx_spacing,   cy-g_link_cy*y_spacing-hy_spacing,   cx-g_link_cx*x_spacing+g_link_max_x*x_spacing+hx_spacing,   cy-g_link_cy*y_spacing+g_link_max_y*y_spacing+hy_spacing,   1)
    fillp()
        rect(cx-g_link_cx*x_spacing-hx_spacing-2, cy-g_link_cy*y_spacing-hy_spacing-2, cx-g_link_cx*x_spacing+g_link_max_x*x_spacing+hx_spacing+2, cy-g_link_cy*y_spacing+g_link_max_y*y_spacing+hy_spacing+2, 1)
    for y=g_link_cy-3,g_link_cy+3 do
        for x=g_link_cx-4,g_link_cx+4 do
            local room = get_room(x, y)
            if room then
                zrectfill_outline(cx+(x-g_link_cx)*x_spacing, cy+(y-g_link_cy)*y_spacing, rw, rh, room.c)
            end
        end
    end

    moving_grid_fill(function()
        local xoff, yoff = g_link_x-g_link_cx, g_link_y-g_link_cy
        rect(cx-x_spacing/2+xoff*x_spacing, cy-y_spacing/2+yoff*y_spacing, cx+x_spacing/2+xoff*x_spacing, cy+y_spacing/2+yoff*y_spacing, 7)
    end)

    draw_bottom_screen(function() end)
end

function moving_grid_fill(callback)
    fillp(t() % 1 < .25 and 0b1100011000111001 or
          t() % 1 < .5  and 0b0110001110011100 or
          t() % 1 < .75 and 0b0011100111000110 or 0b1001110001100011)
    callback()
    fillp()
end

g_tile_x, g_tile_y = 0, 0
function tile_update(key)
    local new_tile_x, new_tile_y
    if g_mouse_enabled then
        new_tile_x = flr((g_mouse_x-64+ROOM_W/2*8)/8-.125)
        new_tile_y = flr((-Y_OFFSET+g_mouse_y-64+ROOM_H/2*8)/8-.125)
    else
        new_tile_x = g_tile_x + xbtnp()
        new_tile_y = g_tile_y + ybtnp()
    end

    g_tile_x = min(ROOM_W-1, max(0, new_tile_x))
    g_tile_y = min(ROOM_H-1, max(0, new_tile_y))

    if key == ' ' then
        g_mode = g_modes.link
    elseif key == 'm' then
        g_mode = g_modes.link
    end
end

function draw_bottom_screen(callback)
    rectfill(0,94,127,127,0)
    rect(0,93,127,95,0)
    rect(0,94,127,94,7)
    camera(0, -96)
    callback()
    camera()
end

function draw_grid(gx, gy, gw, gh, gcx, gcy, goffx, goffy, gridrect, boundrect, selectrect)
    boundrect(goffx-gw/2*8-2, goffy-gh/2*8-2, goffx+gw/2*8+2, goffy+gh/2*8+2)
    for i=1,gw-1 do gridrect(goffx-gw/2*8+i*8, goffy-gh/2*8,     goffx-gw/2*8+i*8, goffy+gh/2*8,     1) end
    for i=1,gh-1 do gridrect(goffx-gw/2*8    , goffy-gh/2*8+i*8, goffx+gw/2*8,     goffy-gh/2*8+i*8, 1) end
    selectrect(goffx-gw/2*8+gx*8, goffy-gh/2*8+gy*8, goffx-gw/2*8+gx*8+8, goffy-gh/2*8+gy*8+8)
end

function tile_draw()
    draw_grid(g_tile_x, g_tile_y, ROOM_W, ROOM_H, 0, 0, 64, 64+Y_OFFSET, function(x1,y1,x2,y2)
        moving_grid_fill(function() rect(x1,y1,x2,y2,1) end)
    end,
    function(x1, y1, x2, y2) rect(x1,y1,x2,y2,8) end,
    function(x1, y1, x2, y2) rect(x1,y1,x2,y2,8) end)

    draw_bottom_screen(function()
        sspr(0, 0, 8*16, 8*4, 0, 0)
    end)
end

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
