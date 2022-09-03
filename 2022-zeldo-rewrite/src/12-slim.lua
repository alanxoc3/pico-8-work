-- BOSS
zclass[[slimy_boss_fight|]]
zclass[[slobs_miny,actor,slimy_boss_fight|
    update,%slimy_minion_spawner_update
]]

|[slimy_minion_spawner_update]| function(a)
    if not a.spawning and (not a.anchoring or (a.anchoring and not a.anchoring:is_alive())) then
        a.spawning, a.anchoring = true

        local x, y = 2.5+7*flr_rnd'2', 2.5+5*flr_rnd'2'
        _g.explode(x, y, 4, 1, function() 
            a.anchoring, a.spawning = _g.miny_actual(rnd'1'+.75, x, y, 0, 0)
        end)
    end
end $$

zclass[[slobs,ma_boss,pushable,actor,collidable,enemy,healthobj,simple_spr,drawlayer_50|
    x,@, y,@, cspr,120, cname,"slobs", sind,120, destroyed,%slimyboss_destroyed;

    did_spin,no,
    minion_target_rad,1.5,
    stateless_update,%slimy_boss_stateless_update,
    rx,.5,ry,.5,
    sw,1,sh,1,sy,-1,
    should_dance,yes,
    statcollide,%slimy_statcollide,
    drawout,%slimy_draw,
    pl_collide_func,%slimy_pl_collide_func,
    stun_callback,%slimy_stun_callback,
    minion_ang_offset,.125,
    max_health,20;

    start; init,%slimyboss_init, duration,0, next,idle;

    stunstate; init,nop, update,%slimy_stunstate, next,idle;

    idle;      minion_target_rad,1.5, init,nop, update,nop, sind,120, duration,.75, pl_collide_func,%slimy_pl_collide_func, next,idle_face;
    idle_face; init,%slimy_boss_idle_init, update,%slimyboss_start, duration,.25;

    bounce_1;  init,%slimy_bounce, update,nop, duration,.0625, next,bounce_2;
    bounce_2;  init,%slimy_bounce, update,nop, duration,.0625, next,jump;
    jump;      jumpspeed,.05,sind,121,init,%slimy_boss_jump_init, update,%slimyboss_jump, duration, .25, next,idle;

    spin_bounce; init,%slimy_bounce, update,nop, duration,.0625, next,spin;
    spin;        init,nop, update,%slimy_boss_spin_update, next,idle, duration,.75;
]]

|[slimy_boss_spin_update]| function(a)
    a.minion_ang_offset -= .02*a.xf
    a.minion_target_rad = 1.5-sin(a:get_elapsed_percent'spin'/2)*2
end $$

|[slimy_boss_stateless_update]| function(a)
    a:start_timer('isma', 0)

    for i=0,7 do
        local cur_minion = a.minions[i+1]
        if cur_minion:is_alive() then
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
    local dead_count = 0
    for i=0,7 do
        local ang = i/8+a.minion_ang_offset
        local cur_minion = a.minions[i+1]
        if not cur_minion:is_alive() then
            dead_count += 1
            if cur_minion.respawn_wait <= 0 then
                a.minions[i+1] = _g.slimy_boss_minion_2(a, a.x, a.y, ang)
            else
                cur_minion.respawn_wait -= 1
            end
        end
    end

    if dead_count < 4 and not a.did_spin and flr_rnd'2' == 0 then
        a.next = 'spin_bounce'
        a.did_spin = true
    else
        a.next = 'bounce_1'
        a.did_spin = false
    end
end $$

|[slimyboss_destroyed]| function(a)
    for i=0,1,.125 do
        _g.miny_actual(rnd'1'+.75, a.x, a.y, sin(i)*.3, cos(i)*.3)
    end

    _g.explode(a.x, a.y, 4, 1, function()
        foreach(g_zclass_entities['slimy_boss_fight'], function(b)
            b:kill()
        end)
    end)
end $$

|[slimyboss_start]| function(a)
    _g.slimy_start(a)
    for i=0,7 do
        local cur_minion = a.minions[i+1]
        if cur_minion:is_alive() then
            cur_minion.xf = a.xf
        end
    end
