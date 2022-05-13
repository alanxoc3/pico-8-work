g_mouse_enabled = false
g_mouse_frame_limit = 0
g_mouse_frame_limit_max = 3
g_mouse_x, g_mouse_y = 0, 0
function update_mouse() 
    g_mouse_frame_limit = (g_mouse_frame_limit+1) % g_mouse_frame_limit_max
    g_mouse_x, g_mouse_y = stat(32), stat(33)
end

function load_assets() reload(0, 0, 0x4300, 'game.p8') end
function save_map() cstore(0x2000, 0x2000, 0x1000, 'game.p8') end

g_cur_song = 0
g_info = {}
function _init()
    poke(0x5f2d, 1) -- enable keyboard
    load_assets()
    update_mouse()

    g_modes = {
        ['l'] = { name = "link", update = link_update, draw = link_draw },
        ['t'] = { name = "tile", update = tile_update, draw = tile_draw },
        ['p'] = { name = "prvw", update = prvw_update, draw = prvw_draw },
        ['o'] = { name = "objs", update = objs_update, draw = objs_draw },
        ['h'] = { name = "help", update = help_update, draw = help_draw },
    }
    g_mode = g_modes.h
    g_prev_mode = g_mode
end

g_compression_percent = 0
function _update60()
    poke(0x5f30,1) -- disable the pause menu
    update_mouse()

    local is_keydown, char = stat(30)
    if is_keydown then char = stat(31) end

    if g_modes[char] then
        if g_mode ~= g_modes[char] then
            g_prev_mode, g_mode = g_mode, g_modes[char]
        else
            g_mode, g_prev_mode = g_prev_mode, g_mode
        end
        char = nil
    elseif char == "\13" then -- return/enter/newline
        char = nil
        g_mode, g_prev_mode = g_prev_mode, g_mode
    elseif char == "m" then char = nil g_mouse_enabled = not g_mouse_enabled
    elseif char == "a" then char = nil
        load_assets()
        g_rooms = decode()
        g_compression_percent = encode_room(g_rooms, 0x2000, 0x3000)
    elseif char == "d" then char = nil g_debug = not g_debug
    elseif char == "s" then char = nil -- save logic
        g_compression_percent = encode_room(g_rooms, 0x2000, 0x3000)
        if g_compression_percent <= 1 then
            save_map()
        end
    elseif char == "	" then char = "tab"
    elseif char == " " then char = "space"
    elseif char == '⁸' then char = "back"
    end

    set_grid_to_cur_room(g_prev_grid)
    set_grid_to_cur_room(g_tile_grid)

    g_mode.update(char)

    set_grid_to_cur_room(g_prev_grid)
    set_grid_to_cur_room(g_tile_grid)

    if get_cur_room() and to_track(get_cur_room().music) ~= g_cur_song then
        g_cur_song = to_track(get_cur_room().music)
        music(g_cur_song)
    end
end

function _draw()
    fillp(0b1111101111111110)
    rectfill(0,0,127,127,ui_col())
    fillp()
    g_mode.draw()

    rectfill(0, 0, 127, 6, ui_col())
    local str = g_mode.name
    for s in all(g_info) do str = str.." | "..s end
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
    rect_boundary_bg = function() end,
    rect_boundary_fg = function() end,
    rect_select      = function(x1, y1, x2, y2) rect(x1-2,y1-2,x2+2,y2+2,0) rect(x1-1,y1-1,x2+1,y2+1,7) end,
    rect_cell        = function(x, y, x1, y1, x2, y2)
                           rectfill(x1+0,y1+0,x2-0,y2-0,get_cur_room().color)
                           local t = get_cur_room().tiles[g_tile_layer][y*12+x]
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

g_tile_pane = true
g_tile_draw_fills = false
function tile_update(key)
    if not get_cur_room() then return end
    update_grid(g_tile_pane and g_tile_grid or g_spr_grid, g_mouse_enabled and g_mouse_frame_limit)

    if key == "tab" then g_tile_pane = not g_tile_pane
    elseif key == "1" then g_tile_layer = 1
    elseif key == "2" then g_tile_layer = 2
    elseif key == "x" then
        local spr_ind = get_cur_room().tiles[g_tile_layer][g_tile_grid.ysel*12+g_tile_grid.xsel]
        g_spr_grid.xsel = spr_ind % 16
        g_spr_grid.ysel = flr(spr_ind / 16)
        update_grid(g_spr_grid)
    elseif key == "space" then
        g_tile_pane = true
        set_tile(get_cur_room(), g_tile_layer, g_tile_grid.ysel*12+g_tile_grid.xsel, g_spr_grid.ysel*16+g_spr_grid.xsel)
    elseif key == "back" and g_tile_pane then
        set_tile(get_cur_room(), g_tile_layer, g_tile_grid.ysel*12+g_tile_grid.xsel)
    end


    local cur_tile_spr = get_cur_room().tiles[g_tile_layer][g_tile_grid.ysel*12+g_tile_grid.xsel]
    g_info={
        g_link_grid.xsel..","..g_link_grid.ysel,
        g_tile_layer,
        g_tile_grid.xsel..","..g_tile_grid.ysel..(cur_tile_spr and ":"..cur_tile_spr+128 or "")
    }
