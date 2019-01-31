-- attachment module
g_act_arrs, g_attach = {}, {}
function nf() end -- the nothing function

function create_parent(str, ...)
   local params = gun_vals(str, ...)
   g_attach[params.id] = function(a)
      return acts_attach_helper(params, a or {})
   end
end

function create_actor(str, ...)
   return acts_attach_helper(gun_vals(str, ...))
end

-- opt: {id, att, par}
function acts_attach_helper(opt, a)
   foreach(opt.par, function(sf) a = g_attach[sf](a) end)

   for k,v in pairs(opt.att) do
      a[k] = v
   end

   if not a[opt.id] then
      g_act_arrs[opt.id] = g_act_arrs[opt.id] or {}
      add(g_act_arrs[opt.id], a)
      a[opt.id] = true
   end

   a.state = a.init and a.init(a)

   return a
end

function acts_loop(id, func, ...)
	for a in all(g_act_arrs[id]) do
      if a[func] then
			a[func](a, ...) end
	end
end

function del_act(a)
   for k, v in pairs(g_act_arrs) do
      if a[k] then del(v, a) end
   end
end

------------------------------------------
--           actor definitions          --
------------------------------------------

-- to generate an actor.
-- includes update
create_parent(
[[ id=$act$,
   att={
      alive=true,
      active=true,
      clean=@
   }
]], function(a)
   if not a.alive then
      del_act(a)
   end
end)

create_parent(
[[ id=$tl$,
   att={
      update=@
   },
   par={$stunnable$}
]], function(a)
   if a.stun_countdown == 0 then
      tl_update(a.state)
   end
end)

create_parent(
[[ id=$timed$,
   att={
      t=0,
      tick=@
   },
   par={$act$}
]], function(a)
   a.t += 1
end)

create_parent(
[[ id=$pos$,
   att={
      x=0,
      y=0
   },
   par={$act$}
]]
)

create_parent(
[[ id=$vec$,
   att={
      dx=0,
      dy=0,
      vec_update=@
   },
   par={$pos$}
]], function(a)
   a.x += a.dx
   a.y += a.dy
end)

create_parent(
[[ id=$mov$,
   att={
      ix=.85,
      iy=.85,
      ax=0,
      ay=0,
      move=@
   },
   par={$vec$}
]], function(a)
   a.dx += a.ax a.dy += a.ay
   a.dx *= a.ix a.dy *= a.iy
   if a.ax == 0 and abs(a.dx) < .01 then a.dx = 0 end
   if a.ay == 0 and abs(a.dy) < .01 then a.dy = 0 end
end)

create_parent(
[[ id=$dim$,
   att={
      rx=.375,
      ry=.375,
      debug_rect=@
   },
   par={$pos$}
]], function(a)
   scr_rect(a.x-a.rx,a.y-a.ry,a.x+a.rx,a.y+a.ry, 8)
end)

-- used with player items/weapons.
create_parent(
[[ id=$rel$,
   att={
      rel_x=0,
      rel_y=0,
      rel_dx=0,
      rel_dy=0,
      rel_update=@
   },
   par={$act$}
]], function(a, a2)
   a.x, a.y, a.dx, a.dy = a2.x+a.rel_x, a2.y+a.rel_y, a2.dx+a.rel_dx, a2.dy+a.rel_dy
end)

create_parent(
[[ id=$drawable$,
   att={
      ixx=0,
      iyy=0,
      xx=0,
      yy=0,
      draw=@,
      reset_off=@
   }
]], nf, function(a)
   a.xx, a.yy = 0, 0
end)

create_parent(
[[ id=$spr$,
   att={
      sind=0,
      sw=1,
      sh=1,
      xf=false,
      yf=false,
      draw=@
   },
   par={$vec$,$drawable$}
]], scr_spr)

create_parent(
[[ id=$spr_out$,
   att={
      draw=@
   },
   par={$spr$}
]], scr_spr_out)

create_parent(
[[ id=$knockable$,
   att={
      knockback=@
   },
   par={$mov$}
]], function(a, speed, xdir, ydir)
   if xdir != 0 then a.dx = xdir * speed
   else              a.dy = ydir * speed end
end)

create_parent(
[[ id=$stunnable$,
   att={
      stun_countdown=0,
      stun=@,
      stun_update=@
   },
   par={$mov$,$drawable$}
]], function(a, len)
   if a.stun_countdown == 0 then
      a.stun_countdown = len
   end
end, function(a)
   if a.stun_countdown != 0 then
      a.ay, a.ax = 0, 0
      a.xx = rnd_one()
      a.stun_countdown -= 1
   end
end)

create_parent(
[[ id=$hurtable$,
   att={
      hearts=3,
      hurt=@
   },
   par={$stunnable$}
]], function(a, damage)
   if a.stun_countdown == 0 then
      a.hearts -= damage
   end
end)

create_parent(
[[ id=$anim$,
   att={
      sinds={},
      anim_loc=1,
      anim_off=0,
      anim_len=1,
      anim_spd=0,
      anim_sind=,
      anim_update=@
   },
   par={$spr$,$timed$}
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

create_parent(
[[ id=$col$,
   att={
      static=false,
      touchable=true,
      xb=0,
      yb=0,
      hit=@,
      move_check=@
   },
   par={$vec$,$dim$}
]], nf, function(a, acts)
   local other_list = {}
   local move_check = function(dx, dy)
      local touched = false

      -- using nested closures :)
      local col_help = function(axis, spd_axis, a, b, pos, spd)
         if spd != 0 and pos < abs(a[axis]-b[axis]) then
            if a.touchable and b.touchable then
               v=a[spd_axis] + b[spd_axis]
               local s_f = function(c) if not c.static then c[spd_axis] = v/2 end end
               s_f(a) s_f(b)
               touched = true
            end

            other_list[b][axis]=spd>0 and 1 or 0 + spd<0 and 0xffff or 0
         end
      end

      foreach(acts, function(b)
         if a != b then
            local x,y = abs(a.x+dx-b.x), abs(a.y+dy-b.y)
            if x < (a.rx+b.rx) and y < (a.ry+b.ry) then 
               if not other_list[b] then other_list[b] = {x=0, y=0} end

               col_help("x", "dx", a, b, x, dx)
               col_help("y", "dy", a, b, y, dy)
            end
         end
      end)

      if touched then
         dx *= -a.xb
         dy *= -a.yb
      end

      return dx + dy
   end

   a.dx = move_check(a.dx, 0)
   a.dy = move_check(0, a.dy)

   -- hitting all the acts in the list.
   -- actor b, dirs d
   for b, d in pairs(other_list) do
      a.hit(a, b,  d.x,  d.y)
      b.hit(b, a, -d.x, -d.y)
   end
end)

create_parent(
[[ id=$tcol$,
   att={
      $tile_hit$=@,
      $coll_tile$=@
   },
   par={$vec$,$dim$}
]], nf, function(a, solid_func)
   a.x, a.dx = coll_tile_help(a.x, a.y, a.dx, a.rx, a.ry, 0, a, a.tile_hit, solid_func)
   a.y, a.dy = coll_tile_help(a.y, a.x, a.dy, a.ry, a.rx, 2, a, a.tile_hit, function(y, x) return solid_func(x, y) end)
end)
