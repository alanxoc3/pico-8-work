function gen_enemy(x, y, max_health, score, ...)
	local a = gen_body(x, y, max_health, score, ...)

	a.touch_group = "enemy"
	a.enemy = true
	a.bad = true
	a.ix = .5
	a.w, a.h = .3, .4
	a.anim_spd = 5

	a.update = function()
		a.anim_len = a.ax != 0 and 3 or 1

		if a.dx < 0 then
			a.xf = true
		elseif a.dx > 0 then
			a.xf = false
		end

		if a.health <= 0 then
			a.die()
		end
	end

	return a
end

function in_range(x_mag, rad_min, rad_max)
	return abs(x_mag) < rad_max and abs(x_mag) > rad_min
end