end

function tile_draw()
    if not get_cur_room() then
        draw_no_room()
        return
    end

    draw_grid(g_tile_grid)
    draw_bottom_screen(g_tile_pane, function()
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
    xoff=57, yoff=45,
    xscr=3,  yscr=2,

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

g_link_pane = true
g_link_default_original =  {
    tiles={{}, {}, {}, {}},
    objs={},
    tiles_lens={0, 0, 0, 0},
    objs_len=0,
    color=3,
    music=0
}
function link_update(key)
    update_grid(g_link_pane and g_link_grid or g_hut_grid, g_mouse_enabled and g_mouse_frame_limit)

    if key == "back"    then del_cur_room()
    elseif key == "tab" then g_link_pane = not g_link_pane
    elseif key == "x" then set_room_default()
    elseif key == "space" then set_cur_room()
    end

    g_info={g_link_grid.xsel..","..g_link_grid.ysel..":"..(is_hut() and "hut" or "room")}
end

function link_draw()
    draw_grid(g_link_grid)
    draw_bottom_screen(g_link_pane, function() end)
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
                               if t then spr(128+t, x1, y1) end
                           end
                       end
}

g_config_items = {
    {
        txt="COLOR",
        set=function(change) get_cur_room().color = max(min(get_cur_room().color+change, 15, 0)) end,
        get=function() return get_cur_room().color end
    },
    {
        txt="MUSIC",
        set=function(change) get_cur_room().music = max(min(get_cur_room().music+change, 15, 0)) end,
        get=function() return to_track(get_cur_room().music) end
    },
}
g_config_item = 1

