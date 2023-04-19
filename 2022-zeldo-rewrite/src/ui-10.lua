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

-- improves performance for draw_card below
|[f_card_table_cache]| f_zobj[[
    1;,1,0,-1,0,13;
    2;,0,1,0,-1,13;
    3;,2,1,-2,-1,1;
    4;,1,2,-1,-2,1;
]] $$

function draw_card(x, y, rx, ry, coffx, coffy, card_func, post_card_func)
    camera()
    local x1, x2, y1, y2 = x-rx, x+rx-1, y-ry, y+ry-1
    local cam_x, cam_y = x1+coffx, y1+coffy

    zcall_tbl(function(xx1, yy1, xx2, yy2, col)
        rectfill(x1+xx1,y1+yy1,x2+xx2,y2+yy2,col)
    end, _g.f_card_table_cache)

    clip(x1+2,y1+2,x2-x1-3,y2-y1-3)
    zcamera(cam_x, cam_y, card_func)
    clip()

    pset(x1+2, y1+2, 1) pset(x1+2, y2-2, 1)
    pset(x2-2, y1+2, 1) pset(x2-2, y2-2, 1)

    zcamera(cam_x, cam_y, post_card_func)
end

zclass[[coin_count,vec,actor,drawlayer_90|
    y,142, draw,%f_coin_coint_draw;
    defaults; dy,0, update,nop;
    start;  next,open,   update,%f_coin_count_start;
    open;   next,normal, dy,-2, duration,.2;
    normal; next,close,  update,%f_coin_count_normal;
    close;  next,start,  dy,2,  duration,.2;
]]

|[f_coin_count_start]| function(a)
    if peek'MEM_MONEY' ~= 0 then a:load() end
end $$

|[f_coin_count_normal]| function(a)
    if peek'MEM_MONEY' == 0 then a:load() end
end $$

|[f_coin_coint_draw]| function(a)
    draw_card(64, a.y, 9, 5, 0, 0, function()
        spr(SPR_COIN_UI, 1, 0)
        zprinttbox(tostr(peek'MEM_MONEY'), 12, 2, 0, 7, 5)
    end, nop)
end $$

-- controls the right stat so there is only ever 1 instance
zclass[[energybar,vec,actor,drawlayer_99|
    obj,@, y,20, draw,%f_energybar_draw;
]]

|[f_energybar_draw]| function(a)
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

zclass[[ma_left|ma_level,0]]
zclass[[ma_right|ma_level,0]]

-- 2 levels of ma_right. battle and f_interact. f_interact always trumps battle.
zclass[[ma_battle,ma_right|ma_level,0]]
zclass[[ma_boss,ma_right|ma_level,1]]
zclass[[ma_interact,ma_right|ma_level,2]]

zclass[[rstat,vec,actor,drawlayer_95|
    align,@, x,@, entity_type,@,
    y,141, draw,%f_stat_draw,
    buffer_update,%f_rstat_update, get,%f_rstat_get;

    defaults; dy,0, update,nop;
    start;  next,open,   update,%f_stat_idle;
    open;   next,normal, dy,-2, duration,.2;
    normal; next,close,  update,%f_stat_normal;
    close;  next,start,  dy,2,  duration,.2;
]]

|[f_stat_idle]| function(a)
    a.obj = nil
    if a.next_obj and a.next_obj:is_alive() then
        a.obj = a.next_obj
        a.next_obj = nil
        a:load()
    end
end $$

|[f_rstat_update]| function(a)
    local buffer, cur_obj, new_lvl, new_obj, should_exit = g_zclass_entities[a.entity_type], a:get(), -1

    for obj in all(buffer) do
        if obj:is_active'isma' and obj:is_alive() and (obj.ma_level > new_lvl or obj == cur_obj and obj.ma_level >= new_lvl) then
            new_obj, new_lvl = obj, obj.ma_level
        end
    end

    a.next_obj = new_obj
end $$

|[f_rstat_get]| function(a)
    return a.curr == 'normal' and a.obj and a.obj:is_alive() and a.obj
end $$

|[f_stat_normal]| function(a)
    if a.next_obj ~= a.obj then
        a:load()
    end
end $$

|[f_stat_draw]| function(a)
    local obj = a.obj
    if obj then
        local has_health = obj.parents and obj.parents.healthobj
        draw_card(a.x, a.y+1, 17.5, has_health and 9 or 6, 2, 4, function()
            local xxo = 11.5-11.5*a.align-1
            spr(obj.cspr, xxo, -2, 1, 1, a.align < 0)
            local xyo = 15.5+15.5*a.align
            if obj.cname then zprinttbox(obj.cname, xyo, -1, a.align, 7, 5) end
            if has_health then
                draw_bar(15-a.align*15-1, 7, 15+a.align*15-1, 11, obj.display_health, -1, 8, 2, 13)
                pset(-1,7,1)
                pset(29,7,1)
            end
        end, nop)
    end
end $$

zclass[[tbox,vec,actor,drawlayer_99|
    rawtext,@, destroyed,@,
    y,142,
    cur_text_index,1,
    anim,0,
    line_1,,
    line_2,,
    update,%f_tbox_update,
    draw,%f_tbox_draw;

    texts;,;
    defaults; init,nop, update,nop;
    start;  dy,-2, duration,.2, next,normal, init,%f_tbox_init;
    normal; dy,0,  anim,0, done,no, update,%f_tbox_update;
    ending; dy,2,  duration,.2;
]]

|[f_tbox_init]| function(a)
    a.texts = split(a.rawtext, "^")
    a.sind = deli(a.texts, 1)
end $$

|[f_tbox_update]| function(a)
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

|[f_tbox_draw]| function(a)
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

    draw_card(118, a.y, 6, 6, 2, 2,
        function()
            spr(a.sind, 0, 0, 1, 1, true)
        end, nop)
end $$
