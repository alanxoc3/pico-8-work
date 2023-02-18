-- fight is: turn -> turn -> { (p1 select) -> (p2 select) -> whogoesfirst -> turn -> turn -> ...repeat }
-- in turn init, if there are no actions then go to p1 select
-- in turn init, switch p0
-- 
-- party1/party2: { {num=123, moves={1=3, 2=4, 3=31, 4=68 }}, ... }
|[f_begin_fight]| function(game, party1, party2, name1, name2, iscpu1, iscpu2)
    local party1, party2 = f_get_fight_party(party1), f_get_fight_party(party2)

    -- winlogic could be used for story mode.
    -- p1 has higher starting priority so game shows their pokemon to come out first
    game.p1 = { name=name1, priority=1, iscpu=iscpu1, actions={}, active=f_party_pkmn_to_active(f_get_next_active(party1)), party=party1, winlogic=f_nop }
    game.p2 = { name=name2, priority=0, iscpu=iscpu2, actions={}, active=f_party_pkmn_to_active(f_get_next_active(party2)), party=party2, winlogic=f_nop }

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