g_prvw_pane = true
function prvw_update(key)
    if get_cur_room() then
        update_grid(g_prev_grid, g_mouse_enabled and g_mouse_frame_limit)
    end


    if g_prvw_pane then
        update_grid(g_link_grid)
    else
        g_config_item = max(min(g_config_item+ybtnp(), #g_config_items), 1)
        g_config_items[g_config_item].set(xbtnp())
    end

    if key == "back"    then del_cur_room() g_prvw_pane = true
    elseif key == "tab" then g_prvw_pane = not g_prvw_pane
    elseif key == "x"   then set_room_default() g_prvw_pane = true
    elseif key == "space" then set_cur_room() g_prvw_pane = true
    end

    g_info={g_link_grid.xsel..","..g_link_grid.ysel..":"..(is_hut() and "hut" or "room")}
end

function prvw_draw()
    if not get_cur_room() then
        draw_no_room()
        return
    end

    draw_grid(g_prev_grid)

    draw_bottom_screen(g_prvw_pane, function()
        local top_align, left_align = 104, 4-- 46
        local color = g_prvw_pane and 5 or 7
        local texts = {}

        local room = get_cur_room()
        for x in all(g_config_items) do
            add(texts, x.txt..": "..x.get())
        end
        zprint(">", left_align, (g_config_item-1)*8+top_align, -1, color)

        for i, t in pairs(texts) do
            zprint(t, 5+left_align, (i-1)*8+top_align, -1, color)
        end
    end)
end

-- OBJECT MODE --
function objs_update()
    g_info={g_link_grid.xsel..","..g_link_grid.ysel}
end

function objs_draw()
    if not get_cur_room() then
        draw_no_room()
        return
    end
end

-- HELP MODE --
function help_update()
    g_info={}
end

function help_draw()
    local top_align, left_align = 11, 5
    local texts = {
        "MAPBUILDER",
        "",
        "L: LINK MODE  | P: PRVW MODE",
        "T: TILE MODE  | O: OBJS MODE",
        "H: HELP MODE",
        "",
        "TAB: MODE ALT | RET: MODE SWAP",
        "M: TOGL MOUSE | D: TOGL DEBUG",
        "",
        "ARROW: MOVE   | SPACE: CREATE",
        "X: SET CREATE | BACK: DELETE",
        "1: FOREGROUND | 2: BACKGROUND",
        "",
        "S: SAVE       | A: RELOAD",
    }

    for i, t in pairs(texts) do
        zprint(t, left_align, (i-1)*8+top_align, -1, 7)
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

CON_L1     = 248
CON_L2     = 249
CON_OBJ_00 = 250
CON_OBJ_05 = 251
CON_OBJ_50 = 252
CON_OBJ_55 = 253
CON_FILL   = 254
CON_END    = 255

function encode_room(rooms, min_loc, max_loc)
    local mem_loc = min_loc

    for room_index,room in pairs(rooms) do
        poke(mem_loc, room_index)
        mem_loc+=1
        poke(mem_loc, bor(room.color, shl(room.music, 4)))
        mem_loc+=1

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
        poke(mem_loc, 0xff)
        mem_loc+=1
    end
    poke(mem_loc, 0xff)
    mem_loc += 1
    local percent = (mem_loc - min_loc) / (max_loc - min_loc)
    for x=mem_loc,max_loc-1 do poke(x, 0) end
    return percent
end

function decode()
    local mem_loc     = 0x2000
    local cur_loc = mem_loc
    local rooms = {}

    while peek(cur_loc) ~= CON_END do
        local room = {
            tiles={{}, {}, {}, {}},
            objs={},
            tiles_lens={0, 0, 0, 0},
            objs_len=0,
            color=0,
            music=0
        }

        local room_ind = peek(cur_loc)
        cur_loc += 1

        local musfill = peek(cur_loc)
        room.color = band(0x0f, musfill)
        room.music = lshr(band(0xf0, musfill), 4)
        cur_loc += 1

        local is_fill = false
        local is_tile = true
        local layer = 1
        local ind = 0
        local byte = 0
        while byte ~= CON_END do
            byte = peek(cur_loc)
            cur_loc += 1

            if     byte == CON_L1     then is_fill = false is_tile = true  layer = 1
            elseif byte == CON_L2     then is_fill = false is_tile = true  layer = 2
            elseif byte == CON_OBJ_00 then is_fill = false is_tile = false
            elseif byte == CON_OBJ_05 then is_fill = false is_tile = false
            elseif byte == CON_OBJ_50 then is_fill = false is_tile = false
            elseif byte == CON_OBJ_55 then is_fill = false is_tile = false
            elseif byte == CON_FILL   then is_fill = true
            elseif byte < 128         then ind = byte
            elseif byte < CON_END     then
                local p1 = band(0x7f, byte)
                if is_fill then
                    local p2 = band(0x7f, peek(cur_loc))
                    cur_loc += 1

                    local xb,yb,xe,ye = p1%12,flr(p1/12), p2%12,flr(p2/12)
                    for yy=yb,ye do
                        for xx=xb,xe do
                            room.tiles[layer][yy*12+xx] = ind
                        end
                    end
                else
                    room.tiles[layer][p1] = ind
                end
            end
        end

        rooms[room_ind] = room
    end

    return rooms
end

g_rooms = {}
function set_tile(room, layer, ind, val)
    local l = room.tiles[layer]

    if     l[ind] and not val then room.tiles_lens[layer] -= 1 end
    if not l[ind] and     val then room.tiles_lens[layer] += 1 end

    l[ind] = val
end

function set_obj(room, ind, val)
    local l = room.objs

    if     l[ind] and not val then room.objs_len -= 1 end
    if not l[ind] and     val then room.objs_len += 1 end

    l[ind] = val
end

function is_hut(y)
    return (y or g_link_grid.ysel) >= 14
end

function set_grid_to_cur_room(g)
    g.xmax = is_hut() and 8 or 12
    g.ymax = is_hut() and 6 or 10

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
    local tempr
    if is_hut() then tempr = g_link_hut_default
    else tempr = g_link_room_default end

    local newr = tabcpy(tempr or g_link_default_original)
    new_room(g_link_grid.xsel, g_link_grid.ysel, newr)
end

function set_room_default()
    local rcpy = tabcpy(get_cur_room())
    if is_hut() then g_link_hut_default  = rcpy
    else             g_link_room_default = rcpy end
end

function get_room(x, y) return g_rooms[y*16+x] end
function del_cur_room()
    local x, y = g_link_grid.xsel, g_link_grid.ysel
    set_room_default()
    g_rooms[y*16+x] = nil
end

function new_room(x, y, room)
    g_rooms[y*16+x] = room
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
