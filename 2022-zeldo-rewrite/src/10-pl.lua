-- do all items have the same beg & end states?
-- bow - right, then charge, then shoot
-- sword - right
-- shield - right
-- bomb - right, start, place

-- bowl - up
-- mask - start, normal, ending
-- brang - just through, yes for ending
-- banjo - appear, ending is instant

-- all items need these:
   -- block_direction:  item doesn't allow a direction change
   -- speed_multiplier: speed is multiplied
   -- initial_energy:   how much energy it takes to initialize the item
   -- gradual_energy:   how much energy is added every step
   -- is_default: is this the "no item" item?
   -- alive: is the item alive?

zclass[[item_horizontal,anchor|
    offspeed,0;
    start;  init,%item_horizontal_start_init,  duration,.08, next,normal;
    normal; init,%item_horizontal_normal_init, offdx,0;
    ending; init,%item_horizontal_ending_init, duration,.08;
]]

|[item_horizontal_start_init]|  function(a) a.offdx = a.xf and -a.offspeed or a.offspeed end $$
|[item_horizontal_normal_init]| function(a) a.offx = abs(a.offx*8)\1/8*sgn(a.offx) end $$
|[item_horizontal_ending_init]| function(a) a.offdx = a.xf and a.offspeed or -a.offspeed end $$

zclass[[mask,anchor,actor|
    visible,yes,
    block_direction, no,
    speed_multiplier, 2,
    initial_energy, .125,
    gradual_energy, PL_ENERGY_COOLDOWN,
    offy, .2,

    anchoring,@, xf,@,
    sind,SPR_MASK;

    start;  offdy,-.0625, duration,.08, next,normal;
    normal; offy,-.125, offdy,0;
    ending; offdy,.0625, duration,.08;
]]

zclass[[bow,item_horizontal,actor|
    visible,yes,
    block_direction, yes,
    speed_multiplier, .5,
    initial_energy, .25,
    gradual_energy, 0,

    offspeed,.105,
    anchoring,@, xf,@,
    sind,SPR_BOW;
]]

zclass[[shield,item_horizontal,actor|
    visible,yes,
    block_direction, yes,
    speed_multiplier, .5,
    initial_energy, .125,
    gradual_energy, 0,
    offy,.125,

    offspeed,.105,
    anchoring,@, xf,@,
    sind,SPR_SHIELD;
]]

zclass[[sword,item_horizontal,actor|
    anchoring,@, xf,@,

    visible,yes,
    block_direction, yes,
    speed_multiplier, .5,
    initial_energy, .25,
    gradual_energy, 0,

    offspeed,.125,
    sind,SPR_SWORD;
]]

zclass[[banjo,anchor,actor|
    anchoring,@, xf,@,

    visible,yes,
    block_direction, yes,
    speed_multiplier, 0,
    initial_energy, 0,
    gradual_energy, 0,
    offy,-.05,

    sind,SPR_BANJO;

    start;  offdy,.0625, duration,.08, next,normal;
    normal; offy,.25, offdy,0, duration,2, next,ending;
    ending; offdy,-.0625, duration,.08;
]]

zclass[[brang,mov,actor|
    anchoring,@, xf,@,

    visible,yes,
    block_direction, yes,
    speed_multiplier, .25,
    initial_energy, .25,
    gradual_energy, 0,

    offspeed,.125,
    sind,SPR_BRANG;
    start; init,%brang_start_init, duration,.08, next,normal;
    normal;init,nop, dx,0, duration,1.5, update,%brang_normal_update, next,ending;
    ending;init,%brang_ending_init, dx,0, speed,0, update,%brang_ending_update, duration,.08;
    final;init,nop, update,nop, alive,no;
]]

|[brang_start_init]| function(a)
    a.x, a.y = a.anchoring.x, a.anchoring.y
    a.dx = a.xf and -.375 or .375
end $$

|[brang_normal_update]| function(a)
    a.speed = 0
    if zbtn(btn, 0) | zbtn(btn, 2) ~= 0 then
        a.ang, a.speed = atan2(zbtn(btn, 0), zbtn(btn, 2)), BRANG_SPEED
    end
end $$

|[brang_ending_init]| function(a)
    a.end_x, a.end_y = a.x, a.y
end $$

|[brang_ending_update]| function(a)
    local percent = a:get_elapsed_percent'ending'
    a.x = a.end_x + (a.anchoring.x - a.end_x)*percent
    a.y = a.end_y + (a.anchoring.y - a.end_y)*percent
