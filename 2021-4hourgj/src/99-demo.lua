-- We write save data to the general purpose buffer, until a save platform
-- is triggered.

-- DEBUG_BEGIN
g_debug = false
-- DEBUG_END

g_card_fade = 8
poke(0x5f5c, 15) -- set the initial delay before repeating.
poke(0x5f5d, 15) -- set the repeating delay.

function _init()
    music(0, 3000)
    g_tl = ztable([[
        -- x=64, y=64, i=@2, u=nf, d=@1, tl_max_time=2.5; -- logo
        i=@3, u=@4, d=@5;  -- game
    ]], logo_draw, function() sfx'63' end,
    game_init, game_update, game_draw
    )
end

function game_init(a)
    _g.fader_in(.5, nf, nf)

    g_cur_room = tabcpy(ztable[[
        x:-16; y:0; w:64; h:16;
    ]])

    g_pl = _g.pl(8, 5)
    g_main_view = _g.view(16, 16, 3, g_pl)
    g_main_view:center_view()
end

function game_update(a)
   batch_call_new(
      acts_loop, [[
         act,update;
         drawable_obj,reset_off;
         mov,move;
         pl,move_check,@1;
         tcol,coll_tile,@2;
         rel,rel_update;
         vec,vec_update;
         kill_too_high,check_height;
         bounded,check_bounds;
         anim,anim_update;
         timed,tick;
         view,update_view;
      ]], g_act_arrs['col'],
      function(x, y)
         return x >= g_cur_room.x and x < g_cur_room.x+g_cur_room.w and
                y >= g_cur_room.y and y < g_cur_room.y+g_cur_room.h and
                fget(mget(x, y), 6)
      end
   )

    batch_call_new(acts_loop, [[act, clean]])
end

function game_draw(a)
    fade(g_card_fade)
    map_draw(g_main_view, 8, 8)
end

function logo_draw(a)
   local logo_opacity = 8+cos(a.tl_tim/a.tl_max_time)*4-4

   fade(logo_opacity)
   camera(logo_opacity > 1 and rnd_one())
   zspr(108, a.x, a.y, 4, 2)
   fade'0'
   camera()
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



-- CAMERA STUFF

function shiftx(view)
    return (view.x-view.off_x-8)*8
end

function shifty(view)
    return (view.y-view.off_y-8)*8
end

function camera_to_view(view)
   camera(shiftx(view), shifty(view))
end

function map_draw(view, x, y)
   if view then
      local rx = x - view.w/2
      local ry = y - view.h/2

      view.off_x = -(16-view.w)/2+rx
      view.off_y = -(16-view.h)/2+ry

      local x1, x2 = rx*8+4, (rx+view.w)*8-5
      local y1, y2 = ry*8+4, (ry+view.h)*8-5
      camera_to_view(view)

      zclip(x1, y1, x2, y2)
      zcls(g_cur_room.c)

      scr_map(g_cur_room.x, g_cur_room.y, g_cur_room.x, g_cur_room.y, g_cur_room.w, g_cur_room.h)

      batch_call_new(acts_loop, [[
            pre_drawable, d;
            pre_drawable_1, d;
            pre_drawable_2, d;
        ]])

      isorty(g_act_arrs.drawable)
      batch_call_new(acts_loop, [[
         drawable,      d;
         drawable_1,      d;
         drawable_2,      d;
         post_drawable, d;
         post_drawable_1, d;
         post_drawable_2, d;
      ]])

      -- DEBUG_BEGIN
      if g_debug then
         acts_loop('dim', 'debug_rect')
      end
      -- DEBUG_END

      clip()
      camera()
      -- zrect(x1, y1, x2, y2)

      -- DEBUG_BEGIN
      if g_debug then
         -- rect(g_cur_room.x, g_cur_room.y, 20, 20, 8)
      end
      -- DEBUG_END
   end
end
