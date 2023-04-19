zclass[[inventory,actor,vec,drawlayer_90|
    ind,5, x,64, y,-9, draw,%f_inventory_draw;

    defaults; dy,0, init,nop, update,nop;
    start;    next,open,                       update,%f_inventory_start_update;
    open;     next,normal, dy,2,  duration,.1, update,%f_inventory_open_update, cachedir,0;
    normal;   next,close,                      update,%f_inventory_update, init,%f_inventory_normal_init;
    close;    next,start,  dy,-2, duration,.1;

    ITEM_IND_BANJO;    mem_loc,MEM_HAS_BANJO  , sxo,0, x,-41, y,0, w,4.5, sind,SPR_BANJO;
    ITEM_IND_BOMB;     mem_loc,MEM_HAS_BOMB   , sxo,0, x,-31, y,0, w,4.5, sind,SPR_BOMB;
    ITEM_IND_BOW;      mem_loc,MEM_HAS_BOW    , sxo,0, x,-21, y,0, w,4.5, sind,SPR_BOW;
    ITEM_IND_SWORD;    mem_loc,MEM_HAS_SWORD  , sxo,0, x,-11, y,0, w,4.5, sind,SPR_SWORD;
    ITEM_IND_INTERACT; mem_loc,MEM_ALWAYS_TRUE, sxo,2, x,0,   y,0, w,6,   sind,SPR_INTERACT;
    ITEM_IND_SHIELD;   mem_loc,MEM_HAS_SHIELD , sxo,0, x,12,  y,0, w,4.5, sind,SPR_SHIELD;
    ITEM_IND_BRANG;    mem_loc,MEM_HAS_BRANG  , sxo,0, x,22,  y,0, w,4.5, sind,SPR_BRANG;
    ITEM_IND_MASK;     mem_loc,MEM_HAS_MASK   , sxo,-1, x,32,  y,0, w,4.5, sind,SPR_MASK;
    ITEM_IND_BOWL;     mem_loc,MEM_HAS_BOWL   , sxo,0, x,42,  y,0, w,4.5, sind,SPR_BOWL;
]]

|[f_inventory_open_update]| function(a)
    a.cachedir += zbtn(btnp, 0)
end $$

|[f_inventory_update]| function(a)
    if does_entity_exist'tbox' or not btn'BTN_ITEM_SELECT' or does_entity_exist'fader' then
        a:load()
        sfx(3,3,8,4)
    else
        local dir = zbtn(btnp, 0) + a.cachedir
        a.cachedir = 0
        for i=peek'MEM_ITEM_INDEX'+dir,5+zsgn(dir)*4,dir do
            if peek(a[i].mem_loc) ~= 0 then
                poke(MEM_ITEM_INDEX, i)
                sfx(3,3,4,4)
                return
            end
        end
    end
end $$

|[f_inventory_start_update]| function(a)
    if not does_entity_exist'tbox' and not does_entity_exist'fader' and btn'BTN_ITEM_SELECT' then
        a:load()
        sfx(3,3,0,4)
    end
end $$

|[f_inventory_normal_init]| function(a)
    poke(MEM_ITEM_INDEX, ITEM_IND_INTERACT)
end $$

|[f_inventory_draw]| function(a)
    for i, item in ipairs(a) do
        local exist = peek(item.mem_loc) ~= 0
        local current = peek'MEM_ITEM_INDEX' == i
        draw_card(a.x+item.x , current and 9 or a.y+item.y, item.w, 4.5, 0, 0,  function()
            if exist then
                spr(item.sind, item.sxo)
            end
        end, nop)
    end
end $$
