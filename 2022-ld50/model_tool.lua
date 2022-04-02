modes = { "lines", "collisions" }
zooms = { .5, 1, 1.5, 2, 3, 5 }
model = { lines={}, collisions={} }
virt_mx, virt_my = 0, 0
show_ui = true
lines_layer = 1
collisions_layer = 1

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
    for i=1,#model.lines,1 do
        str = str.."lines;"..i..";"
        for item in all(model.lines[i]) do
            str = str..","..item
        end
        str = str..";"
    end

    for i=1,#model.collisions,1 do
        str = str.."collisions;"..i..";"
        for item in all(model.collisions[i]) do
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
    if     keyboard_enabled and char == "f" then mode_i = mode_i % #modes + 1 last_x = nil last_y = nil
    elseif keyboard_enabled and char == "b" then mode_i=mode_i-1 mode_i = mode_i == 0 and #modes or mode_i last_x = nil last_y = nil
    elseif keyboard_enabled and char == "t" then show_ui = not show_ui
    elseif keyboard_enabled and char == "s" then printh(model_to_string(), '@clip')
    elseif keyboard_enabled and char == "r" then if stat(4) ~= "" then model = zobj(stat(4)) model.lines=model.lines or {} model.collisions=model.collisions or {} end
    elseif keyboard_enabled and char == "-" then next_zoom = min(#zooms, zoom_i+1)
    elseif keyboard_enabled and char == "+" then next_zoom = max(1, zoom_i-1)
    elseif keyboard_enabled and char == "=" then next_zoom = 2
    elseif curr_mode == "lines" then
        if char == "d" and model.lines[lines_layer] then
            deli(model.lines, lines_layer)
        elseif char == "x" and model.lines[lines_layer] then -- add layer that flips on x axis
            local cpy = {model.lines[lines_layer][1]}
            for i=2,#model.lines[lines_layer],1 do
                local item = model.lines[lines_layer][i]
                add(cpy, i % 2 == 0 and -item or item)
            end
            add(model.lines, cpy)
            lines_layer = #model.lines
        elseif char == "y" and model.lines[lines_layer] then -- add layer that flips on y axis
            local cpy = {model.lines[lines_layer][1]}
            for i=2,#model.lines[lines_layer],1 do
                local item = model.lines[lines_layer][i]
                add(cpy, i % 2 == 1 and -item or item)
            end
            add(model.lines, cpy)
            lines_layer = #model.lines
        elseif btnp(0) then lines_layer = max(1, lines_layer - 1)
        elseif btnp(1) then lines_layer = min(#model.lines+1, lines_layer + 1)
        elseif btnp(2) then 
            if model.lines[lines_layer] then
                model.lines[lines_layer][1] = min(15, model.lines[lines_layer][1]+1)
            end
        elseif btnp(3) then
            if model.lines[lines_layer] then
                model.lines[lines_layer][1] = max(1, model.lines[lines_layer][1]-1)
            end
        end

        -- left click, add point
        if stat(34) == 1 and not (last_x == virt_mx and last_y == virt_my) then
            model.lines[lines_layer] = model.lines[lines_layer] or {7}
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
    cls()

    if show_ui then
        if modes[mode_i] == "lines" then
            local shape = model.lines[lines_layer]
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
    end

    if show_ui then
        fillp(0b1010010110100101)
        wobble_line(64, 0, 64, 127, 8)
        wobble_line(0, 64, 127, 64, 8)
        wobble_line(14, 64-3, 14, 64+3, 7)
        wobble_line(64-3, 14, 64+3, 14, 7)
        wobble_line(114, 64-3, 114, 64+3, 7)
        wobble_line(64-3, 114, 64+3, 114, 7)
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

    for layer_i=1,#model.lines,1 do
        local shape = model.lines[layer_i]
        if #shape >= 5 then
            for i=2,#shape-2,2 do
                local x1, y1 = shape[i], shape[i+1]
                local x2, y2 = shape[i+2], shape[i+3]
                local color = (layer_i == lines_layer and modes[mode_i] == "lines" or not show_ui) and shape[1] or 1
                wobble_line(
                    x1*50/zooms[zoom_i]+64, y1*50/zooms[zoom_i]+64,
                    x2*50/zooms[zoom_i]+64, y2*50/zooms[zoom_i]+64, color
                )
            end
        end
    end

    if show_ui and modes[mode_i] == "lines" then
        local shape = model.lines[lines_layer]
        if shape then
            -- vertices
            for i=2,#shape,2 do
                local x1, y1 = shape[i], shape[i+1]
                circfill(x1*50/zooms[zoom_i]+64, y1*50/zooms[zoom_i]+64, 1, 7)
            end

            -- first point
            if #shape >= 3 then
                circ(shape[2]*50/zooms[zoom_i]+64, shape[3]*50/zooms[zoom_i]+64, 4, 8)
            end
        end
    end

    if show_ui and modes[mode_i] == "collisions" then
        local shape = model.collisions[collisions_layer]
        if shape then
            circ(shape[1]*50/zooms[zoom_i]+64, shape[2]*50/zooms[zoom_i]+64, 4, 8)
            wobble_line(shape[1]*50/zooms[zoom_i]+64, shape[2]*50/zooms[zoom_i]+64, (shape[1]+shape[3])*50/zooms[zoom_i]+64, shape[2]*50/zooms[zoom_i]+64, 11)
            wobble_line(shape[1]*50/zooms[zoom_i]+64, shape[2]*50/zooms[zoom_i]+64, shape[1]*50/zooms[zoom_i]+64, (shape[2]+shape[3])*50/zooms[zoom_i]+64, 11)
            circ(shape[1]*50/zooms[zoom_i]+64, shape[2]*50/zooms[zoom_i]+64, 1, 7)
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
    printh(str)

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
