function gen_alien(x, y)
	return gen_shooter(x, y, 120, 10, .6, 2, 7, 60, 30, 96, 97, 98, 99, 100)
end

function gen_yellow_suit(x, y)
	return gen_shooter(x, y, 220, 15, .7, 3, 8, 50, 25, 101, 102, 103, 104, 105)
end

function gen_shooter(x, y, score, health, bullet_damage, rad_min, rad_max, move_len, shoot_len, ...)
	local a = gen_enemy(x, y, health, score, ...)

	a.move_timer = 1
	a.shooting_timer = 0
	a.move = function()
		local x_mag, pl = calc_close_mag(a)

		-- mag, min, max
		if in_range(x_mag, rad_min, rad_max) and a.move_timer != 0 then
			local ang = atan2(x_mag, pl.y - a.y)
			a.dx = .05 * cos(ang)

			if a.dx < 0 then a.xf = true
			elseif a.dx > 0 then a.xf = false end
	
			a.move_timer = (a.move_timer + 1) % move_len
		elseif a.move_timer == 0 then
			a.shooting_timer = (a.shooting_timer + 1) % shoot_len
			if a.shooting_timer == 0 then
				a.move_timer = 1
			end

			if a.shooting_timer == 10 then
				gen_alien_bullet(a.x, a.y, a.xf and -.3 or .3, bullet_damage)
			end
		else
			a.move_timer = (a.move_timer + 1) % move_len
		end

	end

	a.hit = function(other)
		if other.pl then
			other.health -= .3
		end
	end

	return a
end

function gen_alien_bullet(x, y, dx, damage)
	local a = gen_bullet(x, y, dx, 85, 86, 87, 88)

	a.hit = function(other)
		if other.good then
			a.t = max(85, a.t)
		end

		if other.pl then
			other.health -= damage
		end
	end

	a.bad = true
end
