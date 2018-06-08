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
