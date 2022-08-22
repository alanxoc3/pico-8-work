function draw_bar(x1,y1,x2,y2,percent,align,fg,bg,og)
    if x1 > x2 then x1 -= 3 x2 -= 3 end

    local bar_off = x2-x1-min(percent, 1)*(x2-x1)
    if align == 0 then bar_off /= 2 end

    rectfill(x1, y1, x1, y2, og)
    rectfill(x2, y1, x2, y2, og)

    if percent > 0 then
        local xx = ceil(x1+(align >= 0 and bar_off or 0))
        local yy = flr(x2-(align <= 0 and bar_off or 0))
        rectfill(xx, y1, yy, y2, fg)
        rectfill(xx, y2, yy, y2, bg)
   end
end

function draw_card(x, y, rx, ry, coffx, coffy, card_func, post_card_func)
    local x1, x2, y1, y2 = x-rx, x+rx-1, y-ry, y+ry-1
    local cam_x, cam_y = x1+coffx, y1+coffy

    clip(x1,y1,x2-x1,y2-y1)
    rectfill(-100, -100, 9000, 9000, 1)
    zcamera(cam_x, cam_y, card_func)
    clip()

    for i, c in pairs{1,13,0} do
        i=2-i
        color(c)
        if c ~= 0 then rect(x1+i, y1+i, x2-i, y2-i) end
        i+=1
        pset(x1+i, y1+i) pset(x1+i, y2-i)
        pset(x2-i, y1+i) pset(x2-i, y2-i)
    end

    zcamera(cam_x, cam_y, post_card_func)
end

-- controls the right stat so there is only ever 1 instance
zclass[[energybar,vec,actor,drawlayer_99|
    obj,@, y,-5, draw,%energybar_draw;

    start;  dy,1,  duration,.2, next,normal;
    normal; dy,0,  update,%energybar_update;
    ending; dy,-1, duration,.2;
]]

|[energybar_update]| function(a)
    if not a.obj.alive then a:kill() end
end $$

|[energybar_draw]| function(a)
    local is_cooldown = g_pl.is_energy_cooling_down and g_pl.energy >= g_pl.target_energy
    local fg = is_cooldown and 13 or 6 -- (g_pl.energy > .5 and 8 or 11)
    local bg = is_cooldown and 13 or 6 -- (g_pl.energy > .5 and 2 or 3)

    local yoff = a.y -- + (g_pl.is_energy_cooling_down and -cos(g_fi/4) or 0)

    draw_card(64, yoff, 46, 4.5, 0, 0, function()
        zcall(draw_bar, [[
            1;,2,1,89,5,@,0,@,@,13
        ]], 1-g_pl.energy,
        fg, bg)
    end, nop)

    -- camera(0, -yoff)


    -- camera()
end $$

zclass[[ma_left|]]
zclass[[ma_middle|]]
zclass[[ma_right|]]

zclass[[rstat|
    align,@, x,@, entity_type,@,
    update,%rstat_update,
    get,%rstat_get;
]]

|[rstat_update]| function(a)
    local buffer = g_zclass_entities[a.entity_type]

    local cur_obj = a.stat and a.stat.obj
    local new_obj = nil

    for obj in all(buffer) do
        if obj:is_active'isma' then
            new_obj = obj
            if obj == cur_obj then return end
        end
    end
    if does_entity_exist'tbox' then return end
    
    if a.stat then a.stat:load'ending' end
    a.stat = new_obj and _g.stat(a.align, a.x, new_obj)
end $$

|[rstat_get]| function(a)
    return a.stat and a.stat.obj
end $$

zclass[[stat,vec,actor,drawlayer_95|
    align,@, x,@, obj,@, y,141, draw,%stat_draw;

    start;  dy,-2, duration,.2, next,normal;
    normal; dy,0;
    ending; dy,2, duration,.2;
]]

|[stat_draw]| function(a)
    local obj = a.obj
    local has_health = obj.parents and obj.parents.healthobj
    draw_card(a.x+31, a.y+1, 21.5, has_health and 10 or 8, 2, 4, function()
        if align ~= 0 then
            spr(obj.cspr, 0, -1, 1, 1, a.align > 0)
            local xyo = 10-- -8*a.align-1
            if obj.cname then zprinttbox(obj.cname.." $1", 10, 0, -1, 7, 5) end
            
            if has_health then
                draw_bar(-1, 9, 37, 13, obj.display_health, -1, 11, 3, 13)
                pset(-1,9,1)
                pset(37,9,1)
                -- zprinttbox(flr(obj.health)..'/'..obj.max_health, xyo, 4, a.align, 7, 5)
            end
        end
    end, nop)

    --draw_card(a.x, a.y+(does_entity_exist'tbox' and 0 or -cos(g_si/4)*a.align), 6, 8, 2, 4, function()
    --end, nop)
end $$

zclass[[tbox,vec,actor,drawlayer_99|
    rawtext,@, destroyed,@,
    y,142,
    cur_text_index,1,
    anim,0,
    line_1,,
    line_2,,
    update,%tbox_update,
    draw,%tbox_draw;

    texts;,;
    start;  dy,-2, duration,.2, next,normal, update,nop, init,%tbox_init;
    normal; dy,0,  anim,0, done,no, update,%tbox_update, init,nop;
    ending; dy,2,  update,nop, duration,.2, init,nop;
]]

|[tbox_init]| function(a)
    a.texts = split(a.rawtext, "^")
end $$

|[tbox_update]| function(a)
    local text1 = a.texts[a.cur_text_index]
    local text2 = a.texts[a.cur_text_index+1] or ""
    local textslen = #text1 + #text2 + 4
    a.line_1 = sub(text1, 1, a.anim)
    a.line_2 = sub(text2, 1, max(0, a.anim - #text1))
    
    if a.anim == textslen then
        a.done = true
    end

    if btnp(4) or btnp(5) then
        if a.anim == textslen then
            if a.cur_text_index+2 > #a.texts then
                a:load'ending'
            else
                a.cur_text_index += 2
                a:load'normal'
            end
        else
            a.anim = textslen
        end
    end
    a.anim = min(textslen, a.anim+.5)
end $$

|[tbox_draw]| function(a)
    draw_card(64, a.y, 46, 10, 2.5, 5,
    function()
        zcall(zprinttbox, [[
            1;,@,0,-2,-1,7,5;
            2;,@,0,6,-1,7,5;
        ]], a.line_1 or "", a.line_2 or "")
    end, function()
        if a.done then
            zspr(38, 86, 10+g_si%2)
            zspr(38, 86, 2+g_si%2)
        end
    end)
end $$
