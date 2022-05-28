zclass[[person,target_with_tbox,solid,simple_spr,drawlayer_50|
    text,, rx,.375, ry,.375,
    trx,.5, try,.25,
    target_with_tbox_disable_callback,%person_target_with_tbox_disable_callback,
    target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback;
]]

|[person_target_with_tbox_disable_callback]| function(a)
    a.xf = sgn(g_pl.x-a.x)
    return peek'MEM_ITEM_INDEX' ~= 4 or a.xf == g_pl.xf
end $$

|[person_target_with_tbox_finish_callback]| function(a)
    poke(MEM_IS_NAVY_HOME, 1)
    load_room(%MEM_ROOM_IND, g_pl.x, g_pl.y, g_pl.xf)
end $$

zclass[[navyblock,person|
    x,@, y,@,
    sy,-2,
    cname,"navy",
    cspr,SPR_NAVY,
    sind,SPR_NAVY,
    text,"TEXT_NAVY_BLOCK"
|MEM_IS_NAVY_HOME|0
]]
