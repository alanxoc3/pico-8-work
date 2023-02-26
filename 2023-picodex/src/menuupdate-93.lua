-- only "x" will progress the fight. if you spam, at least you don't miss the end screen.
|[f_turn_update]| function(game)
    if g_bpx or not game.cur_action then
        -- check for win condition before selecting every action
        for p in _all{game.p1, game.p2} do
            if not f_get_next_active(p.party) then
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

-- only "o" will go back
-- |[f_fightover_update]| function(game)
--     if g_bpo then game:pop() end
-- end $$

-- todo: add xbtn/ybtn
-- todo: browse shouldn't share cursor with edit party
