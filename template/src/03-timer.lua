-- 167 tokens

-- A timer object is able to keep track of multiple timers. A callback can be
-- optionally called when each timer completes. Due to pico-8 constraints, there
-- is a default maximum duration of a little over 9 hours. 

-- I want to have a timer that 
-- Timer that lasts forever is wanted.
-- Timer that lasts one step (keep starting the timer to continue it).

-- if elapsed > duration (def done)
-- if elapsed == duration (done)
-- if elapsed & duration == 0 (umm) duration could be false

-- duration 0 could mean forever or 1 step.
-- something ridiculously small could also mean 1 step.

-- callback when timer is complete
-- no callback for forever timers
-- there can be a callback, but it can be a nop if you really want nothing done...
-- unless you want to manually trigger the timer to end
-- so is duration = 0 == 1 step or is it forever or is it non existant
-- hmm... 

-- if you need something forever, no point in using a timer, or just keep restarting your timer.

-- so duration of 0 is one step. the callback will be called as soon as it is executed. and the timer is considered "active" for that step.
-- and percent is considered 1 for and after that step. maybe...

-- nil duration = forever
-- 0 duration = 1 step
-- > 0 duration = blah

zclass[[timer|
    timers;             ,;
    start_timer,        %timer_reset_timer,
    end_timer,          %timer_end_timer,

    is_active,          %timer_is_active,
    get_elapsed_percent,%timer_get_elapsed_percent,
    tick,               %timer_tick,
]]

|[timer_reset_timer]| function(a, timer_name, duration, callback)
    printh(duration)
    a.timers[timer_name] = { active=true, elapsed=false, duration=duration and 0+duration, callback=callback or function() end }
end $$

|[timer_end_timer]| function(a, timer_name)
    if a.timers[timer_name] then
        a.timers[timer_name].elapsed = a.timers[timer_name].duration or a.timers[timer_name].elapsed
        a.timers[timer_name].active = false
    end
end $$

|[timer_get_elapsed_percent]| function(a, timer_name)
    local timer = a.timers[timer_name]
    if not timer then return 0
    elseif not timer.duration then return 0
    elseif timer.duration <= 0 then return 1
    end

    return min(1, (timer.elapsed or 0)/timer.duration)
end $$

-- true means active. false means inactive. nil means doesn't exist.
|[timer_is_active]| function(a, timer_name)
    local timer = a.timers[timer_name]
    return timer and timer.active
end $$

-- This is expected to be called once per frame (at 60 FPS)!
|[timer_tick]| function(a)
    local finished_timers = {}
    for name, timer in pairs(a.timers) do
        if timer.active then
            if timer.elapsed then
                timer.elapsed = timer.elapsed + 1/60
                if timer.duration and timer.elapsed >= timer.duration then
                    add(finished_timers, timer)
                end
            elseif not timer.elapsed then
                timer.elapsed = 0
            end
        end
    end

    -- need separate loop for the scenario if callback tries to add another timer
    foreach(finished_timers, function(timer)
        timer.active = false
        timer.callback(a)
    end)
end $$
