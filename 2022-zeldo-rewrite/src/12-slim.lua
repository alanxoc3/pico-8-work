-- SHARED
zclass[[slimy_parent,pushable,actor,healthobj,enemy,simple_spr|
    should_push,yes,
    should_dance,yes,
    statcollide,%slimy_parent_statcollide
]]

|[slimy_parent_statcollide]| function(a, items)
    if not a.collide_disabled then
    foreach(items, function(item)
        if item ~= a and not a:outside(item) and item:is_alive() then
            local did_hit = false
            if item.damage then
                a:hurt(item.damage, function()
                    a.should_regen = true
                    did_hit = true
                end)
            elseif item.should_stun then
                a:stun(3, function()
                    did_hit = true
                end)
            end

            if did_hit then
                a:start_timer('isma', 2)
                item:item_hit_func()
            end

            if item.should_push or did_hit then
                if item.should_use_xf then
                    a:push(atan2(item.xf, item.y-a.y), .05)
                else
                    local abx, aby = a:abside(item)
                    a:push(atan2(abx, aby), .05)
                end
            end
        end
    end)
    end
end $$

zclass[[slimy_boss_fight|]]
zclass[[slobs_miny,actor,slimy_boss_fight|
    update,%slimy_minion_spawner_update
]]

|[slimy_minion_spawner_update]| function(a)
end $$

zclass[[slobs,slimy_parent,ma_boss,collidable,drawlayer_50|
    x,@, y,@, cspr,120, cname,"slobs", sind,120, destroyed,%slimyboss_destroyed;

    should_regen,yes,
    jump_num,0,
    moving_away,yes,
    did_spin,no,
    stateless_update,%slimy_boss_stateless_update,
    rx,.5,ry,.5,
    sy,-1,
    pl_collide_func,%slimy_pl_collide_func,
    stun_callback,%slimy_stun_callback,
    minion_ang_offset,.125,
    max_health,8;

    defaults; init,nop, update,nop, minion_target_rad,1.25, sind,120, collide_disabled,no, visible,yes, invincible, no;

    start; init,%slimyboss_init, duration,.25, next,idle;
    stunstate; update,%slimy_stunstate, next,idle;

    idle;      init,%slimy_boss_idle_init, update,%slimy_boss_idle_update, duration,.5, next,idle_face;
    idle_face; sind,121, update,%slimy_start, duration,.0625, next,bounce;
    bounce;    init,%slobs_calc_next, duration,.0625;
    jump;      jumpspeed,.025,sind,121,init,%slimy_boss_jump_init, update,%slimyboss_jump, duration, .25, next,idle;

    shotgun_jump;   minion_target_rad,.5, jumpspeed,.025,sind,121,init,%slimy_boss_jump_init, duration, .25, next,shotgun;
    shotgun;        minion_target_rad,.5, init,%slobs_shotgun_init, duration,.75, next,shotgun_jump_2;
    shotgun_jump_2;   minion_target_rad,.5, jumpspeed,.025,sind,121,init,%slimy_boss_jump_init, duration, .25, next,idle;
]]

|[slobs_shotgun_init]| function(a)
    a.sind = 98
    -- a.collide_disabled = true
    a.invincible = true
    for i=0,7 do
        local ang = i/8+a.minion_ang_offset
        if a.minions[i+1] and a.minions[i+1]:is_alive() then
            _g.slimy_boss_ball(a, a.x, a.y, ang, 1-2*flr_rnd'2')
        else
            _g.slimy_boss_ball_small(a, a.x, a.y, ang, 1-2*flr_rnd'2')
        end
    end
end $$

|[slobs_calc_next]| function(a)
    if a.jump_num >= 3 then
        a.jump_num = 0
        a.next = 'shotgun_jump'
    else
        a.jump_num += 1
        a.next = 'jump'
    end
end $$

|[slimy_boss_idle_update]| function(a)
    if a.health <= 4 then
        a.minion_ang_offset -= .01*a.xf
        a.minion_target_rad = 1.25-sin(a:get_elapsed_percent'idle'/2)*.75
    end
end $$

|[slimy_boss_spin_update]| function(a)
    a.minion_ang_offset -= .02*a.xf
    a.minion_target_rad = 1.25-sin(a:get_elapsed_percent'spin'/2)*1
end $$

|[slimy_boss_stateless_update]| function(a)
    a:start_timer('isma', 0)
    for i=0,7 do
        local cur_minion = a.minions[i+1]
        if cur_minion and cur_minion:is_alive() then
            a.minions[i+1].minion_ang = i/8+a.minion_ang_offset
        end
    end

    if a:is_active'stunned' then
        a:load'stunstate'
    end
