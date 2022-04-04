-- 'team' to avoid friendly fire?

zclass[[planet,model,drawable|
    x,@, y,@,
    team,blue,
    health,100,
    d_ang,.001,
    model,%PLANET_SMALL
]]

zclass[[chaser,model,drawable|
    x,@, y,@,
    team,red,
    health,50,
    damage,30,
    scale,2,
    model,%CHASER,
    update,%chaser_update
]]

|chaser_update| function(a)
    -- if there is a target, apply an impulse towards that target
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

zclass[[black_hole,model,drawable|
    x,@, y,@,
    team,red,
    d_ang,.1, -- spinz fast
    damage,32767, -- basically infinite damage
    model,%BLACK_HOLE,
    init,%black_hole_init,
    update,%black_hole_update;
]]

|black_hole_update| function(a)
    
end $$

|black_hole_init| function(a)
    a:set_timer('fade', 10, function() a:explode(.2) end)
end $$