end $$

zclass[[bomb,anchor,actor|
    visible,yes,
    block_direction, yes,
    speed_multiplier, .75,
    initial_energy, .25,
    gradual_energy, 0,

    offspeed,.185,
    anchoring,@, xf,@,
    sind,SPR_BOMB;

    start;    gradual_energy,0, init,%bomb_start_init, offy,.175, offdy,.0625, duration,.08, visible,yes, next,normal;
    normal;   init,%bomb_normal_init, offdy,0, duration,0, next,ending;

    ending;   init,nop, visible,no, duration,.75, next,final;
    final;    init,nop, alive,no;
]]

|[bomb_start_init]| function(a) a.offx = a.xf and -.625 or .625 end $$
|[bomb_normal_init]| function(a) _g.bomb_placed(a.x, a.y-.25, a.xf) end $$

zclass[[bomb_placed,actor,simple_spr,drawlayer_50|
    x,@, y,@, xf,@, sind,SPR_BOMB,
    destroyed,%bomb_placed_destroyed;
    start; duration,.5, next,ending;
    ending; alive,no;
]]

|[bomb_placed_destroyed]| function(a)
    _g.explode(a.x, a.y)
end $$

zclass[[pl,actor,mov,collidable,auto_outline,drawlayer_50|
    cname,"lank", cspr,SPR_PL_WHOLE,
    health,10,max_health,10,
    x,@,y,@,xf,@,
    sind,88,
    rx,PL_RADIUS,ry,PL_RADIUS,

    update,%pl_update,
    energy,0,
    target_energy,0,
    drawout,%pl_drawout;
    sinds;,SPR_PL_FEET_1,SPR_PL_FEET_2,SPR_PL_FEET_3;

    item_funcs; ITEM_IND_SWORD,%sword, ITEM_IND_MASK,%mask, ITEM_IND_BOW,%bow, ITEM_IND_SHIELD,%shield, ITEM_IND_BOMB,%bomb, ITEM_IND_BANJO,%banjo, ITEM_IND_BRANG,%brang;

    default_item;
        visible,no,
        is_default,yes,
        block_direction,no,
        speed_multiplier,1,
        alive,yes,
        gradual_energy,0,
        initial_energy,0;

    item,~default_item;
]]

|[pl_add_energy]| function(a, energy)
    a.energy = 1
end $$

|[pl_update]| function(a)
    g_rstat_left:set(a)

    a.speed = 0
    if not does_entity_exist'tbox' and not btn(BTN_ITEM_SELECT) then
        if zbtn(btn, 0) | zbtn(btn, 2) ~= 0 then
            a.ang, a.speed = atan2(zbtn(btn, 0), zbtn(btn, 2)), PL_SPEED*a.item.speed_multiplier

            if not a.item.block_direction and cos(a.ang) ~= 0 then
                a.xf = cos(a.ang) < 0
            end
        end

        if not a.item.alive then a.item = a.default_item end
        if a.item.is_default and btn'BTN_ITEM_USE' then
            local item_func = a.item_funcs[peek'MEM_ITEM_INDEX']
            if item_func then
                a.item = item_func(a, a.xf)
                a.target_energy += a.item.initial_energy
            end
        elseif not a.item.is_default and a.item.curr ~= 'ending' and not btn'BTN_ITEM_USE' then
            a.item:load'ending'
        end
    end

    a.sind = a.sinds[a.dx|a.dy ~= 0 and t()*12%3\1+1 or 1]

    -- energy
    if a.item.is_default then
        a.target_energy = max(0, a.target_energy-PL_ENERGY_COOLDOWN)
    else
        a.target_energy = a.target_energy+a.item.gradual_energy
    end

    a.energy += zsgn(a.target_energy - a.energy)*min(abs(a.target_energy - a.energy), PL_ENERGY_FOLLOW)
end $$

|[pl_drawout]| function(a)
    local xf = a.xf
    if does_entity_exist'banjo' then xf = g_i % 2 == 0 end

    zspr(a.sind, a.x*8, a.y*8-2, 1, 1, xf)
    zspr(91,     a.x*8, a.y*8-2, 1, 1, xf)
    if a.item.visible then
        zspr(a.item.sind, a.item.x*8, a.item.y*8-2, 1, 1, xf)
    end
end $$
