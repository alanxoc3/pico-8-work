zclass[[inventory,actor,drawlayer_90|
    pl,@;
    start; init,%inventory_start_init, update,%inventory_start_update, draw,nop;
    press; init,nop,                   update,%inventory_press_update, draw,%inventory_draw;
    1; mem_loc,MEM_HAS_BRANG  , index,0, name,brang , xoff,-7, yoff,-9 , sind,SPR_BRANG;
    2; mem_loc,MEM_HAS_MASK   , index,1, name,mask  , xoff,0 , yoff,-11, sind,SPR_MASK;
    3; mem_loc,MEM_HAS_BOMB   , index,2, name,bomb  , xoff,7 , yoff,-9 , sind,SPR_BOMB;
    4; mem_loc,MEM_HAS_SHIELD , index,3, name,shield, xoff,-8, yoff,-3 , sind,SPR_SHIELD;
    5; index,4;
    6; mem_loc,MEM_HAS_BOW    , index,5, name,bow   , xoff,9 , yoff,-2 , sind,SPR_BOW;
    7; mem_loc,MEM_HAS_BANJO  , index,6, name,banjo , xoff,-7, yoff,4  , sind,SPR_BANJO;
    8; mem_loc,MEM_HAS_SWORD  , index,7, name,sword , xoff,0 , yoff,6  , sind,SPR_SWORD;
    9; mem_loc,MEM_HAS_BOWL   , index,8, name,bow   , xoff,7 , yoff,5  , sind,SPR_BOWL;
]]

|inventory_start_init| function(a)
    if peek'MEM_ITEM_INDEX' ~= 4 then
        a.stat = _g.stat(0, 64, {cspr=a[peek'MEM_ITEM_INDEX'+1].sind})
    else
        a.stat = nil
    end
end $$

|inventory_start_update| function(a)
    if not does_entity_exist'tbox' and btn'BTN_ITEM_SELECT' then
        call_not_nil(a.stat, 'load', a.stat, 'ending')
        poke(MEM_ITEM_INDEX, 4)
        a:load'press'
    end
end $$

|inventory_press_update| function(a)
    poke(MEM_ITEM_INDEX, mid(0,2,peek'MEM_ITEM_INDEX'%3+zbtn(btnp,0)) + mid(0,2,peek'MEM_ITEM_INDEX'\3+zbtn(btnp,2))*3)
    if does_entity_exist'tbox' or not btn'BTN_ITEM_SELECT' then
        a:load'start'
    end
end $$

|inventory_draw| function(a)
    for item in all(a) do
        local drawfunc = item.index == 4 and function() a.pl:draw() end or function()
            zspr(item.sind, a.pl.x*8+item.xoff, a.pl.y*8+item.yoff, 1, 1, a.pl.xf)
        end

        draw_outline(item.index == peek'MEM_ITEM_INDEX' and 2 or 1, drawfunc)
        drawfunc()
    end
end $$
