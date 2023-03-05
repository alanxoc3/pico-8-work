-- this file contains logic around teams and creating a "team" pokemon
-- todo: should active pkmn logic go here too?
-- todo: fix team stats draw3 numbers and make it say the team/trainers name instead of team stats

-- todo: fix this error: (when pokemon not first in party & not team 1.
-- runtime error line 17 tab 0
-- elseif align>0 then x-=#text*4+1 end
-- attempt to compare number with nil
-- todo: make it so horde has a team size of more than 6

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

-- all non-browse pokemon are represented by this function
-- |[f_get_team_pkmn]| function(num, mynewmoves)
--     return _setmetatable(f_zobj([[mynewmoves,@, browse,%c_no]], mynewmoves), {__index=c_pokemon[num]})
-- end $$

-- todo: move c_pokemon setup and other related pkmn/team pkmn to this team struct file
|[f_create_team_pkmn]| function(num, mynewmoves)
    -- todo: token crunch here, specifically can the function() parts be smaller
    local teampkmn = f_zobj[[mynewmoves,#, browse,%c_no]]
    local m = teampkmn.mynewmoves
    for i=1,4 do -- todo: maybe extract this out into a "copy moves" function
        m[i] = f_create_move(mynewmoves[i].num)
    end
    return _setmetatable(teampkmn, {__index=c_pokemon[num]})
end $$

-- converts a team into a team ready for battle
|[f_get_fight_team]| function(team)
    local fightteam = {}

    foreach(team, function(pkmn)
        _add(fightteam, f_create_team_pkmn(pkmn.num, pkmn.mynewmoves))
    end)

    return fightteam
end $$
