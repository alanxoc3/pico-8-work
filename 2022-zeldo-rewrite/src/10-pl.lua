-- do all items have the same beg & end states?
-- bow - right, then 
-- bowl - up
-- mask - up
-- bomb - place
-- sword - right
-- shield - right
-- brang
-- banjo - appear
-- bow

-- all items need these:
   -- block_direction:  item doesn't allow a direction change
   -- speed_multiplier: speed is multiplied
zclass[[sword,anchor,vec,actor|
    block_direction, no,
    speed_multiplier, .5,

    anchoring,@,
    offdx,.625,
    sind,SPR_SWORD,
    speed,.125;

    start;  offdx,@, duration,.08, next,normal;
    normal; offdx,0;
    ending; offdx,@, duration,.08;

]]

zclass[[pl,actor,mov,collidable,auto_outline,drawlayer_50|
    cname,"lank", cspr,SPR_PL_WHOLE,
    health,10,max_health,10,
    x,@,y,@,xf,@,
    sind,88,
    rx,PL_RADIUS,ry,PL_RADIUS,

    update,%pl_update,
    energy,0,
    drawout,%pl_drawout;
    sinds;,SPR_PL_FEET_1,SPR_PL_FEET_2,SPR_PL_FEET_3;

    default_item; is_default,yes, block_direction,no, speed_multiplier,1, alive,yes;
    item,~default_item;
]]

|[pl_update]| function(a)
    g_rstat_left:set(a)
    if not a.item.alive then a.item = a.default_item end

    a.speed = 0
    if not does_entity_exist'tbox' and not btn(BTN_ITEM_SELECT) then
        if zbtn(btn, 0) | zbtn(btn, 2) ~= 0 then
            a.ang, a.speed = atan2(zbtn(btn, 0), zbtn(btn, 2)), PL_SPEED*a.item.speed_multiplier

            if not a.item.block_direction and cos(a.ang) ~= 0 then
                a.xf = cos(a.ang) < 0
            end
        end

        if a.item.is_default and btn'BTN_ITEM_USE' then
            if peek'MEM_ITEM_INDEX' == ITEM_IND_SWORD then
                local speed = a.xf and -.125 or .125

                a.item = _g.sword(a, speed, -speed)
            end
        elseif not a.item.is_default and a.item.curr ~= 'ending' and not btn'BTN_ITEM_USE' then
            a.item:load'ending'
        end
    end

    a.sind = a.sinds[a.dx|a.dy ~= 0 and t()*12%3\1+1 or 1]
end $$

|[pl_drawout]| function(a)
    if not a.item.is_default then
        zspr(a.item.sind, a.item.x*8, a.item.y*8-2, 1, 1, a.xf)
    end
    zspr(a.sind, a.x*8, a.y*8-2, 1, 1, a.xf)
    zspr(91,     a.x*8, a.y*8-2, 1, 1, a.xf)
end $$
