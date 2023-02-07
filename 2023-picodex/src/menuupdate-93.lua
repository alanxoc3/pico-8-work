-- only "x" will progress the fight. if you spam, at least you don't miss the end screen.
|[turn_update]| function(game)
    if g_bpx or not game.cur_action then
        -- check for win condition before selecting every action
        for p in all{game.p1, game.p2} do
            if not get_next_active(p.party) then
                game.p0 = get_other_pl(game, p)
                game:load'fightover'
                return
            end
        end

        local action = pop_next_action(game)
        if action then
            game.cur_action = action
            local actionpl = game.cur_action.active == game.p1.active and game.p1 or game.p2

            action.logic(actionpl, get_other_pl(game, actionpl), game)
        else
            game:load() -- next turn
        end
    end

    if g_bpo then _g.beep() end
end $$

-- only "o" will go back
|[fightover_update]| function(game)
    if g_bpo then game:pop() end
end $$

|[browsestat_update]| function(game)
    if g_bpl then
        game.browse.menu:set'-1'
        game:load'browsestat'
    end

    if g_bpr then
        game.browse.menu:set'1'
        game:load'browsestat'
    end

    _g.modes_default_update(game)
end $$
