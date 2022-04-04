-- 'team' to avoid friendly fire?

zclass[[planet,model,drawable|
    x,@, y,@,
    team,blue,
    health,100,
    d_ang,.001,
    model,%PLANET_SMALL
]]

-- the idea is these would just spawn from a planet and quickly zip away
-- ie a ship that you saved
zclass[[zipper,model,drawable|
    x,@,y,@,ang,@,
    team,blue,
    model,%CHASER;
    start;duration,1,next,zip;
    zip;speed,.05,duration,2;
]]

zclass[[chaser,model,drawable|
    x,@, y,@,
    team,red,
    alert_color,8,
    health,50,
    damage,30,
    scale,2,
    model,%CHASER,
    update,%chaser_update
]]

|chaser_update| function(a)
    -- if there is a target, apply an impulse towards that target
    if a.target then
        if not a.target.alive then a.target = nil return end
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

zclass[[black_hole,model,drawable|
    x,@, y,@,
    team,red,
    alert_color,8,
    d_ang,.1, -- spinz fast
    damage,32767, -- basically infinite damage
    model,%BLACK_HOLE,
    init,%black_hole_init,
    update,%black_hole_update;
]]

|black_hole_update| function(a)
    
end $$

|black_hole_init| function(a)
    a:start_timer('fade', 10, function() a:explode(.2) end)
end $$


