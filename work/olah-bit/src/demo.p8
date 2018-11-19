function _init()
	music(0)
	two_players = true
	global_time = 0
	gravity = .05
	air_resistance = .9
	g_resurrect_max = 2

	lvl_init(0)
end

function lvl_init(lvl)
	g_lvl = lvl
	g_y = 0 -- -24 / 8 + lvl * 10 + 1

	-- garbage handler will destroy these.
	g_actors, g_all_actors = {}, {}

	map_to_chars()
end

function _update60()
	if pl1.portal_timer > 30 or pl2.portal_timer > 30 then
		lvl_init(g_lvl+1)
	end

	acts_mov_update()
	acts_col_update(function(x, y) return fget(mget(x, y), 0) end)
	acts_vec_update()
	acts_act_update()
	acts_anim_update()
	acts_clean()

	if global_time % 30 == 0 then
		animate_sprs()
	end

	if global_time % 10 == 0 then
		g_actors = filter(g_all_actors,
			function(a)
				local f = abs(a.x - pl1.x) < 10 or abs(a.x - pl2.x) < 10
				if not f and a.bullet then
					a.alive = false
					return true
				end
				return f
			end)
	end

	global_time += 1
end

function _draw()
	cls(1)

	g_x = pl1.x - 8
	g_y = pl1.y - 4

	-- pl1
	clip(0, 0, 128, 64)
	camera(pl1.cam_x, pl1.cam_y)
	map_outline(0, 0, g_lvl*10+1, scr_x(0), scr_y(g_lvl*10+1), 128, 10)

	acts_loop(g_actors, "pre_draw")
	acts_spr_draw_outline()
	acts_loop(g_actors, "post_draw")

	--map(0, g_lvl*10+1, scr_x(0), scr_y(g_lvl*10+1), 128, 10, 0x2)
	camera()
	draw_health_meter(100, 3, 24, 4, pl1.health)
	print(pl1.points, 3, 3, 7)
	clip()

	g_x = pl2.x - 8
	g_y = pl2.y - 4

	-- pl2
	clip(0, 64, 128, 64)
	camera(pl2.cam_x, pl2.cam_y)
	g_y = g_y - 8
	map_outline(0, 0, g_lvl*10+1, scr_x(0), scr_y(g_lvl*10+1), 128, 10)

	acts_loop(g_actors, "pre_draw")
	acts_spr_draw_outline()
	acts_loop(g_actors, "post_draw")

	--map(0, g_lvl*10+1, scr_x(0), scr_y(g_lvl*10+1), 128, 10, 0x2)
	camera()
	draw_health_meter(100, 67, 24, 4, pl2.health)
	print(pl2.points, 3, 67, 7)
	clip()

	print(stat(1), 53, 62, 7)
	-- screen
	--rectfill(0, 0, 127, 24, 1)
	--rectfill(0, 104, 127, 127, 1)
end
