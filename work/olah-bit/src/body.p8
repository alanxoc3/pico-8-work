function create_body(a)
	local d = acts_spr_attach(nil, a.sinds[#a.sinds])
	acts_mov_attach(d)
	acts_col_attach(d)
	d.touchable = false
	d.solid = true
	d.ay = gravity
	d.iy = air_resistance

	d.x, d.y = a.x, a.y
	d.xf = a.xf
	return d
end

function gen_body(x, y, max_health, score, ...)
	local a = acts_col_attach()
	acts_vec_attach(a, x, y)
	acts_anim_attach(a, ...)
	acts_mov_attach(a)

	a.score = score
	a.bounce = 0
	a.iy = air_resistance
	a.ay = gravity
	a.max_health = max_health
	a.health = max_health
	a.resurrect_count = 0

	a.resurrect = function()
		if a.resurrect_count < g_resurrect_max then
			a.anim_loc = 1
			a.hit, a.move, a.update = a.hit_backup, a.move_backup, a.update_backup
			a.touch_group, a.touchable, a.good, a.bad = a.touch_group_backup, a.touchable_backup, a.good_backup, a.bad_backup
			a.pl, a.enemy = a.pl_backup, a.enemy_backup
			a.w, a.h = a.w_backup, a.h_backup
			a.health = a.max_health
			printh(a.health)

			a.body = false
			a.resurrect_count += 1
		end

		return not a.body
	end

	a.die = function()
		a.dx, a.ax = 0, 0
		a.anim_len = 1
		a.anim_loc = #a.sinds
		a.max_health /= 2

		a.touch_group_backup, a.touchable_backup, a.good_backup, a.bad_backup = a.touch_group, a.touchable, a.good, a.bad
		a.hit_backup, a.move_backup, a.update_backup = a.hit, a.move, a.update
		a.pl_backup, a.enemy_backup = a.pl, a.enemy
		a.w_backup, a.h_backup = a.w, a.h

		a.touch_group, a.touchable, a.good, a.bad = nil, nil, nil, nil
		a.hit, a.move, a.update = nothing_func, nothing_func, nothing_func -- nothing_func()
		a.pl, a.enemy = nil, nil
		a.w, a.h = .5, .5
		printh(a.max_health)

		a.body = true
	end

	return a
end
