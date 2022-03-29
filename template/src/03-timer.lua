-- < 152 tokens

-- A timer object is able to keep track of multiple timers. a callback can be
-- optionally called when each timer completes. Due to pico-8 constraints, there
-- is a default maximum of a little over 9 hours. At that point, the global time()
-- will overflow to a negative number, and timers will cease to work as expected.

zclass[[timer|
    timers;             ,;
    set_timer,          %timer_set_timer,
    delete_timer,       %timer_delete_timer,
    get_elapsed,        %timer_get_elapsed,
    get_elapsed_percent,%timer_get_elapsed_percent,
    tick,               %timer_tick,
]]

|timer_set_timer| function(a, timer_name, duration, callback)
    -- Note: Should use 0 < duration < 32767 (measured in sec; about 9.1 hrs).
    -- Since we rely on the global time(), expect the game to come to a screeching conclusion after 9.1 hrs.
    a.timers[timer_name] = { done=false, start=time(), duration=duration or 32767, callback=callback or function() end }
end $$

|timer_delete_timer| function(a, timer_name)
    a.timers[timer_name] = nil
end $$

|timer_get_elapsed| function(a, timer_name)
    local timer = a.timers[timer_name]
    return timer and (time()-timer.start)
end $$

|timer_get_elapsed_percent| function(a, timer_name)
    local timer = a.timers[timer_name]
    return timer and (time()-timer.start)/timer.duration
end $$

|timer_tick| function(a)
    local finished_timers = {}
    for name, timer in pairs(a.timers) do
        if not timer.done and time()-timer.duration >= timer.start then
            timer.done = true
            add(finished_timers, timer)
        end
    end

    -- need separate loop for the scenario if callback tries to add another timer
    foreach(finished_timers, function(timer)
        timer.callback(a)
    end)
end $$
