-- We write save data to the general purpose buffer, until a save platform
-- is triggered.

cartdata"CART_NAME"

-- DEBUG_BEGIN
g_debug = false
-- DEBUG_END

menuitem(1, "restart", function()
   extcmd'reset'
end)

menuitem(2, "reset save data", function()
   memset(REAL_SAVE_LOCATION, 0, SAVE_LENGTH)
   extcmd'reset'
end)

function _init()
   memset(TEMP_SAVE_LOCATION, 0, SAVE_LENGTH)
   map_init()

   g_tl = ztable([[
      x=64, y=64, i=nf, u=nf, d=@1, tl_max_time=2.5; -- logo
      i=@2, u=@3, d=@4; -- game
      i=@5, u=@6, d=@7; -- game over
   ]], logo_draw, game_init, game_update, game_draw, game_over_init, game_over_update, game_over_draw)
end

create_actor([[game_over_checker;0;act,;|
   u:@1;
]], function(a)
   if btnp'4' or btnp'5' then
      a:kill()

      _g.fader_out(nf, function()
         g_tl.tl_next = 2
      end)
   end
end)

function game_over_init()
   _g.fader_in(nf, _g.game_over_checker)
   game_over_sind, game_over_text = unpack(rnd_item(ztable[[
      32,  "quack quack";
      68,  "and play with me";
      70,  "to save hi-roll";
      81,  "in time for dinner";
      83,  "and make me rich";
      96,  "the banjo awaits you";
      99,  "for your fans";
      118, "splat splat boing";
   ]]))
end

function logo_draw(a)
   local logo_opacity = 8+cos(a.tl_tim/a.tl_max_time)*4-4

   fade(logo_opacity)
   camera(logo_opacity > 1 and rnd_one())
   zspr(192, a.x, a.y, 4, 2)
   fade'0'
   camera()
end

function game_over_update()
   batch_call_new(acts_loop, [[
      act,update;
   ]])
end

function game_over_draw()
   fade(g_card_fade)
   camera(-8*8, -7*8)
   spr_and_out(game_over_sind, .5, sgn(cos(t()/2))/2+1, 1, 1, true, false, 1)

   batch_call_new(tprint, [[
      "game over", 0, -17, 8, 2;
      "come back lank", 0, 12, 10, 4;
      @1, 0, 22, 7, 5;
   ]], game_over_text)

   camera()
end

function _update60()
   -- DEBUG_BEGIN
   if g_debug then
      poke(0x5f42,15) -- glitch sound
   else
      poke(0x5f42,0) -- no glitch sound
   end
   -- DEBUG_END

   if g_tbox_update then
      zsfx(2,5)
      if g_tbox_writing then
         g_tbox_anim = #g_tbox_active.l1+#g_tbox_active.l2
      else
         del(g_tbox_messages, g_tbox_active)
         g_tbox_active, g_tbox_anim = g_tbox_messages[1], 0
      end

      if not g_tbox_active then
         unpause()
         g_tbox_messages.trigger()
      end

      g_tbox_update = false
   end

   -- DEBUG_BEGIN
   if btnp'5' and btn'4' then
      g_debug = not g_debug
   end
   -- DEBUG_END

   tl_node(g_tl)
   tbox_interact()
end

function _draw()
   cls()
   call_not_nil(g_tl, 'd', g_tl)
end

function game_update()
   room_update(g_pl or g_title)

   local was_paused = is_game_paused()
   if is_game_paused() and g_pause_init then
      g_pause_init = false
      batch_call_new(acts_loop, [[act, pause_init]])
      -- poke(0x5f43,1+2+4) -- softer sound
   elseif not is_game_paused() then
      energy_update(.25)
   end

   inventory_update()

   batch_call_new(
      acts_loop, [[
         act,update;
         drawable_obj,reset_off;
         stunnable,stun_update;
         act,pause_update;
         mov,move;
         col,move_check,@1;
         col,move_check,@4;
         trig,trigger_update,@3;
         tcol,coll_tile,@2;
         rel,rel_update;
         vec,vec_update;
         bounded,check_bounds;
         anim,anim_update;
         timed,tick;
         view,update_view;
      ]],
      g_act_arrs['col'],
      function(x, y)
         return x >= g_cur_room.x and x < g_cur_room.x+g_cur_room.w and
                y >= g_cur_room.y and y < g_cur_room.y+g_cur_room.h and
                fget(mget(x, y), 6)
      end,
      g_pl,
      g_act_arrs['anchored']
   )

   if not was_paused and is_game_paused() then
      g_pause_init = true
   end

   if was_paused and not is_game_paused() then
      batch_call_new(acts_loop, [[act, pause_end]])
   end

   batch_call_new(acts_loop, [[act, clean]])

   -- card_shake_update()
