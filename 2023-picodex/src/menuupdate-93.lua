-- only "x" will progress the fight. if you spam, at least you don't miss the end screen.
|[turn_update]| function(game)
    if g_bpx or not game.cur_action then
        -- check for win condition before selecting every action
        for p in _all{game.p1, game.p2} do
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

    if g_bpo then beep() end
end $$

-- only "o" will go back
-- |[fightover_update]| function(game)
--     if g_bpo then game:pop() end
-- end $$

|[browsestat_update]| function(game)
    if g_bpl then
        game.browse.menu:set'-1'
        browsestat_init(game)
    end

    if g_bpr then
        game.browse.menu:set'1'
        browsestat_init(game)
    end

    modes_default_update(game)
end $$

-- todo: maybe incorporate with "next pokemon" function
-- todo: _add xbtn/ybtn
|[partystat_update]| function(game)
    if g_bpl then
        local team = get_party(game:cursor'team1')

        for i=game.editparty.menu.c-1,0,-1 do
            if team[i+1] then
                game.editparty.menu.c = i
                break
            end
        end
        
        partystat_init(game)
    end

    if g_bpr then
        local team = get_party(game:cursor'team1')

        for i=game.editparty.menu.c+1,5,1 do
            if team[i+1] then
                game.editparty.menu.c = i
                break
            end
        end
        
        partystat_init(game)
    end

    modes_default_update(game)
end $$
