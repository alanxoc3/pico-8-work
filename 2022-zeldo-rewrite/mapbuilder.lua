CON_L1     = 248
CON_L2     = 249
CON_OBJ_00 = 250
CON_OBJ_50 = 251
CON_OBJ_05 = 252
CON_OBJ_55 = 253
CON_FILL   = 254
CON_END    = 255
LAST_ROOM_INDEX = 223

#include src/00-zobj.lua
#include src/00-decode-map.lua

g_fills = {}
function update_gfill()
    local room = g_rooms[0]
    g_fills = {}
    if room then
        for layer in all(room.tiles) do
            for x=0,11 do
                if layer[x] then
                    g_fills[layer[x]+128] = {ind=1, fills={layer[x]+128}}
                    for y=1,9 do
                        if layer[y*12+x] then
                            add(g_fills[layer[x]+128].fills, layer[y*12+x]+128)
                        end
                    end
                end
            end
        end
    end
end

g_mouse_enabled = false
g_mouse_frame_limit = 0
g_mouse_frame_limit_max = 3
g_mouse_x, g_mouse_y = 0, 0
function update_mouse() 
    g_mouse_frame_limit = (g_mouse_frame_limit+1) % g_mouse_frame_limit_max
    g_mouse_x, g_mouse_y = stat(32), stat(33)
end

function load_assets()
    reload(0x0000, 0x0000, 0x2000, 'game.p8')
    reload(0x2000, 0x2000, 0x1000, 'game.p8')
    reload(0x3000, 0x3000, 0x1300, 'game.p8')
    g_rooms = mapbuilder_decode()
    g_compression_percent = encode_room(g_rooms, 0x2000, 0x3000)
    update_gfill()
end

function mapbuilder_decode()
    local old_rooms = decode_map()
    local rooms = {}

    for ind, r in pairs(old_rooms) do
        local objs, tiles_1, tiles_2 = {}, {}, {}
        for ind, tile in pairs(r.tiles_1) do tiles_1[ind] = tile-128 end
        for ind, tile in pairs(r.tiles_2) do tiles_2[ind] = tile-128 end

        for obj in all(r.objects) do
            objs[obj.y*2*24+obj.x*2] = obj.index
        end

        rooms[ind] = {
            color = r.color,
            music = r.music,
            tiles = {tiles_1, tiles_2},
            objs  = objs
        }
    end

    return rooms
end

function save_map() cstore(0x2000, 0x2000, 0x1000, 'game.p8') end

function trim_str(str)
    local nstr = ""
    for i=1,#str do
        if sub(str,i,i) ~= " " and sub(str,i,i) ~= "\n" then
            nstr = nstr..sub(str,i,i)
        end
    end
    return nstr
end

g_cur_song = 0
g_info = {}
g_objects = {}
function _init()
    -- convert decoder map to mapbuilder map
    for item in all(g_obj_map) do
        -- {"bed",       39, 1, 2  },       -- 1 INDEX
        item = trim_str(item)
        local name, ignore, rest = unpack(split(item, "-"))
        local index, sind, rx, ry = unpack(split(rest, "|"))
        add(g_objects, {name, sind, rx, ry})
    end

    poke(0x5f5c, 5) -- set custom delay
    poke(0x5f5d, 5) -- set custom delay
    poke(0x5f2d, 1) -- enable keyboard
    load_assets()
    update_mouse()

    g_modes = {
        ['h'] = { ind = 0, name = "h", update = help_update, draw = help_draw },
        ['l'] = { ind = 1, name = "l", update = link_update, draw = link_draw },
        ['p'] = { ind = 2, name = "p", update = prvw_update, draw = prvw_draw },
        ['t'] = { ind = 3, name = "t", update = tile_update, draw = tile_draw },
        ['o'] = { ind = 4, name = "o", update = objs_update, draw = objs_draw },
    }

    g_modes_list = { g_modes.l, g_modes.p, g_modes.t, g_modes.o }
    g_mode = g_modes.h
    g_prev_mode = g_mode
end

