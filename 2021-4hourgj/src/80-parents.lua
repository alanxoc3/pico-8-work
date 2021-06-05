------------------------------------------
--           actor definitions          --
------------------------------------------

-- to generate an actor.
create_parent([[act;0;,;room_init,pause_init,pause_update,pause_end,kill,clean,delete|
   alive:yes;
   stun_countdown:0;
   i:nf; u:nf;
   update:@1;
   clean:@2;
   kill:@3;
   delete:@4;
   room_init:nf;
   create_init:nf;
   pause_init:nf;
   pause_update:nf;
   pause_end:nf;
   destroyed:nf;
   get:@5;
]], function(a)
   if a.alive and a.stun_countdown <= 0 then
      if tl_node(a) then
         a.alive = false
      end
   elseif a.stun_countdown > 0 then
      a.stun_countdown -= 1
   end
end, function(a)
   if not a.alive then
      a:destroyed()
      a:delete()
   end
end, function(a)
   a.alive = nil
end, function(a)
   for k, v in pairs(g_act_arrs) do
      if a[k] then del(v, a) end
   end
end, get)

create_parent[[ma_able;0;act,;|name:"thing";]]
create_parent[[confined;0;act,;room_end,|room_end:nf;]]
create_parent[[loopable;0;act,;|tl_loop:yes;]]
create_parent[[pos;0;act,;|x:0;y:0;]]
create_parent[[move_pause;0;act,;update,move,vec_update,tick|;]]
create_parent[[dim;0;pos,;|rx:.375;ry:.375;]]
create_parent[[knock;0;col,;|;]]
create_parent[[popper;0;col,;|;]]
create_parent[[bad;0;knock,;|;]]

create_parent([[kill_too_high;0;pos,|
    check_height:@1;
]], function(a)
    if a.y < g_main_view.y - g_main_view.h/2 - 8 then -- 10 then
        a:kill()
    end
end)

create_parent([[bounded;0;act,;|
    check_bounds:@1;
    x_check_bounds:@2;
    y_check_bounds:@3;
]], function(a)
    a:x_check_bounds()
    a:y_check_bounds()
end, function(a)
   if a.x+a.dx < g_cur_room.x+.5 then
      a.x = g_cur_room.x+.5
      a.dx = 0
   end

   if a.x+a.dx > g_cur_room.x+g_cur_room.w-.5 then
      a.x = g_cur_room.x+g_cur_room.w-.5
      a.dx = 0
   end
end, function(a)
   if a.y+a.dy < g_cur_room.y+.5 then
      a.y = g_cur_room.y+.5
      a.dy = 0
   end

   if a.y+a.dy > g_cur_room.y+g_cur_room.h-.5 then
      a.y = g_cur_room.y+g_cur_room.h-.5
      a.dy = 0
   end
end)

create_parent[[x_bounded;0;bounded,;| check_bounds:$x_check_bounds; ]]
create_parent[[y_bounded;0;bounded,;| check_bounds:$y_check_bounds; ]]

create_parent([[timed;0;act,;|
   t:0;
   tick:@1;
]], function(a)
   a.t += 1
end)

create_parent([[vec;0;pos,;|
   dx:0;
   dy:0;
   vec_update:@1;
]], function(a)
   a.x += a.dx
   a.y += a.dy
end)

create_parent([[mov;0;vec,;|
   ix:1;
   iy:1;
   ax:0;
   ay:0;
   move:@1;
   stop:@2;
]], function(a)
   a.dx += a.ax a.dy += a.ay
   a.dx *= a.ix a.dy *= a.iy
   if a.ax == 0 and abs(a.dx) < .01 then a.dx = 0 end
   if a.ay == 0 and abs(a.dy) < .01 then a.dy = 0 end
end, function(a)
   a.ax, a.ay, a.dx, a.dy = 0, 0, 0, 0
end)

-- DEBUG_BEGIN
create_parent([[dim;0;pos,;debug_rect,|
   rx:.375;
   ry:.375;
   debug_rect:@1;
]], function(a)
   scr_rect(a.x-a.rx,a.y-a.ry,a.x+a.rx,a.y+a.ry, 8)
end)
-- DEBUG_END

-- used with player items/weapons.
create_parent([[rel;0;act,;rel_update,|
   rel_actor:null;
   rel_x:0;
   rel_y:0;
   rel_dx:0;
   rel_dy:0;
   flippable:no;
   rel_update:@1;
]], function(a)
   local a2 = a.rel_actor
   if a2 then
      if a2.alive then
         a.x, a.y   = a2.x  + a.rel_x , a2.y  + a.rel_y
         a.dx, a.dy = a2.dx + a.rel_dx, a2.dy + a.rel_dy
         a.rel_x += a.rel_dx
         a.rel_y += a.rel_dy
         a.xx, a.yy = a2.xx, a2.yy
         if a.flippable then
            a.xf = a2.xf
         end
      else
         a.alive = false
      end
   end
end)

