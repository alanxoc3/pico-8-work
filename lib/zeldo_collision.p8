-- alan morgan

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
