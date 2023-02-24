|[f_fightover_init]| function(_ENV)
    local winner, loser = p0, f_get_other_pl(_ENV, p0)
    winner:winlogic(loser)

    -- getting out of the win screen should take you to the main menu
    stack = {stack[1]}
    menu:refresh{}

    _add(menu, {pkmn=winner.active.shared.num})
    _add(menu, {hidden=true})

    _add(menu, {name="winner", style=3})
    _add(menu, {name=winner.name})
    _add(menu, {name="6/6"})

    _add(menu, {pkmn=loser.active.shared.num})
    _add(menu, {hidden=true})

    _add(menu, {name="loser", style=3})
    _add(menu, {name=loser.name})
    _add(menu, {name="pkm 6/6"})

end $$

|[f_main_init]| function(_ENV)
    menu:refresh(
        f_zobj[[
            ;name,"browse",  state,browse,     select,%f_menu_state_callback, desc,".browse|"
           ;;name,"edit",    state,team1,      select,%f_menu_state_callback, desc,".edit|stored|teams"
           ;;name,"league",  state,team1story, select,%f_menu_state_callback, desc,".league|"
           ;;name,"player",state,team1match, select,%f_menu_state_callback, desc,".player|custom|battles"
           ;;name,"horde",   state,team1horde, select,%f_menu_state_callback, desc,".horde|"
           ;;name,"credits", state,credits,    select,%f_menu_state_callback, desc,".credits|amorg|games"
        ]]
    )

    menu[1].desc ..= #g_available_pokemon.."/151|pokemon"
    menu[3].desc ..= (@S_STORY).."/40|trainers"
    menu[5].desc ..= (@S_HOARD).."/151|pokemon"

--    menu[4].name ..= 
--    menu[5].name ..= @S_STORY
--    menu[6].name ..= @S_HOARD

end $$

|[f_browse_init]| function(_ENV)
    menu:refresh(
        g_available_pokemon,
        function(num) return {select=function(_ENV) _ENV:push'browsestat' end, num=num} end
    )
end $$

|[f_browsestat_init]| function(_ENV)
    f_update_stat_menu(menu, f_get_browse_pokemon(_ENV:cursor'browse'+1))
end $$

|[f_partystat_init]| function(_ENV)
    local team = f_get_party(_ENV:cursor'team1')
    local partypkmn = team[_ENV:cursor'editparty'+1]
    f_update_stat_menu(menu, c_pokemon[partypkmn.num])
end $$

|[f_credits_init]| function(_ENV)
    menu:refresh(
        _split"106,,!alanxoc3,code,design,6,,!gr8cadet,graphics,sound,129,,!wadlo,magikarp,gyarados,123,,!snippets,zep px9,mot smap,137,,!pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
        function(txt)
            if _type(txt) == "number" then
                return { pkmn=txt }
            end

            local style = 1
            if _sub(txt,1,1) == '!' then
                txt, style = _sub(txt,2), 5
            end

            return { name=txt, style=style, hidden=txt=='' }
        end
    )
end $$

|[f_unlock_pkmn]| function(trainer)
    -- add pokemon defeated to picodex
    foreach(trainer.deadnums, function(num)
        _poke(S_POKEMON+num, 1)
    end)
end $$

