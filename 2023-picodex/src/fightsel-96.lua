|[f_story_select]| function(game) game:push'team2story' end $$
|[f_match_select]| function(game) game:push'team2match' end $$

|[f_match_start]| function(_ENV)
    -- |[f_begin_fight]| function(game, team1, team2, name1, name2, iscpu1, iscpu2, p1_die_logic, p2_die_logic, p1_win_logic, p2_win_logic)
    f_begin_fight(_ENV, f_get_team(_ENV:cursor'team1'), f_get_team(_ENV:cursor'team2match'), "player 1", "player 2", false, false, f_nop, f_nop, f_nop, f_nop)
end $$

|[f_horde_death]| function(p)
    -- first, shift everything in the team to the left.
    local newteam = {}
    for i=1,6 do
        if p.team[i] and p.team[i].major ~= C_MAJOR_FAINTED then
            _add(newteam, p.team[i])
        end
    end

    -- then add new pokemon
    for i=#newteam+1,6 do
        if p.hordeind < 152 then
            p.hordeind += 1

            -- wrap for missingno. missingno is the last pokemon in horde
            newteam[i] = f_create_team_pkmn(p.hordeind%152, f_get_natural_moveset(p.hordeind%152))
        end
    end

    p.team = newteam
end $$

-- todo: dedup with f_fightsel_init
|[f_horde_select]| function(_ENV)
    local cpu_team_draft = {}
    for num=1,6 do
        _add(cpu_team_draft, { num=num, moves=f_get_natural_moveset(num) })
    end

    -- |[f_begin_fight]| function(game, team1, team2, name1, name2, iscpu1, iscpu2, p1_die_logic, p2_die_logic, p1_win_logic, p2_win_logic)
    f_begin_fight(_ENV,
        _ENV:f_get_team_cursor'team1', cpu_team_draft,
        "player 1", "horde",
        false, true,
        f_nop, f_horde_death,
        f_nop, function(horde)
            poke(S_HOARD, mid(@S_HOARD, #horde.deadnums, 255))
        end
    )
end $$
