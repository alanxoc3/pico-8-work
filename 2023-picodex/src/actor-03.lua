-- 112 tokens

-- an o_actor is the basic thing in the game. think of an o_actor in a play. every
-- o_actor has a few basic roles:
-- * inherited o_timer functionality
-- * able to die and be in different states
-- * able to have a time limit on states if desired
-- * init function when entering a state

f_zclass[[o_actor,o_timer|
    load,     %f_actor_load,
    loadlogic,%f_actor_loadlogic,
    state,    %f_actor_state,
    kill,     %f_actor_kill,
    clean,    %f_actor_clean,
    is_alive, %f_actor_is_alive,

    alive,    yes,
    duration, null,
    curr,     start,
    next,     null,
    isnew,    yes,

    init,      %f_nop,
    finit,     %f_nop,
    stateless_update,    %f_nop,
    update,    %f_nop,
    destroyed, %f_nop;
]]

-- if load is called multiple times, the first load is used.
|[f_actor_load]| function(_ENV, stateName)
    next_state = stateName or next
end $$

-- Load the given state into the o_actor, by applying the properties of the sub-object
-- (at key=stateName) to the o_actor object. (If the given stateName is falsey, kill
-- the o_actor.) Then set up the next state change to happen after the o_actor's duration,
-- using stateName=o_actor.next.
|[f_actor_loadlogic]| function(_ENV, stateName)
    next_state, isnew = nil

    if stateName == 'dead' then
        alive = false
    else
        _ENV:finit()
        _ENV:end_timer(curr)

        next, duration = nil -- default values, unless overridden by next line
        for k, v in _pairs(defaults) do _ENV[k] = v end
        for k, v in _pairs(_ENV[stateName]) do _ENV[k] = v end
        curr = stateName
        _ENV:start_timer(curr, duration, duration and function() _ENV:load(next or 'dead') end)

        _ENV:init()
    end
end $$

-- This is expected to be called on each frame!
|[f_actor_state]| function(_ENV)
    -- o_actor created this frame
    if isnew then _ENV:loadlogic(curr) end

    -- will keep calling init/finit until next_state is stable
    -- this means an infinite loop is technically possible if states are misconfigured
    -- but it also makes it so you can skip a state from running one framme if you want
    while next_state do
        _ENV:loadlogic(next_state)
    end

    -- per-frame update
    _ENV:update()
    _ENV:stateless_update()
end $$

|[f_actor_is_alive]| function(_ENV)
    return not effectively_dead and _ENV:is_active'ending' == nil and alive
end $$

-- If there is an ending state, call that. Otherwise, just set alive to false.
|[f_actor_kill]| function(_ENV)
    effectively_dead = true
    if ending then
        if curr == 'start' then
            next = 'ending'
        elseif _ENV:is_active'ending' == nil then
            _ENV:load'ending'
        end
    else
        alive = nil
    end
end $$

-- This is expected to be called at the beginning of each frame!
-- If this is not called at the beginning, you could have a frame delay for things like explosions.
|[f_actor_clean]| function(_ENV)
    if not alive then
        _ENV:destroyed()
        f_deregister_entity(_ENV)
    end
end $$
