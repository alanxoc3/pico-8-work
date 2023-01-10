|[editparty_update]| function(a)
    local test = {}

    -- temp randomize party
    if g_bx then
        for i=1,6 do add(test, {num=rnd(151)\1+1}) end
        save_party(@S_CUR_PARTY, test)
    end

    if g_bpo then a:pop() end
end $$

|[editparty_draw1]| function(a)
    for i,v in ipairs(get_party(@S_CUR_PARTY)) do
        get_pokemon(v.num).draw(7+(i-1)%3*13, 20+(i-1)\3*13, 13, .625)
    end

    --get_pokemon(get_party(@S_CUR_PARTY)[1].num).draw(7+(1-1)%3*13, 20+(1-1)\3*13, 13, .825)
end $$

|[editparty_draw2]| function(a)

end $$

|[editparty_draw3]| function(a)
    print_draw3_message("editing", "your", "party")
end $$
