-- target will call a function if another object touches the boundaries.

zclass[[solid,box|]]

zclass[[anchor,pos|
    update_anchor,%anchor_update_anchor;
    offx,0, offy,0,
    anchoring;,
]]
|anchor_update_anchor| function(a)
    a.x, a.y = a.anchoring.x+a.offx, a.anchoring.y+a.offy
end $$

zclass[[target,anchor,box|
    rx,@, ry,@, offx,@, offy,@, anchoring,@, callback_touch,@, callback_outside,@,
    update_target,%targettouch_update_target
]]
|targettouch_update_target| function(target, objs)
    foreach(objs, function(a)
        if target:outside(a) then
            target:callback_outside(a)
        else
            target:callback_touch(a)
        end
    end)
end $$

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

zclass[[signtest,sign|x,@,y,@,text,"mary had a^little lamb^little lamb^little lamb^mary had a^little lamb^whose fleece was^white as yo face"]]
