ROOM_H=10 ROOM_W=12
Y_OFFSET=-14

g_mouse_enabled = false
g_mouse_frame_limit = 0
g_mouse_frame_limit_max = 3
g_mouse_x, g_mouse_y = 0, 0
function update_mouse() 
    g_mouse_frame_limit = (g_mouse_frame_limit+1) % g_mouse_frame_limit_max
    g_mouse_x, g_mouse_y = stat(32), stat(33)
end

function load_assets() reload(0, 0, 0x4300, 'game.p8') end
function _init()
    poke(0x5f2d, 1) -- enable keyboard
    load_assets()
    update_mouse()

    g_modes = {
        ['l'] = { name = "link", update = link_update, draw = link_draw },
        ['t'] = { name = "tile", update = tile_update, draw = tile_draw },
        ['h'] = { name = "help", update = help_update, draw = help_draw },
    }
    g_mode = g_modes.l
    g_prev_mode = g_mode
end

function _update60()
    poke(0x5f30,1) -- disable the pause menu
    update_mouse()

    local is_keydown, char = stat(30)
    if is_keydown then char = stat(31) end

    if g_modes[char] then
        if g_mode ~= g_modes[char] then
            g_prev_mode, g_mode = g_mode, g_modes[char]
        end
        char = nil
    elseif char == "\13" then -- return/enter/newline
        char = nil
        g_mode, g_prev_mode = g_prev_mode, g_mode
    elseif char == "m" then char = nil g_mouse_enabled = not g_mouse_enabled
    elseif char == "r" then char = nil load_assets()
    elseif char == "s" then char = nil -- save logic
    elseif char == "u" then char = nil -- undo logic
    elseif char == "r" then char = nil -- redo logic
    elseif char == "	" then char = "tab"
    elseif char == " " then char = "space"
    elseif char == '⁸' then char = "back"
    end

    g_mode.update(char)
end

function _draw()
    cls()
    g_mode.draw()

    rectfill(0, 0, 127, 6, 1)
    zprint("mode: "..g_mode.name, 1, 1, -1, 7)
    zprint("["..g_link_grid.xsel..","..g_link_grid.ysel.."]", 129, 1, 1, 7)

    if g_mouse_enabled then
        line(g_mouse_x-2, g_mouse_y-2, g_mouse_x+2, g_mouse_y+2, 7)
        line(g_mouse_x-2, g_mouse_y+2, g_mouse_x+2, g_mouse_y-2, 7)
    end
end

g_rooms = {} -- double array
function upsert_cur_room()
    local room = get_room(g_link_grid.xsel, g_link_grid.ysel)
    if not room then
        room = {tiles={}, objs={}, c=3}
        new_room(g_link_grid.xsel, g_link_grid.ysel, room)
    end
    return room
end

function get_room(x, y) return g_rooms[y] and g_rooms[y][x] end
function del_room(x, y) if g_rooms[y] then g_rooms[y][x] = nil end end
function new_room(x, y, room)
    if not get_room(x, y) then
        g_rooms[y] = g_rooms[y] or {}
        g_rooms[y][x] = room
    end
end

g_link_pane = true
function link_update(key)
    update_grid(g_link_pane and g_link_grid or g_hut_grid)

    if key == "back"    then del_room(g_link_grid.xsel, g_link_grid.ysel)
    elseif key == "tab" then g_link_pane = not g_link_pane
    end
end

g_tile_pane = true
function tile_update(key)
    upsert_cur_room()
    update_grid(g_tile_pane and g_tile_grid or g_spr_grid)

    if key == "tab" then g_tile_pane = not g_tile_pane
    elseif key == "space" and g_tile_pane then
        upsert_cur_room().tiles[g_tile_grid.ysel*12+g_tile_grid.xsel] = g_spr_grid.ysel*16+g_spr_grid.xsel
    elseif key == "back" and g_tile_pane then
        upsert_cur_room().tiles[g_tile_grid.ysel*12+g_tile_grid.xsel] = nil
    end
end

function update_grid(g)
    local xsel, ysel = g.xsel, g.ysel
    if g_mouse_enabled then
        if g_mouse_frame_limit == 0 then
            xsel = flr(g.xcen+(g_mouse_x-g.xoff)/(g.xcel+g.xpad))
            ysel = flr(g.ycen+(g_mouse_y-g.yoff)/(g.ycel+g.ypad))
        end
    else
        xsel = flr(xsel+xbtnp())
        ysel = flr(ysel+ybtnp())
    end

    g.xsel  = min(g.xmax, max(g.xmin, xsel))
    local dist, sign = abs(g.xcen - g.xsel), sgn(g.xcen - g.xsel)
    if dist > g.xscr then g.xcen = g.xsel + sign*g.xscr end
    g.xcen = max(min(g.xcen, g.xmax-g.xscr), g.xmin+g.xscr)

    g.ysel = min(g.ymax, max(g.ymin, ysel))
    local dist, sign = abs(g.ycen - g.ysel), sgn(g.ycen - g.ysel)
    if dist > g.yscr then g.ycen = g.ysel + sign*g.yscr end
    g.ycen = max(min(g.ycen, g.ymax-g.yscr), g.ymin+g.yscr)