g_compression_percent = 0
function _update60()
    poke(0x5f30,1) -- disable the pause menu
    update_mouse()

    if t() % .5 == 0 then
        for i, fill in pairs(g_fills) do
            fill.ind = fill.ind%#fill.fills+1
        end
    end

    local is_keydown, char = stat(30)
    if is_keydown then char = stat(31) end

    if g_modes[char] then
        if g_mode ~= g_modes[char] then
            g_prev_mode, g_mode = g_mode, g_modes[char]
        else
            g_mode, g_prev_mode = g_prev_mode, g_mode
        end
        char = nil
    elseif char == "	" then -- tab
        g_prev_mode, g_mode = g_mode, g_modes_list[g_mode.ind%#g_modes_list+1]
    elseif char == "m" then char = nil g_mouse_enabled = not g_mouse_enabled
    elseif char == "r" then char = nil load_assets()
    elseif char == "g" then char = nil g_debug = not g_debug
    elseif char == "s" then char = nil
        g_compression_percent = encode_room(g_rooms, 0x2000, 0x3000)
        if g_compression_percent <= 1 then
            save_map()
        end
    elseif char == " " then -- space
        char = nil
        g_mode, g_prev_mode = g_prev_mode, g_mode
    end

    set_grid_to_cur_room(g_prev_grid)
    set_grid_to_cur_room(g_tile_grid)
    set_grid_to_cur_room(g_objs_grid, 2)

    g_pane_prev = g_pane
    g_pane = not btn(5)
    g_mode.update(char)

    set_grid_to_cur_room(g_prev_grid)
    set_grid_to_cur_room(g_tile_grid)
    set_grid_to_cur_room(g_objs_grid, 2)

    if get_cur_room() then
        if to_track(get_cur_room().music) ~= g_cur_song then
            g_cur_song = to_track(get_cur_room().music)
            music(g_cur_song)
        end
    end
end

function _draw()
    fillp(0b1111101111111110)
    rectfill(0,0,127,127,ui_col())
    fillp()
    g_mode.draw()

    rectfill(0, 0, 127, 6, ui_col())
    local str = g_mode.name
    for s in all(g_info) do str = str.." "..s end
    zprint(str, 1, 1, -1, 7)

    local percent_color = 11
    if g_compression_percent > 1 then percent_color = t() % .5 > .25 and 8 or 0 
    elseif g_compression_percent > .95 then percent_color = 8
    elseif g_compression_percent > .75 then percent_color = 10 end
    zprint(""..flr(g_compression_percent*100).."%", 127, 1, 1, percent_color)

    if g_mouse_enabled then
        line(g_mouse_x-2, g_mouse_y-2, g_mouse_x+2, g_mouse_y+2, 7)
        line(g_mouse_x-2, g_mouse_y+2, g_mouse_x+2, g_mouse_y-2, 7)
    end
end

-- TILE MODE --
g_tile_layer = 1
g_tile_grid = {
    xsel=6,  ysel=5,
    xcen=6,  ycen=5,
    xmax=12, ymax=10,
    xcel=8,  ycel=8,
    xpad=0,  ypad=0,
    xoff=64, yoff=50,
    xscr=6, yscr=5,

    rect_grid        = function() end,
    rect_boundary_bg = function(x1, y1, x2, y2) rectfill(x1,y1,x2,y2,get_cur_room().color) end,
    rect_boundary_fg = function() end,
    rect_select      = function(x1, y1, x2, y2) rect(x1-2,y1-2,x2+2,y2+2,0) rect(x1-1,y1-1,x2+1,y2+1,7) end,
    rect_cell        = function(x, y, x1, y1, x2, y2)
                           local t = get_tile(x,y)
                           if t then spr(128+t, x1, y1) end
                       end
}

g_spr_grid = {
    xsel=0,  ysel=0,
    xcen=8,  ycen=1.5,
    xmax=16, ymax=8,
    xcel=8,  ycel=8,
    xpad=0,  ypad=0,
    xoff=64, yoff=107,
    xscr=8,  yscr=1.5,

    rect_grid        = function() end,
    rect_boundary_bg = function() end,
    rect_boundary_fg = function() end,
    rect_select      = function(x1, y1, x2, y2) rect(x1-2,y1-2,x2+2,y2+2,0) rect(x1-1,y1-1,x2+1,y2+1,7) end,
    rect_cell        = function(x, y, x1, y1) spr(128+y*16+x,x1,y1) end
}

g_tile_draw_fills = false
function tile_update(key)
    if not get_cur_room() then
        g_info={}
        return
    end

    update_grid(g_pane and g_tile_grid or g_spr_grid, g_mouse_enabled and g_mouse_frame_limit)

    if g_pane then
        if key == "1" then g_tile_layer = 1
        elseif key == "2" then g_tile_layer = 2
        elseif key == "d" then set_cur_tile(nil)
        elseif btn(4) then
            set_cur_tile(g_spr_grid.ysel*16+g_spr_grid.xsel)
        end
    elseif g_pane_prev then
        local spr_ind = get_cur_room().tiles[g_tile_layer][g_tile_grid.ysel*12+g_tile_grid.xsel]
        if spr_ind then
            g_spr_grid.xsel = spr_ind % 16
            g_spr_grid.ysel = flr(spr_ind / 16)
            update_grid(g_spr_grid)
        end
    end

    local cur_tile_spr = get_cur_room().tiles[g_tile_layer][g_tile_grid.ysel*12+g_tile_grid.xsel]
    g_info={
        g_tile_layer,
        g_spr_grid.ysel*16+g_spr_grid.xsel+128,
        g_tile_grid.xsel..","..g_tile_grid.ysel,
        cur_tile_spr and cur_tile_spr+128 or nil
    }
end

function tile_draw()
    if not get_cur_room() then
        draw_no_room()
        return
    end

    draw_grid(g_tile_grid)
    draw_bottom_screen(g_pane, function()
        draw_grid(g_spr_grid)
    end)

    if g_debug then
        local fills, places = itemmap_to_fills(12, 10, get_cur_room().tiles[g_tile_layer])
        for f in all(fills) do
            rect(
                g_tile_grid.xoff-(g_tile_grid.xmax/2)*8+f.xbeg*8,
                g_tile_grid.yoff-(g_tile_grid.ymax/2)*8+f.ybeg*8,
                g_tile_grid.xoff-(g_tile_grid.xmax/2)*8+f.xend*8+8,
                g_tile_grid.yoff-(g_tile_grid.ymax/2)*8+f.yend*8+8,
            8)
        end

        for f in all(places) do
            rect(
                g_tile_grid.xoff-(g_tile_grid.xmax/2)*8+f.x*8+1,
                g_tile_grid.yoff-(g_tile_grid.ymax/2)*8+f.y*8+1,
                g_tile_grid.xoff-(g_tile_grid.xmax/2)*8+f.x*8+8-1,
                g_tile_grid.yoff-(g_tile_grid.ymax/2)*8+f.y*8+8-1,
            9)
        end
    end
end

-- LINK MODE --
g_link_grid = {
    xsel=8,  ysel=8,
    xcen=8,  ycen=8,
    xmax=16, ymax=16,
    xcel=12, ycel=10,
    xpad=2,  ypad=2,
    xoff=57, yoff=60,
    xscr=3,  yscr=3,

    rect_grid        = function(x1,y1,x2,y2) end,
    rect_boundary_bg = function(x1,y1,x2,y2) rectfill(x1-2,y1-2,x2+2,y2+2,0) rect(x1-2,y1-2,x2+2,y2+2,ui_col()) end,
    rect_boundary_fg = function() end,
    rect_select      = function(x1,y1,x2,y2) rect(x1-2,y1-2,x2+2,y2+2,0) rect(x1-1,y1-1,x2+1,y2+1,7) end,
    rect_cell        = function(x,y,x1,y1,x2,y2)
                           local room = get_room(x,y)
                           if room then
                               local pad = is_hut(y) and 2 or 1
                               moving_grid_fill(function() rect(x1-1,y1-1,x2+1,y2+1,ui_col()) end)
                               rectfill(x1+pad,y1+pad,x2-pad,y2-pad,room.color)
                           end
                       end
}

g_link_default_original =  {
    tiles={{}, {}},
    objs={},
    color=3,
    music=0
}
function link_update(key)
    update_grid(g_link_grid, g_mouse_enabled and g_mouse_frame_limit)

    if key == "d"    then del_cur_room()
    elseif btn(5) then set_room_default()
    elseif btn(4) then set_cur_room()
    end

    g_info={is_hut() and "hut" or "room", g_link_grid.xsel..","..g_link_grid.ysel, g_link_grid.ysel*16+g_link_grid.xsel}
end

function link_draw()
    draw_grid(g_link_grid)
end

-- PREV MODE --
g_prev_grid = {
    xsel=6,  ysel=5,
    xcen=6,  ycen=5,
    xmax=12, ymax=10,
    xcel=8,  ycel=8,
    xpad=0,  ypad=0,
    xoff=64, yoff=50,
    xscr=6,  yscr=5,

    rect_grid        = function() end,
    rect_boundary_bg = function(x1, y1, x2, y2) rectfill(x1,y1,x2,y2,get_cur_room().color) end,
    rect_boundary_fg = function(x1, y1, x2, y2)
                           draw_the_objs()
                           rect(x1+0,y1+0,x2-0,y2-0,0)
                           rect(x1+1,y1+1,x2-1,y2-1,0)
                           rect(x1+2,y1+2,x2-2,y2-2,ui_col())
                           rect(x1+3,y1+3,x2-3,y2-3,ui_col())
                           pset(x1+2,y1+2,0) pset(x1+2,y2-2,0)
                           pset(x2-2,y1+2,0) pset(x2-2,y2-2,0)
                           pset(x1+4,y1+4,ui_col()) pset(x1+4,y2-4,ui_col())
                           pset(x2-4,y1+4,ui_col()) pset(x2-4,y2-4,ui_col())
                       end,
    rect_select      = function() end,
    rect_cell        = function(x, y, x1, y1)
                           local room = get_cur_room()
                           -- loop through layers, later layers draw last
                           for l in all(room.tiles) do
                               local t = l[y*12+x]
                               if t then
                                   local sind = 128+t
                                   if g_fills[sind] then
                                       spr(g_fills[sind].fills[g_fills[sind].ind], x1, y1)
                                   else
                                       spr(sind, x1, y1)
                                   end
                               end
                           end
                       end
}

g_config_items = {
    {
        txt="COLOR",
        prop="color",
        set=function(change) get_cur_room().color = max(min(get_cur_room().color+change, 15, 0)) end,
        get=function() return get_cur_room().color end
    },
    {
        txt="MUSIC",
        prop="music",
        set=function(change) get_cur_room().music = max(min(get_cur_room().music+change, 15, 0)) end,
        get=function() return to_track(get_cur_room().music) end
    },
}
g_config_item = 1

function prvw_update(key)
    if get_cur_room() then
        update_grid(g_prev_grid, g_mouse_enabled and g_mouse_frame_limit)
    end

    if g_pane then
        update_grid(g_link_grid)
    else
        g_config_item = max(min(g_config_item+ybtnp(), #g_config_items), 1)
        g_config_items[g_config_item].set(xbtnp())
    end

    g_info={is_hut() and "hut" or "room", g_link_grid.xsel..","..g_link_grid.ysel}
end

function prvw_draw()
    if not get_cur_room() then
        draw_no_room()
        return
    end

    draw_grid(g_prev_grid)

    draw_bottom_screen(g_pane, function()
        local top_align, left_align = 104, 64
        local color = g_pane and 5 or 7
        local texts = {}

        local room = get_cur_room()
        for i, x in pairs(g_config_items) do
            if i == g_config_item then
                local left  = get_cur_room()[x.prop] <= 0 and "   " or "<- "
                local right = get_cur_room()[x.prop] >= 15 and "   " or " ->"
                add(texts, left..x.txt..": "..x.get()..right)
            else
                add(texts, x.txt..": "..x.get())
            end
        end

        for i, t in pairs(texts) do
            zprint(t, left_align, (i-1)*8+top_align, 0, color)
        end
    end)
end

-- OBJECT MODE --
g_objs_grid = {
    xsel=6,  ysel=5,
    xcen=6,  ycen=5,
    xmax=12, ymax=10,
    xcel=4,  ycel=4,
    xpad=0,  ypad=0,
    xoff=64, yoff=50,
    xscr=6,  yscr=5,

    rect_grid        = function() end,
    rect_boundary_bg = function(x1, y1, x2, y2) rectfill(x1,y1,x2,y2,get_cur_room().color) end,
    rect_boundary_fg = function(x1, y1, x2, y2) end,
    rect_select      = function(x1, y1, x2, y2)
                           local m = 4
                           local w = g_objects[g_obji_grid.ysel*16+g_obji_grid.xsel+1][3] - 1
                           local h = g_objects[g_obji_grid.ysel*16+g_obji_grid.xsel+1][4] - 1
                           rect(x1-2,y1-2,x2+2+m,y2+2+m,0)
                           rect(x1-1,y1-1,x2+1+m,y2+1+m,7)
                           rect(x1-2-w*4,y1-2-h*4,x2+2+m+w*4,y2+2+m+h*4,0)
                           rect(x1-1-w*4,y1-1-h*4,x2+1+m+w*4,y2+1+m+h*4,7)
                       end,
    rect_cell        = function(x, y, x1, y1)
                           if x % 2 == 0 and y % 2 == 0 then
                               local nx, ny = x / 2, y / 2
                               local room = get_cur_room()
                               -- loop through layers, later layers draw last
                               for l in all(room.tiles) do
                                   local t = l[ny*12+nx]
                                   if t then spr(128+t, x1, y1) end
                               end
                           end
                       end
}

g_obji_grid = {
    xsel=0,  ysel=0,
    xcen=8,  ycen=1.5,
    xmax=16, ymax=8,
    xcel=8,  ycel=8,
    xpad=0,  ypad=0,
    xoff=64, yoff=107,
    xscr=8,  yscr=1.5,

    rect_grid        = function() end,
    rect_boundary_bg = function() end,
    rect_boundary_fg = function() end,
    rect_select      = function(x1, y1, x2, y2) rect(x1-2,y1-2,x2+2,y2+2,0) rect(x1-1,y1-1,x2+1,y2+1,7) end,
    rect_cell        = function(x, y, x1, y1) spr(g_objects[y*16+x+1][2],x1,y1) end
}

function objs_update(key)
    if not get_cur_room() then g_info={} return end
    g_objs_grid.xmax -= 1
    g_objs_grid.ymax -= 1
    update_grid(g_pane and g_objs_grid or g_obji_grid, g_mouse_enabled and g_mouse_frame_limit)
    g_objs_grid.xmax += 1
    g_objs_grid.ymax += 1

    if g_pane then
        if key == "d" and g_objs_pane then set_cur_obj(nil)
        elseif btn(4) then
            g_objs_pane = true
            set_cur_obj(g_obji_grid.ysel*16+g_obji_grid.xsel+1)
        end
    elseif g_pane_prev then
        local obj_ind = get_cur_room().objs[g_objs_grid.ysel*24+g_objs_grid.xsel]
        if obj_ind then
            obj_ind -= 1
            g_obji_grid.xsel = obj_ind % 16
            g_obji_grid.ysel = flr(obj_ind / 16)
            update_grid(g_obji_grid)
        end
    end

    g_info={
        ""..g_objects[g_obji_grid.ysel*16+g_obji_grid.xsel+1][1]..":"..(g_obji_grid.ysel*16+g_obji_grid.xsel),
        ""..(g_objs_grid.xsel/2)..","..(g_objs_grid.ysel/2)
    }

    if get_cur_room().objs[g_objs_grid.ysel*24+g_objs_grid.xsel] then
        add(g_info, get_cur_room().objs[g_objs_grid.ysel*24+g_objs_grid.xsel])
    end
end

function draw_the_objs(include_rect)
    for obj_loc, obj_ind in pairs(get_cur_room().objs) do
        local x1 = g_objs_grid.xoff+obj_loc%24*4-g_objs_grid.xcen*4
        local y1 = g_objs_grid.yoff+flr(obj_loc/24)*4-g_objs_grid.ycen*4

        local obj = g_objects[obj_ind]
        sprout(obj[2], x1-obj[3]*4+4, y1-obj[4]*4+4, obj[3], obj[4])
    end

    for obj_loc, obj_ind in pairs(get_cur_room().objs) do
        local x1 = g_objs_grid.xoff+obj_loc%24*4-g_objs_grid.xcen*4
        local y1 = g_objs_grid.yoff+flr(obj_loc/24)*4-g_objs_grid.ycen*4

        local obj = g_objects[obj_ind]
        spr(obj[2], x1-obj[3]*4+4, y1-obj[4]*4+4, obj[3], obj[4])
        if include_rect then
            rect(x1-obj[3]*4+4-1, y1-obj[4]*4+4-1, x1+4+obj[3]*4, y1+4+obj[4]*4, 10)
        end
    end
end

function objs_draw()
    if not get_cur_room() then
        draw_no_room()
        return
    end

    draw_grid(g_objs_grid)
    draw_the_objs(true)
    draw_bottom_screen(g_pane, function()
        draw_grid(g_obji_grid)
    end)
end

-- HELP MODE --
function help_update()
    g_info={}
end

function help_draw()
    local tit_top_align = 13
    local top_align, left_align = 13, 6
    local texts = {
        "ARR: MOVE         D: DELETE",
        " 🅾️: CREATE      ❎: PANE",
        "  1: BG LAYER     2: FG LAYER",
        "",
        "  S: SAVE         R: RELOAD",
        "  M: MOUSE        G: DEBUG",
        "",
        "TAB: NEXT       SPA: SWAP",
        "  L: LINKS        P: PREVIEW",
        "  T: TILES        O: OBJECTS",
        "  H: HELP",
    }

    rectfill(63-1, top_align+13, 63+1, 127-10, ui_col())
    rectfill(63, top_align+13, 63, 127-10, 7)
    rect(2   , top_align+13   , 127-2  , 127-10  , ui_col())
    rect(-1+2,-1+ top_align+13,1+ 127-2,1+ 127-10, 7)
    rect(-2+2,-2+ top_align+13,2+ 127-2,2+ 127-10, ui_col())
    -- rect(-3+2,-3+ top_align+13,3+ 127-2,3+ 127-7, ui_col())
    -- rect(-4+2,-4+ top_align+13,4+ 127-2,4+ 127-7, ui_col())
    zprint("         mapbuilder", left_align, tit_top_align, -1, 7)
    for i, t in pairs(texts) do
        zprint(t, left_align, (i-1)*8+top_align+16, -1, 7)
    end
end

-- UTILITIES --

-- input: w, h, {xy: ind}
-- output: [{ind, xbeg, xend, ybeg, yend}...]
function itemmap_to_fills(width, height, itemmap)
    local visited = {}
    local cur_tile, xbeg, xend, ybeg, yend = nil, nil, nil, nil, nil
    local fills = {}
    local places = {}

    local start_fill = function(x, y)
        local index = y*width+x
        visited[index] = true
        cur_tile = itemmap[index]
        xbeg, xend = x, x
        ybeg, yend = y, y
    end

    local end_fill = function()
        if xbeg == xend and ybeg == yend then
            add(places, {ind=cur_tile, x=xbeg, y=ybeg})
        else
            add(fills, {ind=cur_tile, xbeg=xbeg, xend=xend, ybeg=ybeg, yend=yend})
        end
        cur_tile, xbeg, xend, ybeg, yend = nil, nil, nil, nil, nil
    end

    local right_fill = function(x)
        xend = x
    end

    local down_fill = function(y)
        for yy=y+1,height-1 do
            local add_y = true
            for xx=xbeg,xend do
                local ind = yy*width+xx
                if visited[ind] or itemmap[ind] != cur_tile then
                    add_y = false
                    break
                end
            end

            if add_y then
                yend = yy
                for xx=xbeg,xend do
                    visited[yy*width+xx] = true
                end
            else break end
        end
    end

    for y=0,height-1 do
        -- each row should reset current tile
        -- because y traversal is embedded further down
        cur_tile = nil
        for x=0,width-1 do
            local index = y*width+x

            -- if this spot has not been accounted for
            if not visited[index] then
                visited[index] = true
                -- if in the middle of calculating a fill and we can add to the fill now
                if cur_tile and cur_tile == itemmap[index] then
                    right_fill(x)

                -- if in the middle of calculating a fill, current spot does not match and non nil
                elseif cur_tile and itemmap[index] then
                    down_fill(y)
                    end_fill()
                    start_fill(x, y)
                    
                -- if in the middle of calculating a fill, current spot is nil
                elseif cur_tile then
                    down_fill(y)
                    end_fill()

                -- if we aren't currently calculating a fill and the current spot is not empty
                elseif itemmap[index] then
                    start_fill(x, y)
                end

            -- if this spot has already been accounted for and a fill is in progress
            elseif cur_tile then
                down_fill(y)
                end_fill()
            end
        end

        if cur_tile then
            down_fill(y)
            end_fill()
        end
    end

    return fills, places
end

function encode_room(rooms, min_loc, max_loc)
    local mem_loc = min_loc

    for room_index,room in pairs(rooms) do
        poke(mem_loc, room_index)
        mem_loc+=1
        poke(mem_loc, bor(room.color, shl(room.music, 4)))
        mem_loc+=1

        -- tiles
        for layer, tiles in pairs(room.tiles) do
            local fill_by_ind = {}
            local place_by_ind = {}

            local fills, places = itemmap_to_fills(12, 10, tiles)

            for x in all(fills) do
                if not fill_by_ind[x.ind] then fill_by_ind[x.ind] = {} end
                add(fill_by_ind[x.ind], x)
            end

            for x in all(places) do
                if not place_by_ind[x.ind] then place_by_ind[x.ind] = {} end
                add(place_by_ind[x.ind], x)
            end

            if #fills > 0 or #places > 0 then
                poke(mem_loc, CON_L1+layer-1)
                mem_loc+=1
            end

            if #places > 0 then
                for i=0,127 do
                    if place_by_ind[i] then
                        poke(mem_loc, band(0x7f, i))
                        mem_loc+=1

                        for f in all(place_by_ind[i]) do
                            poke(mem_loc, bor(0x80, min(f.y*12+f.x, 119)))
                            mem_loc+=1
                        end
                    end
                end
            end

            if #fills > 0 then
                poke(mem_loc, CON_FILL)
                mem_loc+=1
                for i=0,127 do
                    if fill_by_ind[i] then
                        poke(mem_loc, band(0x7f, i))
                        mem_loc+=1

                        for f in all(fill_by_ind[i]) do
                            poke(mem_loc, bor(0x80, min(f.ybeg*12+f.xbeg, 119)))
                            mem_loc+=1
                            poke(mem_loc, bor(0x80, min(f.yend*12+f.xend, 119)))
                            mem_loc+=1
                        end
                    end
                end
            end
        end

        -- objs
        local buckets = {{}, {}, {}, {}}
        local bucket_lens = {0, 0, 0, 0}
        for i=0,23*20 do
            local x = i % 24
            local y = flr(i/24)

            if room.objs[i] then
                local ind = 1
                    if x % 2 == 1 and y % 2 == 0 then ind = 2
                elseif x % 2 == 0 and y % 2 == 1 then ind = 3
                elseif x % 2 == 1 and y % 2 == 1 then ind = 4
                end

                buckets[ind][room.objs[i]] = buckets[ind][room.objs[i]] or {}
                add(buckets[ind][room.objs[i]], flr(y/2)*12+flr(x/2))
                bucket_lens[ind] += 1
            end
        end

        for i=1,4 do
            local bucket = buckets[i]
            if bucket_lens[i] > 0 then
                poke(mem_loc, CON_OBJ_00+i-1)
                mem_loc+=1

                for i=0,127 do
                    if bucket[i+1] then
                        poke(mem_loc, band(0x7f, i))
                        mem_loc+=1

                        for x in all(bucket[i+1]) do
                            poke(mem_loc, bor(0x80, min(x, 119)))
                            mem_loc+=1
                        end
                    end
                end
            end
        end

        poke(mem_loc, 0xff)
        mem_loc+=1
    end
    poke(mem_loc, 0xff)
    mem_loc += 1
    local percent = (mem_loc - min_loc) / (max_loc - min_loc)
    for x=mem_loc,max_loc-1 do poke(x, 0) end
    return percent
end

g_rooms = {}
function set_cur_tile(val)
    local width = 12
    local x, y = g_tile_grid.xsel, g_tile_grid.ysel
    get_cur_room().tiles[g_tile_layer][y*width+x] = val
end

function set_cur_obj(val)
    local width = 2*12
    local x, y = g_objs_grid.xsel, g_objs_grid.ysel
    get_cur_room().objs[y*width+x] = val
end

function get_tile(x, y)
    local width = 12
    return get_cur_room().tiles[g_tile_layer][y*width+x]
end

function is_hut(y)
    return (y or g_link_grid.ysel) >= 14
end

function set_grid_to_cur_room(g, multiplier)
    multiplier = multiplier or 1
    g.xmax = is_hut() and 8*multiplier or 12*multiplier
    g.ymax = is_hut() and 6*multiplier or 10*multiplier

    g.xcen = g.xmax / 2
    g.ycen = g.ymax / 2
    g.xscr = g.xmax / 2
    g.yscr = g.ymax / 2
    g.xsel = min(g.xsel, g.xmax-1)
    g.ysel = min(g.ysel, g.ymax-1)
end

function get_cur_room()
    return get_room(g_link_grid.xsel, g_link_grid.ysel)
end

function set_cur_room()
    if not get_cur_room() then
        local tempr
        if is_hut() then tempr = g_link_hut_default
        else tempr = g_link_room_default end

        g_rooms[g_link_grid.ysel*16+g_link_grid.xsel] = tabcpy(tempr or g_link_default_original)
    end
end

function set_room_default()
    if get_cur_room() then
        local rcpy = tabcpy(get_cur_room())
        if is_hut() then g_link_hut_default  = rcpy
        else             g_link_room_default = rcpy end
    end
end

function get_room(x, y) return g_rooms[y*16+x] end
function del_cur_room()
    local x, y = g_link_grid.xsel, g_link_grid.ysel
    set_room_default()
    g_rooms[y*16+x] = nil
end

function update_grid(g, mouse_rate)
    local xsel, ysel = g.xsel, g.ysel
    if mouse_rate then
        if mouse_rate == 0 then
            xsel = flr(g.xcen+(g_mouse_x-g.xoff)/(g.xcel+g.xpad))
            ysel = flr(g.ycen+(g_mouse_y-g.yoff)/(g.ycel+g.ypad))
        end
    else
        xsel = flr(xsel+xbtnp())
        ysel = flr(ysel+ybtnp())

        if xsel < 0 then xsel = g.xmax-1 end
        if ysel < 0 then ysel = g.ymax-1 end

        if xsel > g.xmax-1 then xsel = 0 end
        if ysel > g.ymax-1 then ysel = 0 end
    end

    g.xsel  = min(g.xmax-1, max(0, xsel))
    local dist, sign = abs(g.xcen - g.xsel), sgn(g.xcen - g.xsel)
    if dist > g.xscr then g.xcen = g.xsel + sign*g.xscr end
    g.xcen = max(min(g.xcen, g.xmax-1-g.xscr), 0+g.xscr)

    g.ysel = min(g.ymax-1, max(0, ysel))
    local dist, sign = abs(g.ycen - g.ysel), sgn(g.ycen - g.ysel)
    if dist > g.yscr then g.ycen = g.ysel + sign*g.yscr end
    g.ycen = max(min(g.ycen, g.ymax-1-g.yscr), 0+g.yscr)
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

    local offbex = offcex+(g.xmax-1)*cww
    local offbey = offcey+(g.ymax-1)*chh

    g.rect_boundary_bg(offcbx, offcby, offbex, offbey)
    for i=0,g.xmax-1 do g.rect_grid(offcbx+i*cww, offcby,       offcbx+i*cww,  offbey      ) end
    for i=0,g.xmax-1 do g.rect_grid(offcex+i*cww, offcby,       offcex+i*cww,  offbey      ) end
    for i=0,g.ymax-1 do g.rect_grid(offcbx,       offcby+i*chh, offbex,        offcby+i*chh) end
    for i=0,g.ymax-1 do g.rect_grid(offcbx,       offcey+i*chh, offbex,        offcey+i*chh) end

    for j=0,g.ymax-1 do
        for i=0,g.xmax-1 do
            g.rect_cell(i, j, offcbx+i*cww, offcby+j*chh, offcex+i*cww, offcey+j*chh)
        end
    end

    g.rect_select(offcbx+g.xsel*cww, offcby+g.ysel*chh, offcbx+g.xsel*cww+g.xcel-1, offcby+g.ysel*chh+g.ycel-1)
    g.rect_boundary_fg(offcbx, offcby, offbex, offbey)
end

function moving_grid_fill(callback)
    fillp(t() % 1 < .25 and 0b1100011000111001 or
          t() % 1 < .5  and 0b0110001110011100 or
          t() % 1 < .75 and 0b0011100111000110 or 0b1001110001100011)
    callback()
    fillp()
end

function draw_bottom_screen(istop, callback)
    local y = 93
    rectfill(0,y,127,127,0)
    clip(0, y, 128, 128-y)
    callback()
    clip()
    rect(0,y,127,y,istop and 7 or ui_col())
    rect(0,y+1,127,y+1,istop and ui_col() or 7)
end

function to_track(s)
    return flr(s/2)*8+(s%2)*5
end

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

function tabcpy(src, dest)
    dest = dest or {}

    for k,v in pairs(src or {}) do
        if type(v) == 'table' then
            dest[k] = tabcpy(v)
        else
            dest[k] = v
        end
    end
    return dest
end

function ui_col() return g_debug and 2 or 1 end
function draw_no_room() zprint("no room here", 63, 66, 0, 7) end

function sprout(sind, x, y, sw, sh, flip_x, flip_y)
    for c=1,15 do pal(c,1) end
    for i=0,8 do spr(sind, x+i%3-1, y+i\3-1, sw, sh, flip_x, flip_y) end
    pal()
end
