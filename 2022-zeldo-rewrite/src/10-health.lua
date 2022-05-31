-- an object that has health
zclass[[healthobj|
    max_health, 1,

    hurt,%healthobj_hurt,
    health_update,%healthobj_health_update
]]

|[healthobj_hurt]| function(a, amount)
    a.health = max(0, min((a.health or a.max_health)-amount, a.max_health))
end $$

|[healthobj_health_update]| function(a)
    a.health = a.health or a.max_health
    a.display_health = a.display_health or a.health/a.max_health

    local diff = a.health/a.max_health - a.display_health
    a.display_health += zsgn(diff)*min(abs(diff), .05)

    if a.health <= 0 then a:kill() end
end $$
