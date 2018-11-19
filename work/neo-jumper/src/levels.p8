function gen_test_level(b, x1, x2, lvl)
	-- 11
	gen_patch(
		x1+1, x2,
		function()
			return 3, 11
		end,
		function(x1, x2)
			gen_mtn(
				b, x1, x2,
				9, 5 -- gorge
			)
		end
	)

end

function gen_platform_level(b, x1, x2, lvl)
	assert(x1 <= x2)

	-- w --
	local min_w, max_w = min_and_max_lvl(lvl, 8, 10,  2, 6)

	-- y --
	local min_y, max_y = min_and_max_lvl(lvl, 4, 4, 4, 10)

	-- gap --
	local min_gap, max_gap = min_and_max_lvl(lvl, 1, 1, 3, 6)

	-- hu --
	local min_hu, max_hu = min_and_max_lvl(lvl, 0, 0, 2, 3)

	-- gap_hu --
	local min_gap_hu, max_gap_hu = min_and_max_lvl(lvl, 1, 1, 3, 4)

	-- hd --
	local min_hd, max_hd = min_and_max_lvl(lvl, 0, 0, 2, 8)

	-- gap_hd --
	local min_gap_hd, max_gap_hd = min_and_max_lvl(lvl, 1, 1, 5, 7)

	local beg_y = flrrnd(max_y - min_y, min_y)
	local beg_x = x1 + flr(beg_y / 2)

	-- stairs up to platform
	-- +1 here, to ensure it is possible.
	gen_half_mtn(b, x1+1, beg_x, beg_y, true)

	-----------------
	-- patch logic --
	-----------------
	assert(beg_y >= min_y and beg_y <= max_y)
	assert(beg_x <= x2)

	local cur_y = beg_y
	local same_lvl = true

	gen_patch(
		beg_x, x2,
		function(acc)
			local nxt_gap = 0

			if acc > 0 then
				if not same_lvl then
					-- pick a direction, then go in that direction.

					-- change the y for the next item. --
					local up_good  = (cur_y + min_hu <= max_y)
					local dwn_good = (cur_y - min_hd >= min_y)
					assert(up_good or dwn_good)

					-- pick a direction
					local go_up = false

					if     up_good and dwn_good then go_up = flrrnd(2) == 1
					elseif up_good              then go_up = true end

					assert(cur_y >= min_y and cur_y <= max_y)

					if go_up then
						cur_y = flr(min(max_y, cur_y + irnd(min_hu, max_hu)))
						nxt_gap = irnd(min_gap_hu, max_gap_hu)
					else
						cur_y = flr(max(min_y, cur_y - irnd(min_hd, max_hd)))
						nxt_gap = irnd(min_gap_hd, max_gap_hd)
					end
				else
					nxt_gap = irnd(min_gap, max_gap)
				end
			end

			return nxt_gap, irnd(min_w, max_w)
		end,

		function(x1, x2)
			gen_platform(b, x1, x2, cur_y)
			same_lvl = not same_lvl
		end
	)
end

function gen_obstruction_level(b, x1, x2, lvl)
	assert(x1 <= x2)

	local max_h = num_from_lvl(lvl, 1, 3)
	local freq = num_from_lvl(lvl, 0, 1) * (x2-x1) / 2 + .25 * (x2-x1)
	local y_ground = 0
	x1 += 1

	-----------------
	-- patch logic --
	-----------------
	for i=1, freq do
		gen_obstruction(b, flrrnd(x2 - x1, x1), y_ground, max_h)
	end
end

function gen_mountain_level(b, x1, x2, lvl)
	assert(x1 < x2)

	-- w --
	local min_w, max_w = min_and_max_lvl(lvl, 4, 10, 10, 15)

	-- h --
	local min_h, max_h = min_and_max_lvl(lvl, 2, 3, 6, 11)

	-- gap --
	local min_gap, max_gap = min_and_max_lvl(lvl, 5, 10, 1, 3)

	-- gorge --
	-- before 15: 0 - 0
	-- end: 4 - 6
	local min_gor = max(0, ((lvl - 15) / 15) * 4)
	local max_gor = max(0, ((lvl - 15) / 15) * 6)

	-----------------
	-- patch logic --
	-----------------
	gen_patch(
		x1+1, x2,
		function()
			return irnd(min_gap, max_gap), irnd(min_w, max_w)
		end,
		function(x1, x2)
			gen_mtn(
				b, x1, x2,
				irnd(min_h, max_h),
				irnd(min_gor, max_gor)
			)
		end
	)
end

function gen_level(b, lvl, seed)
	lvl = min(lvl, 30)

	local lvl_cnt = flrrnd(count(g_biomes), 1)
	local rem = b.w % lvl_cnt
	local inc = flr(b.w / lvl_cnt)

	local x1, x2 = 1, inc
	for i=1, lvl_cnt do
		if i <= rem then x2 += 1 end

		local cur = flrrnd(count(g_biomes), 1)
		g_biomes[cur](b, x1, x2, lvl)
		x1 = x2 + 1
		x2 += inc
	end

	-- after the level is generated, figure out all the types
	typify_buffer(b, 1, 1, g_buf_w, g_buf_h)
end

function typify_buffer(b, x1, y1, x2, y2)
	assert(x1 <= x2)
	assert(y1 <= y2)

	local up    = 0b00011
	local right = 0b00101
	local down  = 0b01001
	local left  = 0b10001

	for x = x1, x2 do
		for y = y1, y2 do
			if b[x][y] > 0 then
				local typ = 0b00001
				if y < y2 and b[x][y+1] > 0 then typ = bor(typ, up)    end
				if x < x2 and b[x+1][y] > 0 then typ = bor(typ, right) end
				if y > y1 and b[x][y-1] > 0 then typ = bor(typ, down)  end
				if x > x1 and b[x-1][y] > 0 then typ = bor(typ, left)  end
				b[x][y] = typ
			end
		end
	end
end
