zactor[[,timer|
    timers,            #,
    set_time,          %timer_set_time,
    get_time,          %timer_get_time,
    get_time_percent,  %timer_get_time_percent,
    tick,              %timer_tick,
]]

|timer_set_time| function(a, timer_name, limit, callback)
    a.timers[timer_name] = { t=nil, limit=limit, callback=(callback or nop) }
end $$

|timer_get_time| function(a, timer_name)
    local timer = a.timers[timer_name]
    return timer and timer.t
end $$

|timer_get_time_percent| function(a, timer_name)
    local timer = a.timers[timer_name]
    return timer.t and timer.limit and timer.t/timer.limit
end $$

|timer_tick| function(a)
    local keys_to_remove = {}
    for k, v in pairs(a.timers) do
        if v.t then
            v.t += 0.016666666666667 -- 1/60 aka 1 frame
        else
            v.t = 0
        end

        if v.limit then
            v.t = min(v.limit, v.t)
            if v.t == v.limit then
                add(keys_to_remove, k)
            end
        end
    end

    foreach(keys_to_remove, function(k)
        local v = a.timers[k]
        a.timers[k] = nil
        v.callback(a)
    end)
end $$
