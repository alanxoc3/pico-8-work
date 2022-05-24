zclass[[sign,actor,solid,auto_outline,drawlayer_50,outlayer_50|
    text,,rx,.375,ry,.375,
    cname,"sign",cspr,SPR_SIGN,
    init,%sign_init,
    draw,%sign_draw
]]

|sign_init| function(a)
    _g.target(.125,.5,0,.25,a,function()
        if not a.stat then a.stat = _g.stat(1, 119, a) end
        if btnp'4' and not does_entity_exist'tbox' then
            _g.tbox(a.text)
        end
    end, function()
        if a.stat then a.stat:load'ending' a.stat = nil end
    end)
end $$

|sign_draw| function(a)
    zspr(a.cspr, a.x*8, a.y*8)
end $$

zclass[[signtest,sign|x,@,y,@,text,"TEXT_SIGNTEST"]]
