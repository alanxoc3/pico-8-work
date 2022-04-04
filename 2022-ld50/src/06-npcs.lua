-- 'team' to avoid friendly fire?
g_teams = {}

zclass[[teammate|
    team,none, -- default, should usually be overridden
    init,%teammate_init,
    destroyed,%teammate_destroyed;
]]

|teammate_init| function(a)
    g_teams[a.team] = g_teams[a.team] or {}
    add(g_teams[a.team], a)
end $$

|teammate_destroyed| function(a)
    del(g_teams[a.team] or {}, a)
end $$

-- a friendly planet that you protect
zclass[[planet,model,drawable,teammate|
    x,@, y,@,
    team,blue,
    health,100,
    d_ang,.001,
    model,%PLANET_SMALL
]]

-- a friendly ship leaving a planet that you're protecting
-- the idea is these would just spawn from the planet and quickly zip away
zclass[[zipper,model,drawable,teammate|
    x,@,y,@,ang,@,
    team,blue,
    model,%CHASER;
    start;duration,1,next,zip;
    zip;speed,.05,duration,2;
]]

-- an enemy that chases a target around, trying to crash into it
zclass[[chaser,model,drawable,teammate|
    x,@, y,@,
    team,red,
    alert_color,8,
    health,30,
    damage,30,
    scale,2,
    model,%CHASER,
    update,%chaser_update
]]

|chaser_update| function(a)
    -- if there is a target, apply an impulse towards that target
    if not a.target or not a.target.alive then
        a.target = select_next_target(a)
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

function select_next_target(a)

end

-- an enemy that sucks other things into itself and destroys them
zclass[[black_hole,model,drawable,teammate|
    x,@, y,@,
    alert_color,8,
    d_ang,.1, -- spinz fast
    damage,32767, -- basically infinite damage
    model,%BLACK_HOLE,
    tug,%black_hole_tug;
]]

|black_hole_tug| function(a, obj_list)
    foreach(obj_list, function(obj) 
        if a == obj then return end
        local ang = atan2(a.x-obj.x, a.y-obj.y)
        obj.dx += cos(ang) * .001
        obj.dy += sin(ang) * .001
    end)
end $$
