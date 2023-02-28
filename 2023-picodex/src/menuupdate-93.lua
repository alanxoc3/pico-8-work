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

-- todo, combine lfunc and rfunc
|[f_browsestat_lfunc]| function(game)
    local stayed = true
    for i=game.browse.menu.c-1,0,-1 do
        if c_pokemon[i].available() then
            game.browse.menu.c = i
            stayed = false
            f_beep_back()
            break
        end
    end

    if stayed then f_beep() end
    f_browsestat_init(game)
end $$

|[f_browsestat_rfunc]| function(game)
    local stayed = true
    for i=game.browse.menu.c+1,151 do
        if c_pokemon[i].available() then
            game.browse.menu.c = i
            stayed = false
            f_beep_back()
            break
        end
    end

    if stayed then f_beep() end
    f_browsestat_init(game)
end $$

|[f_browsestat_xfunc]| function(game)
    f_minisfx(game:cursor'browse')
end $$

|[f_credits_xfunc]| function()
    f_minisfx(f_flr_rnd'152')
end $$

-- only "o" will go back
-- |[f_fightover_update]| function(game)
--     if g_bpo then game:pop() end
-- end $$

-- todo: add xbtn/ybtn
-- todo: browse shouldn't share cursor with edit team
