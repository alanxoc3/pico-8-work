|[f_fightover_draw1]|  function(game) _print("todo", 5, 5, 1) end $$

|[f_editparty_draw1]| function(game)
    f_modes_default_draw1(game)
    f_wobble_text("team #"..game:cursor'team1'+1, 20, 27, 1)
end $$

-- todo: token crunching.
|[f_turn_draw1]|  function(game)
    local a1, a2, active = game.p1.active, game.p2.active, game.cur_action.active
    local a1a, a2a = active == a1, active == a2
    _rectfill(0,0,39,39,5)
    _rectfill(0,5,39,34,13)

    if a1.shared.major ~= C_MAJOR_FAINTED and not a1.invisible then
        _pal(1,a1a and 6 or 1) _spr(198,20,26,3,1) _pal(1,1)
        f_zprint(a1.shared.hp.."H", 41, 29-2, 13, 1)
        f_draw_hp(40, 31+6, a1.shared.hp, a1.shared.maxhp,  1,  1)
        c_pokemon[a1.shared.num].draw(   10, 40-15, 5)
    end

    if a2.shared.major ~= C_MAJOR_FAINTED and not a2.invisible then
        _pal(1,a2a and 6 or 1) _spr(198,-4,7,3,1) _pal(1,1)
        f_zprint(a2.shared.hp.."H", 1,  6+2,  13, -1)
        f_draw_hp(-1,  8 -6, a2.shared.hp, a2.shared.maxhp, -1, 1)
        c_pokemon[a2.shared.num].draw(40-10,    15, 5, -1)
    end
end $$
