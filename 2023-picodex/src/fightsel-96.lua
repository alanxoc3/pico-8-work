|[f_story_select]| function(game) game:push'team2story' end $$
|[f_match_select]| function(game) game:push'team2match' end $$

|[f_match_start]| function(_ENV)
    f_begin_fight(_ENV,
        {f_get_team(_ENV:cursor'team1'),      "player 1", false, f_nop, f_nop},
        {f_get_team(_ENV:cursor'team2match'), "player 2", false, f_nop, f_nop}
    )
end $$

|[f_horde_select]| function(_ENV)
    local nums = {}

    -- mod here will add missingno (feature, not a bug :)
    for i=1,152 do _add(nums, i%152) end

    -- unlock pkmn and update high score regardless of win/lose
    -- the only pokemon you can unlock is missingno,
    -- since horde mode doesn't appear until after league
    f_begin_fight_cpu(_ENV, nums, "horde", f_nop,
        function(_, other) f_horde_win_func(other) end,
        f_horde_win_func
    )
end $$

|[f_horde_win_func]| function(horde)
    f_unlock_pkmn(horde)
    poke(S_HOARD, mid(@S_HOARD, #f_get_team_dead(horde.team), 255))
end $$
