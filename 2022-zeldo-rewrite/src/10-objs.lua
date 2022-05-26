-- target will call a function if another object touches the boundaries.

zclass[[solid,box|]]
zclass[[wall,solid,anchor|anchoring,@,offx,@,offy,@,rx,@,ry,@]]

zclass[[simple_spr,auto_outline,pos|
    drawout,%simple_spr_draw,
    sind,0, sw,1, sh,1, xf,no, yf,no, sx,0, sy,0
]]
|[simple_spr_draw]| function(a)
    zspr(a.cspr, a.x*8+a.sx, a.y*8+a.sy, a.sw, a.sh, a.xf, a.yf)
end $$

zclass[[anchor,pos|
    update_anchor,%anchor_update_anchor;
    offx,0, offy,0,
    anchoring;,
]]
|[anchor_update_anchor]| function(a)
    a.x, a.y = a.anchoring.x+a.offx, a.anchoring.y+a.offy
end $$

zclass[[target,anchor,box|
    rx,@, ry,@, offx,@, offy,@, anchoring,@, callback_touch,@, callback_outside,@,
    update_target,%targettouch_update_target
]]
|[targettouch_update_target]| function(target, objs)
    foreach(objs, function(a)
        if target:outside(a) then
            target:callback_outside(a)
        else
            target:callback_touch(a)
        end
    end)
end $$

-- placeholders
zclass[[pot]]
zclass[[bed]]
