-- 111 tokens
-- alan morgan

-- example usage:
-- a.x, a.hs = collide_helper(a.x, a.y, a.hs, a.xrad, function(pos, per) return is_solid(mget(pos, per)) end)
-- a.y, a.vs = collide_helper(a.y, a.x, a.vs, a.yrad, function(pos, per) return is_solid(mget(per, pos)) end)
function tile_collide_helper(pos, per, spd, pos_rad, per_rad, solid_func)
	local pos_min, pos_max = collision_bounds(pos+spd, pos_rad)
	local per_min, per_max = collision_bounds(per, per_rad)

	local coll_loop =
		function(beginning, ending, count, inc_add)
			for pos_inc=beginning, ending, count do
				for per_inc=per_min, per_max, 1 do
					if solid_func(pos_inc, per_inc) then
						pos = pos_inc + inc_add
						spd = 0
					end
				end
			end
		end

	if spd > 0 then
		coll_loop(pos_max, pos_min, -1, -pos_rad)
	elseif spd < 0 then
		coll_loop(pos_min, pos_max, 1, pos_rad + 1)
	end

	return pos, spd
end

function collision_bounds(pos, rad)
	return flr(pos - rad), -flr(-(pos + rad)) - 1
end
