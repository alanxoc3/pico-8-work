|[f_fightover_init]| function(_ENV)
    local winner, loser = p0, f_get_other_pl(_ENV, p0)
    winner:winlogic(loser)

    -- getting out of the win screen should take you to the main menu
    stack = {stack[1]}
    menu:refresh{}

    _add(menu, {pkmn=winner.active.shared.num})
    _add(menu, {hidden=true})

    _add(menu, {name="winner", style=5})
    _add(menu, {name=winner.name})
    _add(menu, {name=#winner.deadnums.." dead"})

    _add(menu, {pkmn=loser.active.shared.num})
    _add(menu, {hidden=true})

    _add(menu, {name="loser", style=5})
    _add(menu, {name=loser.name})
    _add(menu, {name=#loser.deadnums.." dead"})

end $$

|[f_main_init]| function(_ENV)
    menu:refresh(
        f_zobj[[
            ;name,"browse",  state,browse,     select,%f_menu_state_callback, desc,".browse|"
           ;;name,"edit",    state,team1,      select,%f_menu_state_callback, desc,".edit|stored|teams"
           ;;name,"league",  state,team1story, select,%f_menu_state_callback, desc,".league|"
           ;;name,'?????',   state,team1horde, select,%f_menu_state_callback, desc,".?????|beat|league"
           ;;name,"player",  state,team1match, select,%f_menu_state_callback, desc,".player|custom|battles"
           ;;name,"credits", state,credits,    select,%f_menu_state_callback, desc,".credits|amorg|games"
        ]]
    )

    local count = 0
    for i=0,151 do count += c_pokemon[i].available() and 1 or 0 end
    menu[1].desc ..= count.."/151|pokemon"
    menu[3].desc ..= (@S_STORY).."/40|trainers"

    if @S_STORY < 40 then
        menu[4].disabled = true
    else
        menu[4].name = "horde"
        menu[4].desc = ".horde|"..(@S_HOARD).."/151|hi-score"
    end
end $$

|[f_browse_init_shared]| function(_ENV, selectfunc)
    local tbl = {}
    for i=0,151 do
        add(tbl, i)
    end

    menu:refresh(
        tbl,
        function(num)
            return {
                select=selectfunc,
                disabled=not c_pokemon[num].available(),
                num=num
            }
        end
    )
end $$

|[f_browse_init]| function(_ENV)
    f_browse_init_shared(_ENV, function(_ENV)
        _ENV:push'browsestat'
    end)
end $$

|[f_teampkmn_init]| function(_ENV)
    f_browse_init_shared(_ENV, function(_ENV)
        f_save_team(_ENV:cursor'team1', f_set_default_team_pkmn(_ENV:f_get_team_cursor'team1', _ENV:cursor'editteam'+1, _ENV:cursor'browse'))
        _ENV:pop()
    end)
end $$

|[f_browsestat_init]| function(_ENV)
    f_update_stat_menu(menu, c_pokemon[_ENV:cursor'browse'])
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
                local cpu_team_draft = {}
                for i=1,6 do
                    local num = entry.team[i]
                    if num then
                        _add(cpu_team_draft, { num=num, moves=f_get_natural_moveset(num) })
                    end
                end

                -- |[f_begin_fight]| function(game, team1, team2, name1, name2, iscpu1, iscpu2, p1_die_logic, p2_die_logic, p1_win_logic, p2_win_logic)
                f_begin_fight(game,
                    _ENV:f_get_team_cursor'team1', cpu_team_draft,
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

|[f_teamaction_init]| function(_ENV)
    menu:refresh(f_zobj[[
        ; name,"moves",  state,teammoves,  select,%f_menu_state_callback -- use the menu system
       ;; name,"switch", state,switchteam, select,%f_menu_state_callback -- use browse pokemon selector
       ;; name,"delete",                   select,%f_teamdel            -- use the edit team screen
    ]])

    teammovesel.menu.c = 0
end $$

|[f_moveaction_init]| function(_ENV)
    -- todo: maybe combine this with a func that gets rid of c_empty slots, then you just check len
    local team = _ENV:f_get_team_cursor'team1'
    local teampkmn = team[_ENV:cursor'editteam'+1]
    local count = 0 
    for j=1,4 do
        if teampkmn.moves[j] then count += 1 end
    end

    menu:refresh(f_zobj([[
        ; name,"change", state,teammovesel, select,%f_menu_state_callback
       ;; name,"switch", state,switchmoves, select,%f_menu_state_callback
       ;; name,"delete", disabled,@,        select,%f_movedel
    ]], count == 1))
end $$

-- todo: fix move an draw3, shouldn't always be question marks
-- todo: fix pop, sd only pop to moves, not before
-- todo: last del should be disabled
|[f_movedel]| function(_ENV)
    local team = _ENV:f_get_team_cursor'team1'
    local teampkmn = team[_ENV:cursor'editteam'+1]
    teampkmn.moves[_ENV:cursor'teammoves'+1] = nil
    f_save_team(_ENV:cursor'team1', team)
    _ENV:pop()
end $$

|[f_teammoves_init]| function(_ENV)
    local team = _ENV:f_get_team_cursor'team1'
    local teampkmn = team[_ENV:cursor'editteam'+1] or {moves={}}

    menu:refresh(f_zobj[[,1,2,3,4]], function(i)
        return {
            num=teampkmn.moves[i],
            name=teampkmn.moves[i] and c_moves[teampkmn.moves[i]].name or "???",
            select=function(_ENV) _ENV:push(teampkmn.moves[i] and 'moveaction' or 'teammovesel') end
        }
    end)
end $$

-- todo: merge logic with f_teammoves_init
|[f_switchmoves_init]| function(_ENV)
    local team = _ENV:f_get_team_cursor'team1'
    local teampkmn = team[_ENV:cursor'editteam'+1] or {moves={}}
    local disabled_ind = _ENV:cursor'teammoves'+1

    menu:refresh(f_zobj[[,1,2,3,4]], function(i)
        return {
            num=teampkmn.moves[i],
            name=teampkmn.moves[i] and c_moves[teampkmn.moves[i]].name or "???",
            select=function(_ENV)
                teampkmn.moves[i], teampkmn.moves[disabled_ind] = teampkmn.moves[disabled_ind], teampkmn.moves[i]
                f_save_team(_ENV:cursor'team1', team)
                _ENV:popuntil'teammoves'
            end,
            disabled=i == disabled_ind
        }
    end)

    menu.c = teammoves.menu.c
end $$

|[f_teammovesel_init]| function(_ENV)
    local team = _ENV:f_get_team_cursor'team1'
    local teampkmn = team[_ENV:cursor'editteam'+1]
    local pkmn = c_pokemon[teampkmn.num]

    local moves = {}
    local add_to_moves = function(movelist, prefix)
        for i=1,#movelist do
            local disabled = false
            for j=1,4 do
                if teampkmn.moves[j] == movelist[i] then
                    disabled = true
                end
            end
            _add(moves, {name=c_moves[movelist[i]].name, disabled=disabled, num=movelist[i], desc=prefix..i})
        end
    end

    add_to_moves(pkmn.moves_natural, "learn #")
    add_to_moves(pkmn.moves_teach,   "teach #")
    add_to_moves(pkmn.moves_event,   "event #")

    menu:refresh(moves, function(m)
        return {
            name=m.name,
            disabled=m.disabled,
            num=m.num,
            ref=m.desc,
            select=function()
                f_save_team(_ENV:cursor'team1', f_set_team_pkmn_move(_ENV:f_get_team_cursor'team1', _ENV:cursor'editteam'+1, _ENV:cursor'teammoves'+1, m.num))
                _ENV:popuntil'teammoves'
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

|[f_pselactions_init]| function(_ENV)
    menu:refresh(f_zobj[[
         ; name,"fight",   desc,"select|next|move",      select,%f_menu_state_callback, state,pselmove
        ;; name,"random",  desc,"select|random|move",    select,%f_menu_cancel -- random logic is in the turn logic if move is c_empty, so just leave the menu
        ;; name,"switch",  desc,"change|active|pokemon", select,%f_menu_state_callback, state,pselswitch
        ;; name,"forfeit", desc,"leave|the|fight",       select,%f_psel_forfeit
    ]])
end $$

|[f_team_init]| function(_ENV)
    menu:refresh(f_zobj[[,1,2,3]], function(i)
        local team = f_get_team(i-1)
        local newteam = {}
        local is_disabled = true

        for i=1,6 do
            if team[i] then newteam[i] = team[i].num is_disabled = false end
        end

        return {
            name="team #"..i,
            team=newteam,
            select=function() _ENV:select_func() end,
            disabled=disable_empty_team and is_disabled
        }
    end)
end $$

-- this is used both in "editteam" and selecting a pkmn in battle.
|[f_editteam_init]| function(_ENV)
    local team = _ENV:f_get_team_cursor'team1'
    menu:refresh(f_zobj[[,1,2,3,4,5,6]], function(i)
        return {
            select=function(_ENV)
                if team[_ENV:cursor'editteam'+1] then
                    _ENV:push'teamaction'
                else
                    _ENV:push'teampkmn'
                end
            end,
            num=team[i] and team[i].num or -1
        }
    end)
end $$

-- todo: combine with editteam
|[f_switchteam_init]| function(_ENV)
    local team = _ENV:f_get_team_cursor'team1'
    menu:refresh(f_zobj[[,1,2,3,4,5,6]], function(i)
        return {
            disabled=i==_ENV:cursor'editteam'+1,
            select=function(_ENV)
                local ind_one, ind_two = _ENV:cursor'editteam'+1, _ENV:cursor'switchteam'+1
                team[ind_one], team[ind_two] = team[ind_two], team[ind_one]
                f_save_team(_ENV:cursor'team1', team)
                _ENV:pop() _ENV:pop()
            end,
            num=team[i] and team[i].num or -1
        }
    end)
    menu.c = editteam.menu.c
end $$

-- this is used both in "editteam" and selecting a pkmn in battle.
-- todo: if a pokemon is dead, just draw a black shadow.
|[f_pselswitch_init]| function(_ENV)
    local team = _ENV:f_get_team_cursor'team1'
    menu:refresh(f_zobj[[,1,2,3,4,5,6]], function(i)
        local disabled = not p0.team[i] or p0.active.shared == p0.team[i] or p0.team[i].major == C_MAJOR_FAINTED
        return {
            disabled=disabled,
            select=function()
                _ENV:pop() _ENV:pop()
                f_select_move(p0, i, true)
            end,
            num=p0.team[i] and p0.team[i].num or -1
        }
    end)
end $$

|[f_turn_init]| function(_ENV)
    -- if there is %c_no action, assume it's a computer player.
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
