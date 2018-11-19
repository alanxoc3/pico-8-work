function gen_portal(x, y)
	local a = acts_col_attach()
	acts_vec_attach(a, x, y)
	acts_anim_attach(a, 27, 28)
	a.w, a.h = .5, .5
	a.anim_len = 2
	a.anim_spd = 13

	a.static = true
	a.touchable = false

	a.hit = function(other)
		if other.pl and other.portal_timer == 0 then
			other.solid = false 
			other.ax, other.ay = 0, -.037

			other.portal_timer = 1
			other.base_x = a.x
			other.ix = .95
			other.t = 0
		end
	end

	return a
end
