-- < 144 tokens

-- a timer object is able to keep track of multiple timers. a callback can be
-- optionally called when the timer completes. each "tick" call will increment all
-- timers by 1/60. that means at an FPS of 60, this will be roughly 1 after a
-- second, and 60 after a minute. due to pico-8 constraints, there is a default
-- maximum of a little over 8 hours. at that point, the timer will no longer
-- increment and remain stagnant at the maximum. the maximum might be a good idea
-- if, for example, you want to record the entire gameplay time of a long game.

zobj[[,timer|
    timers,             #,
    set_timer,          %timer_set_timer,
    get_timer,          %timer_get_timer,
    get_timer_percent,  %timer_get_timer_percent,
    delete_timer,       %timer_delete_timer,
    tick,               %timer_tick,
]]

|timer_set_timer| function(a, timer_name, limit, callback)
    -- hard limit of 30000 seconds to prevent overflow, a little over 8 hours
    a.timers[timer_name] = { t=0, max=limit or 30000, callback=callback or function() end }
end $$

|timer_get_timer| function(a, timer_name)
    local timer = a.timers[timer_name]
    return timer and timer.t
end $$

|timer_delete_timer| function(a, timer_name)
    a.timers[timer_name] = nil
end $$

|timer_get_timer_percent| function(a, timer_name)
    local timer = a.timers[timer_name]
    return timer and timer.t/timer.limit
end $$

|timer_tick| function(a)
    local done = {}
    for k, v in pairs(a.timers) do
        local before_t = v.t
        v.t = min(v.limit, v.t+0.016666666666667) -- 1/60 aka 1 frame
        if v.t > before_t and v.t == v.limit then
            add(done, v)
        end
    end

    -- need separate loop for the scenario if callback tries to add another timer
    foreach(done, function(timer)
        timer.callback(a)
    end)
end $$
