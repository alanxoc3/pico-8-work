function draw_bar(x1,y1,x2,y2,percent,align,fg,bg)
    if x1 > x2 then x1 -= 3 x2 -= 3 end

    local bar_off = x2-x1-min(percent, 1)*(x2-x1)
    if align == 0 then bar_off /= 2 end

    if percent > 0 then
        local xx = ceil(x1+(align >= 0 and bar_off or 0))
        local yy = flr(x2-(align <= 0 and bar_off or 0))
        rectfill(x1, y1, x1, y2, 13)
        rectfill(x2, y1, x2, y2, 13)
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
zclass[[rstat|
    align,@, x,@,
    update,%rstat_update,
    set,%rstat_set,
    get,%rstat_get;

    buffer;,;
]]

|[rstat_update]| function(a)
    local buffer = a.buffer
    a.buffer = {}

    local cur_obj, first_obj = a.stat and a.stat.obj, buffer[1]

    for obj in all(buffer) do
        if cur_obj == obj then return end
    end
    if does_entity_exist'tbox' then return end
    
    if a.stat then a.stat:load'ending' end
    a.stat = first_obj and _g.stat(a.align, a.x, first_obj)
end $$

|[rstat_set]| function(a, s)
    add(a.buffer, s)
end $$

|[rstat_get]| function(a)
    return a.stat and a.stat.obj
end $$

|[rstat_get]| function(a)
    return a.stat and a.stat.obj
end $$

zclass[[stat,vec,actor,drawlayer_95|
    align,@, x,@, obj,@, y,138, draw,%stat_draw;

    start;  dy,-2, duration,.2, next,normal;
    normal; dy,0;
    ending; dy,2, duration,.2;
]]

|[stat_draw]| function(a)
    local obj = a.obj
    if align ~= 0 then
        zcamera(a.x+2, a.y, function()
            local xyo = -8*a.align-1
            if obj.cname then zprinttbox(obj.cname, xyo, -10, a.align, 7, 5) end
            
            if obj.health and obj.max_health then
                draw_bar(xyo, -2, xyo-35*a.align, 1, obj.health/obj.max_health, -1, 11, 3)
                zprinttbox(flr(obj.health)..'/'..obj.max_health, xyo, 4, a.align, 7, 5)
            end
        end)
    end

    draw_card(a.x, a.y+(does_entity_exist'tbox' and 0 or -cos(g_si/4)*a.align), 6, 8, 2, 4, function()
        spr(obj.cspr, 0, 0, 1, 1, a.align > 0)
    end, nop)
end $$

zclass[[tbox,vec,actor,drawlayer_99|
    rawtext,@, destroyed,@,
    y,138,
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
    draw_card(65, a.y, 46.5, 10, 2.5, 5,
    function()
        zcall(zprinttbox, [[
            1;,@,0,-2,-1,7,5;
            2;,@,0,6,-1,7,5;
        ]], a.line_1 or "", a.line_2 or "")
    end, function()
        if a.done then
            zspr(38, 44, 16+g_si%2)
        end
    end)
end $$