end $$

|[slimy_boss_jump_init]| function(a)
    if not a.moving_away and a:dist_point(g_pl.x, g_pl.y) < 2.5 then
        a.ang = atan2(5.5-a.x, 4.5-a.y)
        a.moving_away = true
    else
        a.ang = a.target_ang
        a.moving_away = false
    end
    a:start_timer('jumpanim', a.jump.duration)
end $$

|[slimy_boss_idle_init]| function(a)
    --local regen_count = 0
    for i=0,7 do
        local ang = i/8+a.minion_ang_offset
        local cur_minion = a.minions[i+1]

        if a.should_regen and a.health and (a.health > 0) and (not cur_minion or not cur_minion:is_alive()) then
            a.minions[i+1] = _g.slimy_boss_minion_2(a, a.x, a.y, ang, 1-2*flr_rnd'2')
        end
    end
    a.should_regen = false

    if not a.minion or not a.minion:is_alive() then
        --a.minion = _g.miny_actual(a.x, a.y-.125, 0, 0)
    end
end $$

|[slimyboss_destroyed]| function(a)
    _g.slimy_actual(a.x-.125, a.y-.125, 0, 0)
    _g.slimy_actual(a.x-.125, a.y+.125, 0, 0)
    _g.slimy_actual(a.x+.125, a.y+.125, 0, 0)
    _g.slimy_actual(a.x+.125, a.y-.125, 0, 0)

    _g.explode(a.x, a.y, 4, 1, function()
        foreach(g_zclass_entities['slimy_boss_fight'], function(b)
            b:kill()
        end)
    end)
end $$

|[slimyboss_jump]| function(a)
    _g.slimy_propel(a)
    -- a.minion_ang_offset -= .01*a.xf

    a.minion_ang_offset -= .02*a.xf
end $$

|[slimyboss_init]| function(a)
    a.minions = {}
    _g.slimy_start(a)
end $$

-- MINION
zclass[[slimy_boss_ball,slimy_parent,slimy_boss_fight,drawlayer_75|
    anchoring,@, x,@, y,@, minion_ang,@, xf,@,
    sind,105,
    minion_rad,.25,
    start_x,~x, start_y,~y,
    update,%slimy_ball_update,
    pl_collide_func,%slimy_minion_pl_collide,
    rx,.5,ry,.5, max_health,1;

    start; minion_target_rad,3, duration,.5, next,ending;
    ending; minion_target_rad,.25, duration,.25;
]]

zclass[[slimy_boss_ball_small,slimy_parent,slimy_boss_fight,drawlayer_75|
    anchoring,@, x,@, y,@, minion_ang,@, xf,@,
    sind,106,
    minion_rad,.25,
    start_x,~x, start_y,~y,
    update,%slimy_ball_update,
    pl_collide_func,%slimy_minion_pl_collide,
    rx,.25,ry,.25, max_health,1;

    start; minion_target_rad,3, duration,.5, next,ending;
    ending; minion_target_rad,.25, duration,.25;
]]

|[slimy_ball_update]| function(a)
    if a.minion_rad < a.minion_target_rad then a.minion_rad += .15 end
    if a.minion_rad > a.minion_target_rad then a.minion_rad -= .15 end
    
    a.x = a.start_x+cos(a.minion_ang)*a.minion_rad
    a.y = a.start_y+sin(a.minion_ang)*a.minion_rad
end $$

zclass[[slimy_boss_minion_2,slimy_parent,anchor,slimy_boss_fight,drawlayer_75|
    anchoring,@, x,@, y,@, minion_ang,@, xf,@,
    sind,104,
    minion_rad,0,
    respawn_wait,4,
    update,%slimy_minion_update,
    pl_collide_func,%slimy_minion_pl_collide,
    rx,.25,ry,.25,

    max_health,1, destroyed,%standard_explosion;
]]

|[minion_to_miny]| function(a)
    _g.miny_actual(a.x, a.y, 0, 0)
end $$

|[slimy_minion_pl_collide]| function(a, pl)
    _g.slimy_pl_collide_func(a.anchoring, pl)
end $$

