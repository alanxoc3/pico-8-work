function gen_bullet(x, y, dx, ...)
	local a = acts_col_attach()
	acts_vec_attach(a, x, y, dx)
	acts_anim_attach(a, ...)
	acts_mov_attach(a, 1, 1)
	a.bullet = true
	a.touchable = false
	a.solid = false
	a.death_timer = 0

	a.update = function()
		a.dy = 0

		if a.t > 100 then a.alive = false
		elseif a.t > 97 then a.anim_loc = 4
		elseif a.t > 90 then a.anim_loc = 3
		elseif a.t > 85 then a.anim_loc = 2
		end

		if fget(mget(a.x, a.y), 0) then
			a.ix = .1
			a.t = max(85, a.t)
		end

		if a.t > 85 then a.ix = .1 end
	end

	return a
end
