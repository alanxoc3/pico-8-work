|[f_editteam_draw1]| function(game)
    f_modes_default_draw1(game)
    f_wobble_text("team #"..game:cursor'team1'+1, 20, 27, 1)
end $$

|[f_turn_draw1]|  function(_ENV)
    f_zcall(_rectfill, [[
       ;0,0,39,39,5
      ;;0,5,39,34,13
    ]])

    f_draw_battle_side(p1.active, cur_action.active == p1.active, 1)
    f_draw_battle_side(p2.active, cur_action.active == p2.active, -1)
end $$

|[f_draw_battle_side]| function(_ENV, a1a, flip)
    if major ~= C_MAJOR_FAINTED and not invisible then
        _pal(1,a1a and 6 or 1) _spr(198,8+12*flip,16.5+9.5*flip,3,1) _pal(1,1)
        f_zprint(hp.."H", 21+20*flip, 17.5+9.5*flip, 13, flip)
        f_draw_hp(19.5+20.5*flip, 19.5+17.5*flip, hp, maxhp, flip, 1)
        _ENV:draw(20-10*flip, 20+5*flip, 5, flip)
    end
end $$
