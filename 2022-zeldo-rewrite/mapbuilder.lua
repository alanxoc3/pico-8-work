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
    zprint("["..g_link_grid.xsel..","..g_link_grid.ysel.."]", 129, 1, 1, 7)

    if g_mouse_enabled then
        line(g_mouse_x-2, g_mouse_y-2, g_mouse_x+2, g_mouse_y+2, 7)
        line(g_mouse_x-2, g_mouse_y+2, g_mouse_x+2, g_mouse_y-2, 7)
    end
end

g_rooms = {} -- array
g_link_map = {} -- double array
g_mouse_frame_limit = 0
g_mouse_frame_limit_max = 6
function get_room(x, y) return g_link_map[y] and g_link_map[y][x] and g_rooms[g_link_map[y][x]] end
function del_room(x, y) local room = get_room(x, y) if room then del(g_rooms, room) g_link_map[y][x] = nil end end
function new_room(room) add(g_rooms, room) g_link_map[g_link_grid.ysel] = g_link_map[g_link_grid.ysel] or {} g_link_map[g_link_grid.ysel][g_link_grid.xsel] = #g_rooms end

function link_update(key)
    g_mouse_frame_limit = (g_mouse_frame_limit+1) % g_mouse_frame_limit_max
    local new_link_x, new_link_y = g_link_grid.xsel, g_link_grid.ysel
    if key == ' ' then
        if not get_room(g_link_grid.xsel, g_link_grid.ysel) then
            new_room{ c=rnd(16) }
        end

        g_mode = g_modes.tile
    elseif key == '⁸' then -- backspace
        del_room(g_link_grid.xsel, g_link_grid.ysel)
    else
        if g_mouse_enabled then
            if g_mouse_frame_limit == 0 then
                new_link_x = g_link_grid.xcen+flr((g_mouse_x-63)/14+.5)
                new_link_y = g_link_grid.ycen+flr((-Y_OFFSET+g_mouse_y-63)/14+.5)
            end
        else
            new_link_x += xbtnp()
            new_link_y += ybtnp()
        end
    end

    -- update link x
    g_link_grid.xsel  = min(g_link_grid.xmax, max(g_link_grid.xmin, new_link_x))
    local dist, sign = abs(g_link_grid.xcen - g_link_grid.xsel), sgn(g_link_grid.xcen - g_link_grid.xsel)
    if dist > 3 then g_link_grid.xcen = g_link_grid.xsel + sign*3 end
    g_link_grid.xcen = max(min(g_link_grid.xcen, g_link_grid.xmax-3), g_link_grid.xmin+3)

    -- update link y
    g_link_grid.ysel = min(g_link_grid.ymax, max(g_link_grid.ymin, new_link_y))
    local dist, sign = abs(g_link_grid.ycen - g_link_grid.ysel), sgn(g_link_grid.ycen - g_link_grid.ysel)
    if dist > 2 then g_link_grid.ycen = g_link_grid.ysel + sign*2 end
    g_link_grid.ycen = max(min(g_link_grid.ycen, g_link_grid.ymax-2), g_link_grid.ymin+2)
end

-- function mouse_to_grid() end
-- function update_grid() end

