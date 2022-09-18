-- target will call a function if another object touches the boundaries.

zclass[[solid,box|]]
zclass[[wall,solid,anchor|anchoring,@,offx,@,offy,@,rx,@,ry,@]]

zclass[[simple_spr,auto_outline,pos|
    drawout,%simple_spr_draw,
    visible,yes,
    should_dance,no,
    sind,0, sw,1, sh,1, xf,1, yf,1, sx,0, sy,0
]]
|[simple_spr_draw]| function(a)
    if a.visible then
        local xf = a.xf
        if a.should_dance and does_entity_exist'banjo' then
            xf = (g_si%2-.5)*2
        end
        zspr(a.sind, a.x*8+a.sx, a.y*8+a.sy, a.sw, a.sh, xf, a.yf)
    end
end $$

zclass[[anchor,pos|
    update_anchor,%anchor_update_anchor;
    offx,0, offy,0,
    offdx,0, offdy,0,
    anchoring;,
]]
|[anchor_update_anchor]| function(a)
    a.offx+=a.offdx a.offy+=a.offdy
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

zclass[[coin,actor,enemy,simple_spr,drawlayer_50|
    x,@, y,@, memloc,@, rx,.125, ry, .125, sind,SPR_COIN,
    draw,~drawout,
    pl_collide_func,%coin_pl_collide_func
]]

|[coin_pl_collide_func]| function(a, pl)
    poke(MEM_MONEY, peek'MEM_MONEY'+1)
    poke(a.memloc, 1)
    a:kill()
end $$

|[coin_1]|  create_coin'MEM_COIN_1'  $$
|[coin_2]|  create_coin'MEM_COIN_2'  $$
|[coin_3]|  create_coin'MEM_COIN_3'  $$
|[coin_4]|  create_coin'MEM_COIN_4'  $$
|[coin_5]|  create_coin'MEM_COIN_5'  $$
|[coin_6]|  create_coin'MEM_COIN_6'  $$
|[coin_7]|  create_coin'MEM_COIN_7'  $$
|[coin_8]|  create_coin'MEM_COIN_8'  $$
|[coin_9]|  create_coin'MEM_COIN_9'  $$
|[coin_10]| create_coin'MEM_COIN_10' $$
|[coin_11]| create_coin'MEM_COIN_11' $$
|[coin_12]| create_coin'MEM_COIN_12' $$
|[coin_13]| create_coin'MEM_COIN_13' $$
|[coin_14]| create_coin'MEM_COIN_14' $$
|[coin_15]| create_coin'MEM_COIN_15' $$
|[coin_16]| create_coin'MEM_COIN_16' $$
