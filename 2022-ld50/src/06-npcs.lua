-- 'team' to avoid friendly fire?
zclass[[teammate|]]
zclass[[team_red,teammate|]]  -- enemy team
zclass[[team_blue,teammate|]] -- player team
zclass[[team_none,teammate|]] -- unaffiliated team (black holes)

-- a friendly planet that you protect
zclass[[planet,model,drawable,team_blue|
    x,@, y,@,
    health,100,
    d_ang,.001,
    model,%PLANET_SMALL
]]

-- a friendly ship leaving a planet that you're protecting
-- the idea is these would just spawn from the planet and quickly zip away
zclass[[zipper,model,drawable,team_blue|
    x,@,y,@,ang,@,
    model,%CHASER;
    start;duration,1,next,zip;
    zip;speed,.05,duration,2;
]]

-- an enemy that chases a target around, trying to crash into it
zclass[[chaser,model,drawable,team_red|
    x,@, y,@,
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
zclass[[black_hole,model,drawable,team_none|
    x,@, y,@,
    alert_color,8,
    d_ang,.1, -- spinz fast
    damage,10000, -- basically infinite damage
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
