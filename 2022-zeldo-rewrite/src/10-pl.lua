-- do all items have the same beg & end states?
-- bow - right, then charge, then shoot
-- sword - right
-- shield - right
-- bomb_held - right, start, place

-- bowl - up
-- mask - start, normal, ending
-- brang - just through, yes for ending
-- banjo - appear, ending is instant


--| ITEM STAT |
-- item stats need these: (sword, pellet, bomb_held, brang, shield)
    -- damage: how much damage to do to enemies
    -- stunlen: how much time enemy should be stunned after hit
    -- pushspeed: how fast the enemy should be pushed
    -- should_use_xf: should push speed be reflected by the xf or position
    -- item_hit_func: a function that gets when it hits the enemy

zclass[[statitem,box|]] -- if the item hits an enemy, the enemy becomes the new stat

--| ITEM ZCLASS LOGIC |--
-- all items need these:
   -- block_direction:  item doesn't allow a direction change
   -- speed_multiplier: speed is multiplied
   -- initial_energy:   how much energy it takes to initialize the item
   -- gradual_energy:   how much energy is added every step
   -- is_default: is this the "no item" item?
   -- visible: should it be drawn with the player?
   -- alive: is the item alive?

zclass[[item_horizontal,anchor|
    offspeed,0,
    normal_init,%item_horizontal_normal_init;

    start;  init,%item_horizontal_start_init,  duration,.08, next,normal;
    normal; init,%item_horizontal_normal_init, offdx,0;
    ending; init,%item_horizontal_ending_init, duration,.08;
]]

zclass[[mask,anchor,actor|
    anchoring,@, xf,@,

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

    visible,yes,
    block_direction, yes,
    speed_multiplier, .5,
    initial_energy, .25,
    gradual_energy, 0,

    offspeed,.105,
    sind,SPR_BOW;

    ending; init,%item_horizontal_ending_init, duration,.08;
    ending; init,%bow_ending_init, duration,.08;
]]

zclass[[pellet,vec,collidable,actor,drawlayer_50,statitem|
    x,@, y,@, dx, @, xf, @,

    damage,        1,
    stunlen,       .125,
    pushspeed,     .375,
    should_use_xf, yes,
    item_hit_func, ~kill,

    should_collide_below,no,
    rx,.25, ry,.25,
    destroyed,%standard_explosion,
    draw,%pellet_draw;

    start; update,%pellet_update, duration,.5;
]]

|[pellet_update]| function(a)
    if a.dx == 0 then a:kill() end
end $$

|[pellet_draw]| function(a)
    draw_tail(a.x, a.y-.25, a.dx, 0, 3)
    pset(a.x*8, a.y*8-2, 4)
end $$

|[bow_ending_init]| function(a)
    _g.item_horizontal_ending_init(a)
    _g.pellet(a.anchoring.x, a.anchoring.y, a.xf*.25, a.xf)
end $$

zclass[[shield,item_horizontal,actor,statitem|
    anchoring,@, xf,@,
    rx,.25, ry,.5,

    damage,        0,
    stunlen,       2,
    pushspeed,     .25,
    should_use_xf, yes,
    item_hit_func, %shield_item_hit_func,

    plpushspeed,     .125,
    visible,yes,
    block_direction, yes,
    speed_multiplier, .5,
    initial_energy, .125,
    gradual_energy, 0,
    -- offy,.125,
    

    offspeed,.105,
    sind,SPR_SHIELD;
]]

zclass[[sword,item_horizontal,actor,statitem|
    anchoring,@, xf,@,
    rx, .375, ry, .25,

    damage,        2,
    stunlen,       .25,
    pushspeed,     .25,
    should_use_xf, yes,
    item_hit_func, %sword_item_hit_func,

    plpushspeed,     .125,
    visible,yes,
    block_direction, yes,
    speed_multiplier, .5,
    initial_energy, .125,
    gradual_energy, 0,

    offspeed,.125,
    sind,SPR_SWORD;
]]

