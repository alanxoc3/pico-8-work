function filter_out_dead_things(array)
    local new_array = {}
    for a in all(array) do
        if a.alive then
            add(new_array, a)
        end
    end
    return new_array
end
