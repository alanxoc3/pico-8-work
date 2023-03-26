|[f_psel_init]| function(_ENV)
    p0 = _ENV[p0key]
    do local _ENV=p0.active
        counterdmg, flinching = 0, false -- for counter, and so you can't flinch the next turn
    end

    p0.turnover = false

    -- skip this state if the player is a cpu
    if p0.iscpu then
        f_select_move(p0, f_select_random_move(p0.active))
        _ENV:f_actor_load()
    elseif #p0.actions > 0 then
        _ENV:f_actor_load()
    else
        -- this block is needed so in versus mode, players don't share cursor positions
        pselactions.menu,
        pselmove.menu,
        pselswitch.menu,
        cur_action,
        stack[#stack] = p0.menu_action,
                        p0.menu_move,
                        p0.menu_switch,
                        f_newaction(p0, ""),
                        curr -- without this, next trainer's turn might be skipped

        _ENV:f_modes_push'pselactions'
    end
end $$

|[f_psel_forfeit]| function(_ENV)
    _ENV:f_modes_pop()

    -- must set game.p0 to the other player, so it shows they win
    pwin = _ENV:f_get_other_pl(p0)
    _ENV:f_actor_load'fightover'
end $$
