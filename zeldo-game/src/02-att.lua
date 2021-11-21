-- If the game is paused, only run paused functions.
function acts_loop(id, func_name, ...)
   for a in all(g_act_arrs[id]) do
      if not is_game_paused() or is_game_paused() and a.pause[func_name] then
         call_not_nil(a, func_name, a, ...)
      end
   end
end
