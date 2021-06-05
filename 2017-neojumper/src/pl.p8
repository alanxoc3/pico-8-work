-- 241 tokens

g_moving_tim = 0
function update_pl(l, solid_func, short_jump, tall_jump, jump_delay, gravity, duck_gravity, walk_spd, run_spd, floor, ceiling)
	-- useful variables
	local is_ground = g_falling and l.vs == 0
	local dck_btn = btn(3)
	local run_btn = btn(4)

	-- jumping timer logic
	if btn(5) and not dck_btn and is_ground then
		g_jmp_tim += 1
	else
		if g_jmp_tim <= jump_delay and g_jmp_tim > 0 then
			l.vs = short_jump
		end
		g_jmp_tim = 0
	end

	-- jumping/ducking/gravity physics logic
	if g_jmp_tim > jump_delay then
		l.vs = tall_jump
	end

	if dck_btn and not is_ground then
		l.vs -= duck_gravity
	else
		l.vs -= gravity
	end

	g_falling = l.vs < 0

	-- running logic
	if run_btn then l.hs = run_spd
	else l.hs = walk_spd end

	-- grow/shrink logic
	local old_dck_tim = g_dck_tim
	if dck_btn then
		g_dck_tim = min(g_dck_tim + 1, g_dck_tim_max)
	else
		g_dck_tim = max(g_dck_tim - 1, 0)
	end

	local s_yr = ( g_max_h - g_min_h * (g_dck_tim / g_dck_tim_max) ) / 2
	local s_vs = (s_yr - l.yr)

	local thing_above = collision_above(l.x, l.xr, l.y, s_yr, s_vs, solid_func)

	if thing_above then
		g_dck_tim = old_dck_tim
	else
		l.yr = s_yr
		l.y += s_vs
	end

	-- horizontal collision logic
	l.x, l.hs = tile_collide_helper(l.x, l.y, l.hs, l.xr, l.yr,
		function(pos, per)
			return solid_func(pos, per)
		end)

	l.x += l.hs

	-- vertical collision logic
	l.y, l.vs = tile_collide_helper(l.y, l.x, l.vs, l.yr, l.xr,
		function(pos, per)
			return solid_func(per, pos)
		end)

	-- for the floor and ceiling.
	l.y, l.vs = update_in_box(l.y, l.vs, l.yr, floor, ceiling)
	l.y += l.vs

	-- jumping, jogging, running, stopped, ducking, rising, ducked
	g_pl_jumping = (l.vs ~= 0)
	g_pl_jogging = (l.hs > 0) and not g_pl_jumping
	g_pl_running = (l.hs > 0) and run_btn
	g_pl_stopped = (l.hs == 0)
	g_pl_ducked  = (g_dck_tim > 0 and g_dck_tim == old_dck_tim)
	g_pl_ducking = (g_dck_tim > 0) and (g_dck_tim > old_dck_tim)
	g_pl_rising  = (g_dck_tim > 0) and (g_dck_tim < old_dck_tim)

	-- two frames a second.
	g_moving_tim = (g_moving_tim + 8 / 30) % 4
end

-- figure out spawn location
function calc_respawn_pos(pl, solid_func)
	local x = flr(pl.x+1)

	for y=g_buf_h, 1, -1 do
		if solid_func(x, y) then
			return x+g_w/2, y + g_max_h / 2 + 1
		end
	end

	--assert(false)
	return 1
end

-- moves the player to respawn location
function calc_pos_moving(x1, y1, x2, y2, cur_tim, max_tim)
	if cur_tim == max_tim then
		return x2, y2
	else
		local mx, my = x2 - x1, y2 - y1
		local mag = sqrt(mx * mx + my * my)

		local ang = atan2(mx, my)
		local hs  = mag * cos(ang) * (cur_tim / max_tim)
		local vs  = mag * sin(ang) * (cur_tim / max_tim)

		return x1 + hs, y1 + vs
	end
end

function mov_to_pos(pl, x, y, tim)
	-- reset ducking
	g_pl_stopped = true
	l.yr = g_max_h / 2
	l.vs = 0

	g_jmp_tim = 0
	g_falling = false
	g_dck_tim = 0

	local px = pl.x
	local py = pl.y

	for t = 1, tim do
		pl.x, pl.y = calc_pos_moving(px, py, x, y, t, tim)
		yield()
	end
end

-- 3 second countdown
-- commands: 0 = return the num
--           1 = start
--           2 = return the num and countdown
--           3 = start and countdown
g_countdown = 0
function countdown(tim)
	assert(g_countdown >= 0)
	for c = 30 * tim, 0, -1 do
		g_countdown = -flr(-c / 30)
		yield()
	end

	return true
end

function draw_pl()
	local dim = 2
	local s_num = 0

	if g_pl_ducked or g_pl_ducking or g_pl_rising then
		local ind = (g_dck_tim) / (g_dck_tim_max) * 4

		if ind > 3 then 
			s_num = 198
			if g_pl_jumping then
				s_num = 202
			elseif g_pl_stopped or g_pl_running then
				s_num = 200
			end
		elseif ind > 2 then
			s_num = 196
		elseif ind > 1 then
			s_num = 194
		elseif ind > 0 then
			s_num = 192
		else
			assert(false)
		end
	elseif g_pl_jumping then
		s_num = 168
		if g_pl_running then
			s_num = 232
		end
	elseif g_pl_stopped then
		s_num = 170
	elseif g_pl_jogging then
		-- 160, 162, 164, 166
		local spr_off = 160
		if g_pl_running then 
			spr_off = 224
		end
		s_num = spr_off + 2 * flr(g_moving_tim)
	else
		assert(false)
	end

	local x = (g_plk + g_plk_off - dim / 2) * 8
	if l.hs == 0 then
		x = 8 * (g_plk + g_plk_off + flr(l.x) - l.x) - 3
	end

	local y = (16 - l.y + l.yr - dim) * 8

	palt(14, true)
	spr(s_num, x, y, dim, dim)
	palt(14, false)
end
