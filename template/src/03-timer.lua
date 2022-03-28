-- < 152 tokens

-- a timer object is able to keep track of multiple timers. a callback can be
-- optionally called when the timer completes. each "tick" call will increment all
-- timers by 1/60. that means at an FPS of 60, this will be roughly 1 after a
-- second, and 60 after a minute. due to pico-8 constraints, there is a default
-- maximum of a little over 8 hours. at that point, the timer will no longer
-- increment and remain stagnant at the maximum. the maximum might be a good idea
-- if, for example, you want to record the entire gameplay time of a long game.

zclass[[timer|
    timers;             ,;
    set_timer,          %timer_set_timer,
    get_timer,          %timer_get_timer,
    get_timer_percent,  %timer_get_timer_percent,
    delete_timer,       %timer_delete_timer,
    tick,               %timer_tick,
]]

|timer_set_timer| function(a, timer_name, duration, callback)
    -- hard limit of 30000 seconds to prevent overflow, a little over 8 hours
    a.timers[timer_name] = { done=false, t0=time(), t1=time()+(duration or 30000), callback=callback or function() end }
end $$

|timer_get_timer| function(a, timer_name)
    local timer = a.timers[timer_name]
    return timer and (time()-timer.t0)
end $$

|timer_delete_timer| function(a, timer_name)
    a.timers[timer_name] = nil
end $$

|timer_get_timer_percent| function(a, timer_name)
    local timer = a.timers[timer_name]
    return timer and (time()-timer.t0)/timer.t1
end $$

|timer_tick| function(a)
    local finished_timers = {}
    for k, v in pairs(a.timers) do
        if time() >= v.t1 and not v.done then
            v.done = true
            add(finished_timers, v)
        end
    end

    -- need separate loop for the scenario if callback tries to add another timer
    foreach(finished_timers, function(timer)
        timer.callback(a)
    end)
end $$
