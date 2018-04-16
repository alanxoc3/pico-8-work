--- tokens: 39
function move_to_point(a, spd, x, y)
	local ang = atan2(x - a.x, y - a.y)
	a.dx = spd * cos(ang)
	a.dy = spd * sin(ang)
end

