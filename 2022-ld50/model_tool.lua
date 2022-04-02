modes = { "lines" }
colors = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 }
zooms = { .5, 1, 1.5, 2, 3, 5 }
model = {}
layer = 1
virt_mx, virt_my = 0, 0
show_ui = true

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
    color_i = 7
    zoom_i = 2
end

function model_to_string()
    local str = ""
    for i=1,#model,1 do
        str = str..i..";"
        for item in all(model[i]) do
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

    if stat(30) then
        local char = stat(31)
        if false then
        elseif char == "t" then show_ui = not show_ui
        elseif char == "m" and not model[layer] then mode_i = mode_i % #modes + 1 if model[layer] then model[layer][1] = modes[mode_i] end
        elseif char == "c" then color_i = color_i % #colors + 1 if model[layer] then model[layer][2] = colors[color_i] end
        elseif char == "d" then if model[layer] then deli(model, layer) end
        elseif char == "s" then printh(model_to_string(), '@clip')
        elseif char == "r" then if stat(4) ~= "" then model = zobj(stat(4)) end
        elseif char == "-" then next_zoom = min(#zooms, zoom_i+1)
        elseif char == "+" then next_zoom = max(1, zoom_i-1)
        elseif char == "=" then next_zoom = 2
        end
    elseif btnp(0) then layer = max(1, layer - 1)
    elseif btnp(1) then layer = min(#model+1, layer + 1)
    elseif btnp(2) then next_zoom = max(1, zoom_i-1)
    elseif btnp(3) then next_zoom = min(#zooms, zoom_i+1)
    end

    if btnp(4) then mode_i = mode_i % #modes + 1 end
    if stat(34) == 1 then -- left click, add point
        if not (last_x == virt_mx and last_y == virt_my) then
            model[layer] = model[layer] or {modes[mode_i], colors[color_i]}
            add(model[layer], virt_mx)
            add(model[layer], virt_my)
            last_x = virt_mx
            last_y = virt_my
        end
    end
end

function _draw()
    cls()

    if show_ui then
        fillp(0b1010010110100101)
        line(64, 0, 64, 127, 8)
        line(0, 64, 127, 64, 8)
        line(14, 64-3, 14, 64+3, 7)
        line(64-3, 14, 64+3, 14, 7)
        line(114, 64-3, 114, 64+3, 7)
        line(64-3, 114, 64+3, 114, 7)
        fillp()

        print(zooms[zoom_i], 66, 116, 7)
    end

    for layer_i=1,#model,1 do
        local shape = model[layer_i]
        if #shape >= 4 then
            for i=3,#shape-2,2 do
                local x1, y1 = shape[i], shape[i+1]
                local x2, y2 = shape[i+2], shape[i+3]
                line(
                    x1*50/zooms[zoom_i]+64, y1*50/zooms[zoom_i]+64,
                    x2*50/zooms[zoom_i]+64, y2*50/zooms[zoom_i]+64, (layer_i == layer or not show_ui) and shape[2] or 1
                )
            end
        end
    end

    if show_ui then
        local shape = model[layer]
        if shape then
            -- vertices
            for i=3,#shape,2 do
                local x1, y1 = shape[i], shape[i+1]
                circfill(x1*50/zooms[zoom_i]+64, y1*50/zooms[zoom_i]+64, 1, 7)
            end

            -- origin point
            if #shape >= 4 then
                circ(shape[3]*50/zooms[zoom_i]+64, shape[4]*50/zooms[zoom_i]+64, 4, 8)
            end
        end

        print("l:"..layer.."|p:"..(shape and #shape/2 or 0), 4, 102, colors[color_i])
        print("x: "..virt_mx, 4, 108, colors[color_i])
        print("y: "..virt_my, 4, 114, colors[color_i])
        print("mode: "..modes[mode_i], 4, 120, colors[color_i])
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

function zobj(...)
    return zobj_set({}, ...)
end
