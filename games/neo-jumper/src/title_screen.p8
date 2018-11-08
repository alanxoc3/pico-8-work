function reset_title()
	gf_tit_blink=cocreate(blink_coroutine)

	g_tit_tim=1
	g_tit_inc = 1
	g_tit_end = false

	g_tit_buf_out_swi = false

	-- plk must start at 0, otherwise, there will be a jump in the title screen
	-- the first time. i spent like an hour or two on this line, so don't delete it
	-- >:(. Please.
	g_plk = 0
end

function draw_title()
	local z = g_tit_tim - 30
	local y = -.3 * z * z + 20

	local x = 12

	-- broken up into 3 parts, to conserve space.
	palt(14, true)
	spr(0,  x+3*8,    y,     7,  5)
	spr(7,  x+10*8,    y+5*8, 3,  5)
	spr(80, x,        y+5*8, 10, 5)
	palt(14, false)

	coresume(gf_tit_blink,
		function()
			print('press \x8e or \x97 to start', 20, y + 85, 7)
		end
	)
end

-- returns what the speed should be :)
function buffer_zip(cur_tim, max_tim, max_pos, ini_spd, fin_spd)
	local lft_par = acos(ini_spd*max_tim/max_pos)
	local rgt_par = acos(fin_spd*max_tim/max_pos)
	local mag = rgt_par + lft_par
	local mth_pos = -sin(cur_tim/max_tim*mag-lft_par)
	local cur_pos = (mth_pos + 1) * max_pos / 2

	return cur_pos
end

function title_logic()
	-- what are the possible states the title screen can be in?
	-- going up, going down, first frame of going up, first frame of going down, waiting.
	assert(g_tit_tim <= g_tit_tim_max)

	-- the possible states
	local ending      = g_tit_tim == 0
	local coming_in   = g_tit_tim < g_tit_tim_max and g_tit_inc > 0
	local going_out   = g_tit_tim > 0 and g_tit_inc < 0
	local waiting     = g_tit_tim == g_tit_tim_max
	local btn_pressed = (btn(4) or btn(5)) and waiting

	-- the speed of the title screen level preview.
	l.x += g_tit_prv_spd
	
	if btn_pressed then
		g_tit_inc = -1
		g_tit_tim += g_tit_inc

		g_tit_buf_len = g_buf_w - g_plk_max + l.xr - l.x
		if g_tit_buf_len <= (16 - (g_plk_max + g_plk_off)) then
			g_tit_buf_len += g_buf_w
			g_tit_buf_out_swi = true
		else
			set_buffer(g_buf_2, g_beg_lvl)

		end

		g_tit_beg_x = l.x
		return
	end

	if ending then
		g_tit_end = true
		l.x += g_plk_max

		g_nxt_lvl = g_beg_lvl
		reset_pl()
	end

	-- increase the time.
	if coming_in or going_out then
		g_tit_tim += g_tit_inc
	end

	if going_out then
		local switched = g_tit_buf_out_swi and next_level_switcher(g_beg_lvl)
		if switched then
			g_tit_beg_x -= 160
		end

		local offset = buffer_zip(g_tit_tim_max - g_tit_tim, g_tit_tim_max, g_tit_buf_len, g_tit_prv_spd, 0)
		l.x = g_tit_beg_x + offset
	else
		next_level_switcher(flrrnd(30, 1))
	end
end

