-- BOSS
zclass[[slimy_boss,ma_battle,pushable,actor,collidable,enemy,healthobj,simple_spr,drawlayer_50|
    x,@, y,@, cspr,104, cname,"slobs", sind,104, destroyed,%slimyboss_destroyed;

    rx,.25,ry,.25,
    sw,1,sh,1,sy,-1,
    should_dance,yes,
    statcollide,%slimy_statcollide,
    drawout,%slimy_draw,
    pl_collide_func,%slimy_pl_collide_func,
    stun_callback,%slimy_stun_callback,
    max_health,10;

    start; init,%slimyboss_init, duration,0, next,idle;

    stunstate; init,nop, update,%slimy_stunstate, next,idle;
    idle;      init,nop, update,%slimyboss_start, next,bounce_1, sind,104,duration,.75;
    bounce_1;  init,%slimy_bounce, update,nop, duration,.0625, next,bounce_2;
    bounce_2;  init,%slimy_bounce, update,nop, duration,.0625, next,jump;
    jump;      sind,105,init,%slimy_jump_init, update,%slimyboss_jump, pl_collide_func,%slimy_pl_collide_func, duration, .75, next,idle;
]]

|[slimyboss_destroyed]| function(a)
    _g.slimy_actual(.75, a.x, a.y, -.2)
    _g.slimy_actual(.75, a.x, a.y, .2)
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
    local rad = 1.5 --1.5+sin(.5+a:get_elapsed_percent'jump'/2)
    for i=0,7 do
        local cur_minion = a.minions[i+1]
        if cur_minion:is_alive() then
            local ang = atan2(cur_minion.offx, cur_minion.offy)-.01*a.xf
            cur_minion.offx, cur_minion.offy = cos(ang)*rad, sin(ang)*rad
        end
    end
end $$

|[slimyboss_init]| function(a)
    a.minions = {}
    for i=0,7 do
        add(a.minions, _g.slimy_boss_minion_2(a, a.x, a.y, cos(i/8+.125)*1.5, sin(i/8+.125)*1.5))
    end
end $$

-- MINION
zclass[[slimy_boss_minion_2,healthobj,pushable,anchor,actor,simple_spr,drawlayer_50,enemy|
    anchoring,@, x,@, y,@, offx,@, offy,@,
    update,%slimy_minion_update,
    pl_collide_func,%slimy_pl_collide_func,
    rx,.25,ry,.25,


    statcollide,%slimy_statcollide,
    cspr,116, cname,"miny", max_health,1, destroyed,%standard_explosion;
]]

|[slimy_minion_update]| function(a)
    a.sind = 12+a.anchoring.sind
    if a.anchoring:is_active'jump' and not a:is_active'jump' then
        a:start_timer('jump', a.anchoring.jump.duration)
    end

    if not a.anchoring:is_alive() then
        a:kill()
    end
end $$

-- SLIMY
|[slimy]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.slimy_actual(rnd'1'+.75, x, y, 0) end)
end $$

zclass[[slimy_actual,slimy_shared |
    idle;sind,118,duration,@; jump;sind,119,duration,.5;
    x,@, y,@, dy,@, cspr,118, cname,"slimy", sind,118, max_health,5, destroyed,%slimy_destroyed;
]]

|[slimy_destroyed]| function(a)
    _g.miny_actual(rnd'1'+.75, a.x, a.y, -.2)
    _g.miny_actual(rnd'1'+.75, a.x, a.y, .2)
end $$

-- MINY
|[miny]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.miny_actual(rnd'1'+.75, x, y, 0) end)
end $$

zclass[[miny_actual,slimy_shared  |
    idle;sind,116,duration,@; jump;sind,117;
    x,@, y,@, dy,@, cspr,116, cname,"miny", sind,116, max_health,1, destroyed,%standard_explosion;
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
    idle;      init,nop, update,%slimy_start, next,bounce_1;
    bounce_1;  init,%slimy_bounce, update,nop, duration,.0625, next,bounce_2;
    bounce_2;  init,%slimy_bounce, update,nop, duration,.0625, next,jump;
    jump;      init,%slimy_jump_init, update,%slimy_propel, pl_collide_func,%slimy_pl_collide_func, duration, .25, next,idle;
]]

|[slimy_propel]| function(a)
    a.speed = .025
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
    a.speed = 0
    a:start_timer('isma', 2)
        if a:is_active'jump' then
            --pl:stun'.25'
            pl:push(atan2(a.xf, pl.y-a.y), .25)
        elseif not a:is_active'stunned' then
            pl:push(atan2(a.xf, pl.y-a.y), .03125)
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
                a:stun(1.5, function()
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
