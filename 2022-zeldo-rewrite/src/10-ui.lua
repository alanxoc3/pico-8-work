function draw_bar(x1,y1,x2,y2,percent,align,fg,bg,og)
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
    camera()
    local x1, x2, y1, y2 = x-rx, x+rx-1, y-ry, y+ry-1
    local cam_x, cam_y = x1+coffx, y1+coffy

    zcall(function(xx1, yy1, xx2, yy2, col)
        rectfill(x1+xx1,y1+yy1,x2+xx2,y2+yy2,col)
    end, [[
        1;,1,0,-1,0,13;
        2;,0,1,0,-1,13;
        3;,2,1,-2,-1,1;
        4;,1,2,-1,-2,1;
    ]])

    clip(x1+2,y1+2,x2-x1-3,y2-y1-3)
    zcamera(cam_x, cam_y, card_func)
    clip()

    pset(x1+2, y1+2, 1) pset(x1+2, y2-2, 1)
    pset(x2-2, y1+2, 1) pset(x2-2, y2-2, 1)

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
    local fg = is_cooldown and 13 or 11 -- (g_pl.energy > .5 and 8 or 11)
    local bg = is_cooldown and 5 or 3-- (g_pl.energy > .5 and 2 or 3)

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
    align,@, x,@, obj,@, y,141, draw,%stat_draw, update,%stat_update;

    start;  dy,-2, duration,.2, next,normal;
    normal; dy,0;
    ending; dy,2, duration,.2;
]]

|[stat_update]| function(a)
    --if a.align < 0 then
    --    if does_entity_exist'tbox' then
    --        a.y = min(110-12, a.y+.75)
    --    else
    --        a.y = max(110, a.y-1)
    --    end
    --end
end $$

|[stat_draw]| function(a)
    local obj = a.obj
    local has_health = obj.parents and obj.parents.healthobj
    draw_card(a.x+31, a.y+1, 21.5, has_health and 9 or 6, 2, 4, function()
        local xxo = 15.5-15.5*a.align-1
        spr(obj.cspr, xxo, -2, 1, 1, a.align < 0)
        local xyo = 19.5+19.5*a.align
        if obj.cname then zprinttbox(obj.cname, xyo, -1, a.align, 7, 5) end
        if has_health then
            draw_bar(19-a.align*19-1, 7, 19+a.align*19-1, 11, obj.display_health, -1, 8, 2, 13)
            pset(-1,7,1)
            pset(37,7,1)
        end
    end, nop)
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

        if a.done then
            zspr(38, 86, 9+g_si%2)
        end
    end, nop)
end $$
