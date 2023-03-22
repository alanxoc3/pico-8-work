-- this file contains logic around teams and creating a "team" pokemon
|[f_unlock_pkmn]| function(trainer)
    -- add pokemon defeated to picodex
    _foreach(f_get_team_dead(trainer.team), function(pkmn)
        _poke(S_POKEMON+pkmn.num, 1)
    end)
end $$

|[f_get_team_dead]| function(team)
    local newteam = {}
    _foreach(team, function(pkmn)
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
    _foreach(team, function(pkmn)
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
        local memstart, mynewmoves, has_moves = mem+(i-1)*5, {}, false
        for i=1,4 do
            mynewmoves[i] = f_create_move(_peek(memstart+i), i)
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
        local memstart, pkmn = mem+(i-1)*5, team[i]
        _poke(memstart, _max(0, pkmn.num))

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
    local memloc = _peek2'0x8'
    for i=-1,164 do -- there must be 166 loop interations as that matches the compile file (-1 to 164)
        local typ = _peek(memloc+0)
        local pp  = _peek(memloc+1)*5-5
        local dmg = _peek(memloc+2)*5-5
        local acc = _peek(memloc+3)*5-5
        local name = _deli(c_moves_raw[i], 1)
        local ofunc = _deli(c_moves_raw[i], 1)

        -- ofunc is used in accuracy check, for a charging move
        c_moves[i] = f_zobj([[
            func,@, num,@, name,@, type,@, pp,@, maxpp,~pp, damage,@, accuracy,@, ofunc,@
        ]], function(envparams)
            return move[6](envparams, _unpack(c_moves_raw[i]))
        end, i, name, typ, pp, dmg, acc, ofunc)
        _printh("memloc: "..memloc.." | ")

        memloc+=4
    end
end $$

|[f_get_natural_moveset]| function(num)
    local pkmn, moveset = c_pokemon[num], f_create_empty_moveset()
    for i=1,_min(4,#pkmn.moves_natural) do
        moveset[i] = f_create_move(pkmn.moves_natural[i], i)
    end
    return moveset
end $$

-- move is between -1 and 
|[f_create_move]| function(id, slot)
    return _setmetatable(f_zobj([[slot,@]], slot or 0), {__index=c_moves[id]})
end $$

|[f_create_empty_moveset]| function()
    local moveset = {}
    for i=1,4 do _add(moveset, f_create_move(-1)) end
    return moveset
end $$
