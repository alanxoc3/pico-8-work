|[f_browse_draw2]|      function(game) f_draw2_pokeinfo(c_pokemon[game:cursor'browse']) end $$
|[f_editparty_draw2]|   function(game) f_print_draw2_message("spot #"..(game:cursor'editparty'+1)) end $$
|[f_partymoves_draw2]|  function(game) f_print_draw2_message("move #"..(game:cursor'partymoves'+1)) end $$
|[f_team_draw2]|        function(game) f_print_draw2_message(game.ui_pl) end $$
|[f_fightover_draw2]|   function(game) f_print_draw2_message"match over" end $$
|[f_pselactions_draw2]| function(_) end $$
|[f_pselmove_draw2]|    function(game) end $$

|[f_partymovesel_draw2]|  function(game) 
    local move = game:entry'partymovesel'
    f_print_draw2_message(move and move.ref)
end $$

-- picodex logo
|[f_main_draw2]| function()
    _rectfill(0, 0, 46, 13, 13)
    _pal(7,1)

    local xx = 0
    for i,v in _ipairs(_split'6,5,5,6,6,5,6') do
        _sspr(6*8+xx, 6*8, v,8, xx+3, 3.5+_cos((_t()+i)/4))
        xx += v
    end

    _pal()
end $$

|[f_turn_draw2]|  function(game)
    f_print_draw2_message(game.cur_action.pl.name)
end $$
