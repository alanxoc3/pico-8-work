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

function move_to_player(a, spd)
	move_to_point(a, spd, pl.x, pl.y)
end
