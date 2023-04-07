|[f_psel_init]| function(_ENV)
    p0 = _ENV[p0key]
    do local _ENV=p0.active
        counterdmg, flinching = 0, false -- for counter, and so you can't flinch the next turn
    end

    p0.turnover = false

    -- skip this state if the player is a cpu
    if p0.iscpu then
        -- this is the computer's AI. it just selects a random move.
        local possible_moves = f_get_possible_moves(p0.active)
        f_select_move(p0, possible_moves[f_flr_rnd(#possible_moves)+1] or f_create_move(M_STRUGGLE))
        _ENV:f_actor_load()
    elseif #p0.actions > 0 then
        _ENV:f_actor_load()
    else
        pselactions.menu,
        pselmove.menu,
        pselswitch.menu,
        cur_action,
        stack[#stack] = p0.menu_action,
                        p0.menu_move,
                        p0.menu_switch,
                        f_newaction(p0, "|begins|turn"),
                        curr

        _ENV:f_actor_load'turnview'
    end
end $$

|[f_psel_update]| function(_ENV)
    if g_bpx then
        _ENV:f_modes_push'pselactions'
        f_minisfx'B_OKAY'
    end

    if g_bpo then f_beep() end
end $$

|[f_psel_forfeit]| function(_ENV)
    _ENV:f_modes_pop()

    -- must set game.p0 to the other player, so it shows they win
    pwin = _ENV:f_get_other_pl(p0)
    _ENV:f_actor_load'fightover'
end $$