|[slimy_minion_update]| function(a)
    if a.anchoring:is_active'shotgun' then
        a.collide_disabled = true
        a.visible = false
        a.invincible = true
    else
        a.collide_disabled = false
        a.visible = true
        a.invincible = false
    end
    --a.visible = a.anchoring.visible

    --if a.anchoring:is_active'stunned' and not a:is_active'stunned' then
    --    a:start_timer('stunned', 0)
    --end

    if not a:is_active'stunned' and a.minion_rad < a.anchoring.minion_target_rad then a.minion_rad += .125 end
    if a.minion_rad > a.anchoring.minion_target_rad then a.minion_rad -= .125 end

    if a.anchoring:is_active'jumpanim' and not a:is_active'jumpanim' then
        a:start_timer('jumpanim', a.anchoring.jump.duration)
    end

    a.offx = cos(a.minion_ang)*a.minion_rad
    a.offy = sin(a.minion_ang)*a.minion_rad

    if not a.anchoring:is_alive() then
        a:kill()
    end
end $$

-- SLIMY
|[slimy]| function(x, y) _g.slimy_actual(x, y, 0, 0) end $$

zclass[[smaller_slimes|]]
zclass[[slimy_actual,slimy_parent,ma_battle,collidable,smaller_slimes,drawlayer_50|
    x,@, y,@, dx,@, dy,@,

    idle_sind,118, jump_sind,119,
    cspr,~idle_sind, cname,"slimy", sind,~idle_sind, destroyed,%slimy_destroyed,

    rx, .375, ry, .375,
    max_health,2,
    pl_collide_func,%slimy_pl_collide_func,
    stun_callback,%slimy_stun_callback,
    curr,idle;

    defaults;  init,nop, update,nop;
    stunstate; next,idle,     update,%slimy_stunstate;
    idle;      next,bounce_1, update,%slimy_start, sind,~idle_sind,duration,.5;
    bounce_1;  next,bounce_2, duration,.0625, sind,~jump_sind;
    bounce_2;  next,jump,     duration,.0625, sind,~idle_sind;
    jump;      next,idle,     init,%slimy_jump_init, jumpspeed,.025, update,%slimy_propel, duration, .25, sind,~jump_sind;
]]

|[slimy_destroyed]| function(a)
    _g.miny_actual(a.x, a.y+.125, 0, 0)
    _g.miny_actual(a.x, a.y-.125, 0, 0)
end $$

-- MINY
|[miny]| function(x, y)
    _g.miny_actual(x, y, 0, 0)
end $$

zclass[[miny_actual,slimy_parent,ma_battle,collidable,smaller_slimes,drawlayer_50|
    x,@, y,@, dx,@, dy,@,

    idle_sind,116, jump_sind,117,
    cspr,~idle_sind, cname,"miny", sind,~idle_sind, destroyed,%standard_explosion,

    rx, .25, ry, .25,
    max_health,1,
    pl_collide_func,%slimy_pl_collide_func,
    stun_callback,%slimy_stun_callback,
    curr,idle;

    defaults;  init,nop, update,nop;
    stunstate; next,idle,     update,%slimy_stunstate;
    idle;      next,bounce_1, update,%slimy_start, sind,~idle_sind,duration,.5;
    bounce_1;  next,bounce_2, duration,.0625, sind,~jump_sind;
    bounce_2;  next,jump,     duration,.0625, sind,~idle_sind;
    jump;      next,idle,     init,%slimy_jump_init, jumpspeed,.025, update,%slimy_propel, duration, .25, sind,~jump_sind;
]]

-- SHARED
|[slimy_propel]| function(a)
    a.speed = a.jumpspeed
end $$

|[slimy_stun_callback]| function(a)
    a:load'stunstate'
end $$

|[slimy_stunstate]| function(a)
    if not a:is_active'stunned' then
        a:load()
    end
end $$

|[slimy_pl_collide_func]| function(a, pl)
    if not a.collide_disabled then
        a:start_timer('isma', 2)
            pl:push(atan2(pl.x-a.x, pl.y-a.y), .1)
        if a:is_active'jump' then
        else
            --pl:push(atan2(pl.x-a.x, pl.y-a.y), .03125)
        end
    end
end $$

|[slimy_start]| function(a)
    a.xf = sgn(g_pl.x-a.x)
    a.target_ang = atan2(g_pl.x-a.x, g_pl.y-a.y)
end $$

|[slimy_bounce]| function(a)
    if a.sind == a.idle.sind then
        a.sind = a.jump.sind
    else
        a.sind = a.idle.sind
    end
end $$

|[slimy_jump_init]| function(a)
    a.ang = a.target_ang
    a:start_timer('jumpanim', a.jump.duration)
end $$