|[shield_item_hit_func]| function(a)
    a.anchoring.dx -= a.plpushspeed*a.xf
end $$

|[sword_item_hit_func]| function(a)
    a.anchoring.dx -= a.plpushspeed*a.xf
    a:kill()
end $$

zclass[[banjo,anchor,actor|
    anchoring,@, xf,@,

    visible,yes,
    block_direction, no,
    speed_multiplier, .5,
    initial_energy, .125,
    gradual_energy, 0,
    offy,-.05,

    sind,SPR_BANJO;

    start;    init,%banjo_start_init, offdy,.0625, duration,.08, next,min_play;
    min_play; init,nop, offdy,0, duration,2, next,normal;
    normal;   init,nop, offy,.25, next,ending;
    ending;   init,%banjo_ending_init, offdy,-.0625, duration,.08;
]]

|[banjo_start_init]| function(a)
    sfx(5,0)
    sfx(6,1)
    sfx(7,2)
end $$

|[banjo_ending_init]| function(a)
    sfx(5,-2)
    sfx(6,-2)
    sfx(7,-2)

    if (g_rstat_right:get() or {}).id == 'saveplat' and a:get_elapsed_percent'min_play' and a:get_elapsed_percent'min_play' >= 1 then
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

zclass[[brang,collidable,simple_spr,drawlayer_50,mov,actor,statitem|
    anchoring,@, xf,@,
    rx,.25, ry,.25,

    damage,        0,
    stunlen,       .25,
    pushspeed,     .25,
    should_use_xf, no,
    item_hit_func, ~kill,

    visible,no,
    block_direction, yes,
    speed_multiplier, 0,
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

zclass[[bomb_held,anchor,actor|
    anchoring,@, xf,@,

    sind,SPR_BOMB, sy,-2,
    visible,yes,
    block_direction, no,
    speed_multiplier, 0,
    initial_energy, .3,
    gradual_energy, 0,
    offy,-.25,

    offspeed,.185;

    start;    init,nop, offdy,-.0625, duration,.08, next,normal;
    normal;   init,nop, offdy,0, offy,-.5;
    ending;   visible,no, init,%bomb_held_destroyed, duration,.16;
]]

|[bomb_held_destroyed]| function(a)
    _g.bomb(a.x, a.y, a.xf, g_zbtn_2 > 0 and .075 or .06, atan2(g_zbtn_0 ~= 0 and g_zbtn_0 or a.anchoring.xf, g_zbtn_2+.3))
end $$

zclass[[bomb,mov,box,simple_spr,drawlayer_50,actor|
    x,@, y,@, xf,@, speed,@, ang,@,
    sind,SPR_BOMB,

    damage,        1,
    stunlen,       5,
    pushspeed,     .25,
    should_use_xf, yes,
    item_hit_func, nop,

    destroyed,%bomb_destroyed;

    start; duration, .15, update,%bomb_update, next,wait;
    wait;  speed,0, duration, .7, update,nop, next,ending;
    ending; alive,no;
]]

|[bomb_update]| function(a)
    a.sy = sin(a:get_elapsed_percent'start'/2)*4
end $$

|[bomb_destroyed]| function(a)
    _g.explode(a.x, a.y, 8, 2, nop)
end $$

--| ITEM CODE LOGIC |--
|[item_horizontal_start_init]|  function(a) a.offdx = a.xf*a.offspeed end $$
|[item_horizontal_normal_init]| function(a) a.offx = abs(a.offx*8)\1/8*sgn(a.offx) end $$
|[item_horizontal_ending_init]| function(a) a:normal_init() a.offdx = -a.xf*a.offspeed end $$

--| PL LOGIC |--

-- a few timers that affect the player:
    -- pushed: is the player being pushed in a direction. this has only one speed.
    -- stunned: is the player being hurt? this shakes the screen and prevents items, but not movement.
zclass[[pl,ma_left,actor,mov,collidable,auto_outline,healthobj,drawlayer_50|
    cname,"lank", cspr,SPR_PL_WHOLE,
    x,@, y,@, xf,@, health,@, max_health,@,
    sind,88,
    rx,PL_RADIUS,ry,PL_RADIUS,
    should_collide_with_screen_edge,no,

    update,%pl_update,
    energy,0,
    is_energy_cooling_down,no,
    target_energy,0,
    destroyed,%pl_destroyed,
    drawout,%pl_drawout;

    item_funcs; ITEM_IND_SWORD,%sword, ITEM_IND_MASK,%mask, ITEM_IND_BOW,%bow, ITEM_IND_SHIELD,%shield, ITEM_IND_BOMB,%bomb_held, ITEM_IND_BANJO,%banjo, ITEM_IND_BRANG,%brang;

    default_item;
        visible,no,
        is_default,yes,
        block_direction,no,
        speed_multiplier,1,
        alive,yes,
        gradual_energy,-PL_ENERGY_COOLDOWN,
        initial_energy,0,
        kill,nop;

    item,~default_item;
]]

|[pl_destroyed]| function(a)
    _g.standard_explosion(a)
    _g.fader_out(function() g_state:load'gameover' end)
end $$

|[pl_update]| function(a)
    a:start_timer('isma', 0)
    local item = a.item

    -- item logic
    if not item.alive then item = a.default_item end

    if a:is_active'stunned' or btn(BTN_ITEM_SELECT) or does_entity_exist'tbox' or does_entity_exist'fader' or a.is_energy_cooling_down or not btn'BTN_ITEM_USE' then
        item:kill()
    elseif not a:is_active'stunned' and not a.is_energy_cooling_down and item.is_default and btn'BTN_ITEM_USE' then
        local item_func = a.item_funcs[peek'MEM_ITEM_INDEX']
        if item_func then
            item = item_func(a, a.xf)
            a.target_energy += item.initial_energy
        end
    end

    -- speed & xf logic
    if a:is_active'pushed' then
        a.speed = (1-a:get_elapsed_percent'stunned')*PL_STUN_SPEED
    else
        a.speed = 0
    end

    if not a:inside(g_room_bounds) then
        a.ang, a.speed = atan2(a:abside(g_room_bounds)), PL_SPEED
    elseif not a:is_active'pushed' and not does_entity_exist'fader' and not does_entity_exist'tbox' and not btn(BTN_ITEM_SELECT) then
        if g_zbtn_0 | g_zbtn_2 ~= 0 then
            a.ang, a.speed = atan2(g_zbtn_0, g_zbtn_2), PL_SPEED*item.speed_multiplier

            if not item.block_direction and cos(a.ang) ~= 0 then
                a.xf = sgn(cos(a.ang))
            end
        end
    end

    if not a:is_active'stunned' then
        a.target_energy = max(0, a.target_energy + item.gradual_energy)
    end
    if a.target_energy == 0 then a.is_energy_cooling_down = false
    elseif a.target_energy >= 1 then a.is_energy_cooling_down = true
    end

    local diff = a.target_energy - a.energy
    a.energy += zsgn(diff)*min(abs(diff), PL_ENERGY_FOLLOW)

    -- sind logic
    a.item, a.sind = item, a.dx|a.dy ~= 0 and 88+t()*12%3 or 88
end $$

|[pl_drawout]| function(a)
    local yoff = 0
    local xf = a.xf
    local top = 91
    if does_entity_exist'banjo' then
        -- xf = g_si%2*2-1
        top = 92
    elseif a.item.id == 'bomb_held' then
        top = a.item:is_alive() and 93 or 94
    end

    zspr(a.sind, a.x*8, a.y*8-2+yoff, 1, 1, xf)
    zspr(top,    a.x*8, a.y*8-2+yoff, 1, 1, xf)

    if a.item.visible then
        zspr(a.item.sind, a.item.x*8, a.item.y*8-2+yoff, 1, 1, xf)
    end
end $$
