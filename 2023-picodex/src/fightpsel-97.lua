|[psel_init]| function(game)
    game.p0 = game[game.p0key]

    -- skip this state if the player is a cpu
    if game.p0.iscpu or #game.p0.actions > 0 then
        game:load()
    else
        game.cur_action = newaction(game.p0, "")
        game:push'pselactions'
    end
end $$

|[psel_forfeit]| function(game)
    game:pop()

    -- must set game.p0 to the other player, so it shows they win
    game.p0 = get_other_pl(game, game.p0)
    game:load'fightover'
    -- g_bpx = false
end $$
