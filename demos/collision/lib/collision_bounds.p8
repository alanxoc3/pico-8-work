function collision_bounds(pos, rad)
	return flr(pos - rad), -flr(-(pos + rad)) - 1
end
