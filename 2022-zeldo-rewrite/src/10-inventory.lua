zclass[[inventory,actor,drawlayer_90,ma_middle|
    pl,@, ind,4;
    start;    init,%inventory_start_init, update,%inventory_start_update, draw,nop;
    press;    init,nop,                   update,%inventory_press_update, draw,%inventory_draw;
    expand;   init,nop, update,nop, draw,%inventory_draw, duration,.0625, next,press;
    contract; init,nop, update,nop, draw,%inventory_draw, duration,.0625, next,start;

    ITEM_IND_NEXT_BANJO;    mem_loc,MEM_HAS_BANJO   , index,ITEM_IND_BANJO ,   name,banjo , sxo,0,  syo,1 , xoff,-7, yoff ,-9 , sind,SPR_BANJO,  xf,-1;
    ITEM_IND_NEXT_BOWL;     mem_loc,MEM_HAS_BOWL    , index,ITEM_IND_BOWL  ,   name,bowl  , sxo,1,  syo,-1, xoff,0 , yoff ,-10, sind,SPR_BOWL,   xf,1;
    ITEM_IND_NEXT_MASK;     mem_loc,MEM_HAS_MASK    , index,ITEM_IND_MASK  ,   name,mask  , sxo,2,  syo,2 , xoff,7 , yoff ,-9 , sind,SPR_MASK,   xf,1;
    ITEM_IND_NEXT_SHIELD;   mem_loc,MEM_HAS_SHIELD  , index,ITEM_IND_SHIELD,   name,shield, sxo,-1, syo,0 , xoff,-8, yoff ,-1 , sind,SPR_SHIELD, xf,-1;
    ITEM_IND_NEXT_INTERACT; mem_loc,MEM_ALWAYS_FALSE,                                       sxo,0,  syo,0 , xoff,0 , yoff ,0  , sind,0,          xf,1;
    ITEM_IND_NEXT_SWORD;    mem_loc,MEM_HAS_SWORD   , index,ITEM_IND_SWORD,    name,sword , sxo,1,  syo,0 , xoff,8 , yoff ,-1 , sind,SPR_SWORD,  xf,1;
    ITEM_IND_NEXT_BOMB;     mem_loc,MEM_HAS_BOMB    , index,ITEM_IND_BOMB,     name,bomb ,  sxo,2,  syo,1 , xoff,-7, yoff ,5  , sind,SPR_BOMB,   xf,1;
    ITEM_IND_NEXT_BRANG;    mem_loc,MEM_HAS_BRANG   , index,ITEM_IND_BRANG,    name,brang , sxo,1,  syo,1 , xoff,0 , yoff ,6  , sind,SPR_BRANG,  xf,1;
    ITEM_IND_NEXT_BOW;      mem_loc,MEM_HAS_BOW     , index,ITEM_IND_BOW,      name,bow   , sxo,0,  syo,0 , xoff,7 , yoff ,5  , sind,SPR_BOW,    xf,1;
    10;                     mem_loc,MEM_ALWAYS_TRUE , index,ITEM_IND_INTERACT,              sxo,0,  syo,-2, xoff,0 , yoff ,0  , sind,103,        xf,1, flip_enabled,on;
]]

|[inventory_start_init]| function(a)
    a.cspr = peek'MEM_ITEM_INDEX' ~= 4 and a[peek'MEM_ITEM_INDEX'+1].sind
end $$

|[inventory_start_update]| function(a)
    if peek'MEM_ITEM_INDEX' ~= 4 then
        a:start_timer('isma', 0)
    end

    if not g_pl:is_active'injured' and not g_pl:is_active'stunned' and not does_entity_exist'fader' and not does_entity_exist'tbox' and not does_entity_exist'banjo' and btn'BTN_ITEM_SELECT' then
        poke(MEM_ITEM_INDEX, 9) -- 9 is one more than the highest index
        a.ind = 4
        a:load'expand'
    end
end $$

|[inventory_press_update]| function(a)
    a.ind = mid(0,2,a.ind%3+zbtn(btnp,0)) + mid(0,2,a.ind\3+zbtn(btnp,2))*3
    if g_pl:is_active'injured' or g_pl:is_active'stunned' or does_entity_exist'fader' or does_entity_exist'tbox' or not btn'BTN_ITEM_SELECT' then
        poke(MEM_ITEM_INDEX, peek(a[a.ind+1].mem_loc) ~= 0 and a.ind or 4)
        a:load'contract'
    end
end $$

|[inventory_draw]| function(a)
    local percent = a.curr == 'contract' and (1-a:get_elapsed_percent'contract') or a:get_elapsed_percent'expand'
    for item in all(a) do
        local exist = peek(item.mem_loc) ~= 0
        -- local sind = exist and item.sind or 0
        local sxo, syo = item.sxo, item.syo
        
        local drawfunc = function()
            zspr(item.sind, sxo+a.pl.x*8+item.xoff*percent, syo+a.pl.y*8+item.yoff*percent, 1, 1, item.flip_enabled and a.pl.xf or item.xf)
        end

        if exist then
        draw_outline(item.index == a.ind and 2 or 1, drawfunc)
        if not exist then shade_fade(1) end
        drawfunc()
        pal()
    end
    end
end $$
