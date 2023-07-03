-- TEMPLATE TOKEN COUNT: 1045
function _init()
    g_tl = f_zclass[[
        level,1;
        begin; init,   ~f_game_init,
               update, ~f_game_update,
               draw,   ~f_game_draw;
    ]]

    palt(0, false)

    -- use a 64x64 screen instead of 128x128
    -- saves ~.09 cpu because sspr doesn't have to scale as much
    poke(0x5f2c, 3)
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

-- BLOCK IDEAS
-- : pushable      (bomb can blow up, breakable) GRAVITY TOGETHER
-- : pushable hurt (bomb can blow up, breakable) GRAVITY TOGETHER
-- : bomb (deletes itself and something else) GRAVITY TOGETHER 
-- : sticky GRAVITY
-- : particle GRAVITY
-- : player core
-- : move towards player core
-- : autocontrol core (direction)                             ANTIGRAVITY NONSTATIC
-- : background                                               ANTIGRAVITY STATIC
-- : invincible wall                                          ANTIGRAVITY STATIC
-- : goal (part of background)                                ANTIGRAVITY STATIC
-- : trashcan pixel (immovable indestructable deletes things) ANTIGRAVITY STATIC
-- : graffiti                                                 ANTIGRAVITY STATIC
