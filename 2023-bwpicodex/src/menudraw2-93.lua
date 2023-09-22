|[f_browse_draw2]|      function(game) f_draw2_pokeinfo(c_pokemon[game:f_modes_cursor'browse']) end $$
|[f_editteam_draw2]|    function(game) f_print_draw2_message("spot #"..(game:f_modes_cursor'editteam'+1)) end $$
|[f_teammoves_draw2]|   function(game) f_print_draw2_message("move #"..(game:f_modes_cursor'teammoves'+1)) end $$
|[f_team_draw2]|        function(game) f_print_draw2_message(game.ui_pl) end $$
|[f_fightover_draw2]|   function(game) f_print_draw2_message"match over" end $$

|[f_teammovesel_draw2]|  function(game) 
    local move = game:f_modes_entry'teammovesel'
    f_print_draw2_message(move and move.ref)
end $$

-- picodex logo
|[f_main_draw2]| function()
    rectfill(0, 0, 46, 13, 13)
    local xx = 0
    for i,v in ipairs(split'6,5,5,6,6,5,6') do
        sspr(0*8+xx, 8*8, v,8, xx+3, 3.5+cos((t()+i)/4))
        xx += v
    end
end $$

|[f_turn_draw2]|  function(game) f_print_draw2_message(game.cur_action.pl.name) end $$
