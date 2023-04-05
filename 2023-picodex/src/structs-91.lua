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
        browse,~c_yes,
        attack,0, defense,0, special,0, speed,0, maxhp,0, hp,0, total,0,
        accuracy,100, evasion,100, -- all pkmn have 100 accuracy & 100 evasion. getstat doesn't work with decimal numbers
        base_maxhp,0, base_attack,0, base_defense,0, base_speed,0, base_special,0,

        num,-1, evolvesfrom,-1, name," ",
        type1,T_NONE, type2,T_NONE,
        moves_natural,#, moves_teach,#, moves_event,#,

        mynewmoves,@
    ]], f_create_empty_moveset())
end $$

|[f_populate_c_pokemon]| function()
    local movemem = _peek2'0xa'

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
        local evolvesfrom = num-_deli(pkmndata, 1)
        local pkmn = f_get_default_pokemon()
        f_zobj_set(pkmn, [[
            num,@, evolvesfrom,@, name,@,
            type1,@, type2,@,
            base_maxhp,@, base_attack,@, base_defense,@, base_speed,@, base_special,@
        ]], num, -- evl
            evolvesfrom,  -- evl
            c_pokemon_names[num+1], -- nam

            -- this shouldn't work, but it does. it's unpacking more than it needs to, but since it's at the end, that's fine
            -- the "deli" above is important, because we don't want to include the "evol" key.
            _unpack(pkmndata) -- ty1, ty2, xhp, att, def, spd, spc, .... and junk we don't care about
        )

        ---- PASS 3 - populate the moves ----
        local move_bucket = pkmn.moves_natural
        for i=8,#pkmndata do -- 8, not 9, because of deli above
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
            _foreach(_split'moves_natural,moves_teach,moves_event', function(key)
                _foreach(c_pokemon[evolvesfrom][key], function(move)
                    _add(pkmn[key], move)
                end)
            end)
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
                attack,@, defense,@, special,@, speed,@, maxhp,@, hp,~maxhp
            ]], f_calc_max_stat(base_attack),
                f_calc_max_stat(base_defense),
                f_calc_max_stat(base_special),
                f_calc_max_stat(base_speed),
                f_calc_max_stat(base_maxhp)+55 -- really, this is 5 plus C_LEVEL. I'm hard coding c_level to be 50 in other places anyways though.
            )

            total = attack + defense + special + speed + maxhp
        end

        ---- PASS 5 - finally, set the pokemon to the c_pokemon array ----
        c_pokemon[num] = pkmn
    end
end $$

|[f_create_team_pkmn]| function(num, mynewmoves)
    return _setmetatable(f_zobj([[mynewmoves,@, major,C_MAJOR_NONE, browse,~c_no]], mynewmoves), {___index=c_pokemon[num]})
end $$
