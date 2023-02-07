|[main_init]| function(game)
    game.menu:refresh(
        zobj[[
            ;name,"browse",  state,browse,     select,%menu_state_callback, desc,"view|pokemon|info"
           ;;name,"teams",   state,party,      select,%menu_state_callback, desc,"edit|stored|teams"
           ;;name,"versus",  state,games,      select,%menu_state_callback, desc,"custom|2 player|battle", disabled,yes
           ;;name,"story",   state,fightparty, select,%menu_state_callback, desc,"battle|against|trainers"
           ;;name,"hoard",   state,hoard,      select,%menu_state_callback, desc,"battle all|pokemon|in order", disabled,yes
           ;;name,"credits", state,credits,    select,%menu_state_callback, desc,"by|amorg|games"
        ]]
    )
end $$

|[browse_init]| function(game)
    game.menu:refresh(
        g_available_pokemon,
        function(num) return {select=function(entry, game) game:push'browsestat' end, num=num} end
    )
end $$

|[browsestat_init]| function(game)
    local pkmn = get_browse_pokemon(game:cursor'browse'+1)

    game.menu:refresh(zobj[[
        ;key,total,   name,"tot"
       ;;key,hp,      name,"hp"
       ;;key,speed,   name,"spd"
       ;;key,special, name,"spc"
       ;;key,attack,  name,"att"
       ;;key,defense, name,"def"
       ;;key,level,   name,"lvl"
    ]], function(pair)
        return { name=pair.name.." "..pkmn[pair.key] }
    end)

    add(game.menu, {pkmn=g_available_pokemon[game:cursor'browse'+1]}, 1)
    add(game.menu, {hidden=true}, 2)
    add(game.menu, {name="stats", style=3}, 3)
end $$

|[credits_init]| function(game)
    game.menu:refresh(
        split"65,,!scores,pkmn ,hoard ,106,,!alanxoc3,code,design,6,,!gr8cadet,graphics,sound,129,,!wadlo,magikarp,gyarados,123,,!snippets,zep px9,mot smap,137,,!pkmndata,blbpedia,pokeapi,serebii,smogon,upokcntr,volvox,nintendo",
        function(txt)
            if type(txt) == "number" then
                return { pkmn=txt }
            end

            local style = 1
            if sub(txt,1,1) == '!' then
                txt, style = sub(txt,2), 3
            end

            return { name=txt, style=style, hidden=txt=='' }
        end
    )

    game.menu[4].name ..= #g_available_pokemon
    game.menu[5].name ..= 0
end $$

|[fightsel_init]| function(game)
    game.menu:refresh({
        {name="bugcatch", select=function(a, game)
                local cpu_party_draft = {}
                for i=1,6 do
                    local num = flr_rnd(151)+1
                    add(cpu_party_draft, { num=num, moves=c_pokemon[num].get_natural_moveset(100) })
                end

                begin_fight(game, 100, get_party(game:cursor'party'), cpu_party_draft, "player 1", "bugcatcher", false, true)
            end, desc="i|like|bugs"
        }
    })
end $$

|[partyaction_init]|   function(game)
    game.menu:refresh(zobj[[
        ; name,"info",   state,nop,        select,%menu_state_callback, disabled,yes -- use browse pokemon selector
       ;; name,"moves",  state,partymoves, select,%menu_state_callback -- use the menu system
       ;; name,"delete",                   select,%partydel            -- use the edit party screen
    ]])
end $$

|[partypkmn_init]| function(game)
    game.menu:refresh(
        g_available_pokemon,
        function(num)
            return {
                select=function(_, game)
                    save_party(game:cursor'party', set_default_party_pkmn(get_party(game:cursor'party'), game:cursor'editparty'+1, g_available_pokemon[game:cursor'partypkmn'+1]))
                    game:pop()
                end,
                num=num
            }
        end
    )
end $$

|[partymoves_init]| function(game)
    local party = get_party(game:cursor'party')
    local partypkmn = party[game:cursor'editparty'+1]

    game.menu:refresh(zobj[[,1,2,3,4]], function(i)
        return {
            num=partypkmn.moves[i],
            name=partypkmn.moves[i] and c_moves[partypkmn.moves[i]].name or "<empty>",
            select=function(_, game) game:push'partymovesel' end
        }
    end)
end $$

|[partymovesel_init]| function(game)
    local party = get_party(game:cursor'party')
    local partypkmn = party[game:cursor'editparty'+1]

    local pkmn = c_pokemon[partypkmn.num]
    game.menu:refresh(pkmn.moves, function(m)
        return {
            name=c_moves[m.num].name,
            num=m.num,
            ref=m.ref,
            select=function(_, game)
                save_party(game:cursor'party', set_party_pkmn_move(get_party(game:cursor'party'), game:cursor'editparty'+1, game:cursor'partymoves'+1, m.num))
                game:pop()
            end
        }
    end)
end $$

-- todo: try making the minifier separate on underscores
-- todo: support struggle
|[pselmove_init]|   function(game)
    game.menu:refresh(get_possible_move_slots(game.p0.active), function(move_slot)
        return {
            name=c_moves[game.p0.active.moveids[move_slot]].name,
            desc="todo",
            select=function()
                game:pop() game:pop()
                select_move(game.p0, move_slot)
            end
        }
    end)
end $$

|[pselactions_init]| function(game)
    game.menu:refresh(zobj[[
         ; name,"fight",   desc,"select|a|move",         select,%menu_state_callback, state,pselmove
        ;; name,"switch",  desc,"change|active|pokemon", select,%menu_state_callback, state,pselswitch, disabled,yes
        ;; name,"forfeit", desc,"leave|the|fight",       select,%psel_forfeit
    ]])
end $$

|[party_init]| function(game)
    game.menu:refresh(zobj[[,1,2,3]], function(i)
        local party = get_party(i-1)
        local is_disabled = true
        for i=1,6 do
            if party[i] then is_disabled = false end
        end

        return {
            name="team #"..i,
            select=function() game:select_func() end,
            disabled=game.disable_empty_party and is_disabled
        }
    end)
end $$

-- this is used both in "editparty" and selecting a pkmn in battle.
|[editparty_init]| function(game)
    local party = get_party(game:cursor'party')
    game.menu:refresh(zobj[[,1,2,3,4,5,6]], function(i)
        return {
            select=function(entry, game)
                local party = get_party(game:cursor'party')
                if party[game:cursor'editparty'+1] then
                    game:push'partyaction'
                else
                    game:push'partypkmn'
                end
            end,
            num=party[i] and party[i].num or -2
        }
    end)
end $$

