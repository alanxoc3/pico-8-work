zclass[[person,target_with_tbox,solid,simple_spr,drawlayer_50|
    text,, rx,.375, ry,.375, sy,-2,
    trx,.5, try,.25,
    target_with_tbox_disable_callback,%person_target_with_tbox_disable_callback
]]

|[person_target_with_tbox_disable_callback]| function(a)
    a.xf = sgn(g_pl.x-a.x)
    return peek'MEM_ITEM_INDEX' ~= 4 or a.xf == g_pl.xf
end $$

|[person_target_with_tbox_finish_callback]| function(a)
    poke(a.memloc_trigger, a.memloc_trigger_value)
    load_room(%MEM_ROOM_IND, g_pl.x, g_pl.y, g_pl.xf)
end $$

zclass[[navyblock,person|
    x,@, y,@,
    cname,"navy", cspr,SPR_NAVY, sind,SPR_NAVY,
    text,"my sister has been in^the forest all day.^find something to^protect yourself with^and bring her home.",

    ry,1,
    memloc_trigger,MEM_IS_NAVY_HOME, memloc_trigger_value,1,
    target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback
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
    text,"im bob outside",

    ry,1,
    memloc_trigger,MEM_IS_BOB_HOME, memloc_trigger_value,1,
    target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback
|MEM_IS_BOB_HOME|0
]]

zclass[[bobhouse,person|
    x,@, y,@,
    cname,"bob", cspr,SPR_BOB, sind,SPR_BOB,
    text,"im bob in a house"
|MEM_IS_BOB_HOME|1
]]

zclass[[jane,person|
    x,@, y,@,
    cname,"jane", cspr,SPR_JANE, sind,SPR_JANE,
    text,"im jane in a house"
]]

zclass[[teach,person|
    x,@, y,@,
    cname,"teach", cspr,SPR_TEACH, sind,SPR_TEACH,
    text,"im teach in a house"
]]

zclass[[keep,person|
    x,@, y,@,
    cname,"keep", cspr,SPR_KEEP, sind,SPR_KEEP,
    text,"im keep in a house"
]]

zclass[[lark,person|
    x,@, y,@,
    cname,"lark", cspr,SPR_LARK, sind,SPR_LARK,
    text,"im lark in a house"
]]
