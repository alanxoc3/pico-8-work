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
    -- should_stun: should the enemy be stunned when hit?
    -- pushspeed: how fast the enemy should be pushed
    -- should_use_xf: should push speed be reflected by the xf or position
    -- item_hit_func: a function that gets when it hits the enemy

zclass[[propel,vec|propel,%f_propel_func, propel_speed,0]]

|[f_propel_func]| function(a)
    a.speed = a.propel_speed
end $$

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

|[f_interact]| function(...)
    local obj = g_rstat_right:get()
    -- the is_alive check is needed because there was a duplication bug
    if obj and obj:is_alive() then
        if obj.id == 'pot' then
            obj:kill()
            return _g.pot_held(obj, ...)
        elseif obj.id == 'quack' then
            obj:kill()
            return _g.quack_held(obj, ...)
        end
    end
end $$

zclass[[held_to_throw,vec,actor|
    visible,yes,
    block_direction, no,
    speed_multiplier, .5,
    initial_energy, .125,
    gradual_energy, 0,
    sy,-2,

    item_thrown,nop, sy,-2;

    defaults; init,nop, update,%f_held_to_throw_update;
    start;    init,%f_held_to_throw_beg, duration,.1, next,normal;
    normal;   offy,-.5;
    ending;   visible,no, init,%f_held_to_throw_ending_init, duration,.16;
]]

|[f_held_to_throw_beg]| function(a)
    if a.fromobj then
        a.x, a.y = a.fromobj.x, a.fromobj.y
    else
        a.x, a.y = a.anchoring.x, a.anchoring.y
    end
end $$

|[f_held_to_throw_update]| function(a)
    a:f_vec_mov_towards_point(a.anchoring.x, a.anchoring.y-.5, .15)
end $$

|[f_held_to_throw_ending_init]| function(a)
    a.item_thrown(a.anchoring.x, a.anchoring.y, a.anchoring.xf, .06+a.anchoring.speed, atan2(a.anchoring.xf, 0))
end $$

zclass[[pot_held,held_to_throw   |fromobj,@, anchoring,@, xf,@, sind,49,       item_thrown,%pot_thrown, sy,-3]]
zclass[[quack_held,held_to_throw |fromobj,@, anchoring,@, xf,@, sind,32,       item_thrown,%quack_thrown, sy,-4]]
zclass[[bomb_held,held_to_throw  |anchoring,@, xf,@, sind,SPR_BOMB, item_thrown,%bomb, initial_energy,1, sy,-3]]

zclass[[item_throwing,propel,mov,box,simple_spr,drawlayer_50,actor|
    rx,.25, ry,.25;
    start; duration, .15, update,%f_item_throwing_update;
]]

|[f_item_throwing_update]| function(a)
    a.sy = sin(a:get_elapsed_percent'start'/4+.25)*7
    a:propel()
end $$

zclass[[bomb,item_throwing|
    x,@, y,@, xf,@, propel_speed,@, ang,@,
    should_collide_below, no,
    sind,SPR_BOMB, destroyed,%f_bomb_destroyed;
]]

zclass[[pot_thrown,item_throwing,statitem|
    x,@, y,@, xf,@, propel_speed,@, ang,@,
    sind,49, destroyed,%f_standard_explosion,
    should_stun,yes,
    should_use_xf,yes,
    item_hit_func,nop,
    should_push,yes;
]]

zclass[[quack_thrown,item_throwing|
    x,@, y,@, xf,@, propel_speed,@, ang,@,
    sind,32, destroyed,%f_quack_thrown_destroyed;
]]

|[f_quack_thrown_destroyed]| function(a)
    _g.quack(a.x, a.y)
end $$

|[f_bomb_destroyed]| function(a)
    _g.explode(a.x, a.y, 8, 2, nop)
    _g.bomb_explode(a.x, a.y)
end $$

zclass[[item_horizontal,anchor|
    offspeed,0,
    normal_init,%f_item_horizontal_normal_init;

    start;  init,%f_item_horizontal_start_init,  duration,.08, next,normal;
    normal; init,%f_item_horizontal_normal_init, offdx,0;
    ending; init,%f_item_horizontal_ending_init, duration,.08;
]]

