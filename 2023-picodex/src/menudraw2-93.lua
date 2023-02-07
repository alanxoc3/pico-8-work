|[browse_draw2]|      function(game) draw2_pokeinfo(get_browse_pokemon(game:cursor'browse'+1))    end $$
|[editparty_draw2]|   function(game) print_draw2_message("spot #"..(game:cursor'editparty'+1))    end $$
|[fightover_draw2]|   function(game) print_draw2_message"match over" end $$
|[pselactions_draw2]| function(_)                                                                end $$
|[pselmove_draw2]|    function(game)                                                             end $$

|[partymovesel_draw2]|  function(game) 
    local move = game:entry'partymovesel'
    print_draw2_message(move and move.ref)
end $$

-- picodex logo
|[main_draw2]| function()
    rectfill(0, 0, 46, 13, 13)
    pal(7,1)

    local xx = 0
    for i,v in ipairs(split'6,5,5,6,6,5,6') do
        sspr(6*8+xx, 6*8, v,8, xx+3, 3.5+cos((t()+i)/4))
        xx += v
    end

    pal()
end $$

|[turn_draw2]|  function(game)
    print_draw2_message(game.cur_action.pl.name)
end $$
