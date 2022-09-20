zclass[[person,actor,solid,target_with_tbox,simple_spr,drawlayer_50|
    sy,-2,
    should_dance,yes,
    rx,.375, ry,.375,
    trx,.5, try,.5,
    target_with_tbox_disable_callback,%person_target_with_tbox_disable_callback
]]

|[person_target_with_tbox_disable_callback]| function(a)
    a.xf = sgn(g_pl.x-a.x)
    return _g.sign_target_with_tbox_disable_callback()
end $$

|[person_target_with_tbox_finish_callback]| function(a)
    poke(a.memloc_trigger, a.memloc_trigger_value)
    load_room(%MEM_ROOM_IND, g_pl.x, g_pl.y, g_pl.xf)
end $$

zclass[[navyblock,person|
    x,@, y,@,
    cname,"navy", cspr,SPR_NAVY, sind,SPR_NAVY,
    text,"SPR_NAVY^my sister has been in^the forest all day.^please ask her to^come back home.",

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

zclass[[limeboss,person|
    x,@, y,@,
    cname,"lime", cspr,SPR_LIME, sind,SPR_LIME,
    text,"SPR_LIME^my brother sent you^right?^he must be really^worried about me.^i can come home now.^^...^^wait! what is that?",

    rx,.375, ry,.375,
    target_with_tbox_finish_callback,%lime_callback
|MEM_IS_SLOBS_DEAD|0
]]

zclass[[limebeat,person|
    x,@, y,@,
    cname,"lime", cspr,SPR_LIME_HURT, sind,SPR_LIME_HURT,
    text,"SPR_LIME_HURT^ouchies. thanks for^saving my life.^now i will go home.",
    target_with_tbox_disable_callback,%sign_target_with_tbox_disable_callback,

    rx,.375, ry,.375,
    memloc_trigger,MEM_IS_SLOBS_DEAD, memloc_trigger_value,1,
    target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback
]]

|[lime_callback]| function(a)
    a:kill()
    deregister_entity(a.target)
    _g.limestatue(a.x, a.y, a.xf)
    for i=0,7 do
        _g.explode(a.x+cos(i/8)*3, a.y+sin(i/8)*3, 4, 1, function()
            _g.slobs_enter_ball(a.x, a.y, i/8)
        end)
    end
end $$

zclass[[slobs_enter_ball,actor,simple_spr,drawlayer_75|
    x,@, y,@, minion_ang,@,
    start_x,~x, start_y,~y,
    sind,106,
    update,%slimy_ball_update,
    minion_target_rad,.5, 
    minion_rad,3,
    max_health,1;

    start; duration,.25;
]]

zclass[[limestatue,actor,simple_spr,drawlayer_50|
    x,@,y,@, xf,@,
    sind,SPR_LIME, sy,-2,
    shaking,yes,
    destroyed,%limestatue_destroyed;

    start; duration,.5;
]]

|[limestatue_destroyed]| function(a)
    music'21'
    _g.slobs(a.x, a.y)
end $$

zclass[[bobblock,solid,person|
    x,@, y,@,
    xf,-1,
    cname,"bob", cspr,SPR_BOB, sind,SPR_BOB,
    text,"SPR_BOB^hi lank. i am hungry.^^i mean i am fixing^the road.",

    ry,1,
    memloc_trigger,MEM_IS_BOB_HOME, memloc_trigger_value,1,
    target_with_tbox_finish_callback,%person_target_with_tbox_finish_callback
|MEM_IS_BOB_HOME|0
]]

zclass[[bobhouse,person|
    x,@, y,@,
    cname,"bob", cspr,SPR_BOB, sind,SPR_BOB,
    text,"SPR_BOB^this is some tasty^duck soup."
|MEM_IS_BOB_HOME|1
]]

zclass[[jane,person|
    x,@, y,@,
    cname,"jane", cspr,SPR_JANE, sind,SPR_JANE,
    text,"SPR_JANE^what should i make my^hubby for lunch?"
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
