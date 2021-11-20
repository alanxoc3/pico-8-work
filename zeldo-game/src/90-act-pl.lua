-- SECTION: NPC
-- SECTION: PL
create_actor([[lank_top;1;rel,spr_obj,danceable,pre_drawable|
   rel_actor:@1;sind:147;iyy:-2;u:@2;d:@3;
]], function(a)
   a.xf, a.alive = g_pl.xf, g_pl.alive
end, function(a)
   if g_pl:get[[item;throwable]] then
      a.sind=g_pl.item.throwing and 150 or 148
   elseif is_game_paused'dancing' then
      a.sind = abs(a.dance_time) > .5 and 149 or 147
   elseif is_game_paused'chest' then
      a.sind=148
   else
      a.sind=147
   end
end)

create_actor([[grabbed_item;4;rel,spr_obj,confined|
   rel_actor:@1;sind:@2;iyy:@3;create_func:@4;
   room_end:@7;
   throwable:yes;
   flippable:yes;
   being_held:yes;

   i=@6,throwing=no,tl_max_time=.2;
   i=nf,u=@5;
   throwing=yes,visible=no,tl_max_time=.05;
]], function(a)
   if btnp'4' or btn'5' then
      zsfx(2,3)
      a.create_func(a.x, a.y+a.iyy/8, a.xf)
      return true
   end
end, function(a)
   zsfx(2,2)
end, function(a)
   a.rel_actor.item = nil
end)

function calc_act_dist(a, b)
   return abs(a.x-b.x) + abs(a.y-b.y)
end

create_actor([[fairy_tail;1;mov,move_pause,confined;u,|
   rel_actor:@1;
   i:@2;u:@3;
]], function(a)
   a.x = a.rel_actor.x;
   a.y = a.rel_actor.y;
end, function(a)
   amov_to_actor(a, a.rel_actor, .04 * calc_act_dist(a,a.rel_actor))
end)

create_actor([[fairy;1;post_drawable,mov,move_pause;u,|
   rel_actor:@1;u:@2;off_x:1;off_y:0;d:@4;
   i:@3;room_init:@3;
]], function(a)
   local act = get_cur_ma() or a.rel_actor
   amov_to_actor(a, act, calc_act_dist(a,act)*.013, a.off_x, a.off_y)
   a.off_x, a.off_y = cos(a.tl_tim*.75), sin(a.tl_tim*.75)-.25

   if flr(a.tl_tim / 10) % 2 == 0 then
      a.off_x = -a.off_x
   end
end, function(a)
   a.x, a.y, a.tail = a.rel_actor.x, a.rel_actor.y-.25, _g.fairy_tail(a)
end, function(a)
   batch_call_new(scr_line, [[
      @1,             @2,             @3, @4, 12;
      !plus/@1/.125,  @2,             @3, @4, 1;
      !plus/@1/-.125, @2,             @3, @4, 1;
      @1,             !plus/@2/.125,  @3, @4, 1;
      @1,             !plus/@2/-.125, @3, @4, 1;
      @1,             @2, @1, @2, 12;
   ]], a.x, a.y, a.tail.x, a.tail.y)
end)

create_actor([[pl;2;drawable,anim,col,mov,tcol,hurtable,knockable,stunnable,spr,danceable,ma_able|
   name:"lank";
   x:@1;y:@2;
   sinds:144,145,146;
   sind:144;
   rx:.375;
   ry:.375;
   iyy:-2;
   spd:.02;
   anim_len:3;
   anim_spd:5;
   i:@3;u:@4;destroyed:@5;d:@6;
]], function(a)
   a.ltop, a.max_health, a.health = _g.lank_top(a), zdget_value'MAX_HEALTH', zdget_value'HEALTH'
   a.lanks_fairy = _g.fairy(a)
end, function(a)
   -- movement logic
   if a.stun_countdown == 0 then
      if not btn'5' then
         if (xbtn() != 0) and not a:get[[item;item_slow]] then a.xf = btn'0' end
         a.ax, a.ay = xbtn()*a.spd, ybtn()*a.spd

         -- DEBUG_BEGIN
         if g_debug then
            a.ax *= 3
            a.ay *= 3
            a.touchable=false
         else
            a.touchable=true
         end
         -- DEBUG_END
      else
         a.ax = 0 a.ay = 0
      end
   end

   if a:get[[item;item_stop]] then
      a.ax, a.ay = 0, 0
   end

   -- item logic
   if not btn'5' and not a.item and btnp'4' then
      if not get_selected_item().interact then
         if g_energy_tired then
            zsfx(2,7)
         else
            a.item = gen_pl_item(a)
            zsfx(2,2)
         end
      end
   end

   local item = a.item

   if item then
      if not item.alive then
         a.item = nil
      end

      if not btn'4' and not btn'5' then
         item.being_held = false
      end

      a.ax *= .5 a.ay *= .5
   end

   -- walking animation logic
   a.anim_len = abs(a.dx) + abs(a.dy) > 0 and 3 or 1

   -- shaking logic
   if a.stun_countdown != 0 and a.item then
      a.item.xx = a.xx
   end
end, function(a)
   if a.item then a.item.alive = false end
   _g.destroy_effect(a)
   _g.fader_out(nf, g_tl.next)
   switch_song'-1'
   sfx'4'
   if a.lanks_fairy then
      a.lanks_fairy:kill()
   end
end, function(a) -- draw
   a.ltop.outline_color = a.outline_color
   scr_spr_and_out(a, a.ltop, a.item)
end)
