|[f_story_select]| function(game) game:f_modes_push'team2story' end $$
|[f_match_select]| function(game) game:f_modes_push'team2match' end $$

|[f_match_start]| function(_ENV)
    f_begin_fight(_ENV,
        f_zobj([[,@,"player 1", ~c_no, ~f_nop]], f_get_team(_ENV:f_modes_cursor'team1match')),
        f_zobj([[,@,"player 2", ~c_no, ~f_nop]], f_get_team(_ENV:f_modes_cursor'team2match'))
    )
end $$

|[f_update_horde]| function(_ENV)
    _poke(S_HOARD, _mid(@S_HOARD, #f_get_team_dead(team), 152))
end $$

|[f_horde_select]| function(_ENV)
    local nums = {}

    -- mod here will add missingno (feature, not a bug :)
    for i=1,152 do _add(nums, i%152) end

    -- unlock pkmn and update high score regardless of win/lose
    -- the only pokemon you can unlock is missingno,
    -- since horde mode doesn't appear until after league
    f_begin_fight_cpu(_ENV, nums, "horde", function(_, other)
        f_unlock_pkmn(other)
        f_update_horde(other)
    end, f_update_horde)
end $$
