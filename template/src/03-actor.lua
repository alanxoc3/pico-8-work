-- < 118 tokens

-- an actor is the basic thing in the game. think of an actor in a play. every
-- actor has a few basic roles:
-- * inherited timer functionality
-- * able to die and be 
-- * able to be in different states
-- * able to have a time limit on states if desired
-- * init function when entering a state

zobj[[,actor,timer|
    alive,    yes,
    init,     nop,
    update,   nop,

    duration, null,
    curr,     null,
    next,     null,

    kill,     %actor_kill,
    clean,    %actor_clean,
    load,     %actor_load,
    state,    %actor_state;
]]

|actor_load| function(a, next)
    if next then
        a.next, a.duration = nil
        for k, v in pairs(a[next]) do a[k] = v end
        a.curr = next
    else
        a:kill()
    end

    a:delete_timer'state'
end $$

|actor_state| function(a)
    if not a:get_timer'state' then
        a:set_timer(
            'state',
            a.duration,
            a.duration and function() a:load(a.next) end or function() end
        )

        a:init()
    end

    a:update()
end $$

|actor_kill| function(a) a.alive = nil end $$
|actor_clean| function(a)
    if not a.alive then
        a:destroyed()
        deregister_zobj(a)
    end
end $$
