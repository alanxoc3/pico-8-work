-- todo: make gust/thunder hurt pokemon flying & deal double damage
-- todo: make earthquake/fissure hurt pokemon digging & deal double damage
-- todo: an idea for compression crunching if I need it is to remove most "%" from ztable.

-- this file contains structures for pokemon

-- thanks to bulbapedia: https://bulbapedia.bulbagarden.net/wiki/Stat#Stat
-- this formula is much simpler at a specific level (50), so I took some parts out.
-- this is only used in populate pokemon func below
|[f_calc_max_stat]| function(base)
    return _ceil(base+.5*93)+5
end $$

-- both the default pokemon and shows the fields that should be on the pokemon
-- this makes the f_populate_c_pokemon function easier to understand
|[f_get_default_pokemon]| function()
    return f_zobj([[
        browse,%c_yes,
        level,C_LEVEL,
        attack,0, defense,0, special,0, speed,0, maxhp,0, hp,0, total,0,
        accuracy,1, evasion,1, -- all pkmn have 1 accuracy & 1 evasion
        base_maxhp,0, base_attack,0, base_defense,0, base_speed,0, base_special,0,

        num,-1, evolvesfrom,-1, name," ",
        type1,T_NONE, type2,T_NONE,
        moves_natural,#, moves_teach,#, moves_event,#,

        draw,%f_draw_pkmn_out,

        mynewmoves,@
    ]], f_create_empty_moveset())
end $$

|[f_populate_c_pokemon]| function()
    local movemem = _peek2'8'

    -- -1 is for disabled things. this is never available.
    c_pokemon[-1] = f_get_default_pokemon()

    -- and now set all the other pkmn
    for num=0,151 do
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
        local pkmn = f_get_default_pokemon()
        f_zobj_set(pkmn, [[
            num,@, evolvesfrom,@, name,@,
            type1,@, type2,@,
            base_maxhp,@, base_attack,@, base_defense,@, base_speed,@, base_special,@
        ]], num, -- evl
            evolvesfrom,  -- evl
            c_pokemon_names[num+1], -- nam
            pkmndata[2],  -- ty1
            pkmndata[3],  -- ty2
            pkmndata[4],  -- xhp
            pkmndata[5],  -- att
            pkmndata[6],  -- def
            pkmndata[7],  -- spd
            pkmndata[8]   -- spc
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
        do local _ENV=pkmn
            f_zobj_set(_ENV, [[
                attack,@, defense,@, special,@, speed,@, maxhp,@, hp,~maxhp, level,C_LEVEL
            ]], f_calc_max_stat(base_attack),
                f_calc_max_stat(base_defense),
                f_calc_max_stat(base_special),
                f_calc_max_stat(base_speed),
                f_calc_max_stat(base_maxhp)+5+C_LEVEL
            )

            total = attack + defense + special + speed + maxhp
        end

        ---- PASS 5 - finally, set the pokemon to the c_pokemon array ----
        c_pokemon[num] = pkmn
    end
end $$

|[f_create_team_pkmn]| function(num, mynewmoves)
    return _setmetatable(f_zobj([[mynewmoves,@, major,C_MAJOR_NONE, browse,%c_no]], mynewmoves), {__index=c_pokemon[num]})
end $$

-- teampkmn must be non-nil and match the team table structure defined in f_create_team_pkmn
|[f_team_pkmn_to_active]| function(teampkmn)
    -- need to copy each move just for mimic to work when switching 
    local moves = {}
    _foreach(teampkmn.mynewmoves, function(m)
        _add(moves, m)
    end)

    return _setmetatable(f_zobj([[
        isactive,%c_yes, -- used for a drawing function, should draw fainted pokemon if they are not active, but not if they are active.
        lastmoverecv,0,  -- last move taken damage by, for mirrormove
        accuracy,1,      -- accuracy stat for battle
        evasion,1,       -- evasion stat for battle
        moveturn,0,      -- turn move is on. > 0, decrements each turn. 0, is the same. -1, is multiturn move that doesn't end (rage).

        -- minor conditions are all numbers ...
        disabledtimer,0, -- how long the disabled move should last
        confused,0,      -- for confusion, how long pkmn is confused
        substitute,0,    -- for substitute obviously
        toxiced,0,       -- how bad the toxic is

        -- curmove -- used for multiturn moves, if moveturn ~= 0, this must be set
        shared,@,
        mynewmoves,@,
        turnstarthp,@;

        stages; special, 0, attack, 0,
                defense, 0, speed,  0,
                accuracy,0, evasion,0
    ]], teampkmn, moves, teampkmn.hp), {__index=teampkmn})
end $$
