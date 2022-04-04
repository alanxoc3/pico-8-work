modes = { "lines", "collisions" }
zooms = { .5, 1, 1.5, 2, 3, 5 }
model = { lines={}, collisions={} }

line_view = true
default_line_color = 7
default_wobble = false
default_fill_color = -1

virt_mx, virt_my = 0, 0
show_ui = true
lines_layer, collisions_layer = 1, 1

-- fast approximate distance formula (no need for sqrt & ^2)
-- stolen from a pico-8 forum
function approx_dist(dx,dy)
    local maskx,masky=dx>>31,dy>>31
    local a0,b0=(dx+maskx)^^maskx,(dy+masky)^^masky
    if a0>b0 then
        return a0*0.9609+b0*0.3984
    end
    return b0*0.9609+a0*0.3984
end

function _init()
    poke(0x5f2d, 1)
    mode_i = 1
    zoom_i = 2
end

function model_to_string()
    local str = ""

    for i=1,#model.collisions,1 do
        str = str.."collisions;"..i..";"
        for item in all(model.collisions[i]) do
            str = str..","..item
        end
        str = str..";"
    end

    for i=1,#model.lines,1 do
        str = str.."lines;"..i..";"
        for item in all(model.lines[i]) do
            if item == true then item = "yes" end
            if item == false then item = "no" end
            str = str..","..item
        end
        str = str..";"
    end

    return str
end

function round(num)
    if num >= .5 then return flr(num)
    else return ceil(num) end
end

