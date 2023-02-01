---------------------------------------------------------------------------
-- psel main menu
---------------------------------------------------------------------------
|[psel_init]| function(game)
    game.p0 = game[game.p0key]
    g_cursors.pselaction = 0

    -- skip this state if the player is a cpu
    if game.p0.iscpu or #game.p0.actions > 0 then
        game:load()
    else
        game.cur_action = newaction(game.p0, "")
        game:push'pselactions'
    end
end $$

|[pselactions_init]| function(game)
    game.menu_pselactions:refresh(zobj[[
         ; name,"fight",   desc,"select|a|move",         select,%menu_state_callback, state,pselmove
        ;; name,"switch",  desc,"change|active|pokemon", select,%menu_state_callback, state,pselswitch
        ;; name,"forfeit", desc,"leave|the|fight",       select,%psel_forfeit
    ]])
end $$

|[pselactions_update]| function(game) game.menu_pselactions:update(game) end $$
|[pselactions_draw1]|  function(game) game.menu_pselactions:draw1() end $$
|[pselactions_draw2]|  function(_) end $$
|[pselactions_draw3]|  function(_) end $$

|[psel_forfeit]| function(a, game)
    game:pop()

    -- must set game.p0 to the other player, so it shows they win
    game.p0 = get_other_pl(game, game.p0)
    game:load'fightover'
end $$

---------------------------------------------------------------------------
-- psel move menu
---------------------------------------------------------------------------

-- todo: try making the minifier separate on underscores
-- todo: support struggle
function err_beep() sfx'60' end -- todo: move and use this
|[pselmove_init]|   function(game)
    game.menu_pselmove:refresh(get_possible_move_slots(game.p0.active), function(move_slot)
        return {
            name=c_moves[game.p0.active.moveids[move_slot]].name,
            desc="todo",
            select=function()
                game:pop() game:pop()
                select_move(game.p0, move_slot)
            end
        }
    end)
end $$

|[pselmove_update]| function(game) game.menu_pselmove:update(game) end $$
|[pselmove_draw1]|  function(game) game.menu_pselmove:draw1() end $$
|[pselmove_draw2]|  function(game) end $$
|[pselmove_draw3]|  function(game) end $$

---------------------------------------------------------------------------
-- psel switch menu
---------------------------------------------------------------------------
