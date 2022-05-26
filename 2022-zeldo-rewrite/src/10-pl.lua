zclass[[pl,actor,mov,collidable,auto_outline,drawlayer_50|
    cname,"lank", cspr,SPR_PL_WHOLE,
    health,10,max_health,10,
    x,@,y,@,xf,@,
    sind,88,
    rx,PL_RADIUS,ry,PL_RADIUS,
    init,%pl_init,
    update,%pl_update,
    energy,0,
    drawout,%pl_drawout;
    sinds;,SPR_PL_FEET_1,SPR_PL_FEET_2,SPR_PL_FEET_3
]]

|[pl_init]| function(a) _g.stat(-1, 9, a) end $$

|[pl_update]| function(a)
    if not does_entity_exist'tbox' and not btn(BTN_ITEM_SELECT) and zbtn(btn, 0) | zbtn(btn, 2) ~= 0 then
        a.ang, a.speed = atan2(zbtn(btn, 0), zbtn(btn, 2)), PL_SPEED

        if cos(a.ang) ~= 0 then
            a.xf = cos(a.ang) < 0
        end
    else
        a.speed = 0
    end

    a.sind = a.sinds[a.dx|a.dy ~= 0 and t()*12%3\1+1 or 1]
end $$

|[pl_drawout]| function(a)
    zspr(a.sind, a.x*8, a.y*8-2, 1, 1, a.xf)
    zspr(91,     a.x*8, a.y*8-2, 1, 1, a.xf)
end $$
