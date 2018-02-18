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
