zclass[[inventory,actor,vec,drawlayer_90|
    ind,5, x,64, y,-9, draw,%inventory_draw;

    start;  next,open,   dy,0,  update,%inventory_start_update;
    open;   next,normal, dy,2,  update,nop, duration,.1;
    normal; next,close,  dy,0,  update,%inventory_update;
    close;  next,start,  dy,-2, duration,.1, update,nop;

    ITEM_IND_BANJO;    mem_loc,MEM_HAS_BANJO  , sxo,0, syo,-1, x,-41, y,0, w,4.5, h,4.5, sind,SPR_BANJO;
    ITEM_IND_BOMB;     mem_loc,MEM_HAS_BOMB   , sxo,0, syo, 0, x,-31, y,0, w,4.5, h,4.5, sind,SPR_BOMB;
    ITEM_IND_BOW;      mem_loc,MEM_HAS_BOW    , sxo,0, syo,-1, x,-21, y,0, w,4.5, h,4.5, sind,SPR_BOW;
    ITEM_IND_SWORD;    mem_loc,MEM_HAS_SWORD  , sxo,0, syo,-1, x,-11, y,0, w,4.5, h,4.5, sind,SPR_SWORD;
    ITEM_IND_INTERACT; mem_loc,MEM_ALWAYS_TRUE, sxo,2, syo, 0, x,0,   y,0, w,6,   h,4.5, sind,0;
    ITEM_IND_SHIELD;   mem_loc,MEM_HAS_SHIELD , sxo,0, syo, 0, x,12,  y,0, w,4.5, h,4.5, sind,SPR_SHIELD;
    ITEM_IND_BRANG;    mem_loc,MEM_HAS_BRANG  , sxo,0, syo, 0, x,22,  y,0, w,4.5, h,4.5, sind,SPR_BRANG;
    ITEM_IND_MASK;     mem_loc,MEM_HAS_MASK   , sxo,0, syo, 0, x,32,  y,0, w,4.5, h,4.5, sind,SPR_MASK;
    ITEM_IND_BOWL;     mem_loc,MEM_HAS_BOWL   , sxo,0, syo,-1, x,42,  y,0, w,4.5, h,4.5, sind,SPR_BOWL;
]]

|[inventory_update]| function(a)
    if not btn'BTN_ITEM_SELECT' then
        a:load()
    else
        poke(MEM_ITEM_INDEX, max(1, min(9, peek'MEM_ITEM_INDEX' + zbtn(btnp, 0))))
    end
end $$

|[inventory_start_update]| function(a)
    if not does_entity_exist'fader' and btn'BTN_ITEM_SELECT' then
        a:load()
    end
end $$

|[inventory_draw]| function(a)
    for i, item in ipairs(a) do
        local exist = peek(item.mem_loc) ~= 0
        local current = peek'MEM_ITEM_INDEX' == i
        draw_card(a.x+item.x , current and 9 or a.y+item.y, item.w, item.h, 0, 0,  function()
            if exist then
                spr(item.sind, item.sxo, item.syo)
            end
        end , nop)
    end
end $$
