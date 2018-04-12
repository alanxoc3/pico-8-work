function move_counter(a, spd, radx, rady, timer)
	local ang = timer / 30 / spd + .5
	a.dx = radx * cos(ang) / 30
	a.dy = rady * sin(ang) / 30
end