create_parent([[drawable_obj;0;pos,;reset_off,|
   ixx:0;
   iyy:0;
   xx:0;
   yy:0;
   visible:yes;
   reset_off:@1;
]], function(a)
   a.xx, a.yy = 0, 0
end)

create_parent[[drawable;0;drawable_obj,;d,|d:nf;]]
create_parent[[drawable_1;0;drawable_obj,;d,|d:nf;]]
create_parent[[drawable_2;0;drawable_obj,;d,|d:nf;]]
create_parent[[pre_drawable;0;drawable_obj,;d,|d:nf;]]
create_parent[[pre_drawable_1;0;drawable_obj,;d,|d:nf;]]
create_parent[[pre_drawable_2;0;drawable_obj,;d,|d:nf;]]
create_parent[[post_drawable;0;drawable_obj,;d,|d:nf;]]
create_parent[[post_drawable_1;0;drawable_obj,;d,|d:nf;]]
create_parent[[post_drawable_2;0;drawable_obj,;d,|d:nf;]]

create_parent[[above_map_post_camera_drawable;0;drawable_obj,;d,|d:nf;]]

create_parent([[spr_obj;0;vec,drawable_obj,;|
   sind:0;
   outline_color:BG_UI;
   sw:1;
   sh:1;
   xf:no;
   yf:no;
   draw_spr:@1;
   draw_out:@2;
   draw_both:@3;
]], scr_spr, scr_out, scr_spr_and_out
)

create_parent([[spr;0;spr_obj,;|
   d:@1;
]], scr_spr_and_out)

create_parent([[knockable;0;mov,;|
   knockback:@1;
]], function(a, speed, xdir, ydir)
   a.dx = xdir * speed
   a.dy = ydir * speed
end)

create_parent([[stunnable;0;mov,drawable_obj;|
   stun_update:@1;
]], function(a)
   if a.stun_countdown > 0 then
      a.ay, a.ax = 0, 0
      a.yy = rnd_one()
      a.outline_color = 2
   else
      a.outline_color = 1
   end
end)

create_parent([[hurtable;0;act,;|
   health:1;
   max_health:1;
   health_visible:yes;

   hurt:@1; heal:@2;
]], function(a, damage, stun_val)
   if a.stun_countdown <= 0 then
      a.stun_countdown = stun_val

      a.health = max(0, a.health - damage)

      if a.health == 0 then
         a.alive = false
      end
   end
end, function(a, health)
   a.health = min(a.max_health, a.health + health)
end)

create_parent[[brang_hurtable;0;hurtable,;|;]]

create_parent([[anim;0;spr,timed;|
   sinds:,;
   anim_loc:1;
   anim_off:0;
   anim_len:1;
   anim_spd:0;
   anim_sind:null;
   anim_update:@1;
]], function(a)
   if a.anim_sind then
      a.sind = a.anim_sind
   else
      if a.t % a.anim_spd == 0 then
         a.anim_off += 1
         a.anim_off %= a.anim_len
      end

      a.sind = a.sinds[a.anim_loc + a.anim_off] or 0xffff
   end
end)

create_parent([[trig;0;vec,dim;|
   contains:nf;
   intersects:nf;
   not_contains_or_intersects:nf;
   contains_or_intersects:@1;
   trigger_update:@1;
]], function(a, b)
   if does_a_contain_b(a, b) then
      a:contains(b)
   elseif do_actors_intersect(a, b) then
      a:intersects(b)
   else
      a:not_contains_or_intersects(b)
   end
end)

create_parent[[anchored;1;vec,dim;|touchable:@1;hit:nf;]]

create_parent([[col;0;vec,dim;|
   touchable:yes;
   hit:nf;
   move_check:@1;
]], function(a, acts)
   local hit_list = {}
   local move_check = function(dx, dy)
      local ret_val = dx+dy

      -- using nested closures :)
      local col_help = function(axis, spd_axis, a, b, pos, spd)
         if spd != 0 and pos < abs(a[axis]-b[axis]) then
            if a.touchable and b.touchable then
               local s_f = function(c)
                  if not c.anchored then
                     c[spd_axis] = (a[spd_axis] + b[spd_axis])/2
                  end
               end
               s_f(a) s_f(b)
               ret_val = 0
            end

            hit_list[b][spd_axis]=zsgn(spd)
         end
      end

      foreach(acts, function(b)
         if a != b and (not a.anchored or not b.anchored) then
            local x,y = abs(a.x+dx-b.x), abs(a.y+dy-b.y)
            if x < a.rx+b.rx and y < a.ry+b.ry then
               hit_list[b] = hit_list[b] or ztable[[dx:0;dy:0]]

               batch_call_new(col_help, [[
                  x, dx, @1, @2, @3, @4;
                  y, dy, @1, @2, @5, @6;
               ]], a, b, x, dx, y, dy)
            end
         end
      end)

      return ret_val
   end

   a.dx, a.dy = move_check(a.dx, 0), move_check(0, a.dy)

   -- hitting all the acts in the list.
   -- actor b, dirs d
   for b, d in pairs(hit_list) do
      a:hit(b,  d.dx,  d.dy)
   end
