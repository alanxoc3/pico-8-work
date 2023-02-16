|[fightover_draw1]|  function(game) print("todo", 5, 5, 1) end $$

|[editparty_draw1]| function(game)
    _g.modes_default_draw1(game)
    wobble_text("team #"..game:cursor'team1'+1, 20, 27, 1)
end $$

-- todo: token crunching.
|[turn_draw1]|  function(game)
    local a1, a2, active = game.p1.active, game.p2.active, game.cur_action.active
    local a1a, a2a = active == a1, active == a2
    rectfill(0,0,39,39,5)
    rectfill(0,5,39,34,13)

    if a1.shared.major ~= C_MAJOR_FAINTED then
        pal(1,a1a and 6 or 1) spr(198,20,26,3,1) pal(1,1)
        zprint(a1.shared.hp.."H", 41, 29-2, 13, 1)
        draw_hp(40, 31+6, a1.shared.hp, a1.shared.maxhp,  1,  1)
        c_pokemon[a1.shared.num].draw(   10, 40-15, 5)
    end

    if a2.shared.major ~= C_MAJOR_FAINTED then
        pal(1,a2a and 6 or 1) spr(198,-4,7,3,1) pal(1,1)
        zprint(a2.shared.hp.."H", 1,  6+2,  13, -1)
        draw_hp(-1,  8 -6, a2.shared.hp, a2.shared.maxhp, -1, 1)
        c_pokemon[a2.shared.num].draw(40-10,    15, 5, -1)
    end
end $$
