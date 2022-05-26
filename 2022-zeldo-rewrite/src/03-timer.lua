-- 167 tokens

-- A timer object is able to keep track of multiple timers. A callback can be
-- optionally called when each timer completes. Due to pico-8 constraints, there
-- is a default maximum duration of a little over 9 hours. 

zclass[[timer|
    timers;             ,;
    start_timer,        %timer_start_timer,
    stop_timer,         %timer_stop_timer,
    play_timer,         %timer_play_timer,

    delete_timer,       %timer_delete_timer,
    get_elapsed,        %timer_get_elapsed,
    get_elapsed_percent,%timer_get_elapsed_percent,
    tick,               %timer_tick,
]]

|[timer_start_timer]| function(...)
    _g.timer_stop_timer(...)
    _g.timer_play_timer(...)
end $$

|[timer_stop_timer]| function(a, timer_name, duration, callback)
    a.timers[timer_name] = { elapsed=false, duration=0+(duration or 32767), callback=callback or function() end }
end $$

|[timer_play_timer]| function(a, timer_name)
    if a.timers[timer_name] and not a.timers[timer_name].elapsed then
        a.timers[timer_name].elapsed = 0
    end
end $$

|[timer_delete_timer]| function(a, timer_name)
    a.timers[timer_name] = nil
end $$

|[timer_get_elapsed]| function(a, timer_name)
    local timer = a.timers[timer_name]
    return timer and (timer.elapsed or false)
end $$

|[timer_get_elapsed_percent]| function(a, timer_name)
    local timer = a.timers[timer_name]
    return timer and (timer.elapsed or 0)/timer.duration
end $$

-- This is expected to be called once per frame (at 60 FPS)!
|[timer_tick]| function(a)
    local finished_timers = {}
    for name, timer in pairs(a.timers) do
        if timer.elapsed and timer.elapsed < timer.duration then
            timer.elapsed = timer.elapsed + 1/60
            if timer.elapsed >= timer.duration then
                add(finished_timers, timer)
            end
        end
    end

    -- need separate loop for the scenario if callback tries to add another timer
    foreach(finished_timers, function(timer)
        timer.callback(a)
    end)
end $$
