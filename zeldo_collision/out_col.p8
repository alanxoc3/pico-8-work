pico-8 cartridge // http://www.pico-8.com
version 8
__lua__
-- zeldo collision
-- by alan morgan


function gen_debug_enemy(x, y)
	local e = make_col_actor(x, y)
	e.bounce = .6
	e.inertia = 1
	e.w, e.h = .4, .4
	e.move =
	function(a)
		move_to_actor(a, pl, .05)
	end
	add(actors,e)
	return e
end

function gen_debug_enem2(x, y)
	local e = make_col_actor(x, y)
	e.bounce = 1
	e.inertia = 1
	e.w, e.h = .4, .4
	e.move =
	function(a)
		move_counter(a, 4, 5, 5, global_time)
	end
	add(actors,e)
	return e
end

function _init()
	global_time = 0

	pl = make_col_actor(8,8)
	pl.spd = .05
	pl.w, pl.h = .5, .5
	pl.move = function(a) move_controller(a, a.spd) end
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
	move_actors(function(x, y) return fget(mget(x, y), 1) end)
	global_time += 1
end

function _draw()
	cls()
	print('pico_project!', 20, 20, 7)

	map(0, 0, 0, 0, 16, 16)
	foreach(actors, function(a) debug_actor_box(a, 9) end)
end
actors = {}

-- make an actors and add to global collection.
-- x,y means center of the actors, in map tiles (not pixels).
function make_col_actor(x, y)
	local a={}

	-- things used by collision
	a.static = false   -- if true, then this object cannot be moved by other objects.
	a.solid = true     -- if false, then you can walk through walls.
	a.touchable = true -- if false, then you can go through other actors, but not walls. hit() will still be called.
	a.stun  = 0        -- if higher than zero, move() won't be called until the timer goes down.
	a.inertia = .6     -- if 1, then no friction. if 0, then lots of friction.
	a.bounce  = .1     -- if 1, then no loss of speed when you bounce.
	a.is_outside = false -- if true, then the character is out of bounds.
	a.x, a.y, a.dx, a.dy = x, y, 0.0, 0.0 -- position and speed.
	a.w, a.h = 0.4, 0.4 -- collision radius width and height

	a.move = function(self) end -- called every frame.
	a.hit = function(other) end -- called if two actors in bounds are touching each other.

	return a
end

function move_actors(actors, tile_func)
	-- speed/collision, speed/walls, then position
	foreach(actors, function (a) set_actor_speed(a, actors) end)
	foreach(actors, function(a) tile_col(a, tile_func) end)
	foreach(actors, set_actor_pos)
end

function tile_col(a, func)
	if a.solid then
		a.x, a.dx = tile_collide_helper(a.x, a.y, a.dx, a.w, a.h, function(pos, per) return func(pos, per) end)
		a.y, a.dy = tile_collide_helper(a.y, a.x, a.dy, a.h, a.w, function(pos, per) return func(per, pos) end)
	end
end

function set_actor_speed(a, actors)
	if a.is_outside then
		return
	end

	if a.move != nil then
		if a.stun <= 0 then
			a.move(a)
		else
			a.stun -= 1
		end

		a.dx = move_actor_check(a, actors, a.dx, 0)
		a.dy = move_actor_check(a, actors, 0, a.dy)
	end
end

function set_actor_pos(a)
	if a.is_outside then
		return
	end

	-- update the position then apply inertia.
	a.x += a.dx
	a.y += a.dy

	a.dx *= a.inertia
	a.dy *= a.inertia
end

-- moves, with actor collisions
function move_actor_check(a, actors, dx, dy)
	local other_list = actor_collision(a, actors, dx, dy) 

	if #other_list != 0 then
		hit_actors(a,other_list)

		if a.touchable and has_touchable(other_list) then
			dx *= -a.bounce
			dy *= -a.bounce
		end
	end

	return dx + dy
end

