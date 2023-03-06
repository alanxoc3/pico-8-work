-- this file contains logic around teams and creating a "team" pokemon
-- todo: fix team stats draw3 numbers and make it say the team/trainers name instead of team stats

-- todo: fix this error: (when pokemon not first in party & not team 1.
-- runtime error line 17 tab 0
-- elseif align>0 then x-=#text*4+1 end
-- attempt to compare number with nil

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

-- todo: win league game, stay in league tab
-- assumes that mynewmoves parameter is open to modification for team. this doesn't copy moves.
|[f_create_team_pkmn]| function(num, mynewmoves)
    return _setmetatable(f_zobj([[mynewmoves,@, browse,%c_no]], mynewmoves), {__index=c_pokemon[num]})
end $$

-- converts a team into a team ready for battle
|[f_get_fight_team]| function(team)
    local fightteam = {}

    foreach(team, function(pkmn)
        _add(fightteam, f_create_team_pkmn(pkmn.num, pkmn.mynewmoves))
    end)

    return fightteam
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
