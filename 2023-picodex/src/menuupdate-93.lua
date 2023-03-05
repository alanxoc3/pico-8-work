-- only "x" will progress the fight. if you spam, at least you don't miss the end screen.
|[f_turn_update]| function(game)
    if g_bpx or not game.cur_action then
        -- check for win condition before selecting every action
        for p in _all{game.p1, game.p2} do
            if not f_get_next_active(p.team) then
                game.p0 = f_get_other_pl(game, p)
                game:load'fightover'
                return
            end
        end

        local action = f_pop_next_action(game)
        if action then
            game.cur_action = action
            local actionpl = game.cur_action.active == game.p1.active and game.p1 or game.p2

            action.logic(actionpl, f_get_other_pl(game, actionpl), game)
        else
            game:load() -- next turn
        end
    end

    if g_bpo then f_beep() end
end $$

-- lr is guaranteed to be -1 or 1
|[f_browsestat_lrfunc]| function(_ENV, lr)
    local stayed = true
    for i=browse.menu.c+lr,75.5+75.5*lr,lr do
        if c_pokemon[i]:available() then
            browse.menu.c = i
            stayed = false
            f_beep_back()
            break
        end
    end

    if stayed then f_beep() end
    f_browsestat_init(_ENV)
end $$

-- lr is guaranteed to be -1 or 1
|[f_pstat_lrfunc]| function(_ENV)
    p0.statplayer = f_get_other_pl(_ENV, p0.statplayer)
    f_beep_back()
    f_pstat_init(_ENV)
end $$

|[f_pstat_xfunc]| function(_ENV)
    f_minisfx(p0.statplayer.active.num)
end $$

|[f_browsestat_xfunc]| function(game)
    f_minisfx(game:cursor'browse')
end $$

|[f_credits_xfunc]| function()
    f_minisfx(f_flr_rnd'152')
end $$

|[f_fightover_xfunc]| function(_ENV)
    f_minisfx(p0.active.num)
end $$
