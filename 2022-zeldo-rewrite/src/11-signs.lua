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

zclass[[target_with_tbox,actor|
    init,%target_with_tbox_init,
    trx,0, try,0, tx,0, ty,0,
    target_with_tbox_disable_callback,nop,
    target_with_tbox_finish_callback,nop
]]

|[target_with_tbox_init]| function(a)
    _g.target(a.trx, a.try, a.tx, a.ty, a, function()
        if not a:target_with_tbox_disable_callback() then
            g_rstat_right:set(a)
            if btnp'4' and not does_entity_exist'tbox' then
                _g.tbox(a.text, function()
                    a:target_with_tbox_finish_callback()
                end)
            end
        end
    end, nop)
end $$

zclass[[sign,target_with_tbox,solid,simple_spr,drawlayer_50|
    text,,rx,.375,ry,.375,
    sy,-2,
    cname,"sign",cspr,SPR_SIGN,
    sind,SPR_SIGN,
    trx,.125, try,.375, tx,0, ty,.25
]]

zclass[[signtest,sign|x,@,y,@,text,"TEXT_SIGNTEST"]]
