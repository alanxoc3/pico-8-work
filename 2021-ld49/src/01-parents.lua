-- apply parents to your actor

-- lets you create timers on your actor
create_parent([[timer;0;,;|
    timers:,;
    tick:@1;
    create_timer:@2;
    any_timer_active:@3;
    get_timer_percent:@4;
]], function(a)
    local keys_to_remove = {}
    for k, v in pairs(a.timers) do
        v.t += 1
        if v.t > v.limit then
            add(keys_to_remove, k)
        end
    end

    for k in all(keys_to_remove) do
        local v = a.timers[k]
        a.timers[k] = nil
        v.callback(a)
    end
end, function(a, timer_name, limit, callback)
    a.timers[timer_name] = { t=0, limit=limit, callback=(callback or nf) }
end, function(a, ...)
    for timer_name in all{...} do
        if a.timers[timer_name] ~= nil then
            return true
        end
    end
    return false
end, function(a, timer_name)
    local timer = a.timers[timer_name]
    return timer and (timer.t/timer.limit) or 1
end)

-- basic actor. most things ultimately inherit this.
-- handles update, init, and deletion stuff.
create_parent([[act;0;timer,;room_init,kill,clean,delete|
    update:@1; clean:@2; kill:@3; delete:@4; get:@5; disabled:,;
    alive:yes; i:nf; u:nf; room_init:nf; destroyed:nf;
]], function(a)
    -- tl_node calls the u/i functions.
    if a.alive and tl_node(a) then
        a.alive = false
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
create_parent[[knock;0;col,;|;]]
create_parent[[popper;0;col,;|;]]

-- these are used to simplify collision handling.
create_parent[[good_character;0;col,hurtable;|;]]
create_parent[[bad_character;0;col,hurtable;|;]]

create_parent([[good_attack;0;col,;|
    hit:@1;
]], function(a, other)
    if other.bad_character then
        other:damage(a)
    end
end)

create_parent([[bad_attack;0;col,;|
    hit:@1; kill_when_hit:no;
]], function(a, other)
    if other.good_character then
        other:damage(a)
    end
    if a.kill_when_hit then
        a:kill()
    end
end)

create_parent([[x_bounded;0;dim,;|
    check_bounds_x:@1;
]], function(a)
   if a.x+a.dx < g_room.x+a.rx then
      a.x = g_room.x+a.rx
      a.dx = 0
   end

   if a.x+a.dx > g_room.x+g_room.w-a.rx then
      a.x = g_room.x+g_room.w-a.rx
      a.dx = 0
   end
end)

create_parent([[y_bounded;0;dim,;|
    check_bounds_y:@1;
]], function(a)
   if a.y+a.dy < g_room.y+a.ry then
      a.y = g_room.y+a.ry
      a.dy = 0
   end

   if a.y+a.dy > g_room.y+g_room.h-a.ry then
      a.y = g_room.y+g_room.h-a.ry
      a.dy = 0
   end
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
   inertia_x:.90; -- inertia for every object in the game!
   inertia_y:.90; -- inertia for every object in the game!
   ax:0;
   ay:0;
   mov_update:@1;
   stop:@2;
]], function(a)
   a.dx += a.ax a.dy += a.ay
   a.dx *= a.inertia_x a.dy *= a.inertia_y
   if a.ax == 0 and abs(a.dx) < .01 then a.dx = 0 end
   if a.ay == 0 and abs(a.dy) < .01 then a.dy = 0 end
end, function(a)
   a.ax, a.ay, a.dx, a.dy = 0, 0, 0, 0
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

create_parent[[above_map_drawable;0;drawable_obj,;d,|d:nf;]]
create_parent[[above_map_drawable_1;0;drawable_obj,;d,|d:nf;]]

create_parent[[spr_obj;0;vec,drawable_obj,;|
   sind:0;
   outline_color:BG_UI;
   sw:1;
   sh:1;
   xf:no;
   yf:no;
]]

create_parent([[spr;0;spr_obj,;|
   d:@1;
]], scr_spr)

create_parent([[knockbackable;0;mov,timer,;|
    knockback:@1;
    apply_knockback:@2;
    knockback_speed:0;
    knockback_dir:0;
]], function(a, direction)
    if not a:any_timer_active("knockback") then
        a.knockback_speed = .075
        a.knockback_dir = direction
        a:create_timer("knockback", 4)
    end
end, function(a)
    a.ax = cos(a.knockback_dir)*a.knockback_speed
    a.ay = sin(a.knockback_dir)*a.knockback_speed
end)

-- HURTABLE: something that has health and can be hurt or healed.
create_parent([[hurtable;0;act,;|
    health:1;
    max_health:1;
    hurt_cooldown_time:60;
    hurt_start:nf;
    hurt_end:nf;
    damage:nf;

    hurt:@1; heal:@2;
]], function(a, damage)
    damage = damage or 1
    if not a:any_timer_active("hurt_cooldown") then
        a.health = max(0, a.health - damage)

        if a.health == 0 then
            a.alive = false
            return
        end

        a:create_timer("hurt_cooldown", a.hurt_cooldown_time, a.hurt_end)
        a:hurt_start()
    end
end, function(a, health)
   a.health = min(a.max_health, a.health + health)
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
   local y, dy = coll_tile_help(a.y, a.x, a.dy, a.ry, a.rx, 2, a, a.tile_hit, function(a, y, x) return solid_func(a, x, y) end)
   if a.tile_solid then
      a.x, a.y, a.dx, a.dy = x, y, dx, dy
   end
end)
