|game_init| function()

end $$

|game_update| function()
    loop_entities('actor', 'state')
end $$

|game_draw| function()
    -- draw_room(g_rooms[8*16+8], 64, 64, nop, nop)
    loop_entities('outlayer_99', 'drawout')
    loop_entities('drawlayer_99', 'draw')
end $$