-- todo: make it so player 1 and player 2 don't share the same cursor in match mode.
|[f_fightsel_init]| function(_ENV)
    menu:refresh(c_trainers, function(trainer, num)
        local disabled, team = num-1 > @S_STORY, {}
        for i=1,6 do team[i] = trainer[i+1] end

        return {
            name=trainer[1],
            team=team,
            disabled=disabled,
            select=function(game, entry)
                local cpu_party_draft = {}
                for i=1,6 do
                    local num = entry.team[i]
                    if num then
                        _add(cpu_party_draft, { num=num, moves=f_get_natural_moveset(num) })
                    end
                end

                -- |[f_begin_fight]| function(game, party1, party2, name1, name2, iscpu1, iscpu2, p1_die_logic, p2_die_logic, p1_win_logic, p2_win_logic)
                f_begin_fight(game,
                    f_get_party(game:cursor'team1'), cpu_party_draft,
                    "player 1", entry.name,
                    false, true,
                    f_nop, f_nop,
                    function(pl, other)
                        poke(S_STORY, mid(@S_STORY, num, #c_trainers))
                        f_unlock_pkmn(other)
                    end, f_nop)
            end
        }
    end)
end $$

|[f_partyaction_init]| function(_ENV)
    menu:refresh(f_zobj[[
        ; name,"info",   state,partystat,  select,%f_menu_state_callback, -- use browse pokemon selector
       ;; name,"moves",  state,partymoves, select,%f_menu_state_callback  -- use the menu system
       ;; name,"delete",                   select,%f_partydel             -- use the edit team screen
    ]])

    partymovesel.menu.c = 0
end $$

|[f_partypkmn_init]| function(_ENV)
    menu:refresh(
        g_available_pokemon,
        function(num)
            return {
                select=function(_ENV)
                    f_save_party(_ENV:cursor'team1', f_set_default_party_pkmn(f_get_party(_ENV:cursor'team1'), _ENV:cursor'editparty'+1, g_available_pokemon[_ENV:cursor'browse'+1]))
                    _ENV:pop()
                end,
                num=num
            }
        end
    )
end $$

|[f_partymoves_init]| function(_ENV)
    local team = f_get_party(_ENV:cursor'team1')
    local partypkmn = team[_ENV:cursor'editparty'+1]

    menu:refresh(f_zobj[[,1,2,3,4]], function(i)
        return {
            num=partypkmn.moves[i],
            name=partypkmn.moves[i] and c_moves[partypkmn.moves[i]].name or "???",
            select=function(_ENV) _ENV:push'partymovesel' end
        }
    end)
end $$

|[f_partymovesel_init]| function(_ENV)
    local team = f_get_party(_ENV:cursor'team1')
    local partypkmn = team[_ENV:cursor'editparty'+1]
    local pkmn = c_pokemon[partypkmn.num]

    local moves = {}
    local add_to_moves = function(movelist, prefix)
        for i=1,#movelist do
            _add(moves, {name=c_moves[movelist[i]].name, num=movelist[i], desc=prefix or c_moves[movelist[i]].ref or "error"})
        end
    end

    add_to_moves(pkmn.moves_natural, "learn")
    add_to_moves(pkmn.moves_tm)
    add_to_moves(pkmn.moves_event, "event")

    menu:refresh(moves, function(m)
        return {
            name=m.name,
            disabled=m.disabled,
            num=m.num,
            ref=m.desc,
            select=function()
                f_save_party(_ENV:cursor'team1', f_set_party_pkmn_move(f_get_party(_ENV:cursor'team1'), _ENV:cursor'editparty'+1, _ENV:cursor'partymoves'+1, m.num))
                _ENV:pop()
            end
        }
    end)
end $$

-- todo: support struggle
|[f_pselmove_init]|   function(_ENV)
    menu:refresh(f_get_possible_move_slots(p0.active), function(move_slot)
        local move = c_moves[p0.active.moveids[move_slot]]
        return {
            name=move.name,
            num=move.num,
            select=function()
                _ENV:pop() _ENV:pop()
                f_select_move(p0, move_slot)
            end
        }
    end)
end $$

-- todo: make switch work
|[f_pselactions_init]| function(_ENV)
    menu:refresh(f_zobj[[
         ; name,"fight",   desc,"select|next|move",      select,%f_menu_state_callback, state,pselmove
        ;; name,"random",  desc,"select|random|move",    select,%f_menu_cancel -- random logic is in the turn logic if move is empty, so just leave the menu
        ;; name,"switch",  desc,"change|active|pokemon", select,%f_menu_state_callback, state,pselswitch
        ;; name,"forfeit", desc,"leave|the|fight",       select,%f_psel_forfeit
    ]])
end $$

|[f_party_init]| function(_ENV)
    menu:refresh(f_zobj[[,1,2,3]], function(i)
        local team = f_get_party(i-1)
        local newteam = {}
        local is_disabled = true

        for i=1,6 do
            if team[i] then newteam[i] = team[i].num is_disabled = false end
        end

        return {
            name="team #"..i,
            team=newteam,
            select=function() _ENV:select_func() end,
            disabled=disable_empty_party and is_disabled
        }
    end)
end $$

-- this is used both in "editparty" and selecting a pkmn in battle.
|[f_editparty_init]| function(_ENV)
    local team = f_get_party(_ENV:cursor'team1')
    menu:refresh(f_zobj[[,1,2,3,4,5,6]], function(i)
        return {
            select=function(_ENV)
                if team[_ENV:cursor'editparty'+1] then
                    _ENV:push'partyaction'
                else
                    _ENV:push'partypkmn'
                end
            end,
            num=team[i] and team[i].num or -1
        }
    end)
end $$

-- this is used both in "editparty" and selecting a pkmn in battle.
-- todo: if a pokemon is dead, just draw a black shadow.
|[f_pselswitch_init]| function(_ENV)
    local team = f_get_party(_ENV:cursor'team1')
    menu:refresh(f_zobj[[,1,2,3,4,5,6]], function(i)
        local disabled = not p0.party[i] or p0.party[i].major == C_MAJOR_FAINTED
        return {
            select=disabled and f_beep or function()
                _ENV:pop() _ENV:pop()
                f_select_move(p0, i, true)
            end,
            num=p0.party[i] and p0.party[i].num or -1
        }
    end)
end $$

|[f_turn_init]| function(_ENV)
    -- if there is no action, assume it's a computer player.
    for p in _all{p1, p2} do
        if #p.actions == 0 then
            f_select_move(p, f_select_random_move_slot(p.active))
        end
    end

    -- p0 is equal to the higher priority
    local p1, p2 = p1, p2
    if p1.priority == p2.priority then p2.priority += _sgn(_rnd'2'-1) end
    p0 = p1.priority > p2.priority and p1 or p2
end $$
