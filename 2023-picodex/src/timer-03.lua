-- 167 tokens

-- A o_timer object is able to keep track of multiple timers. A callback can be
-- optionally called when each o_timer completes. Due to pico-8 constraints, there
-- is a default maximum duration of a little over 9 hours. 

-- I want to have a o_timer that 
-- Timer that lasts forever is wanted.
-- Timer that lasts one step (keep starting the o_timer to continue it).

-- if elapsed > duration (def done)
-- if elapsed == duration (done)
-- if elapsed & duration == 0 (umm) duration could be false

-- duration 0 could mean forever or 1 step.
-- something ridiculously small could also mean 1 step.

-- callback when o_timer is complete
-- no callback for forever timers
-- there can be a callback, but it can be a f_nop if you really want nothing done...
-- unless you want to manually trigger the o_timer to end
-- so is duration = 0 == 1 step or is it forever or is it non existant
-- hmm... 

-- if you need something forever, no point in using a o_timer, or just keep restarting your o_timer.

-- so duration of 0 is one step. the callback will be called as soon as it is executed. and the o_timer is considered "active" for that step.
-- and percent is considered 1 for and after that step. maybe...

-- nil duration = forever
-- 0 duration = 1 step
-- > 0 duration = blah

f_zclass[[o_timer|
    timers;             ,;
    start_timer,        %f_timer_reset_timer,
    end_timer,          %f_timer_end_timer,

    is_active,          %f_timer_is_active,
    get_elapsed_percent,%f_timer_get_elapsed_percent,
    tick,               %f_timer_tick,
]]

|[f_timer_reset_timer]| function(a, timer_name, duration, callback)
    a.timers[timer_name] = { active=true, elapsed=false, duration=duration and 0+duration, callback=callback or function() end }
end $$

|[f_timer_end_timer]| function(a, timer_name)
    if a.timers[timer_name] then
        a.timers[timer_name].elapsed = a.timers[timer_name].duration or a.timers[timer_name].elapsed
        a.timers[timer_name].active = false
    end
end $$

|[f_timer_get_elapsed_percent]| function(a, timer_name)
    local o_timer = a.timers[timer_name]
    if not o_timer then return 0
    elseif not o_timer.duration then return 0
    elseif o_timer.duration <= 0 then return 1
    end

    return _min(1, (o_timer.elapsed or 0)/o_timer.duration)
end $$

-- true means active. false means inactive. nil means doesn't exist.
|[f_timer_is_active]| function(a, timer_name)
    local o_timer = a.timers[timer_name]
    return o_timer and o_timer.active
end $$

-- This is expected to be called once per frame (at 60 FPS)!
|[f_timer_tick]| function(a)
    local finished_timers = {}
    for name, o_timer in _pairs(a.timers) do
        if o_timer.active then
            if o_timer.elapsed then
                o_timer.elapsed = o_timer.elapsed + 1/60
                if o_timer.duration and o_timer.elapsed >= o_timer.duration then
                    _add(finished_timers, o_timer)
                end
            elseif not o_timer.elapsed then
                o_timer.elapsed = 0
            end
        end
    end

    -- need separate loop for the scenario if callback tries to _add another o_timer
    _foreach(finished_timers, function(o_timer)
        o_timer.active = false
        o_timer.callback(a)
    end)
end $$
