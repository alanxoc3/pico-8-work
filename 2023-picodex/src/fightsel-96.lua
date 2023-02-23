-- todo: make it so when hoard is over, it increments the hoard high score

|[f_story_select]| function(game) game:push'team2story' end $$
|[f_match_select]| function(game) game:push'team2match' end $$

|[f_match_start]| function(_ENV)
    -- |[f_begin_fight]| function(game, party1, party2, name1, name2, iscpu1, iscpu2, p1_die_logic, p2_die_logic, p1_win_logic, p2_win_logic)
    f_begin_fight(_ENV, f_get_party(_ENV:cursor'team1'), f_get_party(_ENV:cursor'team2match'), "player 1", "player 2", false, false, f_nop, f_nop, f_nop, f_nop)
end $$

-- |[f_story_winlogic]| function(pl, other)
--     poke(S_STORY, min(@S_STORY+1, #c_trainers))
--     -- todo: add pokemon that were defeated to pokedex.
-- end $$

|[f_hoard_death]| function(p)
    -- first, shift everything in the party to the left.
    local newparty = {}
    for i=1,6 do
        if p.party[i] and p.party[i].major ~= C_MAJOR_FAINTED then
            _add(newparty, p.party[i])
        end
    end

    -- then add new pokemon
    for i=#newparty+1,6 do
        -- wrap for missingno, then continue with bulbasaur again
        p.hoardind = (p.hoardind+1) % 152
        newparty[i] = f_create_party_pkmn(p.hoardind, f_get_natural_moveset(p.hoardind))
    end

    p.party = newparty
end $$

-- todo: dedup with f_fightsel_init
|[f_hoard_select]| function(_ENV)
    local cpu_party_draft = {}
    for num=1,6 do
        _add(cpu_party_draft, { num=num, moves=f_get_natural_moveset(num) })
    end

    -- |[f_begin_fight]| function(game, party1, party2, name1, name2, iscpu1, iscpu2, p1_die_logic, p2_die_logic, p1_win_logic, p2_win_logic)
    f_begin_fight(_ENV, f_get_party(_ENV:cursor'team1'), cpu_party_draft, "player 1", "hoard", false, true, f_nop, f_hoard_death, f_story_winlogic, f_nop)
end $$
