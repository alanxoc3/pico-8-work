zclass[[inventory,actor,drawlayer_90|
    pl,@, ind,4, flip,1;
    start;    init,%inventory_start_init, update,%inventory_start_update, draw,nop;
    press;    init,nop,                   update,%inventory_press_update, draw,%inventory_draw;
    expand;   init,nop, update,nop, draw,%inventory_draw, duration,.0625, next,press;
    contract; init,nop, update,nop, draw,%inventory_draw, duration,.0625, next,start;

    1; mem_loc,MEM_HAS_BOMB   , index,0, name,bomb  , sxo,-1, syo,1, xoff,-7 , yoff,-9 , sind,SPR_BOMB;
    2; mem_loc,MEM_HAS_BOWL   , index,1, name,bowl  , sxo,0, syo,-1, xoff,0 , yoff,-10  , sind,SPR_BOWL;
    3; mem_loc,MEM_HAS_MASK   , index,2, name,mask  , sxo,1, syo,1, xoff,7 , yoff,-9, sind,SPR_MASK;
    4; mem_loc,MEM_HAS_SHIELD , index,3, name,shield, sxo,0, syo,0, xoff,-8, yoff,-2 , sind,SPR_SHIELD;
    5; mem_loc,MEM_ALWAYS_FALSE,                      sxo,0, syo,0, xoff,0,  yoff,0, sind,0;
    6; mem_loc,MEM_HAS_SWORD  , index,5, name,sword , sxo,1, syo,0, xoff,8 , yoff,-2  , sind,SPR_SWORD;
    7; mem_loc,MEM_HAS_BANJO  , index,6, name,banjo , sxo,1, syo,0, xoff,-7, yoff,5  , sind,SPR_BANJO;
    8; mem_loc,MEM_HAS_BRANG  , index,7, name,brang , sxo,1, syo,1, xoff,0, yoff,6 , sind,SPR_BRANG;
    9; mem_loc,MEM_HAS_BOW    , index,8, name,bow   , sxo,0, syo,0, xoff,7 , yoff,5  , sind,SPR_BOW;
    10; mem_loc,MEM_ALWAYS_TRUE, index,4,             sxo,0, syo,-2, xoff,0 , yoff,0, sind,103;
]]

|[inventory_start_init]| function(a)
    poke(MEM_ITEM_INDEX, peek(a[a.ind+1].mem_loc) ~= 0 and a.ind or 4)
    a.stat = peek'MEM_ITEM_INDEX' ~= 4 and {cspr=a[peek'MEM_ITEM_INDEX'+1].sind}
end $$

|[inventory_start_update]| function(a)
    g_rstat_inventory:set(a.stat)

    if not does_entity_exist'tbox' and btn'BTN_ITEM_SELECT' then
        poke(MEM_ITEM_INDEX, 9) -- 9 is one more than the highest index
        a.flip = a.pl.xf and -1 or 1
        a.ind = 4
        a:load'expand'
    end
end $$

|[inventory_press_update]| function(a)
    a.ind = mid(0,2,a.ind%3+a.flip*zbtn(btnp,0)) + mid(0,2,a.ind\3+zbtn(btnp,2))*3
    if does_entity_exist'tbox' or not btn'BTN_ITEM_SELECT' then
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
            zspr(sind, sxo*a.flip+ a.pl.x*8+a.flip*item.xoff*percent, syo+a.pl.y*8+item.yoff*percent, 1, 1, a.flip < 0)
        end

        draw_outline(item.index == a.ind and 2 or 1, drawfunc)
        drawfunc()
    end
end $$
