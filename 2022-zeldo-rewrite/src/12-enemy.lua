|[slimy]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.slimy_actual(rnd'1'+.75, x, y, 0) end)
end $$

|[miny]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.miny_actual(rnd'1'+.75, x, y, 0) end)
end $$

-- enemy can collide with the player
zclass[[enemy,box|
    pl_collide_func_batch,%enemy_pl_collide_func_batch,
    pl_collide_func,nop
]]

zclass[[quack,propel,ma_interact,actor,collidable,mov,enemy,simple_spr,drawlayer_50|
    x,@, y,@, rx, .25, ry, .25,
    should_dance,yes,
    sy,-2,
    propel_speed,.0125,
    pl_collide_func,%quack_pl_collide_func,
    sind,32, cspr,32, cname,"quack";
    start; init,%quack_change_dir, update,~propel, duration,1, next,start;
]]

|[quack_change_dir]| function(a)
    a.ang = rnd(2)-1
    a.xf = sgn(cos(a.ang))
end $$

|[quack_pl_collide_func]| function(a, pl)
    if not _g.sign_target_with_tbox_disable_callback() then
        a:start_timer('isma', 0)
    end
end $$

|[enemy_pl_collide_func_batch]| function(a, others)
    foreach(others, function(other)
        if not a:outside(other) then
            a:pl_collide_func(other)
        end
    end)
end $$

zclass[[slimy_boss,ma_battle,pushable,actor,collidable,enemy,healthobj,simple_spr,drawlayer_50|
    x,@, y,@, cspr,104, cname,"slimy", sind,104, destroyed,%slimyboss_destroyed;

    rx, .25, ry, .25,
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
        --if i % 2 == 0 then
        --    --add(a.minions, _g.slimy_boss_minion(a, a.x, a.y, cos(i/8+.125)*1.5, sin(i/8+.125)*1.5))
        --else
        --end
        add(a.minions, _g.slimy_boss_minion_2(a, a.x, a.y, cos(i/8+.125)*1.5, sin(i/8+.125)*1.5))
    end
end $$

zclass[[slimy_boss_minion,slimy_shared,anchor|
    idle;sind,118,duration,.75; jump;sind,119;
    idle;update,nop;
    anchoring,@, x,@, y,@, offx,@, offy,@, cspr,118, cname,"slimy", sind,118, max_health,5, destroyed,%slimy_destroyed;
]]

zclass[[slimy_boss_minion_2,slimy_shared,anchor|
    idle;sind,116,duration,.75; jump;sind,117;
    idle;update,nop;
    anchoring,@, x,@, y,@, offx,@, offy,@, cspr,116, cname,"miny", sind,116, max_health,1, destroyed,%standard_explosion;
]]

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

zclass[[slimy_actual,slimy_shared |
    idle;sind,118,duration,@; jump;sind,119,duration,.5;
    x,@, y,@, dy,@, cspr,118, cname,"slimy", sind,118, max_health,5, destroyed,%slimy_destroyed;
]]

zclass[[miny_actual,slimy_shared  |
    idle;sind,116,duration,@; jump;sind,117;
    x,@, y,@, dy,@, cspr,116, cname,"miny", sind,116, max_health,1, destroyed,%standard_explosion;
]]

|[slimy_pl_collide_func]| function(a, pl)
    a.speed = 0
    a:start_timer('isma', 2)
        if a:is_active'jump' then
            --pl:stun'.25'
            pl:push(atan2(a.xf, pl.y-a.y), .25)
        else
            pl:push(atan2(a.xf, pl.y-a.y), .03125)
        end
end $$

|[slimy_destroyed]| function(a)
    _g.miny_actual(rnd'1'+.75, a.x, a.y, -.2)
    _g.miny_actual(rnd'1'+.75, a.x, a.y, .2)
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
    -- a.stunned.duration = rnd"1"
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
