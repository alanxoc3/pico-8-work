-- 'team' to avoid friendly fire?
zclass[[teammate|]]
zclass[[team_red,teammate|]]  -- enemy team
zclass[[team_blue,teammate|]] -- player team
zclass[[team_none,teammate|]] -- unaffiliated team (black holes)

zclass[[model_health_bar,model|hit,%model_health_bar_hit, health_bar_min,1, health_color,1]]

|model_health_bar_hit| function(a, other, ...)
    local prev_health = a.health
    _g.model_hit(a, other, ...)

    if prev_health ~= a.health and (not a.health_bar or not a.health_bar.alive) then
        a.health_bar = _g.bar(a, function() SCREEN_SHAKE = true return a.health / a.max_health end, 5, a.health_bar_min, a.health_bar_min+1, .5)
    end
end $$

-- a friendly planet that you protect
zclass[[planet,model_health_bar,drawlayer_20,team_blue|
    x,@, y,@, model,@,
    spawn_delay,4, spawn_rate,4,
    health_bar_min,1.7,
    alert_color,11,
    health_bar_color,5,
    max_health,75,
    health,~max_health,
    explode_sfx,24,
    destroyed,%planet_destroyed,
    damage,10000, -- so that things that crash into the planet immediately die
    d_ang,.001;
    start;duration,~spawn_delay,next,evac;
    evac;init,%planet_evac,duration,~spawn_rate,next,evac;
]]

|planet_destroyed| function(a)
    g_view.following = a
end $$

|planet_evac| function(a)
    _g.zipper(a.x, a.y, rnd())
end $$

-- a friendly asteroid that you might not want to protect
zclass[[asteroid,model_health_bar,drawlayer_20,team_blue|
    x,@, y,@, model,%ASTEROID,
    max_health,50,
    health,~max_health,

    health_bar_min,1.7,
    health_bar_color,5,

    alert_color,13,
    explode_sfx,27,
    damage,10000, -- so that things that crash into the asteroid immediately die
    d_ang,.001;
]]

-- a friendly ship leaving a planet that you're protecting
-- the idea is these would just spawn from the planet and quickly zip away
zclass[[zipper,model,drawlayer_20,team_blue|
    x,@,y,@,ang,@,
    destroyed,~explode,model,%ZIPPER;
    start;init,%zipper_init,duration,1,next,zip;
    zip;init,nop,speed,.05,duration,1;
]]

|zipper_init| function() g_zipper_count += 1 end $$
|zipper_destroyed| function(a) a:explode() end $$

-- an enemy that chases a target around, trying to crash into it
zclass[[chaser,model_health_bar,drawlayer_20,team_red|
    x,@, y,@, target,@,
    alert_color,8,
    health_bar_min,1.2,
    health_bar_color,5,
    max_health,5,
    health,~max_health,
    explode_sfx,27,
    damage,25,
    model,%CHASER,
    init,%chaser_init,
    update,%chaser_update,
    hit,%chaser_hit;
]]

|chaser_init| function(a)
    a.ang = atan2(a.target.x - a.x, a.target.y - a.y)
end $$

|chaser_update| function(a)
    -- if there is a target, apply an impulse towards that target
    -- if not a.target or not a.target.alive then
        -- a.target = g_zclass_entities['team_blue'][1]
    -- end
    if a.target then
        local ang = atan2(a.target.x-a.x, a.target.y-a.y)
            -- This would be the shortest path, but making it change rotational direction adds character
            --local diff = ang - a.ang%1
            --a.d_ang = sgn(abs(diff) > 0.5 and -diff or diff) * .01
        a.d_ang = sgn(ang - a.ang%1) * .01
        a.speed = .004*.75
    else
        a.d_ang = .01
        a.speed = 0
    end
end $$

|chaser_hit| function(a, b, dx, dy)
    _g.model_health_bar_hit(a, b, dx, dy)
    if b.id == 'missile' then a.target = g_pl end
end $$

-- an enemy that sucks other things into itself and destroys them
zclass[[black_hole,model,drawlayer_20|
    x,@, y,@,
    alert_color,2,
    d_ang,.1, -- spinz fast
    damage,10000, -- basically infinite damage
    tug_constant,.0004,
    model,%BLACK_HOLE;

    start;duration,1.5, tug,nop, next,run;
    run;tug,%black_hole_tug;
]]

|black_hole_tug| function(a, obj_list)
    foreach(obj_list, function(obj) 
        if a.id == obj then return end
        local x, y = a.x-obj.x, a.y-obj.y
        local ang = atan2(x, y)
        local dist = min(approx_dist(x,y), a.tug_constant)
        obj.dx += cos(ang) * dist
        obj.dy += sin(ang) * dist
    end)
end $$