zclass[[mask,anchor,actor|
    anchoring,@, xf,@,

    visible,yes,
    block_direction, no,
    speed_multiplier, 1,
    initial_energy, .375,
    gradual_energy, 0,

    offy, .2,
    sy,-2,
    sind,SPR_MASK;

    defaults; init,nop;
    start;  init,%f_mask_init, offdy,-.0625, duration,.08, next,normal;
    normal; offy,-.125, offdy,0;
    ending; init,%f_mask_end, offdy,.0625, duration,.08;
]]

|[f_mask_init]| function() sfx(3,3,0,4) end $$
|[f_mask_end]| function() sfx(3,3,8,4) end $$

zclass[[bow,item_horizontal,actor|
    anchoring,@, xf,@,

    visible,yes,
    block_direction, yes,
    speed_multiplier, .5,
    initial_energy, .25,
    gradual_energy, 0,

    sy,-1,
    offspeed,.105,
    sind,SPR_BOW;

    ending; init,%f_bow_ending_init, duration,.08;
]]

zclass[[pellet,vec,collidable,actor,drawlayer_50,statitem|
    x,@, y,@, dx, @, xf, @,

    damage,        1,
    pushspeed,     .375,
    should_use_xf, yes,
    item_hit_func, ~kill,

    should_collide_below,no,
    rx,.25, ry,.25,
    destroyed,%f_standard_explosion,
    draw,%f_pellet_draw;

    start; update,%f_pellet_update, duration,.5;
]]

|[f_pellet_update]| function(a)
    if a.dx == 0 then a:kill() end
end $$

|[f_pellet_draw]| function(a)
    draw_tail(a.x, a.y-.25, a.dx, 0, 3)
    pset(a.x*8, a.y*8-2, 4)
end $$

|[f_bow_ending_init]| function(a)
    _g.f_item_horizontal_ending_init(a)
    _g.pellet(a.anchoring.x, a.anchoring.y, a.xf*.25, a.xf)
end $$

zclass[[shield,item_horizontal,actor,statitem|
    anchoring,@, xf,@,
    rx,.375, ry,.375,

    pushspeed,     .25,
    should_use_xf, yes,
    item_hit_func, nop,

    should_push, yes,
    plpushspeed,     0,
    visible,yes,
    block_direction, yes,
    speed_multiplier, .5,
    initial_energy, .125,
    gradual_energy, 0,

    sy,-1,
    offspeed,.105,
    sind,SPR_SHIELD;

    start; should_stun,yes;
    normal; should_stun,no;
]]

zclass[[sword,item_horizontal,actor,statitem|
    anchoring,@, xf,@,
    rx, .375, ry, .25,

    pushspeed,     .25,
    should_use_xf, yes,
    item_hit_func, %f_sword_item_hit_func,

    plpushspeed,     .125,
    visible,yes,
    block_direction, yes,
    speed_multiplier, .5,
    initial_energy, .125,
    gradual_energy, 0,

    sy,0,
    offspeed,.125,
    sind,SPR_SWORD;
    start;  damage, 1;
    normal; damage, 1;
]]

|[f_sword_item_hit_func]| function(a)
    a:kill()
end $$

zclass[[banjo,anchor,actor|
    anchoring,@, xf,@,

    visible,yes,
    block_direction, no,
    speed_multiplier, .5,
    initial_energy, .125,
    gradual_energy, 0,
    offy,0,

    sy,-3,
    sind,SPR_BANJO;

    defaults; init,nop;
    start;    init,%f_banjo_start_init, offdy,.125, duration,.03, next,min_play;
    min_play; offdy,0, duration,2, next,normal;
    normal;   next,ending;
    ending;   init,%f_banjo_ending_init, offdy,-.125, duration,.03;
]]

|[f_banjo_start_init]| function(a)
    sfx(5,0)
    sfx(6,1)
    sfx(7,2)
end $$

|[f_banjo_ending_init]| function(a)
    sfx(5,-2)
    sfx(6,-2)
    sfx(7,-2)

    if (g_rstat_right:get() or {}).id == 'saveplat' and a:get_elapsed_percent'min_play' and a:get_elapsed_percent'min_play' >= 1 then
        zcall(poke, [[
            1;,MEM_PL_X,       @;
            2;,MEM_PL_Y,       @;
            3;,MEM_PL_XF,      @;
            4;,MEM_ITEM_INDEX, ITEM_IND_INTERACT;
        ]], a.anchoring.x*POS_MULTIPLIER_FOR_MEMORY,
            a.anchoring.y*POS_MULTIPLIER_FOR_MEMORY,
            (a.anchoring.xf+1)\2
        )

        memcpy(REAL_SAVE_LOCATION, MEM_SAVE_LOCATION, SAVE_LENGTH)
        poke(MEM_ITEM_INDEX, ITEM_IND_BANJO) -- reset to banjo
        _g.tbox("SPR_TEACH^great banjo playing.^saving complete!", nop)
    end
