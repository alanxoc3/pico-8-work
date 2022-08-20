-- an object that has health
zclass[[healthobj|
    max_health, 1,

    hurt,%healthobj_hurt,
    stun,%healthobj_stun,
    health_update,%healthobj_health_update
]]

|[healthobj_hurt]| function(a, amount)
    if not a:is_active'injured' and not a:is_active'injured_cooldown' then
        a:start_timer('injured', .25, function()
            if a.health <= 0 then
                a:kill()
            else
                a:start_timer('injured_cooldown', .25)
            end
        end)
        a.health = max(0, min((a.health or a.max_health)-amount, a.max_health))
    end
end $$

|[healthobj_stun]| function(a, amount)
    if not a:is_active'stunned' and not a:is_active'stunned_cooldown' then
        a:start_timer('stunned', .25, function()
            if a.health <= 0 then
                a:kill()
            else
                a:start_timer('stunned_cooldown', .25)
            end
        end)
    end
end $$

|[healthobj_health_update]| function(a)
    a.health = a.health or a.max_health
    a.display_health = a.display_health or a.health/a.max_health

    local diff = a.health/a.max_health - a.display_health
    a.display_health += zsgn(diff)*min(abs(diff), .05)
end $$
