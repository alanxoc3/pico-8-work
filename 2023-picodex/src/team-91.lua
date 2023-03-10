-- this file contains logic around teams and creating a "team" pokemon

|[f_unlock_pkmn]| function(trainer)
    -- add pokemon defeated to picodex
    foreach(f_get_team_dead(trainer.team), function(pkmn)
        _poke(S_POKEMON+pkmn.num, 1)
    end)
end $$

|[f_get_team_dead]| function(team)
    local newteam = {}
    foreach(team, function(pkmn)
        if pkmn.num > -1 and pkmn.major == C_MAJOR_FAINTED then
            _add(newteam, pkmn)
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
            _add(newteam, pkmn)
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
    team[game:cursor'editteam'+1] = f_create_team_pkmn(-1, f_create_empty_moveset())
    f_save_team(game:cursor'team1', team)
    game:pop()
end $$

|[f_set_default_team_pkmn]| function(team, ind, num)
    team[ind] = f_create_team_pkmn(num, f_get_natural_moveset(num))
    return team
end $$

---------- SAVE/LOAD TEAM LOGIC

-- 1,6 and 1,4 are hard-coded here. saved teams can't have less/more than 6 pkmn.
c_team_memlocs = f_zobj[[0,S_PARTY1, 1,S_PARTY2, 2,S_PARTY3]]
|[f_get_team]| function(team_index) -- 0 to 2
    local mem = c_team_memlocs[team_index]
    local team = f_zobj[[]]

    for i=1,6 do
        -- todo: token crunch these local vars.
        local memstart = mem+(i-1)*5
        local mynewmoves = {}
        local has_moves = false
        for i=1,4 do
            mynewmoves[i] = f_create_move(_peek(memstart+i))
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
    _memset(mem,0,30)

    -- clear team and we'll replace it with the logic below

    for i=1,6 do
        -- todo: token crunch these local vars.
        local memstart = mem+(i-1)*5
        local pkmn = team[i]
        _poke(memstart, max(0, pkmn.num))

        for i=1,4 do
            _poke(memstart+i, pkmn.mynewmoves[i].num > 0 and pkmn.mynewmoves[i].num or 0)
        end
    end
end $$

----------------------------------
----- MOVE RELATED FUNCTIONS -----
----------------------------------

-- this is called on startup to populate c_moves
|[f_populate_c_moves]| function()
    for i=-1,#c_moves_raw do
        local move = c_moves_raw[i]
        local params = {}
        for i=7,#move do _add(params, move[i]) end
        c_moves[i] = f_zobj([[
            name,@, type,@, pp,@, maxpp,~pp, damage,@, accuracy,@, func,@, num,@
        ]], move[1], move[2], move[3], move[4], move[5], function(m, p0, other)
            local envparams = f_zobj([[
                move,@, self,@, other,@,
                selfactive,@, otheractive,@,
                param1,@, param2,@
            ]], m, p0, other, p0.active, other.active)
            return move[6](envparams, _unpack(params))
        end, i)
    end
end $$

|[f_get_natural_moveset]| function(num)
    local pkmn, moveset = c_pokemon[num], f_create_empty_moveset()
    for i=1,min(4,#pkmn.moves_natural) do
        moveset[i] = f_create_move(pkmn.moves_natural[i])
    end
    return moveset
end $$

-- move is between -1 and 
|[f_create_move]| function(id)
    return _setmetatable(f_zobj[[]], {__index=c_moves[id]})
end $$

|[f_create_empty_moveset]| function()
    local moveset = {}
    for i=1,4 do _add(moveset, f_create_move(-1)) end
    return moveset
end $$