function draw_grid(g)
    local cww = g.xcel + g.xpad
    local chh = g.ycel + g.ypad

    local offx = g.xoff - g.xcen*cww - g.xpad
    local offy = g.yoff - g.ycen*chh - g.ypad

    local offcbx = offx+g.xpad/2
    local offcby = offy+g.ypad/2
    local offcex = offx+g.xpad/2+g.xcel-1
    local offcey = offy+g.ypad/2+g.ycel-1

    local offbex = offcex+(g.xmax)*cww
    local offbey = offcey+(g.ymax)*chh

    for i=g.xmin,g.xmax do g.rect_grid(offcbx+i*cww, offcby,       offcbx+i*cww,  offbey      ) end
    for i=g.xmin,g.xmax do g.rect_grid(offcex+i*cww, offcby,       offcex+i*cww,  offbey      ) end
    for i=g.ymin,g.ymax do g.rect_grid(offcbx,       offcby+i*chh, offbex,        offcby+i*chh) end
    for i=g.ymin,g.ymax do g.rect_grid(offcbx,       offcey+i*chh, offbex,        offcey+i*chh) end
    g.rect_boundary(offcbx, offcby, offbex, offbey)

    for i=0,g.xmax do
        for j=0,g.ymax do
            --g.rect_cell(offx-gw/2*cww+i*cww, offy-g.ymax*chh+j*chh, offx-gw/2*cww+i*cww+g.xcel, offy-g.ymax*chh+j*chh+g.ycel)
        end
    end

    g.rect_select(offcbx+g.xsel*cww, offcby+g.ysel*chh, offcbx+g.xsel*cww+g.xcel-1, offcby+g.ysel*chh+g.ycel-1)
end

g_link_grid = {
    xsel=8,  ysel=8,
    xcen=8,  ycen=8,
    xmin=0,  ymin=0,
    xmax=15, ymax=15,
    xcel=12, ycel=10,
    xpad=2,  ypad=2,
    xoff=57, yoff=45,

    rect_grid     = function(x1,y1,x2,y2) moving_grid_fill(function() rect(x1,y1,x2,y2,1) end) end,
    rect_boundary = function(x1, y1, x2, y2) rect(x1-2,y1-2,x2+2,y2+2,1) end,
    rect_select   = function(x1, y1, x2, y2) rect(x1-1,y1-1,x2+1,y2+1,7) end,
    rect_cell     = function(x1, y1, x2, y2) rect(x1,y1,x2,y2,4) end
}

function link_draw()
    draw_grid(g_link_grid)

    draw_bottom_screen(function() end)
end

function moving_grid_fill(callback)
    fillp(t() % 1 < .25 and 0b1100011000111001 or
          t() % 1 < .5  and 0b0110001110011100 or
          t() % 1 < .75 and 0b0011100111000110 or 0b1001110001100011)
    callback()
    fillp()
end

g_tile_grid = {
    xsel=6,  ysel=5,
    xcen=6,  ycen=5,
    xmin=0,  ymin=0,
    xmax=11, ymax=9,
    xcel=8,  ycel=8,
    xpad=0,  ypad=0,
    xoff=64, yoff=50,

    rect_grid     = function(x1,y1,x2,y2) moving_grid_fill(function() rect(x1,y1,x2,y2,1) end) end,
    rect_boundary = function(x1, y1, x2, y2) rect(x1,y1,x2,y2,8) end,
    rect_select   = function(x1, y1, x2, y2) rect(x1,y1,x2,y2,8) end,
    rect_cell     = function(x, y) spr(15,x,y) end
}

function tile_update(key)
    local new_tile_x, new_tile_y
    if g_mouse_enabled then
        new_tile_x = flr((g_mouse_x-64+ROOM_W/2*8)/8-.125)
        new_tile_y = flr((-Y_OFFSET+g_mouse_y-64+ROOM_H/2*8)/8-.125)
    else
        new_tile_x = g_tile_grid.xsel + xbtnp()
        new_tile_y = g_tile_grid.ysel + ybtnp()
    end

    g_tile_grid.xsel = min(ROOM_W-1, max(0, new_tile_x))
    g_tile_grid.ysel = min(ROOM_H-1, max(0, new_tile_y))

    if key == ' ' then
        g_mode = g_modes.link
    elseif key == 'm' then
        g_mode = g_modes.link
    end
end

function draw_bottom_screen(callback)
    local y = 93
    rectfill(0,y,127,127,0)
    rect(0,y-1,127,y+1,0)
    rect(0,y,127,y,7)
    rect(0,y+1,127,y+1,7)
    camera(0, -y-3)
    callback()
    camera()
end

function tile_draw()
    draw_grid(g_tile_grid)

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
