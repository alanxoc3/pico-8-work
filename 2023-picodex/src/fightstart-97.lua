-- fight is: turn -> turn -> { (p1 select) -> (p2 select) -> whogoesfirst -> turn -> turn -> ...repeat }
-- in turn init, if there are ~c_no actions then go to p1 select
-- in turn init, switch p0
-- 
-- team1/team2: { {num=123, moves={1=3, 2=4, 3=31, 4=68 }}, ... }

-- story - win (p1)   - p2 killed pkmn are added to picodex & increment trainer story
-- horde - win (both) - p2 killed pkmn are added to picodex
-- horde - die (p2)   - p2 adds a new pkmn to the team

|[f_begin_fight]| function(_ENV, d1, d2)
    -- winlogic could be used for story mode.
    -- p1 has higher starting priority so game shows their pokemon to come out first
    -- horde count is only used for p2. this is the index the horde is currently on.

    d1.key, d2.key = 'p1', 'p2'
    for dd in _all{d1, d2} do
        _ENV[dd.key] = f_zobj([[
            actions,#, priority,1,
            menu_action,@, menu_move,@, menu_switch,@, team,@, name,@, iscpu,@, winlogic,@
        ]], f_create_menu(f_menu_drawentry),
            f_create_menu(f_menu_drawentry),
            f_create_menu(f_browse_drawentry, 3),
            _unpack(dd))
        local _ENV=_ENV[dd.key]
        menu_action.cancel = f_beep
        _add(actions, f_pkmn_comes_out(_ENV, f_get_next_active(team)))
    end

    _ENV:f_modes_push'turn'
end $$

-- horde and story share similar logic for cpu battle
|[f_begin_fight_cpu]| function(_ENV, pkmn_nums, name, plwinfunc, cpuwinfunc)
    local cpu_team_draft = {}
    for i=1,#pkmn_nums do
        f_set_default_team_pkmn(cpu_team_draft, i, pkmn_nums[i])
    end

    f_begin_fight(_ENV,
        {_ENV:f_get_team_cursor'team1', "player", false, plwinfunc},
        {cpu_team_draft,                name,     true,  cpuwinfunc}
    )
end $$
