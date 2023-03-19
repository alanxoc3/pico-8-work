|[f_zclass]| function(template)
    return f_zobj_set(f_zobj[[
        load,      %f_actor_load,
        loadlogic, %f_actor_loadlogic,
        state,     %f_actor_state,
        get_elapsed_percent,%f_actor_get_elapsed_percent,

        timer, 0,
        stacksize, 0, -- need a separate var for stack size for so buttons don't jitter on ui

        isnew, %c_yes,
        curr,  start,

        init,   %f_nop,
        update, %f_nop;

        stack;,;
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
    stacksize = #stack
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

|[f_modes_popuntil]| function(_ENV, untilstate)
    while next_state ~= untilstate and #stack > 0 do
        _ENV:pop()
    end
end $$

|[f_modes_pop]| function(_ENV)
    -- delete the last item on the stack, then load the new last item.
    -- most modes on the stack won't have an init in this game.
    _deli(stack) 
    _ENV:load(stack[#stack] or 'main')
end $$

|[f_modes_push]| function(_ENV, newstate)
    _add(stack, newstate)
    _ENV:f_actor_load(newstate)
end $$
