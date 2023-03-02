-- fight is: turn -> turn -> { (p1 select) -> (p2 select) -> whogoesfirst -> turn -> turn -> ...repeat }
-- in turn init, if there are %c_no actions then go to p1 select
-- in turn init, switch p0
-- 
-- team1/team2: { {num=123, moves={1=3, 2=4, 3=31, 4=68 }}, ... }

-- story - win (p1)   - p2 killed pkmn are added to picodex & increment trainer story
-- horde - win (both) - p2 killed pkmn are added to picodex
-- horde - die (p2)   - p2 adds a new pkmn to the team

|[f_begin_fight]| function(_ENV, team1, team2, name1, name2, iscpu1, iscpu2, p1_die_logic, p2_die_logic, p1_win_logic, p2_win_logic)
    local team1, team2 = f_get_fight_team(team1), f_get_fight_team(team2)

    -- winlogic could be used for story mode.
    -- p1 has higher starting priority so game shows their pokemon to come out first
    -- horde count is only used for p2. this is the index the horde is currently on.
    p1 = f_zobj([[
        hordeind,6, deadnums,#, actions,#, priority,1,
        name,@, iscpu,@, active,@, team,@, winlogic,@, dielogic,@
    ]], name1, iscpu1, f_team_pkmn_to_active(f_get_next_active(team1)), team1, p1_win_logic, p1_die_logic)
    _add(p1.actions, f_newaction(p1, "#,comes,out"))

    p2 = f_zobj([[
        hordeind,6, deadnums,#, actions,#, priority,1,
        name,@, iscpu,@, active,@, team,@, winlogic,@, dielogic,@
    ]], name2, iscpu2, f_team_pkmn_to_active(f_get_next_active(team2)), team2, p2_win_logic, p2_die_logic)
    _add(p2.actions, f_newaction(p2, "#,comes,out"))

    -- how to switch the current player
    -- game.p0 = game.p0 == game.p1 and game.p2 or game.p1
    p0 = p1
    pselactions.menu.c, pselmove.menu.c = 0, 0 -- cursor should not copy previous fights

    _ENV:push'turn'
end $$

-- used to switch to the next pkmn at the start of the battle and when a pkmn is ko-ed.
-- if this returns nil, the battle is over
|[f_get_next_active]| function(team)
    for i=1,6 do
        if team[i] and team[i].major ~= C_MAJOR_FAINTED then
            return team[i]
        end
    end
end $$
