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
create_parent[[knock;0;col,;|;]]
create_parent[[popper;0;col,;|;]]
create_parent[[bad;0;knock,;|;]]

create_parent[[bounded;0;act,;|
    check_bounds:nf;
]]

create_parent([[x_bounded;0;bounded,;|
    check_bounds:@1;
]], function(a)
   if a.x+a.dx < g_cur_room.x+.5 then
      a.x = g_cur_room.x+.5
      a.dx = 0
   end

   if a.x+a.dx > g_cur_room.x+g_cur_room.w-.5 then
      a.x = g_cur_room.x+g_cur_room.w-.5
      a.dx = 0
   end
end)

create_parent([[y_bounded;0;bounded,;|
   check_bounds:@1;
]], function(a)
   if a.y+a.dy < g_cur_room.y+.5 then
      a.y = g_cur_room.y+.5
      a.dy = 0
   end

   if a.y+a.dy > g_cur_room.y+g_cur_room.h-.5 then
      a.y = g_cur_room.y+g_cur_room.h-.5
      a.dy = 0
   end
end)

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
    calc_next_pos:@3;
]], function(a)
    a.dx += a.ax a.dy += a.ay
    a.dx *= a.ix a.dy *= a.iy
    if a.ax == 0 and abs(a.dx) < .01 then a.dx = 0 end
    if a.ay == 0 and abs(a.dy) < .01 then a.dy = 0 end
end, function(a)
    a.ax, a.ay, a.dx, a.dy = 0, 0, 0, 0
end, function(a, ax, ay)
    return a.x+(a.dx+ax)*a.ix, a.y+(a.dy+ay)*a.iy
end)

create_parent[[dim;0;pos,;|rx:.375;ry:.375;]]

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

-- HURTABLE: something that has health and can be hurt or healed.
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

-- TRIG: a trigger that calls a function if called
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

-- ANCHORED: the object will not move
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
