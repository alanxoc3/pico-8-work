function coll_tile_help(pos, per, spd, pos_rad, per_rad, dir, hit_func, solid_func)
	local pos_min, pos_max = coll_tile_bounds(pos + spd, pos_rad)
	local per_min, per_max = coll_tile_bounds(per, per_rad)

	for i=pos_min, pos_max do
		for j=per_min, per_max do
			if spd < 0 and solid_func(pos_min, j) then
				hit_func(dir)
				return pos_min + pos_rad + 1, 0
			elseif spd > 0 and solid_func(pos_max, j) then
				hit_func(dir+1)
				return pos_max - pos_rad, 0
			end
		end
	end

	return pos, spd
end
