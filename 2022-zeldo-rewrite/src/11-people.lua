zclass[[person,solid,target_with_tbox,simple_spr,drawlayer_50|
    sy,-2,
    rx,.375, ry,.375,
    trx,.5, try,.5,
    target_with_tbox_disable_callback,%person_target_with_tbox_disable_callback
]]

|[person_target_with_tbox_disable_callback]| function(a)
    a.xf = sgn(g_pl.x-a.x)
    return peek'MEM_ITEM_INDEX' ~= ITEM_IND_INTERACT
end $$

|[person_target_with_tbox_finish_callback]| function(a)
    poke(a.memloc_trigger, a.memloc_trigger_value)
    load_room(%MEM_ROOM_IND, g_pl.x, g_pl.y, g_pl.xf)
end $$

zclass[[navyblock,person|
    x,@, y,@,
    cname,"navy", cspr,SPR_NAVY, sind,SPR_NAVY,
    text,"SPR_NAVY^my sister has been in^the forest all day.^find something to^protect yourself with^and bring her home.",

    rx,.375, ry,1,
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

zclass[[bobblock,solid,person|
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
    text,"SPR_BOB^im bob in a house"
|MEM_IS_BOB_HOME|1
]]

zclass[[jane,person|
    x,@, y,@,
    cname,"jane", cspr,SPR_JANE, sind,SPR_JANE,
    text,"SPR_JANE^im jane in a house"
]]

zclass[[teach,person|
    x,@, y,@,
    cname,"teach", cspr,SPR_TEACH, sind,SPR_TEACH,
    gettext,%teach_gettext
]]

|[teach_gettext]| function(a)
    if peek'MEM_HAS_BANJO' == 0 then
        return "SPR_TEACH^the almighty power of^music is now yours!^take this banjo.", function()
            poke(MEM_HAS_BANJO, 1)
        end
    else
        return "SPR_TEACH^try playing the banjo^on a save platform.", nop
    end
end $$

zclass[[lark,person|
    x,@, y,@,
    cname,"lark", cspr,SPR_LARK, sind,SPR_LARK,
    text,"SPR_LARK^im lark in a house"
]]

zclass[[keep_parent,person|
    x,@, y,@,
    cname,"keep", cspr,SPR_KEEP, sind,SPR_KEEP,
    gettext,%keep_gettext
]]

|[keep_gettext]| function(a)
    if peek(a.memloc) ~= 0 then
        return "SPR_KEEP^visit my 3 cousins^for more deals.", nop
    elseif peek'MEM_MONEY' >= 4 then
        return "SPR_KEEP^thanks for the coins.^have this "..a.item_name..".", function()
            poke(a.memloc, 1)
            poke(MEM_MONEY, peek'MEM_MONEY'-4)
        end
    else
        return "SPR_KEEP^4 coins will buy you^something good.", nop
    end
end $$

zclass[[keep_brang, keep_parent|x,@, y,@,item_name,"boomerang", memloc, MEM_HAS_BRANG]]
zclass[[keep_shield,keep_parent|x,@, y,@,item_name,"shield",    memloc, MEM_HAS_SHIELD]]
zclass[[keep_sling, keep_parent|x,@, y,@,item_name,"slingshot", memloc, MEM_HAS_BOW]]
zclass[[keep_mask,  keep_parent|x,@, y,@,item_name,"scary mask",      memloc, MEM_HAS_MASK]]
