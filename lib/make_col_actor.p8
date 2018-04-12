
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

