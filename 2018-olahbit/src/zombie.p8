function gen_zombie(x, y)
	local a = gen_enemy(x, y, 40, 5, 112, 113, 114, 115, 116)

	a.move = function()
		local x_mag, pl = calc_close_mag(a)

		-- mag, min, max
		if in_range(x_mag, .4, 5) then
			local ang = atan2(x_mag, pl.y - a.y)
			a.ax = .03 * cos(ang)
			if abs(a.ax) <= .01 then
				a.ax = 0
			end
		else
			a.ax = 0
		end
	end

	a.hit = function(other)
		if other.pl then
			other.health -= .4
		end
	end

	return a
end
