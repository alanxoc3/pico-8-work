|[f_zclass]| function(template)
    return f_zobj_set(f_zobj[[
        load,      %f_actor_load,
        loadlogic, %f_actor_loadlogic,
        state,     %f_actor_state,
        get_elapsed_percent,%f_actor_get_elapsed_percent,

        timer, 0,

        isnew, %c_yes,
        curr,  start,

        init,   %f_nop,
        update, %f_nop;
    ]], template)
end $$

|[f_actor_get_elapsed_percent]| function(_ENV, key)
    if key == curr then
        return duration and timer/duration or 0
    end
    
    if _ENV[key] and _ENV[key].done then
        return 1
    end

    return 0
end $$

|[f_actor_load]| function(_ENV, stateName)
    next_state = stateName or next
end $$

|[f_actor_loadlogic]| function(_ENV, stateName)
    timer, next_state, isnew, next, duration = 0

    _ENV[curr].done = true
    for k, v in _pairs(defaults) do _ENV[k] = v end
    for k, v in _pairs(_ENV[stateName]) do _ENV[k] = v end

    curr = stateName

    _ENV:init()
end $$

|[f_actor_state]| function(_ENV)
    timer += 1/60

    if isnew then _ENV:loadlogic(curr) end

    if duration and timer >= duration then
        _ENV:load()
    end

    while next_state do
        _ENV:loadlogic(next_state)
    end

    _ENV:update()
end $$
