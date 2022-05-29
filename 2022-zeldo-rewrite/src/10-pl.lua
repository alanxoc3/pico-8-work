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
   -- kill_when_release: should the item die when releasing the button?
   -- block_direction:  item doesn't allow a direction change
   -- speed_multiplier: speed is multiplied
   -- initial_energy:   how much energy it takes to initialize the item
   -- gradual_energy:   how much energy is added every step
   -- is_default: is this the "no item" item?
   -- visible: should it be drawn with the player?
   -- alive: is the item alive?

--| ITEM ZCLASS LOGIC |--
zclass[[item_horizontal,anchor|
    offspeed,0,
    normal_init,%item_horizontal_normal_init;

    start;  init,%item_horizontal_start_init,  duration,.08, next,normal;
    normal; init,%item_horizontal_normal_init, offdx,0;
    ending; init,%item_horizontal_ending_init, duration,.08;
]]

zclass[[mask,anchor,actor|
    anchoring,@, xf,@,

    kill_when_release,yes,
    visible,yes,
    block_direction, no,
    speed_multiplier, 2,
    initial_energy, .125,
    gradual_energy, PL_ENERGY_COOLDOWN,

    offy, .2,
    sind,SPR_MASK;

    start;  offdy,-.0625, duration,.08, next,normal;
    normal; offy,-.125, offdy,0;
    ending; offdy,.0625, duration,.08;
]]

zclass[[bow,item_horizontal,actor|
    anchoring,@, xf,@,

    kill_when_release,yes,
    visible,yes,
    block_direction, yes,
    speed_multiplier, .5,
    initial_energy, .25,
    gradual_energy, 0,

    offspeed,.105,
    sind,SPR_BOW;
]]

zclass[[shield,item_horizontal,actor|
    anchoring,@, xf,@,

    kill_when_release,yes,
    visible,yes,
    block_direction, yes,
    speed_multiplier, .5,
    initial_energy, .125,
    gradual_energy, 0,
    offy,.125,

    offspeed,.105,
    sind,SPR_SHIELD;
]]

zclass[[sword,item_horizontal,actor|
    anchoring,@, xf,@,

    kill_when_release,yes,
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

    kill_when_release,no,
    visible,yes,
    block_direction, yes,
    speed_multiplier, 0,
    initial_energy, .125,
    gradual_energy, 0,
    offy,-.05,

    sind,SPR_BANJO;

    start;  offdy,.0625, duration,.08, next,normal;
    normal; offy,.25, offdy,0, duration,3, next,ending;
    ending; init,%banjo_ending_init, offdy,-.0625, duration,.08;
]]

zclass[[brang,collidable,simple_spr,drawlayer_50,mov,actor,box|
    anchoring,@, xf,@,
    rx,.375, ry,.375,

    kill_when_release,yes,
    visible,no,
    block_direction, yes,
    speed_multiplier, .25,
    initial_energy, .25,
    gradual_energy, 0,

    should_collide_below,no,
    offspeed,.125,
    drawout,%brang_drawout,
    sind,SPR_BRANG;
    
    start; init,%brang_start_init, speed,.075, duration,.125, next,normal;
    normal;init,nop, speed,0, duration,1.5, update,%brang_normal_update, next,ending;
    ending;init,%brang_ending_init, speed,0, speed,0, update,%brang_ending_update, duration,.125, adjust_deltas_for_solids,nop, adjust_deltas_for_tiles,nop;
    final;init,nop, update,nop, alive,no;
]]

zclass[[bomb,actor,solid,vec,simple_spr,drawlayer_50|
    anchoring,@, xf,@,

    rx,.25, ry,.25,
    sind,SPR_BOMB, sy,-2,

    kill_when_release,no,
    visible,no,
    block_direction, no,
    speed_multiplier, 1,
    initial_energy, .25,
    gradual_energy, 0,

    offspeed,.185;

    start;    init,%bomb_start_init, dy,.08, duration,.08, next,normal;
    normal;   init,nop, duration,.5, dx,0, dy,0, next,ending;
    ending;   init,%bomb_destroyed, duration,.25, next,final, draw,nop;
    final;    init,nop, alive,no;
]]

--| ITEM CODE LOGIC |--
|[banjo_ending_init]| function(a)
    if (g_rstat_right:get() or {}).id == 'saveplat' then
        zcall(poke, [[
            1;,MEM_PL_X,     @;
            2;,MEM_PL_Y,     @;
            3;,MEM_PL_XF,    @;
        ]], a.anchoring.x*POS_MULTIPLIER_FOR_MEMORY,
            a.anchoring.y*POS_MULTIPLIER_FOR_MEMORY,
            (a.anchoring.xf+1)\2
        )

        memcpy(REAL_SAVE_LOCATION, MEM_SAVE_LOCATION, SAVE_LENGTH)
        _g.tbox("great banjo playing.^saving complete!", nop)
    end
