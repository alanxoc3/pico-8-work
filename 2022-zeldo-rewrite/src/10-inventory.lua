zclass[[inventory,actor,drawlayer_90|
    pl,@, ind,4;
    start;    init,%inventory_start_init, update,%inventory_start_update, draw,nop;
    press;    init,nop,                   update,%inventory_press_update, draw,%inventory_draw;
    expand;   init,nop, update,nop, draw,%inventory_draw, duration,.0625, next,press;
    contract; init,nop, update,nop, draw,%inventory_draw, duration,.0625, next,start;

    ITEM_IND_NEXT_BOMB;     mem_loc,MEM_HAS_BOMB   , index,ITEM_IND_BOMB, name,bomb  ,   sxo,-1, syo,1 , xoff,-7 , yoff ,-9   , sind,SPR_BOMB;
    ITEM_IND_NEXT_BOWL;     mem_loc,MEM_HAS_BOWL   , index,ITEM_IND_BOWL, name,bowl  ,   sxo,0 , syo,-1, xoff,0  , yoff ,-10  , sind,SPR_BOWL;
    ITEM_IND_NEXT_MASK;     mem_loc,MEM_HAS_MASK   , index,ITEM_IND_MASK, name,mask  ,   sxo,1 , syo,1 , xoff,7  , yoff ,-9   , sind,SPR_MASK;
    ITEM_IND_NEXT_SHIELD;   mem_loc,MEM_HAS_SHIELD , index,ITEM_IND_SHIELD, name,shield, sxo,0 , syo,0 , xoff,-8 , yoff ,-2   , sind,SPR_SHIELD;
    ITEM_IND_NEXT_INTERACT; mem_loc,MEM_ALWAYS_FALSE,                                    sxo,0 , syo,0 , xoff,0  ,  yoff,0    , sind,0;
    ITEM_IND_NEXT_SWORD;    mem_loc,MEM_HAS_SWORD  , index,ITEM_IND_SWORD, name,sword ,  sxo,1 , syo,0 , xoff,8  , yoff ,-2   , sind,SPR_SWORD;
    ITEM_IND_NEXT_BANJO;    mem_loc,MEM_HAS_BANJO  , index,ITEM_IND_BANJO, name,banjo ,  sxo,1 , syo,0 , xoff,-7 , yoff ,5    , sind,SPR_BANJO;
    ITEM_IND_NEXT_BRANG;    mem_loc,MEM_HAS_BRANG  , index,ITEM_IND_BRANG, name,brang ,  sxo,1 , syo,1 , xoff,0  , yoff ,6    , sind,SPR_BRANG;
    ITEM_IND_NEXT_BOW;      mem_loc,MEM_HAS_BOW    , index,ITEM_IND_BOW, name,bow   ,    sxo,0 , syo,0 , xoff,7  , yoff ,5    , sind,SPR_BOW;
    10;                     mem_loc,MEM_ALWAYS_TRUE, index,ITEM_IND_INTERACT,            sxo,0 , syo,-2, xoff,0  , yoff ,0    , sind,103, flip_enabled,on;
]]

|[inventory_start_init]| function(a)
    a.stat = peek'MEM_ITEM_INDEX' ~= 4 and {cspr=a[peek'MEM_ITEM_INDEX'+1].sind}
    -- a.ind = peek'MEM_ITEM_INDEX'
end $$

|[inventory_start_update]| function(a)
    g_rstat_inventory:set(a.stat)

    if not does_entity_exist'fader' and not does_entity_exist'tbox' and not does_entity_exist'banjo' and btn'BTN_ITEM_SELECT' then
        poke(MEM_ITEM_INDEX, 9) -- 9 is one more than the highest index
        a.ind = 4
        a:load'expand'
    end
end $$

|[inventory_press_update]| function(a)
    a.ind = mid(0,2,a.ind%3+zbtn(btnp,0)) + mid(0,2,a.ind\3+zbtn(btnp,2))*3
    if does_entity_exist'fader' or does_entity_exist'tbox' or not btn'BTN_ITEM_SELECT' then
        poke(MEM_ITEM_INDEX, peek(a[a.ind+1].mem_loc) ~= 0 and a.ind or 4)
        a:load'contract'
    end
end $$

|[inventory_draw]| function(a)
    local percent = a.curr == 'contract' and (1-a:get_elapsed_percent'contract') or a:get_elapsed_percent'expand'

    zrect(a.pl.x*8, a.pl.y*8-2,     percent*8, percent*8, 1)
    for item in all(a) do
        local exist = peek(item.mem_loc) ~= 0
        local sind = exist and item.sind or 0
        local sxo, syo = exist and item.sxo or 0, exist and item.syo or 0
        
        local drawfunc = function()
            zspr(sind, sxo+a.pl.x*8+item.xoff*percent, syo+a.pl.y*8+item.yoff*percent, 1, 1, item.flip_enabled and a.pl.xf)
        end

        draw_outline(item.index == a.ind and 2 or 1, drawfunc)
        drawfunc()
    end
end $$
