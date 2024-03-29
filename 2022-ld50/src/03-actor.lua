-- 112 tokens

-- an actor is the basic thing in the game. think of an actor in a play. every
-- actor has a few basic roles:
-- * inherited timer functionality
-- * able to die and be in different states
-- * able to have a time limit on states if desired
-- * init function when entering a state

zclass[[actor,timer|
    load,     %actor_load,
    state,    %actor_state,
    kill,     %actor_kill,
    clean,    %actor_clean,

    alive,    yes,
    duration, null,
    curr,     start,
    next,     null,

    init,      nop,
    update,    nop,
    destroyed, nop,
    deregistered, %actor_deregistered;
]]

-- Load the given state into the actor, by applying the properties of the sub-object
-- (at key=stateName) to the actor object. (If the given stateName is falsey, kill
-- the actor.) Then set up the next state change to happen after the actor's duration,
-- using stateName=actor.next.
|[actor_load]| function(a, stateName)
    if stateName then
        a.next, a.duration = nil -- default values, unless overridden by next line
        for k, v in pairs(a[stateName]) do a[k] = v end
        a.curr = stateName
        a:stop_timer('state', a.duration, a.duration and function() a:load(a.next) end)
    else
        a:kill()
    end
end $$

-- This is expected to be called on each frame!
|[actor_state]| function(a)
    if a:get_elapsed'state' == nil   then a:load(a.curr) end -- actor created this frame
    if a:get_elapsed'state' == false then a:play_timer'state' a:init() end -- state changed in this frame
    a:update() -- per-frame update
end $$

-- Stage this actor to be removed at the beginning of the next frame.
|[actor_kill]| function(a) a.alive = nil end $$

-- This is expected to be called at the beginning of each frame!
-- If this is not called at the beginning, you could have a frame delay for things like explosions.
|[actor_clean]| function(a) if not a.alive then deregister_entity(a) end end $$

-- Called when deregistered. See zclass for more information.
|[actor_deregistered]| function(a) a:kill() a:destroyed() end $$
