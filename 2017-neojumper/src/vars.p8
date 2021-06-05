-- global declarations are here!

g_w = .9

-- for ducking
g_max_h = 1.8
g_min_h = .9
g_dck_tim_max = 10

-- for horizontal position
-- a plank, if you fall off, you die!
g_plk_max = 3
g_plk_inc = .3
g_plk_dec = .1
g_plk_rsp = .1

g_tit_prv_spd = .1

-- offset for plk
g_plk_off = 2

g_biomes = {}

g_buf_h = 12
g_buf_w = 160
g_buf_off = 17

g_lif_max = 3

g_tit_tim_max = 35

g_wlk_spd = .15

-- should be 1
g_beg_lvl = 1
g_nxt_lvl = g_beg_lvl

-- respawn
l = {}

function blockify(a, x, y, w, h)
end

function _init()
	palt(0, false)
	add(g_biomes, gen_mountain_level)
	add(g_biomes, gen_obstruction_level)
	add(g_biomes, gen_platform_level)
	--add(g_biomes, gen_test_level)

	reset_pl()
	l.x = 4 - l.xr

	init_buffers()

	reset_buffers(flrrnd(30, 1), flrrnd(30, 1))

	gf_blink=cocreate(blink_coroutine)

	gf_shake=cocreate(
		function() -- shake the screen
			camera(0,0)
			while true do
				camera(flrrnd(10, -5), flrrnd(10, -5))
				yield()
			end
		end
	)

	sfx(0) -- logo

	reset_duck()
	reset_respawn()
	reset_title()
end

function reset_pl()
	g_timer=cocreate(countdown)

	g_lif = 3
	gf_pl_mov=nil
	g_plk = g_plk_max
	l.h = g_max_h

	l.hs = 0
	l.vs = 0

	l.xr = g_w / 2
	l.yr = g_max_h / 2

	l.y = 1 + l.yr
end

function reset_respawn()
	g_rsp = false
	g_rsp_mov = false
end

function reset_duck()
	g_dck_tim = 0
	g_jmp_tim = 0
	g_falling = false
end
