zactor[[,actor,killable,timer|
    duration, null,
    next,     null,

    init,         %stateful_load,
    load,         %stateful_load,
    update_state, %stateful_update_state,
]]

|stateful_load| function(a)
    local next = a.next
    if next then
        a.next, a.duration = nil
        for k, v in pairs(a[next]) do a[k] = v end
        if a.duration then
            a:set_timer('state', a.duration, a.load)
        end
    end
end $$

|stateful_update_state| function(a)
    local life_timer = a:get_timer'life'

    if not life_timer then
        life_timer:set_timer'life'
    end

    if a:get_timer'state' == 0 then
        a.init()
    end
    a:update()
end $$

|stateful_draw_state| function(a)
    if a:get_timer'state' > 0 then
        a.init()
    end
    a:update()
end $$

zactor[[,act,stateful|
    init,   nop,
    update, nop,
]]

|stateful_load| function(a)
    local next = a.next
    if next then
        a.next, a.duration = nil
        for k, v in pairs(a[next]) do a[k] = v end
        if a.duration then
            a:create_timer('state', a.duration, a.load)
        end
    end
end