end

-- g_card_shake_x, g_card_shake_y, g_card_shake_time = 0, 0, 0
-- function card_shake_update()
   -- if g_card_shake_time > 0 then
      -- g_card_shake_x = rnd_one()/8
      -- g_card_shake_y = rnd_one()/8
      -- g_card_shake_time -= 1
   -- else
      -- g_card_shake_x, g_card_shake_y = 0, 0
      -- --sfx(9,-2)
   -- end
-- end

--function card_shake()
   --if g_card_shake_time == 0 then
      --g_card_shake_time = 15
   --end
--end

function camera_to_view(view)
   camera((view.x-view.off_x-8)*8, (view.y-view.off_y-8)*8)
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

      isorty(g_act_arrs.drawable)
      batch_call_new(acts_loop, [[
         pre_drawable,  d;
         drawable,      d;
         post_drawable, d;
      ]])

      -- DEBUG_BEGIN
      if g_debug then acts_loop('dim', 'debug_rect') end
      -- DEBUG_END

      clip()
      camera()
      zrect(x1, y1, x2, y2)
   end
end

function game_draw()
   -- local x, y = 8+g_card_shake_x, 7+g_card_shake_y

   fade(g_card_fade)
   map_draw(g_main_view, 8, 7)
   camera_to_view(g_main_view)
   if g_menu_open then
      if g_selected == 5 then g_pl.outline_color = SL_UI end
      g_pl.d(g_pl)
   end
   acts_loop('above_map_drawable', 'd')
   camera()
   draw_status()
   ttbox_draw(2,105)
end

function game_init()
   batch_call_new(acts_loop, [[acts,kill;acts,delete;]])

   memcpy(TEMP_SAVE_LOCATION, REAL_SAVE_LOCATION, SAVE_LENGTH)

   -- DEBUG_BEGIN
   -- We don't care about save info with debug mode.
   memset(TEMP_SAVE_LOCATION, 0, SAVE_LENGTH)

   -- Let's get all the items in debug mode.
   batch_call_new(zdset, [[
      HAS_BOOMERANG,;
      HAS_SWORD,;
      HAS_SHIELD,;
      HAS_BANJO,;
      -- BANJO_TUNED,;
      CAN_THROW_POTS,;
   ]])
   -- DEBUG_END

   -- After here, we can set memory locations that will be in effect during the
   -- game.
   zdset'ALWAYS_TRUE' -- Used with inventory and npcs.
   if not zdget'GAME_CONTINUE' then -- logic for new games
      zdset(MAX_HEALTH, LANK_START_HEALTH)
      zdset(HEALTH, LANK_START_HEALTH)
      zdset'GAME_CONTINUE'
   end

   -- DEBUG_BEGIN
   zdset(HEALTH, 1)
   -- DEBUG_END

   inventory_init()
   g_energy, g_energy_tired, g_energy_amount = 0, false, 0
   g_money = zdget_value(MONEY)

   -- g_pl = _g.pl(0, 0)

   g_pl = nil -- for game over reset
   g_title = _g.title()
   g_card_fade = 8
   _g.fader_in(
      function()
         pause'transitioning'
      end, function()
         unpause()
      end
   )

   -- load_room(R_13, 3, 5, g_pl)
   -- load_room(R_01, 8, 5, g_pl)
   local spot = g_save_spots[zdget_value'SAVE_SPOT']
   load_room(spot.room, spot.x, spot.y, g_title)
   -- load_room(R_17, 5, 5, g_pl)
end

function pause(reason)
   if reason == 'dancing' or reason == 'chest' then
      mute_music()
   end
   stop_music()

   g_pause_reason=reason g_game_paused=true
end

function unpause() resume_music() g_game_paused=false end

function is_game_paused(reason)
   return g_game_paused and (reason == g_pause_reason or not reason)
end

function zdget_value(ind)
   return peek(TEMP_SAVE_LOCATION+ind)
end

function zdget(ind)
   return zdget_value(ind) > 0
end

function zdset(ind, val)
   return poke(TEMP_SAVE_LOCATION+ind, val or 1)
end

function mute_music()
   sfx(63,0,0)
   sfx(62,1,1)
end

function stop_music(sound)
   poke(0x5f43,3)
   -- mute_music()
   if sound then
      sfx(sound)
   end
end

function resume_music(song)
   switch_song(song)
   poke(0x5f43,0)
   sfx(63,-1) sfx(62,-1)
   g_music_current = song or g_music_current
end

-- switches the current song
function switch_song(song)
   if song and song ~= g_music_current then
      g_music_current = song
      music(song, 500, 7)
   end
end
