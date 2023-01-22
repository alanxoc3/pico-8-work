---------------------------------------------------------------------------
-- psel main menu
---------------------------------------------------------------------------
c_pselactions = zobj[[
    ; name,"fight",   desc,"select|a|move",         func,%menu_state_callback, state,pselmove
   ;; name,"switch",  desc,"change|active|pokemon", func,%menu_state_callback, state,pselswitch
   ;; name,"forfeit", desc,"leave|the|fight",       func,%psel_forfeit
]]

|[psel_init]| function(game)
    game.p0 = game[game.p0key]
    poke2(S_CURSOR_PSELACTION, 0)

    -- skip this state if the player is a cpu
    if game.p0.iscpu or #game.p0.actions > 0 then
        game:load()
    else
        game.cur_action = newaction(game.p0, "")
        game:push'pselactions'
    end
end $$

|[pselactions_update]| function(game) menu_update(game, S_CURSOR_PSELACTION, c_pselactions, true) end $$
|[pselactions_draw1]|  function(game) menu_draw1 (game, S_CURSOR_PSELACTION, c_pselactions) end $$
|[pselactions_draw2]|  function(game) end $$
|[pselactions_draw3]|  function(game) end $$

|[psel_forfeit]| function(a, game)
    game:pop()

    -- must set game.p0 to the other player, so it shows they win
    game.p0 = get_other_pl(game, game.p0)
    game:load'fightover'
end $$

---------------------------------------------------------------------------
-- psel move menu
---------------------------------------------------------------------------

-- todo: support struggle
function err_beep() sfx'60' end -- todo: move and use this
|[pselmove_init]|   function(game)
    game.available_actions = {}

    -- todo: remove possible moves var
    local possible_moves = get_possible_move_slots(game.p0.active)
    for move_slot in all(possible_moves) do
        add(game.available_actions, {
            name=c_moves[game.p0.active.moveids[move_slot]].name,
            desc="todo",
            func=function()
                game:pop()
                game:pop()

                select_move(game.p0, move_slot)
            end
        })
    end
end $$

|[pselmove_update]| function(game) menu_update(game, S_CURSOR_PSELACTION, game.available_actions) end $$
|[pselmove_draw1]|  function(game) menu_draw1 (game, S_CURSOR_PSELACTION, game.available_actions) end $$
|[pselmove_draw2]|  function(game) end $$
|[pselmove_draw3]|  function(game) end $$

---------------------------------------------------------------------------
-- psel switch menu
---------------------------------------------------------------------------

