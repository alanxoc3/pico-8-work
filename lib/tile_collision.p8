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