end $$

zclass[[brang,collidable,simple_spr,drawlayer_50,mov,actor,statitem|
    anchoring,@, xf,@,
    rx,.25, ry,.25,

    should_push,no,
    pushspeed,     .25,
    should_use_xf, no,
    item_hit_func, ~kill,
    should_stun,yes,

    visible,no,
    block_direction, yes,
    speed_multiplier, 0,
    initial_energy, .125,
    gradual_energy, 0,

    should_collide_below,no,
    offspeed,.125,
    drawout,%f_brang_drawout,
    sind,SPR_BRANG;
    
    defaults; init,nop;
    start; init,%f_brang_start_init, update,%f_brang_start_update, duration,.125, next,normal;
    normal;update,%f_brang_normal_update, next,ending;
    ending;init,%f_brang_ending_init, update,%f_brang_ending_update, duration,.125, f_adjust_deltas_for_solids,nop, f_adjust_deltas_for_tiles,nop;
    final;update,nop, alive,no;
]]

|[f_brang_drawout]| function(a)
    zspr(a.sind, a.x*8+a.sx, a.y*8+a.sy, 1, 1, cos(g_fi/5), sin(g_fi/5))
end $$

|[f_brang_start_init]| function(a)
    _g.f_mask_init()
    a.x, a.y = a.anchoring.x, a.anchoring.y
    a.ang = atan2(a.xf, 0)
end $$

|[f_brang_start_update]| function(a)
    a.speed = .05
end $$

|[f_brang_normal_update]| function(a)
    a.speed = 0

    if g_zbtn_0 | g_zbtn_2 ~= 0 then
        a.ang, a.speed = atan2(g_zbtn_0, g_zbtn_2), .0375
    end
end $$

|[f_brang_ending_init]| function(a)
    a.end_x, a.end_y = a.x, a.y
    _g.f_mask_end()
end $$

|[f_brang_ending_update]| function(a)
    local percent = a:get_elapsed_percent'ending'
    a.x = a.end_x + (a.anchoring.x - a.end_x)*percent
    a.y = a.end_y + (a.anchoring.y - a.end_y)*percent
end $$

zclass[[bomb_explode,enemy,box,actor,statitem|
    x,@, y,@, rx,1, ry,1,
    damage,3,
    pushspeed,.25,
    should_use_xf,no,
    item_hit_func,nop,
    pl_collide_func,%f_bomb_pl_hit;

    start; duration,.25;
]]

|[f_bomb_pl_hit]| function(a, pl)
    pl:hurt'5'
end $$

--| ITEM CODE LOGIC |--
|[f_item_horizontal_start_init]|  function(a) sfx(3,3,0,4) a.offdx = a.xf*a.offspeed end $$
|[f_item_horizontal_normal_init]| function(a) a.offx = abs(a.offx*8)\1/8*sgn(a.offx) end $$
|[f_item_horizontal_ending_init]| function(a) sfx(3,3,8,4) a:normal_init() a.offdx = -a.xf*a.offspeed end $$

--| PL LOGIC |--

-- a few timers that affect the player:
    -- pushed: is the player being pushed in a direction. this has only one speed.
    -- stunned: is the player being hurt? this shakes the screen and prevents items, but not movement.

zclass[[maskcheck|maskcheck,%f_maskcheck_func]]

-- true means there is no mask
|[f_maskcheck_func]| function(a, override)
    return override or not a.item or a.item.id ~= 'mask'
end $$

zclass[[pushable,mov|
    push_ang,0,
    push,%f_pushable_push,
    update_push,%f_pushable_update_push
]]

|[f_pushable_push]| function(a, ang, duration, override)
    a:start_timer('push', duration)
    a.push_ang = ang
end $$

|[f_pushable_update_push]| function(a)
    if a:is_active'push' then
        a.ang, a.speed = a.push_ang, (1-a:get_elapsed_percent'pushed')*PL_STUN_SPEED
    end
end $$

