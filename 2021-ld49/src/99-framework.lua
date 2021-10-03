-- the general pico8 framework functions are here (init, update, draw).

-- DEBUG_BEGIN
g_debug = false
-- DEBUG_END

g_card_fade = 8
poke(0x5f5c, 15) -- set the initial delay before repeating.
poke(0x5f5d, 15) -- set the repeating delay.

function _init()
    music(0, 3000)
    g_tl = ztable([[
--         x=64, y=64, i=@2, u=nf, d=@1, tl_max_time=2.5; -- logo
--         i=@3, u=@4, d=@5; -- title
        i=@6, u=@7, d=@8;  -- game
    ]], logo_draw, function() sfx'63' end,
    title_init, title_update, title_draw,
    game_init, game_update, game_draw
    )
end

function _update60()
   -- DEBUG_BEGIN
   if g_debug then poke(0x5f42,15) -- glitch sound
   else poke(0x5f42,0) -- no glitch sound
   end
   -- DEBUG_END

   -- DEBUG_BEGIN
   if btnp'5' and btn'4' then g_debug = not g_debug end
   -- DEBUG_END

   tl_node(g_tl)
end

function _draw()
    cls()

    -- DEBUG_BEGIN
    if g_debug then
        rect(0,0,127,127,8)
    end
    -- DEBUG_END

    call_not_nil(g_tl, 'd', g_tl)
end

function logo_draw(a)
   local logo_opacity = 8+cos(a.tl_tim/a.tl_max_time)*4-4

   fade(logo_opacity)
   camera(logo_opacity > 1 and rnd_one())
   zspr(108, a.x, a.y, 4, 2)
   fade'0'
   camera()
end
