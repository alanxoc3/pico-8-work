-- todo: token crunch, use _ENV instead of game here.
|[f_psel_init]| function(game)
    game.p0 = game[game.p0key]
    game.p0.active.turnstarthp = game.p0.active.hp -- for counter

    -- skip this state if the player is a cpu
    if game.p0.iscpu then
        f_select_move(game.p0, f_select_random_move(game.p0.active))
        game:load()
    elseif #game.p0.actions > 0 then
        game:load()
    else
        -- this block is needed so in versus mode, players don't share cursor positions
        -- todo: please token crunch this block somehow
        game.pselactions.menu = game.p0.menu_action
        game.pselmove.menu    = game.p0.menu_move
        game.pselswitch.menu  = game.p0.menu_switch
        game.pstat.menu       = game.p0.menu_stats

        game.cur_action = f_newaction(game.p0, "")
        game.stack[#game.stack] = game.curr -- without this, next trainer's turn might be skipped
        game:push'pselactions'
    end
end $$

|[f_psel_forfeit]| function(game)
    game:pop()

    -- must set game.p0 to the other player, so it shows they win
    game.p0 = f_get_other_pl(game, game.p0)
    game:load'fightover'
end $$
