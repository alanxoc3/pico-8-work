-- while the title is going back up:
function init_buffers()
	g_buf_1 = create_buffer(g_buf_w, g_buf_h)
	g_buf_2 = create_buffer(g_buf_w, g_buf_h)
end

function need_buffer_switch(pos)
	return pos > g_buf_w + g_plk_off + g_plk_max
end

function switch_buffers()
	local tmp = g_buf_1
	g_buf_1 = g_buf_2
	g_buf_2 = tmp
end

function draw_buffer(b, xoff, yoff, colr)
	for i=1, b.w do
		for j=1, b.h do
			if b[i][j] > 0 then
				local x1 = xoff + i
				local x2 = xoff + i + 1

				-- j+1 is because the index starts at 1.
				local y1 = yoff + j + 1
				local y2 = yoff + j

				--debug_rect(x1, y1, x2, y2, colr, false, b[i][j])
				draw_block(x1, y1, b[i][j])
			end
		end
	end
end

function draw_block(x, y, typ)
	x = x * 8
	y = (17 - y)*8 -- block offset is 1 high
	
	local typ = shr(band(typ, 0b11110), 1)
	local ind = typ * 16 + 15

	palt(14, true)
	spr(ind, x, y)
	palt(14, false)
end

-- delete for final game
function debug_rect(x1, y1, x2, y2, colr, fill, printing)
	x1 = x1 * 8
	x2 = x2*8 - 1
	-- 17 because of indicies starting at 1.
	y1 = (17 - y1)*8
	y2 = (17 - y2)*8 - 1
	if fill then
		rectfill(x1, y1, x2, y2, colr)
	else
		rect(x1, y1, x2, y2, colr)
	end

	print(printing, x1+1, y1+2, 12)
end

function clear_buffer(b)
	for i=1, b.w do
		for j=1, b.h do
			b[i][j] = 0
		end
	end
end

function create_buffer(w, h)
	local b = {}
	b.w = w
	b.h = h

	for i=1, w do
		b[i] = {}
	end

	clear_buffer(b)

	return b
end

function next_level_switcher(lvl)
	if need_buffer_switch(l.x) then
		l.x %= 160

		switch_buffers()
		set_buffer(g_buf_2, lvl)

		return true
	end

	return false
end

function reset_buffers(buf1_lvl, buf2_lvl)
	set_buffer(g_buf_1, buf1_lvl)
	set_buffer(g_buf_2, buf2_lvl)
end

function set_buffer(buf, lvl)
	clear_buffer(buf)
	gen_level(buf, lvl, time())
end

function draw_buffers()
	local x = g_plk - l.x + g_plk_off
	line(x*8, 0, x*8, 127, 4)
	line(x*8+g_buf_w*8, 0, x*8+g_buf_w*8, 127, 4)
	draw_buffer(g_buf_1, x,           1, 8)
	draw_buffer(g_buf_2, x + g_buf_w, 1, 8)
end

function buf_sol_hlp(b, x, y)
	local x = flr(x)
	local y = flr(y)

	if x < 1 or y < 1 or x > b.w or y > b.h then
		return false
	end

	return b[x][y] > 0
end

function buffer_solid_func(x, y)
	return buf_sol_hlp(g_buf_1, x, y) or
		buf_sol_hlp(g_buf_2, x-g_buf_w, y)
end
