zclass[[inventory,actor,drawlayer_90,nopause|
    pl,@;
    start; nopause_update,%inventory_start_update, draw,nop;
    press; nopause_update,%inventory_press_update, cur_item,4, draw,%inventory_draw;
    1; mem_loc,HAS_BRANG  , index,0, name,brang , xoff,-7, yoff,-9 , sind,SPR_BRANG;
    2; mem_loc,HAS_MASK   , index,1, name,mask  , xoff,0 , yoff,-11, sind,SPR_MASK;
    3; mem_loc,HAS_BOMB   , index,2, name,bomb  , xoff,7 , yoff,-9 , sind,SPR_BOMB;
    4; mem_loc,HAS_SHIELD , index,3, name,shield, xoff,-8, yoff,-3 , sind,SPR_SHIELD;
    5; index,4;
    6; mem_loc,HAS_BOW    , index,5, name,bow   , xoff,9 , yoff,-2 , sind,SPR_BOW;
    7; mem_loc,HAS_BANJO  , index,6, name,banjo , xoff,-7, yoff,4  , sind,SPR_BANJO;
    8; mem_loc,HAS_SWORD  , index,7, name,sword , xoff,0 , yoff,6  , sind,SPR_SWORD;
    9; mem_loc,HAS_BOWL   , index,8, name,bow   , xoff,7 , yoff,5  , sind,SPR_BOWL;
]]

|inventory_start_update| function(a)
    if btn'BTN_ITEM_SELECT' then a:load'press' end
end $$

|inventory_press_update| function(a)
    if not btn'BTN_ITEM_SELECT' then a:load'start' end
    a.cur_item = mid(0,2,a.cur_item%3+zbtn(btnp,0)) + mid(0,2,a.cur_item\3+zbtn(btnp,2))*3
end $$

|inventory_draw| function(a)
    for item in all(a) do
        local drawfunc = item.index == 4 and function() a.pl:draw() end or function()
            zspr(item.sind, a.pl.x*8+item.xoff, a.pl.y*8+item.yoff, 1, 1, a.pl.xf)
        end

        draw_outline(item.index == a.cur_item and 2 or 1, drawfunc)
        drawfunc()
    end
end $$