end $$

|[item_horizontal_start_init]|  function(a) a.offdx = a.xf*a.offspeed end $$
|[item_horizontal_normal_init]| function(a) a.offx = abs(a.offx*8)\1/8*sgn(a.offx) end $$
|[item_horizontal_ending_init]| function(a) a:normal_init() a.offdx = -a.xf*a.offspeed end $$

|[brang_drawout]| function(a)
    zspr(a.sind, a.x*8+a.sx, a.y*8+a.sy, 1, 1, cos(g_fi/5), sin(g_fi/5))
end $$

|[brang_start_init]| function(a)
    a.x, a.y = a.anchoring.x, a.anchoring.y
    a.ang = atan2(a.xf, 0)
end $$

|[brang_normal_update]| function(a)
    a.speed = 0

    if g_zbtn_0 | g_zbtn_2 ~= 0 then
        a.ang, a.speed = atan2(g_zbtn_0, g_zbtn_2), .0375
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

|[bomb_start_init]| function(a)
    a.x, a.y = a.anchoring.x+a.xf, a.anchoring.y
    a.dx = a.dx + a.xf*.125
end $$

|[bomb_destroyed]| function(a)
    _g.explode(a.x, a.y)
end $$

--| PL LOGIC |--

zclass[[pl,actor,mov,collidable,auto_outline,drawlayer_50|
    cname,"lank", cspr,SPR_PL_WHOLE,
    health,10,max_health,10,
    x,@,y,@,xf,@,
    sind,88,
    rx,PL_RADIUS,ry,PL_RADIUS,
    should_collide_with_screen_edge,no,

    update,%pl_update,
    energy,0,
    is_energy_cooling_down,no,
    target_energy,0,
    drawout,%pl_drawout;

    item_funcs; ITEM_IND_SWORD,%sword, ITEM_IND_MASK,%mask, ITEM_IND_BOW,%bow, ITEM_IND_SHIELD,%shield, ITEM_IND_BOMB,%bomb, ITEM_IND_BANJO,%banjo, ITEM_IND_BRANG,%brang;

    default_item;
        visible,no,
        is_default,yes,
        block_direction,no,
        speed_multiplier,1,
        alive,yes,
        gradual_energy,-PL_ENERGY_COOLDOWN,
        kill_when_release,no,
        initial_energy,0;

    item,~default_item;
]]

|[pl_update]| function(a)
    g_rstat_left:set(a)
    local item = a.item

    a.speed = 0
    if not a:inside(g_room_bounds) then
        a.ang, a.speed = atan2(a:abside(g_room_bounds)), PL_SPEED
    elseif not does_entity_exist'fader' and not does_entity_exist'tbox' and not btn(BTN_ITEM_SELECT) then
        if g_zbtn_0 | g_zbtn_2 ~= 0 then
            a.ang, a.speed = atan2(g_zbtn_0, g_zbtn_2), PL_SPEED*item.speed_multiplier

            if not item.block_direction and cos(a.ang) ~= 0 then
                a.xf = sgn(cos(a.ang))
            end
        end

        if not item.alive then item = a.default_item end
        if not a.is_energy_cooling_down and item.is_default and btn'BTN_ITEM_USE' then
            local item_func = a.item_funcs[peek'MEM_ITEM_INDEX']
            if item_func then
                item = item_func(a, a.xf)
                a.target_energy += item.initial_energy
            end
        elseif item.kill_when_release and (a.is_energy_cooling_down or not btn'BTN_ITEM_USE') then
            item:kill()
        end
    end

    a.target_energy = max(0, a.target_energy + item.gradual_energy)
    if a.target_energy == 0 then a.is_energy_cooling_down = false
    elseif a.target_energy >= 1 then a.is_energy_cooling_down = true
    end

    local diff = a.target_energy - a.energy
    a.energy += zsgn(diff)*min(abs(diff), PL_ENERGY_FOLLOW)

    -- sind logic
    a.item, a.sind = item, a.dx|a.dy ~= 0 and 88+t()*12%3 or 88
end $$

|[pl_drawout]| function(a)
    local xf = a.xf
    local top = 91
    if does_entity_exist'banjo' then
        xf = g_si%2*2-1
        top = 92
    end

    zspr(a.sind, a.x*8, a.y*8-2, 1, 1, xf)
    zspr(top,    a.x*8, a.y*8-2, 1, 1, xf)
    if a.item.visible then
        zspr(a.item.sind, a.item.x*8, a.item.y*8-2, 1, 1, xf)
    end
end $$