end

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

    g.rect_boundary(offcbx, offcby, offbex, offbey)
    for i=g.xmin,g.xmax do g.rect_grid(offcbx+i*cww, offcby,       offcbx+i*cww,  offbey      ) end
    for i=g.xmin,g.xmax do g.rect_grid(offcex+i*cww, offcby,       offcex+i*cww,  offbey      ) end
    for i=g.ymin,g.ymax do g.rect_grid(offcbx,       offcby+i*chh, offbex,        offcby+i*chh) end
    for i=g.ymin,g.ymax do g.rect_grid(offcbx,       offcey+i*chh, offbex,        offcey+i*chh) end

    for j=0,g.ymax do
        for i=0,g.xmax do
            g.rect_cell(i, j, offcbx+i*cww, offcby+j*chh, offcex+i*cww, offcey+j*chh)
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
    xscr=3,  yscr=2,

    rect_grid     = function(x1,y1,x2,y2) end,
    rect_boundary = function(x1,y1,x2,y2) rect(x1-2,y1-2,x2+2,y2+2,1) end,
    rect_select   = function(x1,y1,x2,y2) rect(x1-2,y1-2,x2+2,y2+2,0) rect(x1-1,y1-1,x2+1,y2+1,7) end,
    rect_cell     = function(x,y,x1,y1,x2,y2)
                        local room = get_room(x,y)
                        if room then
                            moving_grid_fill(function() rect(x1-1,y1-1,x2+1,y2+1,1) end)
                            rectfill(x1+1,y1+1,x2-1,y2-1,room.c)
                        end
                    end
}

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
    xscr=6, yscr=5,

    rect_grid     = function(x1,y1,x2,y2) rect(x1,y1,x2,y2,0) end,
    rect_boundary = function(x1, y1, x2, y2) rectfill(x1,y1,x2,y2,upsert_cur_room().c) end,
    rect_select   = function(x1, y1, x2, y2) rect(x1-2,y1-2,x2+2,y2+2,0) rect(x1-1,y1-1,x2+1,y2+1,7) end,
    rect_cell     = function(x, y, x1, y1)
                        local t = upsert_cur_room().tiles[y*12+x]
                        if t then spr(128+t, x1, y1) end
                    end
}

g_spr_grid = {
    xsel=0,  ysel=0,
    xcen=8,  ycen=1.5,
    xmin=0,  ymin=0,
    xmax=15, ymax=7,
    xcel=8,  ycel=8,
    xpad=0,  ypad=0,
    xoff=64, yoff=107,
    xscr=8,  yscr=1.5,

    rect_grid     = function() end,
    rect_boundary = function() end,
    rect_select   = function(x1, y1, x2, y2) rect(x1-2,y1-2,x2+2,y2+2,0) rect(x1-1,y1-1,x2+1,y2+1,7) end,
    rect_cell     = function(x, y, x1, y1) spr(128+y*16+x,x1,y1) end
}

function link_draw()
    draw_grid(g_link_grid)
    draw_bottom_screen(g_link_pane, function() end)
end

function tile_draw()
    draw_grid(g_tile_grid)
    draw_bottom_screen(g_tile_pane, function()
        draw_grid(g_spr_grid)
    end)
end

function draw_bottom_screen(istop, callback)
    local y = 93
    rectfill(0,y,127,127,0)
    clip(0, y, 128, 128-y)
    callback()
    clip()
    rect(0,y,127,y,istop and 7 or 1)
    rect(0,y+1,127,y+1,istop and 1 or 7)
end

function help_update() end
function help_draw()
    local top_align, left_align = 11, 5
    local texts = {
        "ZELDO MAPBUILDER",
        "",
        "H:   HELP MODE | P: PREV MODE",
        "L:   LINK MODE | C: CONF MODE",
        "T:   TILE MODE | O: OBJ  MODE",
        "RET: SWAP MODE | M: TOGL MOUSE",
        "",
        "TAB: ALT PANE  | AROW: MOVE",
        "SPACE: CREATE  | BACK: DELETE",
        "LCLK:  CREATE  | RCLK: DELETE",
        "",
        "U: UNDO        | R: REDO",
        "S: SAVE        | A: LOAD SPRS",
    }

    for i, t in pairs(texts) do
        zprint(t, left_align, (i-1)*8+top_align, -1, 7)
    end
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
