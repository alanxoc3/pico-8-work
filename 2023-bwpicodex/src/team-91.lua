-- this file contains logic around teams and creating a "team" pokemon
|[f_unlock_pkmn]| function(trainer)
    -- add pokemon defeated to picodex
    foreach(f_get_team_dead(trainer.team), function(pkmn)
        poke(S_POKEMON+pkmn.num, 1)
    end)
end $$

|[f_get_team_dead]| function(team)
    local newteam = {}
    foreach(team, function(pkmn)
        if pkmn.num > -1 and pkmn.major == C_MAJOR_FAINTED then
            add(newteam, pkmn)
        end
    end)
    return newteam
end $$

-- exclude missingno for reporting (like fight over and battle stat screens).
-- but include it for whirlwind/teleport.
-- that way missingno is more of a secret.
|[f_get_team_live]| function(team, exclude_missingno)
    local newteam = {}
    foreach(team, function(pkmn)
        if pkmn.num > (exclude_missingno and 0 or -1) and pkmn.major ~= C_MAJOR_FAINTED then
            add(newteam, pkmn)
        end
    end)
    return newteam
end $$

-- used to switch to the next pkmn at the start of the battle and when a pkmn is ko-ed.
-- if this returns nil, the battle is over
|[f_get_next_active]| function(team)
    -- include missingno, so it pops up in horde
    return f_get_team_live(team)[1]
end $$

-- assumes that mynewmoves parameter is open to modification for team. this doesn't copy moves.
|[f_teamdel]| function(game)
    local team = game:f_get_team_cursor'team1'
    team[game:f_modes_cursor'editteam'+1] = f_create_team_pkmn(-1, f_create_empty_moveset())
    f_save_team(game:f_modes_cursor'team1', team)
    game:f_modes_pop()
end $$

|[f_set_default_team_pkmn]| function(team, ind, num)
    local pkmn, moveset = c_pokemon[num], f_create_empty_moveset()
    for i=1,min(4,#pkmn.moves_natural) do
        moveset[i] = f_create_move(pkmn.moves_natural[i], i)
    end

    team[ind] = f_create_team_pkmn(num, moveset)
    return team
end $$

---------- SAVE/LOAD TEAM LOGIC

-- 1,6 and 1,4 are hard-coded here. saved teams can't have less/more than 6 pkmn.
c_team_memlocs = f_zobj[[0,S_PARTY1, 1,S_PARTY2, 2,S_PARTY3]]
|[f_get_team]| function(team_index) -- 0 to 2
    local mem, team = c_team_memlocs[team_index], f_zobj[[]]

    for i=1,6 do
        local memstart, mynewmoves, has_moves = mem+(i-1)*5, {}, false
        for i=1,4 do
            mynewmoves[i] = f_create_move(peek(memstart+i), i)
            if mynewmoves[i].num > 0 then
                has_moves = true
            else
                mynewmoves[i] = f_create_move(-1)
            end
        end

        team[i] = f_create_team_pkmn(has_moves and @memstart or -1, mynewmoves)
    end

    return team
end $$

|[f_save_team]| function(team_index, team) -- 0 to 2
    local mem = c_team_memlocs[team_index]
    memset(mem,0,30)

    -- clear team and we'll replace it with the logic below

    for i=1,6 do
        local memstart, pkmn = mem+(i-1)*5, team[i]
        poke(memstart, max(0, pkmn.num))

        for i=1,4 do
            poke(memstart+i, pkmn.mynewmoves[i].num > 0 and pkmn.mynewmoves[i].num or 0)
        end
    end
end $$

----------------------------------
----- MOVE RELATED FUNCTIONS -----
----------------------------------

-- this is called on startup to populate c_moves
|[f_populate_c_moves]| function()
    for i=-1,164 do -- there must be 166 loop interations as that matches the compile file (-1 to 164)
        local params, ofunc = {}, deli(c_moves_raw[i], 6)
        for ii=6,#c_moves_raw[i] do
            add(params, deli(c_moves_raw[i], 6))
        end

        -- ofunc is used in accuracy check, for a charging move
        c_moves[i] = f_zobj([[
            func,@, num,@, ofunc,@, name,@, movetype,@, pp,@, maxpp,~pp, damage,@, accuracy,@
        ]], function(envparams)
            return ofunc(envparams, unpack(params))
        end, i, ofunc, unpack(c_moves_raw[i]))
    end
end $$

-- move is between -1 and
|[f_create_move]| function(id, slot)
    return setmetatable(f_zobj([[slot,@]], slot or 0), {__index=c_moves[id]})
end $$

|[f_create_empty_moveset]| function()
    local moveset = {}
    for i=1,4 do add(moveset, f_create_move(-1)) end
    return moveset
end $$