zclass[[pl,ma_left,pushable,actor,mov,collidable,auto_outline,healthobj,drawlayer_50|
    cname,"lank", cspr,SPR_PL_WHOLE,
    x,@, y,@, xf,@, health,@, max_health,@, inventory,@,
    rx,PL_RADIUS,ry,PL_RADIUS,
    should_collide_with_screen_edge,no,

    should_dance,yes,
    update,%f_pl_update,
    energy,0,
    is_energy_cooling_down,no,
    target_energy,0,
    destroyed,%f_standard_explosion,
    drawout,%f_pl_drawout;

    item_funcs;
        ITEM_IND_BANJO    ,%banjo,
        ITEM_IND_BOMB     ,%bomb_held,
        ITEM_IND_BOW      ,%bow,
        ITEM_IND_SWORD    ,%sword,
        ITEM_IND_INTERACT ,%f_interact,
        ITEM_IND_SHIELD   ,%shield,
        ITEM_IND_BRANG    ,%brang,
        ITEM_IND_MASK     ,%mask;

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

-- every frame: updates isma / update display energy
-- resets dead item to default
-- kills item
-- creates item / updates energy
-- sets speed (control or 0 (stun/injure/fader/tbox/itemselect) or leaving room)
-- energy logic (replenish) only when no item in use, and no for many things...

|[f_pl_update]| function(a)
    -- global update
    a:start_timer('isma', 0)
    local item = a.item
    if not item.alive then item = a.default_item end

    if a:is_active'injured' or a:is_active'stunned' or btn'BTN_ITEM_SELECT' or does_entity_exist'tbox' or does_entity_exist'fader' or (item.gradual_energy > 0 and a.is_energy_cooling_down) or not btn'BTN_ITEM_USE' then
        item:kill()
    elseif not a:is_active'injured' and not a:is_active'stunned' and not a.is_energy_cooling_down and item.is_default and btn'BTN_ITEM_USE' then
        local item_func = a.item_funcs[peek'MEM_ITEM_INDEX']
        if item_func then
            item = item_func(a, a.xf) or item
            a.target_energy += item.initial_energy
        end
    end

    a.speed = 0
    if not a:inside(g_room_bounds) then
        a:push(atan2(a:abside(g_room_bounds)), 5, true)
    end

    if not a:is_active'injured' and not a:is_active'stunned' and not does_entity_exist'fader' and not does_entity_exist'tbox' and not btn'BTN_ITEM_SELECT' then
        if g_zbtn_0 | g_zbtn_2 ~= 0 then
            a.ang, a.speed = atan2(g_zbtn_0, g_zbtn_2), PL_SPEED*item.speed_multiplier

            if not item.block_direction and cos(a.ang) ~= 0 then
                a.xf = sgn(cos(a.ang))
            end
        end
    end

    if not a:is_active'injured' and not a:is_active'stunned' then
        a.target_energy = max(0, a.target_energy + item.gradual_energy)
    end

    if a.target_energy == 0 then a.is_energy_cooling_down = false
    elseif a.target_energy >= 1 then a.is_energy_cooling_down = true
    end

    local diff = a.target_energy - a.energy
    a.energy += zsgn(diff)*min(abs(diff), PL_ENERGY_FOLLOW)

    a.item = item
end $$

|[f_pl_drawout]| function(a)
    -- printh("x "..(a.x*16).." y "..(a.y*16))
    local xoff = 0
    local yoff = 0
    local xf = a.xf
    local top = 91
    if does_entity_exist'shield' or does_entity_exist'sword' or does_entity_exist'bow' then
        -- xf = g_si%2*2-1
        top = 92
    elseif does_entity_exist'brang' then
        -- xf = g_si%2*2-1
        top = 95
    elseif does_entity_exist'banjo' then
        top = g_fi%4 < 2 and 92 or 95
    elseif does_entity_exist'held_to_throw' then
        top = a.item:is_alive() and 93 or 94
    end

    zspr(a.dx|a.dy ~= 0 and 88+t()*12%3 or 88, a.x*8+xoff, a.y*8-2+yoff, 1, 1, xf)
    zspr(top,                                  a.x*8+xoff, a.y*8-2+yoff, 1, 1, xf)

    if a.item.visible then
        zspr(a.item.sind, a.item.x*8+xoff, yoff+a.item.y*8+a.item.sy, 1, 1, xf)
    end
end $$
