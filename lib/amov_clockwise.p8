--- tokens: 40
-- assumes that when timer is zero, you are at the top of the circle.
function amov_clockwise(a, spd, radx, rady, timer)
	local ang = -timer / 30 / spd
	a.dx = radx * cos(ang) / 30
	a.dy = rady * sin(ang) / 30
end
