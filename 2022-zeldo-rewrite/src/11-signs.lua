-- shared person/sign logic:
-- both have targets
-- both bring up a text box when interacted with

-- for people, the text is dependent on memory state
-- for people, when the text box finishes, something can be done

-- how can the text box system combine with the statcard thing?
-- if the actor supports it and in interact mode, 

-- actors should only care about trying to keep the card thing up
-- what should be done if multiple actors are competing for the card thing?
--   how about first come first serve. check for a ".stat"

zclass[[class_with_target,actor|
    trx,0, try,0, tx,0, ty,0,
    init,%class_with_target_init,
    callback_touch,nop,
    callback_outside,nop
]]

|[class_with_target_init]| function(a)
    _g.target(a.trx, a.try, a.tx, a.ty, a,
        function() a:callback_touch() end,
        function() a:callback_outside() end
    )
end $$

zclass[[target_with_tbox,class_with_target,ma_right|
    text,,
    
    gettext,%target_with_tbox_gettext,
    callback_touch,%target_with_tbox_target_func,
    target_with_tbox_disable_callback,nop,
    target_with_tbox_finish_callback,nop
]]

|[target_with_tbox_gettext]| function(a)
    return a.text, function()
        a:target_with_tbox_finish_callback()
    end
end $$

|[target_with_tbox_target_func]| function(a)
    if not a:target_with_tbox_disable_callback() then
        a:start_timer('isma',0)
        if should_interact() then
            _g.tbox(a:gettext())
        end
    end
end $$

zclass[[sign,target_with_tbox,solid,simple_spr,drawlayer_50|
    rx,.375,ry,.375,
    sy,-2,
    target_with_tbox_disable_callback,%sign_target_with_tbox_disable_callback,
    cname,"sign",cspr,SPR_SIGN,
    sind,SPR_SIGN,
    trx,.125, try,.375, tx,0, ty,.25
]]

-- really this is used in a lot of places... I should refactor...
|[sign_target_with_tbox_disable_callback]| function()
    return peek'MEM_ITEM_INDEX' ~= ITEM_IND_INTERACT or not g_pl.item.is_default
end $$

zclass[[signtest,sign|x,@,y,@,text,  "SPR_SIGN^mary had a^little lamb^little lamb^little lamb^mary had a^little lamb^whose fleece was^white as yo face"]]
zclass[[signlank,  sign|x,@,y,@,text,"SPR_SIGN^lanks house"]]
zclass[[signkeep,  sign|x,@,y,@,text,"SPR_SIGN^keeps house"]]
zclass[[signnavy,  sign|x,@,y,@,text,"SPR_SIGN^navys house"]]
zclass[[signteach, sign|x,@,y,@,text,"SPR_SIGN^teachs house"]]
zclass[[signlark,  sign|x,@,y,@,text,"SPR_SIGN^larks house"]]
zclass[[signjane,  sign|x,@,y,@,text,"SPR_SIGN^janes house"]]
