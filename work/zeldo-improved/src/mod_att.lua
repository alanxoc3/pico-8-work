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
   local id, a, attrs, vals, parents = params[1], params[2] or {}, params[3], params[4], params[5]
   foreach(parents, function(sf) a = g_attach[sf](a) end)

   for i=1,#attrs do
      local ind = attrs[i]
      a[ind] = vals[i] or a[i]
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
   return acts_attach("act,@,{alive,active,clean},{true,true,@}", a,
   function(a)
      if not a.alive then
         del_act(a)
      end
   end)
end)

gen_attach("tl", function(a)
   return acts_attach("tl,@,{update},{@}",  a, function(a) tl_update(a.state) end)
end)

gen_attach("timed", function(a)
   return acts_attach("timed,@,{t,tick},{0,@},{act}", a, function(a) a.t += 1 end)
end)

gen_attach("pos", function(a)
   return acts_attach("pos,@,{x,y},{0,0},{act}", a)
end)

gen_attach("vec", function(a)
   return acts_attach("vec,@,{dx,dy,vec_update},{0,0,@},{pos}", a,
      function(a)
         a.x += a.dx
         a.y += a.dy
      end)
end)

gen_attach("mov", function(a)
   return acts_attach("mov,@,{ix,iy,ax,ay,move},{.85,.85,0,0,@},{vec}", a,
      function(a)
         a.dx += a.ax a.dy += a.ay
         a.dx *= a.ix a.dy *= a.iy
         if a.ax == 0 and abs(a.dx) < .01 then a.dx = 0 end
         if a.ay == 0 and abs(a.dy) < .01 then a.dy = 0 end
      end)
end)

gen_attach("dim", function(a)
   return acts_attach("dim,@,{rx,ry},{.4,.4},{pos}", a)
end)

-- used with player items/weapons.
gen_attach("rel", function(a)
   return acts_attach("rel,@,{rel_x,rel_y,rel_dx,rel_dy,rel_update},{0,0,0,0,@},{act}", a,
	function(a, a2)
		a.x, a.y, a.dx, a.dy = a2.x+a.rel_x, a2.y+a.rel_y, a2.dx+a.rel_dx, a2.dy+a.rel_dy
	end)
end)

gen_attach("spr", function(a)
   return acts_attach("spr,@,{sind,sw,sh,xf,yf,xx,yy,draw},{0,1,1,false,false,0,0,@},{vec}", a, function(a) scr_spr(a) end)
end)

gen_attach("spr_out", function(a)
   return acts_attach("spr_out,@,{draw},{@},{spr,vec}", a,
   function(a)
		scr_spr_out(1, a)
   end)
end)

gen_attach("anim", function(a)
   return acts_attach("anim,@,{sinds,anim_loc,anim_off,anim_len,anim_spd,anim_sind,anim_update},{{},1,0,1,0,nil,@},{spr,timed}", a,
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
   return acts_attach("col,@,{static,touchable,xb,yb,hit,move_check},{false,true,0,0,@,@},{vec,dim}", a, nf,
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
   return acts_attach("tcol,@,{tile_hit,coll_tile},{@,@},{vec,dim}", a, nf,
   function(a, solid_func)
      a.x, a.dx = coll_tile_help(a.x, a.y, a.dx, a.rx, a.ry, 0, a, a.tile_hit, solid_func)
      a.y, a.dy = coll_tile_help(a.y, a.x, a.dy, a.ry, a.rx, 2, a, a.tile_hit, function(y, x) return solid_func(x, y) end)
   end)
end)