function _update60()
    if next_zoom then
        zoom_i = next_zoom
        next_zoom = nil
    end

    virt_mx, virt_my = (min(120, max(8, stat(32)))-64)/50*zooms[zoom_i], (min(120, max(8, stat(33)))-64)/50*zooms[zoom_i]
    virt_mx, virt_my = round(virt_mx*10)/10, round(virt_my*10)/10

    -- switch mode logic
    local keyboard_enabled = stat(30)
    local char = stat(31)
    local curr_mode = modes[mode_i]
    if     keyboard_enabled and char == "m" then mode_i = mode_i % #modes + 1 last_x = nil last_y = nil
    elseif keyboard_enabled and char == "t" then show_ui = not show_ui
    elseif keyboard_enabled and char == "s" then printh(model_to_string(), '@clip')
    elseif keyboard_enabled and char == "r" then if stat(4) ~= "" then model = zobj(stat(4)) model.lines=model.lines or {} model.collisions=model.collisions or {} end
    elseif keyboard_enabled and char == "-" then next_zoom = min(#zooms, zoom_i+1)
    elseif keyboard_enabled and char == "+" then next_zoom = max(1, zoom_i-1)
    elseif keyboard_enabled and char == "=" then next_zoom = 2
    elseif keyboard_enabled and char == "o" then -- rotate everything
        for lines in all(model.lines) do
            for i=4,#lines,2 do
                lines[i], lines[i+1] = -lines[i+1], lines[i]
            end
        end

        for collision in all(model.collisions) do
            collision[1], collision[2] = -collision[2], collision[1]
        end
    elseif curr_mode == "lines" then
        if char == "d" and model.lines[lines_layer] then
            deli(model.lines, lines_layer)
        elseif char == "y" and model.lines[lines_layer] then -- add layer that flips on y axis
            local cpy = {model.lines[lines_layer][1]}
            for i=4,#model.lines[lines_layer],1 do
                local item = model.lines[lines_layer][i]
                add(cpy, i % 2 == 1 and -item or item)
            end
            add(model.lines, cpy)
            lines_layer = #model.lines
        elseif char == "x" and model.lines[lines_layer] then -- add layer that flips on x axis
            local cpy = {model.lines[lines_layer][1]}
            for i=4,#model.lines[lines_layer],1 do
                local item = model.lines[lines_layer][i]
                add(cpy, i % 2 == 0 and -item or item)
            end
            add(model.lines, cpy)
            lines_layer = #model.lines
        elseif char == "w" then
            if model.lines[lines_layer] then
                model.lines[lines_layer][3] = not model.lines[lines_layer][3]
                default_wobble = model.lines[lines_layer][3]
            end
        elseif char == "[" then -- move layer left
            if lines_layer > 1 and model.lines[lines_layer] then
                model.lines[lines_layer], model.lines[lines_layer-1] = model.lines[lines_layer-1], model.lines[lines_layer]
                lines_layer -= 1
            end
        elseif char == "]" then -- move layer left
            if lines_layer < #model.lines and model.lines[lines_layer] then
                model.lines[lines_layer], model.lines[lines_layer+1] = model.lines[lines_layer+1], model.lines[lines_layer]
                lines_layer += 1
            end
        elseif char == "0" then if line_view then default_line_color = 0  if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 0  if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "1" then if line_view then default_line_color = 1  if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 1  if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "2" then if line_view then default_line_color = 2  if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 2  if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "3" then if line_view then default_line_color = 3  if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 3  if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "4" then if line_view then default_line_color = 4  if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 4  if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "5" then if line_view then default_line_color = 5  if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 5  if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "6" then if line_view then default_line_color = 6  if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 6  if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "7" then if line_view then default_line_color = 7  if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 7  if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "8" then if line_view then default_line_color = 8  if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 8  if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "9" then if line_view then default_line_color = 9  if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 9  if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == ")" then if line_view then default_line_color = 10 if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 10 if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "!" then if line_view then default_line_color = 11 if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 11 if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "@" then if line_view then default_line_color = 12 if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 12 if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "#" then if line_view then default_line_color = 13 if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 13 if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "$" then if line_view then default_line_color = 14 if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 14 if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "%" then if line_view then default_line_color = 15 if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = 15 if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "`" then if line_view then default_line_color = -1 if model.lines[lines_layer] then model.lines[lines_layer][1] = default_line_color end else default_fill_color = -1 if model.lines[lines_layer] then model.lines[lines_layer][2] = default_fill_color end end
        elseif char == "f" then line_view = not line_view
        elseif btnp(0) then lines_layer = max(1, lines_layer - 1)
        elseif btnp(1) then lines_layer = min(#model.lines+1, lines_layer + 1)
        end

        -- left click, add point
        if stat(34) == 1 and not (last_x == virt_mx and last_y == virt_my) then
            model.lines[lines_layer] = model.lines[lines_layer] or {default_line_color, default_fill_color, default_wobble}
            add(model.lines[lines_layer], virt_mx)
            add(model.lines[lines_layer], virt_my)
            last_x = virt_mx
            last_y = virt_my
        end
    elseif curr_mode == "collisions" then
        if char == "d" and model.collisions[collisions_layer] then
            deli(model.collisions, collisions_layer)
        elseif btnp(0) then collisions_layer = max(1, collisions_layer - 1)
        elseif btnp(1) then collisions_layer = min(#model.collisions+1, collisions_layer + 1)
        elseif btnp(2) then 
            if model.collisions[collisions_layer] then
                model.collisions[collisions_layer][3] = min(5, model.collisions[collisions_layer][3]+.1)
            end
        elseif btnp(3) then
            if model.collisions[collisions_layer] then
                model.collisions[collisions_layer][3] = max(.1, model.collisions[collisions_layer][3]-.1)
            end
        end

        -- left click, add point
        if stat(34) == 1 and not (last_x == virt_mx and last_y == virt_my) then
            model.collisions[collisions_layer] = model.collisions[collisions_layer] or { virt_mx, virt_my, .5 }
            model.collisions[collisions_layer][1] = virt_mx
            model.collisions[collisions_layer][2] = virt_my
            last_x, last_y = virt_mx, virt_my
        end
    end
end

function _draw()
    if show_ui then
        cls()
    else
        fillp(0b0111101111011110)
        rectfill(0, 0, 127, 127, 1)
        fillp()
    end

    if show_ui then
        if modes[mode_i] == "lines" then
            local shape = model.lines[lines_layer]
            print(line_view and "line edit" or "fill edit", 4, 84, 5)
            print("wobble "..(shape and shape[3] and "on" or "off"), 4, 90, 5)
            print("points:"..(shape and (#shape-1)/2 or 0), 4, 96, 5)
            print("layer:"..lines_layer, 4, 102, 5)
        elseif modes[mode_i] == "collisions" then
            local shape = model.collisions[collisions_layer]
            print("rad:"..(shape and shape[3] or 0), 4, 96, 5)
            print("layer:"..collisions_layer, 4, 102, 5)
        end
        print("x: "..virt_mx, 4, 108, 5)
        print("y: "..virt_my, 4, 114, 5)
        print(modes[mode_i], 4, 120, 5)

        -- grid
        fillp(0b1010010110100101)
        line(64, 0, 64, 127, 8)
        line(0, 64, 127, 64, 8)
        line(14, 64-3, 14, 64+3, 7)
        line(64-3, 14, 64+3, 14, 7)
        line(114, 64-3, 114, 64+3, 7)
        line(64-3, 114, 64+3, 114, 7)
        fillp()

        print(zooms[zoom_i], 66, 116, 7)

        for coll_i=1,#model.collisions,1 do
            local collision = model.collisions[coll_i]
            for i=1,#collision,3 do
                local x, y, rad = collision[i], collision[i+1], collision[i+2]
                local color = modes[mode_i] == "collisions" and collisions_layer == coll_i and 11 or 2
                circ(x*50/zooms[zoom_i]+64, y*50/zooms[zoom_i]+64, rad*50/zooms[zoom_i], color)
            end
        end
    end

    if not show_ui then
        for layer_i=1,#model.lines,1 do
            local shape = model.lines[layer_i]
            if #shape >= 3 then
                local points = {}
                for i=4,#shape-2,2 do
                    add(points, {x=shape[i]*50/zooms[zoom_i]+64, y=shape[i+1]*50/zooms[zoom_i]+64})
                end

                if shape[2] >= 0 then -- negative means transparent
                    draw_polygon(points, shape[2])
                end
            end
        end
    end

    for layer_i=1,#model.lines,1 do
        local shape = model.lines[layer_i]
        if #shape >= 7 then
            for i=4,#shape-2,2 do
                local x1, y1 = shape[i], shape[i+1]
                local x2, y2 = shape[i+2], shape[i+3]
                local color = 1
                if not show_ui then
                    color = shape[1]
                elseif layer_i == lines_layer and modes[mode_i] == "lines" then
                    color = shape[line_view and 1 or 2]
                end

                if color >= 0 then
                    if not shape[3] then
                        line(
                            x1*50/zooms[zoom_i]+64, y1*50/zooms[zoom_i]+64,
                            x2*50/zooms[zoom_i]+64, y2*50/zooms[zoom_i]+64, color
                        )
                    else
                        wobble_line(
                            x1*50/zooms[zoom_i]+64, y1*50/zooms[zoom_i]+64,
                            x2*50/zooms[zoom_i]+64, y2*50/zooms[zoom_i]+64, color
                        )
                    end
                end
            end
        end
    end

    if show_ui then
        if modes[mode_i] == "lines" then
            local shape = model.lines[lines_layer]
            if shape then
                -- vertices
                for i=4,#shape,2 do
                    local x1, y1 = shape[i], shape[i+1]
                    circfill(x1*50/zooms[zoom_i]+64, y1*50/zooms[zoom_i]+64, 1, 7)
                end

                -- first point
                if #shape >= 5 then
                    circ(shape[4]*50/zooms[zoom_i]+64, shape[5]*50/zooms[zoom_i]+64, 4, 8)
                end
            end
        elseif modes[mode_i] == "collisions" then
            local shape = model.collisions[collisions_layer]
            if shape then
                circ(shape[1]*50/zooms[zoom_i]+64, shape[2]*50/zooms[zoom_i]+64, 4, 8)
                wobble_line(shape[1]*50/zooms[zoom_i]+64, shape[2]*50/zooms[zoom_i]+64, (shape[1]+shape[3])*50/zooms[zoom_i]+64, shape[2]*50/zooms[zoom_i]+64, 11)
                wobble_line(shape[1]*50/zooms[zoom_i]+64, shape[2]*50/zooms[zoom_i]+64, shape[1]*50/zooms[zoom_i]+64, (shape[2]+shape[3])*50/zooms[zoom_i]+64, 11)
                circ(shape[1]*50/zooms[zoom_i]+64, shape[2]*50/zooms[zoom_i]+64, 1, 7)
            end
        end
    end

    -- cursor
    pset(virt_mx*50/zooms[zoom_i]+64-1, virt_my*50/zooms[zoom_i]+64,   pget(virt_mx*50/zooms[zoom_i]+64-1, virt_my*50/zooms[zoom_i]+64)+7)
    pset(virt_mx*50/zooms[zoom_i]+64+1, virt_my*50/zooms[zoom_i]+64,   pget(virt_mx*50/zooms[zoom_i]+64+1, virt_my*50/zooms[zoom_i]+64)+7)
    pset(virt_mx*50/zooms[zoom_i]+64,   virt_my*50/zooms[zoom_i]+64-1, pget(virt_mx*50/zooms[zoom_i]+64,   virt_my*50/zooms[zoom_i]+64-1)+7)
    pset(virt_mx*50/zooms[zoom_i]+64,   virt_my*50/zooms[zoom_i]+64+1, pget(virt_mx*50/zooms[zoom_i]+64,   virt_my*50/zooms[zoom_i]+64+1)+7)

    pset(virt_mx*50/zooms[zoom_i]+64-2, virt_my*50/zooms[zoom_i]+64,   pget(virt_mx*50/zooms[zoom_i]+64-2, virt_my*50/zooms[zoom_i]+64)+7)
    pset(virt_mx*50/zooms[zoom_i]+64+2, virt_my*50/zooms[zoom_i]+64,   pget(virt_mx*50/zooms[zoom_i]+64+2, virt_my*50/zooms[zoom_i]+64)+7)
    pset(virt_mx*50/zooms[zoom_i]+64,   virt_my*50/zooms[zoom_i]+64-2, pget(virt_mx*50/zooms[zoom_i]+64,   virt_my*50/zooms[zoom_i]+64-2)+7)
    pset(virt_mx*50/zooms[zoom_i]+64,   virt_my*50/zooms[zoom_i]+64+2, pget(virt_mx*50/zooms[zoom_i]+64,   virt_my*50/zooms[zoom_i]+64+2)+7)
end

-- thanks to https://www.lexaloffle.com/bbs/?tid=34282
function draw_polygon(points, c)
    local xl,xr,ymin,ymax={},{},129,0xffff
    for k,v in pairs(points) do
        local p2=points[k%#points+1]
        local x1,y1,x2,y2=v.x,flr(v.y),p2.x,flr(p2.y)
        if y1>y2 then
            y1,y2,x1,x2=y2,y1,x2,x1
        end
        local d=y2-y1
        for y=y1,y2 do
            local xval=flr(x1+(x2-x1)*(d==0 and 1 or (y-y1)/d))
            xl[y],xr[y]=min(xl[y] or 32767,xval),max(xr[y] or 0x8001,xval)
        end
        ymin,ymax=min(y1,ymin),max(y2,ymax)
    end
    for y=ymin,ymax do
        rectfill(xl[y],y,xr[y],y,c)
    end
end

-- MODIFIED ZOBJ
function zobj_eval(val, table, parameters)
    if     val == 'yes'  or val == 'no' then return val=='yes'
    elseif val == 'null' or val == ''   then return -- nil is inferred
    elseif val == 'nop'                 then return function() end
    end                                      return val
end

-- has an extra split call no matter key or val, but token & character count goes down from ztable-ord
function zobj_set(table, oldstr, ...)
    local str = ""
    for i=1,#oldstr,1 do
        local code = ord(sub(oldstr, i, i))
        if code ~= 10 and code ~= 9 and code ~= 0 and code ~= 8 and code ~= 32 then
            str = str..sub(oldstr,i,i)
        end
    end

    local params, statements, dest = {...}, split(str, ";"), table
    foreach(statements, function(statement)
        local tokens = split(statement)
        if #tokens > 1 then
            if tokens[1] == '' then -- array (started with ',')
                foreach(tokens, function(val)
                    add(dest, zobj_eval(val, table, params))
                end)
            else -- map
                for i=1,#tokens,2 do
                    dest[tokens[i]] = zobj_eval(tokens[i+1], table, params)
                end
            end
            dest = table
        else
            if type(dest[statement]) ~= "table" then
                dest[statement] = {}
            end
            dest = dest[statement]
        end
    end)
    return table
end

function flr_rnd(x)
    return flr(rnd(x))
end

function wobble_line(x1, y1, x3, y3, color)
    if not show_ui then
        srand(t()*4\1)
        local x2, y2 = (x3-x1)/2+x1+flr_rnd(3)-1, (y3-y1)/2+y1+flr_rnd(3)-1
        line(x1, y1, x2, y2, color)
        line(x2, y2, x3, y3, color)
    else
        line(x1, y1, x3, y3, color)
    end
end

function zobj(...)
    return zobj_set({}, ...)
end
