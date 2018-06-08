pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- mod test
-- by alan morgan
-- this is an all-purpose actor engine
function _init()
   g_pl = acts_spr_attach(acts_mov_attach(acts_col_attach()))
   g_pl.pl = true
   g_pl.x = 10
   g_pl.y = 5
   g_pl.w = 5
   g_pl.h = 4, 4
   g_pl.bounce = 0

   create_block(rnd()*10, rnd()*10)
end

function _update60()
   acts_loop("anim", "anim_update")

   if btn(0) then g_pl.ax = -.03
   elseif btn(1) then g_pl.ax = .03
   else g_pl.ax = 0 end

   if btn(2) then g_pl.ay = -.03
   elseif btn(3) then g_pl.ay = .03
   else g_pl.ay = 0 end

   acts_loop("mov", "move")

   local acts = filter_id(g_actors, "col")
   acts_loop("pl", "move_check", acts)

   acts_loop("vec", "vec_update")
   acts_loop("act", "clean")
end

function _draw()
   cls(1)
   spr(g_pl.sind, g_pl.x*8-4, g_pl.y*8-4)
   for a in all(g_actors) do
      rectfill(a.x*8-a.w*8, a.y*8-a.h*8, a.x*8 + a.w*8, a.y*8 + a.h*8, rnd()*16)
   end
   map(0, 0, 0, 0, 16, 16)
end

function create_block(x, y)
   acts_attach("idblock", nil,
   {"x", "y", "w", "h", "hit"},
   {x,   y,   2,  2,
   function(self, other, xdir, ydir)
      if other == g_pl then
         create_block(rnd()*15.5, rnd()*15.5)
         self.alive = false
         printh("xdir: "..xdir.." -- ydir: "..ydir)
      end
   end}, acts_col_attach, acts_mov_attach)
end

-- attachment module

g_actors = {}
function nf() end -- the nothing function

-- this attaches the basic stuff
-- id, a, attrs, vals, parents
function acts_attach(id, a, attrs, vals, ...)
   a = a or {}
   foreach({...}, function(sf) a = sf(a) end)

   for i=1,#attrs do
      local ind = attrs[i]
      a[ind] = vals[i] or a[i]
   end

   a[id] = true

	if not a.in_g_actors then
		add(g_actors, a)
		a.in_g_actors = true
	end

   return a
end

function acts_loop(...)
   list_loop(g_actors, ...)
end

function list_loop(list, id, func, ...)
	for a in all(filter_id(list, id)) do
      if a[func] then
			a[func](a, ...) end
	end
end

function filter_id(list, id)
   local ret = {}
   foreach(list, function(a)
		if a[id] then add(ret, a) end
	end)
   return ret
end

------------------------------------------
--        some actor definitions        --
------------------------------------------

-- to generate an actor.
function acts_act_attach(a)
   return acts_attach("act",  a,
   {"alive", "active", "clean"},
   {true,    true,     function(a) if not a.alive then del(g_actors, a) end end})
end

function acts_timed_attach(a)
   return acts_attach("timed",  a,
		{"t", "tick"},
		{0,    function(a) a.t += 1 end}, acts_act_attach)
end

function acts_anim_attach(a)
   return acts_attach("anim", a,
		{"sinds", "anim_loc", "anim_off", "anim_len", "anim_spd",
		"anim_update"},
		{{},      1,          0,          1,          1,
		function(a)
			if a.t % a.anim_spd == 0 then
				a.anim_off += 1
				a.anim_off %= a.anim_len
			end

			a.sind = a.sinds[a.anim_loc + a.anim_off] or 0xffff
		end
		}, acts_spr_attach)
end

function acts_vec_attach (a)
   return acts_attach("vec",  a,
		{"x", "y", "dx", "dy", "vec_update"},
		{0,   0,   0,    0,
		function(a)
			a.x += a.dx
			a.y += a.dy
		end
		}, acts_act_attach)
end

function acts_spr_attach (a)
   return acts_attach("spr",  a,
   {"sind", "sw", "sh", "xf",  "yf",  "pre_draw", "post_draw"},
   {0,      1,    1,    false, false, nf,         nf}, acts_vec_attach)
end

function acts_mov_attach (a)
   return acts_attach("mov",  a,
      {"ix", "iy", "ax", "ay", "move"},
      {.9,   .9,   0,    0,
      function(a)
         a.dx += a.ax a.dy += a.ay
         a.dx *= a.ix a.dy *= a.iy
      end}, acts_vec_attach)
end

function acts_dim_attach(a)
   return acts_attach("dim",  a, {"w", "h"}, {.4,  .4})
end
-->8
-- collision module
-- assumes the attachment module

-- an attachment!
function acts_col_attach (a)
   return acts_attach("col",  a,
      {"static", "solid", "touchable", "xb", "yb", "hit", "tile_hit",
      "move_check"},

      {false,    true,    true,        .1,   .1,   nf,    nf,
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
                  if x < (a.w+b.w) and y < (a.h+b.h) then 
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
      end}, acts_vec_attach, acts_dim_attach)
end
__sfx__
010f0000212502325029250262502623026220262102620026200262002b0702b0502b0302b0202b0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