end $$

|[slimyboss_jump]| function(a)
    _g.slimy_propel(a)
    a.minion_ang_offset -= .01*a.xf
end $$

|[slimyboss_init]| function(a)
    a.minions = {}
    for i=0,7 do
        add(a.minions, _g.slimy_boss_minion_2(a, a.x, a.y, i/8+a.minion_ang_offset))
    end
end $$

-- MINION
zclass[[slimy_boss_minion_2,healthobj,pushable,anchor,actor,simple_spr,drawlayer_50,enemy,slimy_boss_fight|
    anchoring,@, x,@, y,@, minion_ang,@,
    minion_rad,0,
    respawn_wait,2,
    should_dance,yes,
    update,%slimy_minion_update,
    pl_collide_func,%slimy_minion_pl_collide,
    rx,.25,ry,.25,

    statcollide,%slimy_statcollide,
    cspr,116, cname,"miny", max_health,1, destroyed,%standard_explosion;
]]

|[minion_to_miny]| function(a)
    _g.miny_actual(rnd'1'+.75, a.x, a.y, 0, 0)
end $$

|[slimy_minion_pl_collide]| function(a, pl)
    _g.slimy_pl_collide_func(a.anchoring, pl)
end $$

|[slimy_minion_update]| function(a)
    a.sind = 104

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
|[slimy]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.slimy_actual(rnd'1'+.75, x, y, 0, 0) end)
end $$

zclass[[slimy_actual,slimy_shared |
    idle;sind,118,duration,@; jump;sind,119,duration,.5;
    x,@, y,@, dx,@, dy,@, cspr,118, cname,"slimy", sind,118, max_health,5, destroyed,%slimy_destroyed;
]]

|[slimy_destroyed]| function(a)
    _g.miny_actual(rnd'1'+.75, a.x, a.y, 0, -.2)
    _g.miny_actual(rnd'1'+.75, a.x, a.y, 0, .2)
end $$

-- MINY
|[miny]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.miny_actual(rnd'1'+.75, x, y, 0, 0) end)
end $$

zclass[[miny_actual,slimy_shared  |
    idle;sind,116,duration,@; jump;sind,117;
    x,@, y,@, dx,@, dy,@, cspr,116, cname,"miny", sind,116, max_health,1, destroyed,%standard_explosion;
]]

-- SHARED
zclass[[slimy_shared,ma_battle,pushable,actor,collidable,healthobj,enemy,simple_spr,drawlayer_50|
    rx, .25, ry, .25,
    should_dance,yes,
    statcollide,%slimy_statcollide,
    drawout,%slimy_draw,
    pl_collide_func,%slimy_pl_collide_func,
    stun_callback,%slimy_stun_callback,
    max_health,5,
    curr,idle;

    stunstate; init,nop, update,%slimy_stunstate, next,idle;
    idle;      init,nop, update,%slimy_start, next,bounce_1, pl_collide_func,%slimy_pl_collide_func;
    bounce_1;  init,%slimy_bounce, update,nop, duration,.0625, next,bounce_2;
    bounce_2;  init,%slimy_bounce, update,nop, duration,.0625, next,jump;
    jump;      jumpspeed,.025, init,%slimy_jump_init, update,%slimy_propel, pl_collide_func,%slimy_pl_collide_func, duration, .25, next,idle;
]]

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
    a:start_timer('isma', 2)
    if a:is_active'jump' then
        pl:push(atan2(pl.x-a.x, pl.y-a.y), .25)
    else
        pl:push(atan2(pl.x-a.x, pl.y-a.y), .03125)
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

|[slimy_draw]| function(a)
    _g.simple_spr_draw(a)
end $$

|[slimy_statcollide]| function(a, items)
    foreach(items, function(item)
        if not a:outside(item) and item:is_alive() then
            local did_hit = false
            if item.damage then
                a:hurt(item.damage, function()
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
                    a:push(atan2(item.xf, item.y-a.y), .125)
                else
                    local abx, aby = a:abside(item)
                    a:push(atan2(abx, aby), .125)
                end
            end
        end
    end)
end $$
