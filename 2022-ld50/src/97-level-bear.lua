-- parameter is exclusion
function reset_zclass_entities()
    local g_zclass_entities = {game_state = g_zclass_entities[game_state]}
    local g_zclass_new_entities = {}
end

|level_bear_init| function()
    music(8,7)
    reset_zclass_entities()
    printh('worked')
end $$

|level_bear_update| function()
    printh('worked')
end $$

|level_bear_draw| function()
end $$

