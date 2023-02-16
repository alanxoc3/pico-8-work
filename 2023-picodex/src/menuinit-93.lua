-- todo: make a function that loops from 1 to 6.

|[fightover_init]| function(_ENV)
    local winner, loser = p0, get_other_pl(_ENV, p0)
    winner.winlogic()

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

|[main_init]| function(_ENV)
    menu:refresh(
        zobj[[
            ;name,"browse",  state,browse,     select,%menu_state_callback, desc,"view|pokemon|info"
           ;;name,"teams",   state,team1,      select,%menu_state_callback, desc,"edit|stored|teams"
           ;;name,"fight",   state,games,      select,%menu_state_callback, desc,"custom|2 player|battle", disabled,yes
           ;;name,"story",   state,team1fight, select,%menu_state_callback, desc,"battle|against|trainers"
           ;;name,"hoard",   state,hoard,      select,%menu_state_callback, desc,"battle all|pokemon|in order", disabled,yes
           ;;name,"credits", state,credits,    select,%menu_state_callback, desc,"made by|amorg|games"
        ]]
    )
end $$

|[browse_init]| function(_ENV)
    menu:refresh(
        g_available_pokemon,
        function(num) return {select=function(_ENV) _ENV:push'browsestat' end, num=num} end
    )
end $$

|[browsestat_init]| function(_ENV)
    update_stat_menu(menu, get_browse_pokemon(_ENV:cursor'browse'+1))
end $$

|[partystat_init]| function(_ENV)
    local team = get_party(_ENV:cursor'team1')
    local partypkmn = team[_ENV:cursor'editparty'+1]
    update_stat_menu(menu, c_pokemon[partypkmn.num])
end $$

|[credits_init]| function(_ENV)
    menu:refresh(
        _split"65,,!scores,pkmn ,hoard ,106,,!alanxoc3,code,design,6,,!gr8cadet,graphics,sound,129,,!wadlo,magikarp,gyarados,123,,!snippets,zep px9,mot smap,137,,!pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
        function(txt)
            if _type(txt) == "number" then
                return { pkmn=txt }
            end

            local style = 1
            if _sub(txt,1,1) == '!' then
                txt, style = _sub(txt,2), 3
            end

            return { name=txt, style=style, hidden=txt=='' }
        end
    )

    menu[4].name ..= #g_available_pokemon
    menu[5].name ..= 0
end $$

|[fightsel_init]| function(_ENV)
    menu:refresh(c_trainers, function(trainer, num)
        local disabled, team = num-1 > @S_STORY, {}
        for i=1,6 do team[i] = trainer[i+1] end

        return {
            name=trainer[1],
            team=team,
            disabled=disabled,
            desc=disabled and "beat|previous|to unlock",
            select=function(_ENV, entry)
                local cpu_party_draft = {}
                for i=1,6 do
                    local num = entry.team[i]
                    if num then
                        _add(cpu_party_draft, { num=num, moves=c_pokemon[num].get_natural_moveset(100) })
                    end
                end

                begin_fight(_ENV, get_party(_ENV:cursor'team1'), cpu_party_draft, "player 1", entry.name, false, true)
            end
        }
    end)
end $$

|[partyaction_init]| function(_ENV)
    menu:refresh(zobj[[
        ; name,"info",   state,partystat,  select,%menu_state_callback, -- use browse pokemon selector
       ;; name,"moves",  state,partymoves, select,%menu_state_callback  -- use the menu system
       ;; name,"delete",                   select,%partydel             -- use the edit team screen
    ]])

    partymovesel.menu.c = 0
end $$

|[partypkmn_init]| function(_ENV)
    menu:refresh(
        g_available_pokemon,
        function(num)
            return {
                select=function(_ENV)
                    save_party(_ENV:cursor'team1', set_default_party_pkmn(get_party(_ENV:cursor'team1'), _ENV:cursor'editparty'+1, g_available_pokemon[_ENV:cursor'browse'+1]))
                    _ENV:pop()
                end,
                num=num
            }
        end
    )
end $$

|[partymoves_init]| function(_ENV)
    local team = get_party(_ENV:cursor'team1')
    local partypkmn = team[_ENV:cursor'editparty'+1]

    menu:refresh(zobj[[,1,2,3,4]], function(i)
        return {
            num=partypkmn.moves[i],
            name=partypkmn.moves[i] and c_moves[partypkmn.moves[i]].name or "???",
            select=function(_ENV) _ENV:push'partymovesel' end
        }
    end)
end $$

|[partymovesel_init]| function(_ENV)
    local team = get_party(_ENV:cursor'team1')
    local partypkmn = team[_ENV:cursor'editparty'+1]

    local pkmn = c_pokemon[partypkmn.num]
    menu:refresh(pkmn.moves, function(m)
        return {
            name=c_moves[m.num].name,
            num=m.num,
            ref=m.ref,
            select=function()
                save_party(_ENV:cursor'team1', set_party_pkmn_move(get_party(_ENV:cursor'team1'), _ENV:cursor'editparty'+1, _ENV:cursor'partymoves'+1, m.num))
                _ENV:pop()
            end
        }
    end)
end $$

-- todo: try making the minifier separate on underscores
-- todo: support struggle
|[pselmove_init]|   function(_ENV)
    menu:refresh(get_possible_move_slots(p0.active), function(move_slot)
        local move = c_moves[p0.active.moveids[move_slot]]
        return {
            name=move.name,
            num=move.num,
            select=function()
                _ENV:pop() _ENV:pop()
                select_move(p0, move_slot)
            end
        }
    end)
end $$

|[pselactions_init]| function(_ENV)
    menu:refresh(zobj[[
         ; name,"fight",   desc,"select|next|move",         select,%menu_state_callback, state,pselmove
        ;; name,"random",  desc,"select|random|move",    select,%menu_cancel -- random logic is in the turn logic if move is empty, so just leave the menu
        ;; name,"switch",  desc,"change|active|pokemon", select,%menu_state_callback, state,pselswitch, disabled,yes
        ;; name,"forfeit", desc,"leave|the|fight",       select,%psel_forfeit
    ]])
end $$

|[party_init]| function(_ENV)
    menu:refresh(zobj[[,1,2,3]], function(i)
        local team = get_party(i-1)
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
|[editparty_init]| function(_ENV)
    local team = get_party(_ENV:cursor'team1')
    menu:refresh(zobj[[,1,2,3,4,5,6]], function(i)
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

|[turn_init]| function(_ENV)
    -- if there is no action, assume it's a computer player.
    for p in _all{p1, p2} do
        if #p.actions == 0 then
            select_move(p, select_random_move_slot(p.active))
        end
    end

    -- p0 is equal to the higher priority
    local p1, p2 = p1, p2
    if p1.priority == p2.priority then p2.priority += _sgn(_rnd'2'-1) end
    p0 = p1.priority > p2.priority and p1 or p2
end $$
