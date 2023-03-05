-- this file contains structures for pokemon

|[f_populate_c_pokemon]| function()
    local movemem = _peek2'8'

    -- -1 is for disabled things. this is never available.
    for num=-1,151 do
        ---- PASS 1 - create array ----
        -- this populates an array for the pokemon, based on data stored in the cartridge
        local pkmndata, is_range = {}, false
        while @movemem ~= C_NEXT do
            if @movemem == C_DASH then
                is_range = true
            elseif is_range then
                for i=pkmndata[#pkmndata]+1,@movemem do
                    _add(pkmndata, i)
                end
                is_range = false
            else
                _add(pkmndata, @movemem)
            end
            movemem += 1
        end
        movemem += 1

        ---- PART 2 - populate most attributes ----
        local evolvesfrom = num-pkmndata[1]
        local pkmn = f_zobj([[
            browse,%c_yes,
            mynewmoves,@,
            num,@, evolvesfrom,@, name,@,
            type1,@, type2,@,
            base_maxhp,@, base_attack,@, base_defense,@, base_speed,@, base_special,@,
            moves_natural,@, moves_teach,@, moves_event,@
        ]],
            f_create_empty_moveset(), -- evl
            num, -- evl
            evolvesfrom,  -- evl
            c_pokemon_names[num+1], -- nam
            pkmndata[2],  -- ty1
            pkmndata[3],  -- ty2
            pkmndata[4],  -- xhp
            pkmndata[5],  -- att
            pkmndata[6],  -- def
            pkmndata[7],  -- spd
            pkmndata[8],  -- spc
            {}, {}, {}
        )

        ---- PASS 3 - populate the moves ----
        local move_bucket = pkmn.moves_natural
        for i=9,#pkmndata do
            local val = pkmndata[i]
            if val == C_TEACH then
                move_bucket = pkmn.moves_teach
            elseif val == C_EVENT then
                move_bucket = pkmn.moves_event
            else
                _add(move_bucket, val)
            end
        end

        if evolvesfrom < num then
            _foreach(c_pokemon[evolvesfrom].moves_natural, function(move) _add(pkmn.moves_natural, move) end)
            _foreach(c_pokemon[evolvesfrom].moves_teach,   function(move) _add(pkmn.moves_teach,   move) end)
            _foreach(c_pokemon[evolvesfrom].moves_event,   function(move) _add(pkmn.moves_event,   move) end)
        end

        -- this is my ghetto sorting. it fixes weird ordering for new teachs on evolved forms (tm/hm order)
        local teach_map, teachs = {}, {}
        _foreach(pkmn.moves_teach, function(move) teach_map[move] = true end)
        for i=1,54 do
            if teach_map[i] then _add(teachs, i) end
        end
        pkmn.moves_teach = teachs

        ---- PASS 4 - add level specific data and other attributes to the pkmn ----
        f_zobj_set(pkmn, [[
            attack,@, defense,@, special,@, speed,@, maxhp,@, hp,~maxhp, level,C_LEVEL
        ]], f_calc_max_stat(pkmn.base_attack),
            f_calc_max_stat(pkmn.base_defense),
            f_calc_max_stat(pkmn.base_special),
            f_calc_max_stat(pkmn.base_speed),
            f_calc_max_stat(pkmn.base_maxhp)+5+C_LEVEL
        )

        pkmn.total = pkmn.attack + pkmn.defense + pkmn.special + pkmn.speed + pkmn.maxhp

        -- todo: token crunch on these funcs, mainly just separate them out & use zobj stuff
        pkmn.draw = function(pkmn, ...)
            -- todo: incorporate transform ... transform into surfing pikachu should become surfing pikachu
            local num = pkmn:available() and pkmn.num or -1
            if num == P_PIKACHU and pkmn:hasmove(M_SURF)    then num = 158 end
            if num == P_PSYDUCK and pkmn:hasmove(M_AMNESIA) then num = 159 end
            f_draw_pkmn_out(num, ...)
        end

        pkmn.hasmove = function(pkmn, moveid)
            for j=1,4 do
                if pkmn.mynewmoves[j].num == moveid then
                    return true
                end
            end
            return false
        end

        pkmn.isempty = function(pkmn)
            for j=1,4 do
                if pkmn.mynewmoves[j].num ~= -1 then
                    return false
                end
            end
            return true
        end

        pkmn.available = function(pkmn)
            -- non-browse pokemon are always available (credit, edit, and battle) the browse attribute represents that
            if pkmn.num >= 0 then -- shouldn't be -1
                return not pkmn.browse or @(S_POKEMON+pkmn.num) > 0
            end
        end

        ---- PASS 5 - finally, set the pokemon to the c_pokemon array ----
        c_pokemon[num] = pkmn
    end
end $$

-- todo: move c_pokemon setup and other related pkmn/team pkmn to this team struct file
-- todo: add movepps attribute to c_pokemon maybe and also saved/edit team area. this function might be able to be combined with f_get_team_pkmn
|[f_create_team_pkmn]| function(num, mynewmoves)
    -- todo: token crunch here, specifically can the function() parts be smaller
    local teampkmn = f_zobj[[mynewmoves,#]]
    local m = teampkmn.mynewmoves
    for i=1,4 do -- todo: maybe extract this out into a "copy moves" function
        m[i] = f_create_move(mynewmoves[i].num)
    end
    return _setmetatable(teampkmn, {__index=c_pokemon[num]})
end $$

-- converts a team into a team ready for battle
|[f_get_fight_team]| function(team)
    local fightteam = {}

    for i=1,6 do
        local cur = team[i]
        fightteam[i] = f_create_team_pkmn(cur.num, cur.mynewmoves)
    end

    return fightteam
end $$

-- teampkmn must be non-nil and match the team table structure defined in f_get_fight_team 
|[f_team_pkmn_to_active]| function(teampkmn)
    return _setmetatable(f_zobj([[
        shared,@,  getstat,@, -- shared exists to check team[i] == active.shared and as a sure way to get original values
        minor, #;
        
        stages; special,0, defense,0, attack,0, speed,0, accuracy,0, evasion,0;
    ]], teampkmn, function(a, stat)
        -- evasion and accuracy have a different formula: https://www.smogon.com/rb/articles/stadium_guide
        -- all stats cap at 999: https://www.smogon.com/rb/articles/rby_mechanics_guide
        -- and i'm giving it a _min of 1 too, because zero messes things up

        local stage = a.stages[stat]
        return _ceil(_mid(1, 999,
            a.shared[stat]*(
                (stat == 'evasion' or stat == 'accuracy')
                and _mid(1, 1+stage/3, 3)/_mid(1, 1-stage/3, 3)
                 or _mid(2, 2+stage,   8)/_mid(2, 2-stage,   8)
            )
        ))
    end), {__index=teampkmn})
end $$
