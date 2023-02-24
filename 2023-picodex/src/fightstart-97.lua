-- fight is: turn -> turn -> { (p1 select) -> (p2 select) -> whogoesfirst -> turn -> turn -> ...repeat }
-- in turn init, if there are no actions then go to p1 select
-- in turn init, switch p0
-- 
-- party1/party2: { {num=123, moves={1=3, 2=4, 3=31, 4=68 }}, ... }

-- story - win (p1)   - p2 killed pkmn are added to picodex & increment trainer story
-- horde - win (both) - p2 killed pkmn are added to picodex
-- horde - die (p2)   - p2 adds a new pkmn to the party

-- todo: token crunching here...
|[f_begin_fight]| function(game, party1, party2, name1, name2, iscpu1, iscpu2, p1_die_logic, p2_die_logic, p1_win_logic, p2_win_logic)
    local party1, party2 = f_get_fight_party(party1), f_get_fight_party(party2)

    -- winlogic could be used for story mode.
    -- p1 has higher starting priority so game shows their pokemon to come out first
    -- horde count is only used for p2. this is the index the horde is currently on.
    game.p1 = { name=name1, hordeind=6, deadnums={}, priority=1, iscpu=iscpu1, actions={}, active=f_party_pkmn_to_active(f_get_next_active(party1)), party=party1, winlogic=p1_win_logic, dielogic=p1_die_logic }
    game.p2 = { name=name2, hordeind=6, deadnums={}, priority=0, iscpu=iscpu2, actions={}, active=f_party_pkmn_to_active(f_get_next_active(party2)), party=party2, winlogic=p2_win_logic, dielogic=p2_die_logic }

    _add(game.p1.actions, f_newaction(game.p1, "#,comes,out"))
    _add(game.p2.actions, f_newaction(game.p2, "#,comes,out"))

    -- how to switch the current player
    -- game.p0 = game.p0 == game.p1 and game.p2 or game.p1
    game.p0 = game.p1
    game.pselactions.menu.c, game.pselmove.menu.c = 0, 0 -- cursor should not copy previous fights

    game:push'turn'
end $$

-- used to switch to the next pkmn at the start of the battle and when a pkmn is ko-ed.
-- if this returns nil, the battle is over
|[f_get_next_active]| function(party)
    for i=1,6 do
        if party[i] and party[i].major ~= C_MAJOR_FAINTED then
            return party[i]
        end
    end
end $$
