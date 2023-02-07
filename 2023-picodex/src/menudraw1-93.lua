|[fightover_draw1]|  function(game) print("todo", 5, 5, 1) end $$

|[editparty_draw1]| function(game)
    _g.modes_default_draw1(game)
    wobble_text("team #"..game:cursor'party'+1, 20, 27, 1)
end $$

|[turn_draw1]|  function(game)
    local a1, a2, active = game.p1.active, game.p2.active, game.cur_action.active
    draw_hp(38, 30, a1.shared.hp, a1.shared.maxhp, a1.shared.major, 1,  active == game.p1.active and 6 or 1)
    draw_hp(1,  9,  a2.shared.hp, a2.shared.maxhp, a2.shared.major, -1, active == game.p2.active and 6 or 1)
    c_pokemon[a1.shared.num].draw(   10, 40-10-t()%2\1, 5)
    c_pokemon[a2.shared.num].draw(40-10,    10+t()%2\1, 5, -1)
end $$

