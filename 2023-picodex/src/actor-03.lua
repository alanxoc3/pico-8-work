-- 112 tokens

-- an actor is the basic thing in the game. think of an actor in a play. every
-- actor has a few basic roles:
-- * inherited timer functionality
-- * able to die and be in different states
-- * able to have a time limit on states if desired
-- * init function when entering a state

zclass[[actor,timer|
    load,     %actor_load,
    loadlogic,%actor_loadlogic,
    state,    %actor_state,
    kill,     %actor_kill,
    clean,    %actor_clean,
    is_alive, %actor_is_alive,

    alive,    yes,
    duration, null,
    curr,     start,
    next,     null,
    isnew,    yes,

    init,      nop,
    finit,     nop,
    stateless_update,    nop,
    update,    nop,
    destroyed, nop;
]]

-- if load is called multiple times, the first load is used.
|[actor_load]| function(a, stateName)
    a.next_state = stateName or a.next
end $$

-- Load the given state into the actor, by applying the properties of the sub-object
-- (at key=stateName) to the actor object. (If the given stateName is falsey, kill
-- the actor.) Then set up the next state change to happen after the actor's duration,
-- using stateName=actor.next.
|[actor_loadlogic]| function(a, stateName)
    a.next_state, a.isnew = nil

    if stateName == 'dead' then
        a.alive = false
    else
        a:finit()
        a:end_timer(a.curr)

        a.next, a.duration = nil -- default values, unless overridden by next line
        for k, v in _pairs(a.defaults) do a[k] = v end
        for k, v in _pairs(a[stateName]) do a[k] = v end
        a.curr = stateName
        a:start_timer(a.curr, a.duration, a.duration and function() a:load(a.next or 'dead') end)

        a:init()
    end
end $$

-- This is expected to be called on each frame!
|[actor_state]| function(a)
    -- actor created this frame
    if a.isnew then a:loadlogic(a.curr) end

    -- will keep calling init/finit until next_state is stable
    -- this means an infinite loop is technically possible if states are misconfigured
    -- but it also makes it so you can skip a state from running one framme if you want
    while a.next_state do
        a:loadlogic(a.next_state)
    end

    -- per-frame update
    a:update()
    a:stateless_update()
end $$

|[actor_is_alive]| function(a)
    return not a.effectively_dead and a:is_active'ending' == nil and a.alive
end $$

-- If there is an ending state, call that. Otherwise, just set alive to false.
|[actor_kill]| function(a)
    a.effectively_dead = true
    if a.ending then
        if a.curr == 'start' then
            a.next = 'ending'
        elseif a:is_active'ending' == nil then
            a:load'ending'
        end
    else
        a.alive = nil
    end
end $$

-- This is expected to be called at the beginning of each frame!
-- If this is not called at the beginning, you could have a frame delay for things like explosions.
|[actor_clean]| function(a) if not a.alive then a:destroyed() deregister_entity(a) end end $$
