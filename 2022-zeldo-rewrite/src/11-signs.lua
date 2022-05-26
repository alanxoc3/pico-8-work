zclass[[target_with_tbox,actor|
    init,%target_with_tbox_init,
    trx,0, try,0, tx,0, ty,0,
    target_with_tbox_disable_callback,nop,
    target_with_tbox_finish_callback,nop
]]

|[target_with_tbox_init]| function(a)
    local end_stat = function()
        if a.stat then a.stat:load'ending' a.stat = nil end
    end

    _g.target(a.trx, a.try, a.tx, a.ty, a, function()
        if a:target_with_tbox_disable_callback() then
            end_stat()
        else
            if not a.stat then a.stat = _g.stat(1, 119, a) end
            if btnp'4' and not does_entity_exist'tbox' then
                _g.tbox(a.text, function()
                    a:target_with_tbox_finish_callback()
                end)
            end
        end
    end, end_stat)
end $$

zclass[[sign,target_with_tbox,solid,simple_spr,drawlayer_50|
    text,,rx,.375,ry,.375,
    sy,-2,
    cname,"sign",cspr,SPR_SIGN,
    sind,SPR_SIGN,
    trx,.125, try,.5, tx,0, ty,.25
]]

-- |[sign_init]| function(a)
--     _g.target(.125,.5,0,.25,a,function()
--         if not a.stat then a.stat = _g.stat(1, 119, a) end
--         if btnp'4' and not does_entity_exist'tbox' then
--             _g.tbox(a.text, nop)
--         end
--     end, function()
--         if a.stat then a.stat:load'ending' a.stat = nil end
--     end)
-- end $$

zclass[[signtest,sign|x,@,y,@,text,"TEXT_SIGNTEST"]]
