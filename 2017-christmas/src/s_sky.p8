--- tokens: 592
function init_sky()
	init_pl(8, -1, 0, 0, 2)
	g_pillar_w = 0
	g_angel_y = 52    -- this is for a cut scene
	g_angel_spr = 146 -- this is for a cut scene
	g_angel_hover_time = 0 -- this is for a cut scene
	g_hill_y = 67 -- cut scene
	g_moon_y = 58 -- cut scene
	game_load_view(0, 0, 16, 70)
end

function update_sky()
	update_pl(angel_input, sky_collision)
	game_update_view()

	if g_pl.y > 46 then
		g_tl_next()
	end
end

function draw_sky()
	cls(1)

	-- moon
	draw_moon(g_moon_y)

	-- yellow sky
	scr_rectfill(0, 0, 16, 15, 10)

	-- cloud sky.
	scr_rectfill(0, 15, 16, 30, 7)
	draw_cloud_line(15, 7)

	-- dark clouds
	scr_rectfill(0, 30, 16, 45, 6)
	draw_cloud_line(30, 6)

	draw_pillar(55, 75)

	-- ground
	draw_hill(g_hill_y)

	-- player
	draw_angel()

	-- for cutscene (should be behind clouds)
	scr_spr(g_angel_spr, 7, g_angel_y, 2, 2)

	-- sheep
	draw_sheep()

	-- pl shepherd
	scr_spr(102, 2, g_hill_y+.5, 2, 2)

	-- shepherds
	draw_shepherds(8, g_hill_y)

	-- purple
	scr_rectfill(0, 45, 16, g_hill_y - 12, 2)
	draw_cloud_line(45, 2)

	draw_cloud_line(g_hill_y - 13, 2)

	-- draw feet
	scr_spr(7, 4, 0, 3, 6)
	scr_spr(7, 9, 0, 3, 6, true)
end

function draw_sheep()
	scr_spr(16, 1, g_hill_y+1)
	scr_spr(16, 4, g_hill_y+.5)
	scr_spr(16, 5, g_hill_y+1.5)
	scr_spr(16, 2.5, g_hill_y+3.5)
	scr_spr(16, 5.5, g_hill_y+4)

	scr_spr(16, 14, g_hill_y+1.5, 1, 1, true)
	scr_spr(16, 10, g_hill_y+3.5, 1, 1, true)
end

function draw_shepherds(x, y)
	scr_spr(116, x+1.5, y, 2, 2, true)
	scr_spr(112, x+3, y-1, 2, 2, true)
	scr_spr(116, x+4, y+.5, 2, 2, true)
end

function sky_collision()
	local x, y, hs, vs

	-- bounds
	x, hs = update_in_box(g_pl.x, g_pl.hs, .5, 0, 16)
	y, vs = g_pl.y, g_pl.vs

	return x, y, hs, vs
end

function draw_cloud_line(y, col)
	scr_circ(0,   y,     1,   col)
	scr_circ(1.5, y+.5,  1.2, col)
	scr_circ(3,   y+.5,  1,   col)
	scr_circ(5,   y+.25, 1.2, col)
	scr_circ(7,   y,     1.5, col)
	scr_circ(8.5, y,     1  , col)
	scr_circ(10 , y+.75, 1.2, col)
	scr_circ(12 , y+.25,  1.5, col)
	scr_circ(15 , y,     1.5, col)
end

-- the moon can move on its own.
function draw_moon(y_top)
	scr_circ(12.5, y_top, 2, 6)
end

function draw_hill(y1)
	scr_circ(8, y1+32, 32, 3)
	scr_rectfill(8, y1, 8+16, y1+16, 3)
end

function draw_pillar(y1, y2)
	if g_pillar_w > 0 then
		-- pillar radius
		local pr = g_pillar_w / 2
		scr_rectfill(8-pr,    y1, 8+pr,   y2, 12)
		scr_rectfill(8-5*pr/8,  y1, 8+5*pr/8, y2, 7)
		scr_rectfill(8-pr/2,  y1, 8+pr/2, y2, 13)
	end
end
