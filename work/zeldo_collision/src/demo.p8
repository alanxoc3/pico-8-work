actors = {}

function gen_debug_enemy(x, y)
	local e = acts_attach_collidable({}, x, y)
	e.bounce = .6
	e.inertia = 1
	e.w, e.h = .4, .4
	e.move =
	function(a)
		amov_to_actor(a, pl, .05)
	end
	add(actors,e)
	return e
end

function gen_debug_enem2(x, y)
	local e = acts_attach_collidable({}, x, y)
	e.bounce = 1
	e.inertia = 1
	e.w, e.h = .4, .4
	e.move =
	function(a)
		amov_counter(a, 4, 5, 5, global_time)
	end
	add(actors,e)
	return e
end

function _init()
	global_time = 0

	pl = acts_attach_collidable({}, 8,8)
	pl.spd = .05
	pl.w, pl.h = .5, .5
	pl.move = function(a) amov_controller(a, a.spd) end
	pl.inertia = .6
	pl.bounce = 0
	pl.touchable = false
	pl.solid = false
	add(actors,pl)

	gen_debug_enemy(10, 10)
	gen_debug_enemy(11, 11)
	gen_debug_enemy(12, 12)
	gen_debug_enemy(13, 13)
	gen_debug_enem2(8, 8)
end

function _update60()
	acts_update_collidables(actors, function(x, y) return fget(mget(x, y), 1) end)
	global_time += 1
end

function _draw()
	cls()
	print('pico_project!', 20, 20, 7)

	map(0, 0, 0, 0, 16, 16)
	foreach(actors, function(a) debug_actor_box(a, 9) end)
end
