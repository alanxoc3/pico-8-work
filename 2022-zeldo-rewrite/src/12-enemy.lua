|[slimy]| function(x, y)
    _g.explode(x, y, 4, 1, function() _g.slimy_actual(rnd'1'+.75, x, y) end)
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

zclass[[slimy_boss,ma_battle,pushable,actor,collidable,healthobj,enemy,simple_spr,drawlayer_50|
    x,@, y,@, cspr,104, cname,"slimy", sind,104, destroyed,%slimy_destroyed;

    rx, .5, ry, .5,
    sw,2,sh,2,
    should_dance,yes,
    statcollide,%slimy_statcollide,
    drawout,%slimy_draw,
    pl_collide_func,%slimy_pl_collide_func,
    stun_callback,%slimy_stun_callback,
    max_health,10;

    start; init,%slimyboss_init, duration,0, next,idle;

    stunstate; init,nop, update,%slimy_stunstate, next,idle;
    idle;      init,nop, update,%slimy_start, next,bounce_1, sind,104,duration,.75;
    bounce_1;  init,%slimy_bounce, update,nop, duration,.0625, next,bounce_2;
    bounce_2;  init,%slimy_bounce, update,nop, duration,.0625, next,jump;
    jump;      sind,106,init,%slimy_jump_init, update,%slimy_propel, pl_collide_func,%slimy_pl_collide_func, duration, .25, next,idle;
]]

|[slimyboss_init]| function(a)
    for i=0,5 do
        _g.slimy_boss_minion(a.x, a.y, cos(i/6)*.4, sin(i/6)*.4)
    end
end $$

zclass[[slimy_boss_minion,slimy_shared|
    idle;sind,118,duration,.75; jump;sind,119;
    x,@, y,@, dx,@, dy,@, cspr,118, cname,"slimy", sind,118, max_health,10, destroyed,%slimy_destroyed;
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
    idle;sind,118,duration,@; jump;sind,119;
    x,@, y,@, cspr,118, cname,"slimy", sind,118, max_health,5, destroyed,%slimy_destroyed;
]]

zclass[[miny_actual,slimy_shared  |
    idle;sind,116,duration,@; jump;sind,117;
    x,@, y,@, dy,@, cspr,116, cname,"miny", sind,116, max_health,1, destroyed,%standard_explosion;
]]

|[slimy_pl_collide_func]| function(a, pl)
    a.speed = 0
    a:start_timer('isma', 2)
        if a:is_active'jump' then
            pl:push(atan2(a.xf, pl.y-a.y), .125)
            pl:stun'.25'
        else
            pl:push(atan2(pl:abside(a)), .03125)
        end
end $$

|[slimy_destroyed]| function(a)
    _g.miny_actual(rnd'1', a.x, a.y, -.2)
    _g.miny_actual(rnd'1', a.x, a.y, .2)
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
    a:start_timer('jumpanim', .25)
    -- a.stunned.duration = rnd"1"
end $$

|[slimy_draw]| function(a)
    a.sy = sin(a:get_elapsed_percent'jumpanim'/2)*8
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
