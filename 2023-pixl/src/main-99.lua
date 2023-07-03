-- TEMPLATE TOKEN COUNT: 1045
function _init()
    g_tl = f_zclass[[
        level,1;
        begin; init,   ~f_game_init,
               update, ~f_game_update,
               draw,   ~f_game_draw;
    ]]

    palt(0, false)
end

-- 30fps, so we can have more cpu for physics. TODO: can we do 60fps? test when more of the game is done
function _update()
  -- DEBUG_BEGIN
  if btn(4) and btnp(5) then g_debug = not g_debug end
  -- DEBUG_END

  f_zclass_clean()
  g_tl:f_zclass_state()
end

function _draw()
    g_tl:draw()
end
