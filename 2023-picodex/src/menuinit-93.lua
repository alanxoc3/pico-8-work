|[f_fightover_init]| function(_ENV)
    local winner, loser = p0, f_get_other_pl(_ENV, p0)
    winner:winlogic(loser)

    -- getting out of the win screen should take you to the main menu
    -- stack = {stack[1]}
    menu:refresh{}

    -- since horde and player don't have a "league" screen, this will go back to the main menu.
    -- hacky for this specific scenario :)
    menu.cancel = function(game)
        game:popuntil'team2story'
    end

    for pl in _all{winner,loser} do
        f_zobj_set(menu, [[
            v,0 -- fight over view should always start on top. don't save position for this one.
          ;;pkmn,@
          ;;hidden,%c_yes

          ;;name,@, style,5
          ;;name,@
          ;;name,@
        ]], pl.active.shared, pl.name, (#f_get_team_live(pl.team, true)).." live", (#f_get_team_dead(pl.team)).." dead")
    end
end $$

|[f_main_init]| function(_ENV)
    local count = 0
    for i=0,151 do count += c_pokemon[i]:f_pkmn_available() and 1 or 0 end

    menu:refresh(
        f_zobj([[
            ;name,"browse",  state,browse,     select,%f_menu_state_callback, desc,@
           ;;name,"edit",    state,team1,      select,%f_menu_state_callback, desc,"edit|stored|teams"
           ;;name,"league",  state,team1story, select,%f_menu_state_callback, desc,@
           ;;name,"player",  state,team1match, select,%f_menu_state_callback, desc,"player|custom|battles"
           ;;name,'?????',   state,team1horde, select,%f_menu_state_callback, desc,"?????|beat|league", disabled,%c_yes
           ;;name,"credits", state,credits,    select,%f_menu_state_callback, desc,"credits|amorg|games"
        ]], "browse|"..count.."/151|pokemon", "league|"..(@S_STORY).."/40|trainers")
    )

    if @S_STORY >= 40 then
        f_zobj_set(menu[5], [[disabled,%c_no, name,"horde", desc,@]], "horde|"..(@S_HOARD).."/151|hi-score")
    end
end $$

|[f_browse_init_shared]| function(_ENV, selectfunc)
    local tbl = {}
    for i=0,151 do
        _add(tbl, i)
    end

    menu:refresh(
        tbl,
        function(num)
            local pkmn = c_pokemon[num]
            return {
                select=selectfunc,
                disabled=not pkmn:f_pkmn_available(),
                pkmn=pkmn
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
    f_update_stat_menu(menu, _ENV:entry'browse'.pkmn)
end $$

|[f_credits_init]| function(_ENV)
    menu:refresh(
        _split"106,,!alanxoc3,code+sfx,design,6,,!gr8cadet,graphics,playtest,129,,!wadlo,magikarp,playtest,145,,!zep,pico-8,px9 func,137,,!pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
        function(txt)
            if _type(txt) == "number" then
                return { pkmn=f_create_team_pkmn(txt, f_create_empty_moveset()) }
            end

            local style = 1
            if _sub(txt,1,1) == '!' then
                txt, style = _sub(txt,2), 5
            end

            return { name=txt, style=style, hidden=txt=='' }
        end
    )
    menu.v = 0
end $$

-- 1,6 is hardcoded here because all trainers have exactly 6 pkmn
|[f_fightsel_init]| function(_ENV)
    menu:refresh(c_trainers, function(trainer, num)
        return {
            name=trainer.name,
            team=trainer,
            disabled=num-1 > @S_STORY,
            select=function(game, entry)
                f_begin_fight_cpu(game, entry.team, entry.name, f_nop, function(pl, other)
                    _poke(S_STORY, _mid(@S_STORY, num, #c_trainers)) -- todo: token crunch if low on tokens/compression, replace #c_trainers with "40", since there is a hard-coded limit
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
       ;; name,"delete",                   select,%f_teamdel             -- use the edit team screen
    ]])

    teammovesel.menu.c = 0
end $$

|[f_moveaction_init]| function(_ENV)
    local teampkmn = _ENV:f_get_pkmn_team_edit()
    local count = 0 
    for j=1,4 do
        if teampkmn.mynewmoves[j].num > 0 then count += 1 end
    end

    menu:refresh(f_zobj([[
        ; name,"change", state,teammovesel, select,%f_menu_state_callback
       ;; name,"switch", state,switchmoves, select,%f_menu_state_callback
       ;; name,"delete", disabled,@,        select,%f_movedel
    ]], count == 1))
end $$

|[f_movedel]| function(_ENV)
    local teampkmn, team = _ENV:f_get_pkmn_team_edit()
    teampkmn.mynewmoves[_ENV:cursor'teammoves'+1] = f_create_move(-1)
    f_save_team(_ENV:cursor'team1', team)
    _ENV:pop()
end $$

|[f_moves_init_helper]| function(_ENV, disabled_ind, select_func)
    local teampkmn, team = _ENV:f_get_pkmn_team_edit()
    menu:refresh(f_zobj[[,1,2,3,4]], function(i)
        local move = teampkmn.mynewmoves[i]
        return {
            move=move,
            name=move.name,
            select=function(_ENV) select_func(_ENV, i, teampkmn, team) end,
            disabled=i == disabled_ind
        }
    end)
end $$

|[f_teammoves_init]| function(_ENV)
    f_moves_init_helper(_ENV, 0, function(_ENV, i, teampkmn)
        _ENV:push(teampkmn.mynewmoves[i].num > 0 and 'moveaction' or 'teammovesel')
    end)
end $$

|[f_switchmoves_init]| function(_ENV)
    local disabled_ind = _ENV:cursor'teammoves'+1

    f_moves_init_helper(_ENV, disabled_ind, function(_ENV, i, teampkmn, team)
        teampkmn.mynewmoves[i], teampkmn.mynewmoves[disabled_ind] = teampkmn.mynewmoves[disabled_ind], teampkmn.mynewmoves[i]
        f_save_team(_ENV:cursor'team1', team)
        _ENV:popuntil'teammoves'
    end)

    menu.c = teammoves.menu.c
end $$

|[f_teammovesel_init]| function(_ENV)
    local teampkmn = _ENV:f_get_pkmn_team_edit()
    local pkmn = c_pokemon[teampkmn.num]

    local movemetadata = {}
    f_zcall(function(movelist, prefix)
        for i=1,#movelist do
            local moveind = movelist[i]
            _add(movemetadata, {name=c_moves[moveind].name, disabled=teampkmn:f_pkmn_has_move(moveind), num=moveind, desc=prefix..i})
        end
    end, [[
       ;,@,"learn #"
      ;;,@,"teach #"
      ;;,@,"event #"
    ]], pkmn.moves_natural, pkmn.moves_teach, pkmn.moves_event)

    menu:refresh(movemetadata, function(m)
        return {
            name=m.name,
            disabled=m.disabled,
            move=c_moves[m.num],
            ref=m.desc,
            select=function()
                local team = _ENV:f_get_team_cursor'team1'
                team[_ENV:cursor'editteam'+1].mynewmoves[_ENV:cursor'teammoves'+1] = f_create_move(m.num)
                f_save_team(_ENV:cursor'team1', team)
                _ENV:popuntil'teammoves'
            end
        }
    end)
end $$

|[f_pselmove_init]| function(_ENV)
    local possible_moves = f_get_possible_moves(p0.active)

    if p0.active.curmove then
        f_select_move(p0, p0.active.curmove)
        _ENV:pop() _ENV:pop()
    elseif #possible_moves == 0 then
        f_select_move(p0, f_create_move(M_STRUGGLE))
        _ENV:pop() _ENV:pop()
    end

    menu:refresh(p0.active.mynewmoves, function(move)
        return f_zobj([[disabled,@, name,@, move,@, select,@]],
            not possible_moves[move],
            move.name,
            move,
            function()
                _ENV:pop() _ENV:pop()
                f_select_move(p0, move)
            end
        )
    end)
end $$

|[f_pselactions_init]| function(_ENV)
    menu:refresh(f_zobj[[
         ; name,"fight",  desc,"fight|select|move",       select,%f_menu_state_callback, state,pselmove
        ;; name,"switch", desc,"switch|active|pokemon",   select,%f_menu_state_callback, state,pselswitch
        ;; name,"forfeit",  desc,"forfeit|pokemon|battle",  select,%f_psel_forfeit
    ]])
end $$

|[f_team_init]| function(_ENV)
    menu:refresh(f_zobj[[,1,2,3]], function(i)
        local team = f_get_team(i-1)
        local newteam = {}
        local is_disabled = true

        for i=1,6 do
            newteam[i] = team[i].num
            if not team[i]:f_pkmn_isempty() then
                is_disabled = false
            end
        end

        return {
            name="team #"..i,
            team=newteam,
            select=function() _ENV:select_func() end,
            disabled=disable_empty_team and is_disabled
        }
    end)
end $$

|[f_get_team_num]| function(team, i)
    return team[i] and team[i].num or -1
end $$

|[f_editteam_init]| function(_ENV)
    local team = _ENV:f_get_team_cursor'team1'
    menu:refresh(f_zobj[[,1,2,3,4,5,6]], function(i)
        return {
            pkmn=team[i],
            select=function(_ENV)
                if team[_ENV:cursor'editteam'+1]:f_pkmn_available() then
                    _ENV:push'teamaction'
                else
                    _ENV:push'teampkmn'
                end
            end
        }
    end)
end $$

|[f_switchteam_init]| function(_ENV)
    local team = _ENV:f_get_team_cursor'team1'
    menu:refresh(f_zobj[[,1,2,3,4,5,6]], function(i)
        return {
            disabled=i==_ENV:cursor'editteam'+1,
            select=function(_ENV)
                local ind_one, ind_two = _ENV:cursor'editteam'+1, _ENV:cursor'switchteam'+1
                team[ind_one], team[ind_two] = team[ind_two], team[ind_one]
                f_save_team(_ENV:cursor'team1', team)
                _ENV:popuntil'editteam'
            end,
            pkmn=team[i]
        }
    end)
    menu.c = editteam.menu.c
end $$

|[f_pselswitch_init]| function(_ENV)
    local team = _ENV:f_get_team_cursor'team1'
    menu:refresh(f_zobj[[,1,2,3,4,5,6]], function(i)
        local disabled = p0.team[i]:f_pkmn_isempty() or p0.active.shared == p0.team[i] or p0.team[i].major == C_MAJOR_FAINTED
        return {
            disabled=disabled,
            select=function()
                _ENV:pop() _ENV:pop() -- pop twice. this could come from p1 or p2
                f_select_switch(p0, p0.team[i])
            end,
            pkmn=p0.team[i]
        }
    end)
end $$

|[f_turn_init]| function(_ENV)
    -- p0 is equal to the higher priority
    local p1, p2 = p1, p2
    if p1.priority == p2.priority then p2.priority += _sgn(_rnd'2'-1) end
    p0 = p1.priority > p2.priority and p1 or p2
end $$
