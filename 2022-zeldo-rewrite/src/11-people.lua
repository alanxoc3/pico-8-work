zclass[[person,target_with_tbox,solid,simple_spr,drawlayer_50|
    text,, rx,.375, ry,.375, sy,-2,
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
    cname,"navy", cspr,SPR_NAVY, sind,SPR_NAVY,
    text,"my sister has been in^the forest all day.^find something to^protect yourself with^and bring her home."
|MEM_IS_NAVY_HOME|0
]]

zclass[[navyhouse,person|
    x,@, y,@,
    cname,"navy", cspr,SPR_NAVY, sind,SPR_NAVY,
    text,"im navy in a house"
|MEM_IS_NAVY_HOME|1
]]

zclass[[bobblock,person|
    x,@, y,@,
    cname,"bob", cspr,SPR_BOB, sind,SPR_BOB,
    text,"im bob outside"
|MEM_IS_BOB_HOME|0
]]

zclass[[bobhouse,person|
    x,@, y,@,
    cname,"bob", cspr,SPR_BOB, sind,SPR_BOB,
    text,"im bob in a house"
|MEM_IS_BOB_HOME|1
]]