-- returns a list of all actors hit. will return nil if none were hit.
-- or if this is out of bounds.
-- bounds. won't check for actors that are out of bounds.
-- also does not work with overlapping actors.
function actor_collision(a, actors, dx, dy)
	local retlist = {}

	if not a.is_outside then
		for a2 in all(actors) do
			if not a2.is_outside and a != a2 then
				local x=(a.x+dx) - a2.x
				local y=(a.y+dy) - a2.y
				if ((abs(x) < (a.w+a2.w)) and
					(abs(y) < (a.h+a2.h)))
				then 
					-- check if moving together
					if (dx != 0 and abs(x) <
							abs(a.x-a2.x)) then
						if a.touchable and a2.touchable then
							v=a.dx + a2.dx
							if not a.static then a.dx = v/2 end
							if not a2.static then a2.dx = v/2 end
						end
						add(retlist, a2)
					elseif (dy != 0 and abs(y) <
									abs(a.y-a2.y)) then
						if a.touchable and a2.touchable then
							v=a.dy + a2.dy
							if not a.static then a.dy = v/2 end
							if not a2.static then a2.dy = v/2 end
						end
						add(retlist, a2)
					end
				end
			end
		end
	end

	return retlist
end

-- calls the hit function for each actor touching a.
function hit_actors(a,alist)
	-- hits with the main actor.
	for other in all(alist) do
		a.hit(other)
		other.hit(a)
	end
end

-- existential function for touchable items.
function has_touchable(actor_list)
	for a in all(actor_list) do
		if a.touchable then
			return true
		end
	end
	return false
end

-- todo, remove this for final game.
function debug_actor_box(a, col)
	local x1 = (a.x-.5) * 8
	local x2 = (a.x+.5)*8 - 1
	local y1 = (a.y-.5)*8
	local y2 = (a.y+.5)*8 - 1
	rect(x1, y1, x2, y2, col)
end
-----------------
-- movement functions
-----------------
-- assumes that when timer is zero, you are at the top of the circle.
function move_clockwise(a, spd, radx, rady, timer)
	local ang = -timer / 30 / spd
	a.dx = radx * cos(ang) / 30
	a.dy = rady * sin(ang) / 30
end

function move_counter(a, spd, radx, rady, timer)
	local ang = timer / 30 / spd + .5
	a.dx = radx * cos(ang) / 30
	a.dy = rady * sin(ang) / 30
end

function move_to_point(a, spd, x, y)
	local ang = atan2(x - a.x, y - a.y)
	a.dx = spd * cos(ang)
	a.dy = spd * sin(ang)
end

function move_to_actor(a1, a2, spd)
	move_to_point(a1, spd, a2.x, a2.y)
end

function move_controller(a, spd)
	if btn(0) then a.dx -= spd end
	if btn(1) then a.dx += spd end
	if btn(2) then a.dy -= spd end
	if btn(3) then a.dy += spd end
end
-- 104 tokens
-- alan morgan

-- example usage:
-- a.x, a.hs = collide_helper(a.x, a.y, a.hs, a.rad, function(pos, per) return is_solid(mget(pos, per)) end)
-- a.y, a.vs = collide_helper(a.y, a.x, a.vs, a.rad, function(pos, per) return is_solid(mget(per, pos)) end)
function tile_collide_helper(pos, per, spd, pos_rad, per_rad, solid_func)
	local pos_min, pos_max = collision_bounds(pos + spd, pos_rad)
	local per_min, per_max = collision_bounds(per, per_rad)

	for i=pos_min, pos_max, 1 do
		for per_inc=per_min, per_max, 1 do
			local dir = 0
			if spd < 0 and solid_func(pos_min, per_inc)     then
				pos = pos_min + pos_rad + 1
				spd = 0
			elseif spd > 0 and solid_func(pos_max, per_inc) then
				pos = pos_max - pos_rad
				spd = 0
			end
		end
	end

	return pos, spd
end

function collision_bounds(pos, rad)
	return flr(pos - rad), -flr(-(pos + rad)) - 1
end
__gfx__
00000000111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000155555510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700155555510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000155555510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000155555510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700155555510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000155555510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
