-- attachment module
g_act_arrs, g_attach = {}, {}
function nf() end -- the nothing function

function gen_attach(name, func)
   g_attach[name] = func
end

-- this attaches the basic stuff
-- id, a, attrs, vals, parents
function acts_attach(str, ...)
   local params = gun_vals(str, ...)
   local id, a, attrs, parents = params[1], params[2] or {}, params[3], params[4]
   foreach(parents, function(sf) a = g_attach[sf](a) end)

   for k,v in pairs(attrs) do
      a[k] = v
   end

   if not a[id] then
      g_act_arrs[id] = g_act_arrs[id] or {}
      add(g_act_arrs[id], a)
      a[id] = true
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
gen_attach("act", function(a)
   return acts_attach([[
      $act$,@,
      {
         alive=true,
         active=true,
         clean=@
      }
   ]], a,
   function(a)
      if not a.alive then
         del_act(a)
      end
   end)
end)

gen_attach("tl", function(a)
   return acts_attach([[
      $tl$,@,{
         update=@
      },{$stunnable$}
   ]],  a,
   function(a)
      if a.stun_countdown == 0 then
         tl_update(a.state)
      end
   end)
end)

gen_attach("timed", function(a)
   return acts_attach([[
      $timed$,@,
      {
         t=0,
         tick=@
      },{$act$}
   ]], a,
   function(a)
      a.t += 1
   end)
end)

gen_attach("pos", function(a)
   return acts_attach([[$pos$,@,
      {
         x=0,
         y=0
      },{$act$}]], a
   )
end)

gen_attach("vec", function(a)
   return acts_attach([[
      $vec$,@,
      {
         dx=0,
         dy=0,
         vec_update=@
      },{$pos$}
   ]], a,
   function(a)
      a.x += a.dx
      a.y += a.dy
   end)
end)

gen_attach("mov", function(a)
   return acts_attach([[
      $mov$,@,
      {
         ix=.85,
         iy=.85,
         ax=0,
         ay=0,
         move=@
      },{$vec$}
   ]], a,
   function(a)
      a.dx += a.ax a.dy += a.ay
      a.dx *= a.ix a.dy *= a.iy
      if a.ax == 0 and abs(a.dx) < .01 then a.dx = 0 end
      if a.ay == 0 and abs(a.dy) < .01 then a.dy = 0 end
   end)
end)

gen_attach("dim", function(a)
   return acts_attach([[
      $dim$,@,
      {
         rx=.375,
         ry=.375,
         debug_rect=@
      },{$pos$}
   ]], a, function(a)
      scr_rect(a.x-a.rx,a.y-a.ry,a.x+a.rx,a.y+a.ry, 8)
   end)
end)

-- used with player items/weapons.
gen_attach("rel", function(a)
   return acts_attach([[
      $rel$,@,
      {
         rel_x=0,
         rel_y=0,
         rel_dx=0,
         rel_dy=0,
         rel_update=@
      },{$act$}
   ]], a,
	function(a, a2)
		a.x, a.y, a.dx, a.dy = a2.x+a.rel_x, a2.y+a.rel_y, a2.dx+a.rel_dx, a2.dy+a.rel_dy
	end)
end)

gen_attach("drawable", function(a)
   return acts_attach([[
      $drawable$,@,
      {
         ixx=0,
         iyy=0,
         xx=0,
         yy=0,
         draw=@,
         reset_off=@
      }
   ]], a, nf, function(a) a.xx, a.yy = 0, 0 end)
end)

gen_attach("spr", function(a)
   return acts_attach([[
      $spr$,@,
      {
         sind=0,
         sw=1,
         sh=1,
         xf=false,
         yf=false,
         draw=@
      },{$vec$,$drawable$}
   ]], a, scr_spr)
end)

gen_attach("spr_out", function(a)
   return acts_attach([[
      $spr_out$,@,
      {
         draw=@
      },{$spr$}
   ]], a, scr_spr_out)
end)

gen_attach("knockable", function(a)
   return acts_attach([[
      $knockable$,@,{
         knockback=@
      },{$mov$}
   ]], a,
   function(speed, xdir, ydir)
      if xdir != 0 then a.dx = xdir * speed
      else              a.dy = ydir * speed end
   end)
end)

gen_attach("stunnable", function(a)
   return acts_attach([[
      $stunnable$,@,{
         stun_countdown=0,
         stun=@,
         stun_update=@
      },{$mov$,$drawable$}
   ]], a,
   function(len)
      if a.stun_countdown == 0 then
         a.stun_countdown = len
      end
   end, function()
      if a.stun_countdown != 0 then
         a.ay, a.ax = 0, 0
         a.xx = rnd_one()
         a.stun_countdown -= 1
      end
   end)
end)

gen_attach("hurtable", function(a)
   return acts_attach([[
      $hurtable$,@,{
         hearts=3,
         hurt=@
      },{$stunnable$}
   ]], a,
   function(damage)
      if a.stun_countdown == 0 then
         a.hearts -= damage
      end
   end)
end)

gen_attach("anim", function(a)
   return acts_attach([[
      $anim$,@,{
         sinds={},
         anim_loc=1,
         anim_off=0,
         anim_len=1,
         anim_spd=0,
         anim_sind=nil,
         anim_update=@
      },{$spr$,$timed$}
   ]], a,
		function(a)
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
end)

gen_attach("col", function(a)
   return acts_attach([[
      $col$,@,{
         static=false,
         touchable=true,
         xb=0,
         yb=0,
         hit=@,
         move_check=@
      },{$vec$,$dim$}
   ]], a, nf,
      function(a, acts)
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
end)

gen_attach("tcol", function(a)
   return acts_attach([[
      $tcol$,@,{
         $tile_hit$=@,
         $coll_tile$=@
      },{$vec$,$dim$}
   ]], a, nf,
   function(a, solid_func)
      a.x, a.dx = coll_tile_help(a.x, a.y, a.dx, a.rx, a.ry, 0, a, a.tile_hit, solid_func)
      a.y, a.dy = coll_tile_help(a.y, a.x, a.dy, a.ry, a.rx, 2, a, a.tile_hit, function(y, x) return solid_func(x, y) end)
   end)
end)
