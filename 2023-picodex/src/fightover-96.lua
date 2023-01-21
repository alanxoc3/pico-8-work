|[fightover_init]| function(game) game.p0.winlogic() end $$

|[fightover_update]| function(game)
    if g_bpo or g_bpx then
        game:pop()
    end
end $$

|[fightover_draw1]|  function(game) print("todo", 5, 5, 1) end $$
|[fightover_draw2]|  function(game) zprint("match over", 23, 4, 1, 0) end $$
|[fightover_draw3]|  function(game) print_draw3_message(game.p0.name, "is the", "winner") end $$