end)

create_parent([[tcol;0;vec,dim;|
   tile_solid:yes;
   tile_hit:nf;
   coll_tile:@1;
]], function(a, solid_func)
   local x, dx = coll_tile_help(a.x, a.y, a.dx, a.rx, a.ry, 0, a, a.tile_hit, solid_func)
   local y, dy = coll_tile_help(a.y, a.x, a.dy, a.ry, a.rx, 2, a, a.tile_hit, function(y, x) return solid_func(x, y) end)
   if a.tile_solid then
      a.x, a.y, a.dx, a.dy = x, y, dx, dy
   end
end)

-- SECTION: CHARS
create_parent([[interactable;0;spr,anchored/yes,confined,ma_able;|
   interactable_trigger:nf;
   trig_x:0;
   trig_y:0;
   trig_rx:.75;
   trig_ry:.75;
   trig:null;
   i:@1;
   interactable_init:@1;
]], function(a)
   a.trig = _g.gen_trigger_block(a, a.trig_x, a.trig_y, a.trig_rx, a.trig_ry, nf, function(trig, other)
      if npc_able_to_interact(a, other) then
         change_cur_ma(a)
         if able_to_interact(a, other) then
            a:interactable_trigger()
         end
      else
         if get_cur_ma() == a then
            change_cur_ma()
         end
      end
   end)
end)

create_parent[[nnpc;0;drawable,danceable,interactable,ma_able;|
   rx:.5;ry:.5;iyy:-2;
   u:%look_at_pl
]]

-- SECTION: INVENTORY
create_parent([[bashable;0;rel,knockable,col;|
   bash_dx:1;
   rel_bash_dx:1;
   hit:@1;bash:@1;
]], function(a, o)
   if o != a.rel_actor then
      call_not_nil(o, 'knockback', o, a.bash_dx, bool_to_num(a.xf), 0)
      change_cur_ma(o)
      if a.rel_actor then
         call_not_nil(a.rel_actor, 'knockback', a.rel_actor, -a.rel_bash_dx, bool_to_num(a.xf), 0)
      end
   end
end
)

create_parent([[item;0;drawable,rel,confined,spr_obj;|
   being_held:yes;destroyed:@1;
]], function(a)
   if a == a.rel_actor.item then a.rel_actor.item = nil end
end)

create_parent([[pokeable;0;rel,drawable_obj,item;|
   i:@1;
   u:@2;
   e:@3;
   poke_init:@1;
   poke_update:@2;
   poke_end:@3;
   poke_update_reverse:@4;
   poke:20;
   poke_dist:20;
   poke_energy:0;
]], function(a) -- set position
   a.xf = a.rel_actor.xf
   a.ixx = a.xf and a.poke_ixx or -a.poke_ixx
   use_energy(a.poke_energy)
end, function(a) -- move to position
   a.rel_dx = bool_to_num(a.xf)*a.poke_dist/a.tl_max_time/FPS
   pause_energy()
end, function(a) -- e
   a.rel_dx, a.rel_x = 0, a.xf and -a.poke_dist or a.poke_dist
end, function(a)
   a.rel_dx = -bool_to_num(a.xf)*a.poke_dist/a.tl_max_time/FPS/2
end)

-- SECTION: NPCS
create_parent([[shop_item;0;drawable,interactable,ma_able;update,|
   costable:yes;
   interactable_trigger:@1;
   rx:.5;ry:.5;
   iyy:-3;
   trig_x:0;trig_y:.125;
   trig_rx:.5;trig_ry:.625;
   mem_loc:BOGUS_SPOT;cost:99
]], function(a)
   if remove_money(a.cost) then
      a:kill()
      _g.item_show(g_pl, a.sind, a.mem_loc)
      pause'chest' -- not a chest, but is the same functionality.
      stop_music'1'
   else
      zsfx(2,6)
   end
end)

-- exists based on memory
create_parent([[mem_dep;0;act,;|
   room_init:@1;
   mem_loc:BOGUS_SPOT;
   mem_loc_expect:yes;
]], function(a)
   if zdget(a.mem_loc) == a.mem_loc_expect then
      a:delete()
   end
end)
