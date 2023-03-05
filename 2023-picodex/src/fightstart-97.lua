-- fight is: turn -> turn -> { (p1 select) -> (p2 select) -> whogoesfirst -> turn -> turn -> ...repeat }
-- in turn init, if there are %c_no actions then go to p1 select
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
            menu_action,@, menu_move,@, menu_stats,@, menu_switch,@, team,@, name,@, iscpu,@, dielogic,@, winlogic,@
        ]], f_create_menu(f_menu_drawentry),
            f_create_menu(f_menu_drawentry),
            f_create_menu_view(f_menu_drawentry),
            f_create_menu(f_browse_drawentry, 3),
            _unpack(dd))
        local _ENV=_ENV[dd.key]
        statplayer = _ENV

        -- todo: look at usages, but the get_fight_team call here might not be needed
        menu_action.cancel, team = f_beep, f_get_fight_team(team)      
        active = f_team_pkmn_to_active(f_get_next_active(team))
        _add(actions, f_newaction(_ENV, "#,comes,out"))
    end

    -- how to switch the current player
    -- p0 = p0 == p1 and p2 or p1
    p0 = p1
    _ENV:push'turn'
end $$

-- horde and story share similar logic for cpu battle
|[f_begin_fight_cpu]| function(_ENV, team, name, deathfunc, plwinfunc, cpuwinfunc)
    local cpu_team_draft = {}
    _foreach(team, function(pkmn)
        -- todo: maybe use f_set_default_team_pkmn
        _add(cpu_team_draft, f_create_team_pkmn(pkmn, f_get_natural_moveset(pkmn)))
    end)

    f_begin_fight(_ENV,
        {_ENV:f_get_team_cursor'team1', "player", false, f_nop,     plwinfunc},
        {cpu_team_draft,                name,     true,  deathfunc, cpuwinfunc}
    )
end $$
