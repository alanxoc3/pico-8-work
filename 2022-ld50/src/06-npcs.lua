-- 'team' to avoid friendly fire?
zclass[[teammate|]]
zclass[[team_red,teammate|]]  -- enemy team
zclass[[team_blue,teammate|]] -- player team
zclass[[team_none,teammate|]] -- unaffiliated team (black holes)

-- a friendly planet that you protect
zclass[[planet,model,drawlayer_20,team_blue|
    x,@, y,@,total_ships,@,model,@,
    done_ships,0,
    max_health,100,
    health,100,
    damage,10000, -- so that things that crash into the planet immediately die
    d_ang,.001;
    start;duration,10,next,evac;
    evac;init,%planet_evac,duration,9.5,next,evac;
    done;,;
]]

|planet_evac| function(a)
    _g.zipper(a.x, a.y, a.ang)
    a.done_ships += 1
    if a.done_ships == a.total_ships then a.next = 'done' end
end $$

-- a friendly ship leaving a planet that you're protecting
-- the idea is these would just spawn from the planet and quickly zip away
zclass[[zipper,model,drawlayer_20,team_blue|
    x,@,y,@,ang,@,
    model,%ZIPPER;
    start;duration,1,next,zip;
    zip;speed,.05,duration,1;
]]

-- an enemy that chases a target around, trying to crash into it
zclass[[chaser,model,drawlayer_20,team_red|
    x,@, y,@, target,@,
    alert_color,8,
    max_health,20,
    health,20,
    damage,30,
    scale,2,
    model,%CHASER,
    update,%chaser_update,
    hit,%chaser_hit;
]]

|chaser_update| function(a)
    -- if there is a target, apply an impulse towards that target
    if not a.target or not a.target.alive then
        a.target = g_zclass_entities['team_blue'][1]
    end
    if a.target then
        local ang = atan2(a.target.x-a.x, a.target.y-a.y)
            -- This would be the shortest path, but making it change rotational direction adds character
            --local diff = ang - a.ang%1
            --a.d_ang = sgn(abs(diff) > 0.5 and -diff or diff) * .01
        a.d_ang = sgn(ang - a.ang%1) * .01
        a.speed = .004
    else
        a.speed = 0
    end
end $$

|chaser_hit| function(a, b, dx, dy)
    _g.model_hit(a, b, dx, dy)
    if b.id == 'missile' then a.target = g_pl end
end $$

-- an enemy that sucks other things into itself and destroys them
zclass[[black_hole,model,drawlayer_20,team_none|
    x,@, y,@,
    alert_color,1,
    d_ang,.1, -- spinz fast
    damage,10000, -- basically infinite damage
    tug_constant,.001,
    model,%BLACK_HOLE;

    start;duration,1.5, tug,nop, next,run;
    run;tug,%black_hole_tug;
]]

|black_hole_tug| function(a, obj_list)
    foreach(obj_list, function(obj) 
        if a == obj then return end
        local ang = atan2(a.x-obj.x, a.y-obj.y)
        obj.dx += cos(ang) * a.tug_constant
        obj.dy += sin(ang) * a.tug_constant
    end)
end $$
