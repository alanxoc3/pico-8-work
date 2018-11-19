--- tokens: 260
-- just think, never ending running.
-- pl position still changes.

-- can i go backwards? yes, but the screen cannot go backwards.
-- if x > scrx, then scrx = x - 8 or whatever.
-- and the end will be where the stable is.
-- all the moving things will be drawn based on the screen's x position.

function init_field()
	init_pl(3, 11.5, 0, 0, 1)
	field_textures=gen_field_texture(8, 10.5, 16*11.5, 15, 100)
	field_cold_text=false
	game_load_view(g_x, 0, 16*12, 16)
end

function update_field()
	update_pl(boy_input, field_collision)
	game_update_view()
	spawn_particles(2, 0, 0, g_x/16, 1)
	update_particles()
end

function field_collision()
	local x, y, hs, vs

	-- bounds
	x, hs = update_in_box(g_pl.x, g_pl.hs, .5, g_x, 16*12)
	y, vs = update_in_box(g_pl.y, g_pl.vs, .5, 10.5, 15)

	if x > 16*11 then
		g_tl_next()
	end

	if x > 16*6 and not field_cold_text then
		tbox(":i'm cold.")
		field_cold_text = true
	end

	return x, y, hs, vs
end

function draw_field()
	rectfill(0,0,127,127,1) -- not cls, for the fade
	scr_rectfill(8, 10, 16*12, 16, 3)
	draw_hill(10)

	for t in all(field_textures) do
		scr_rectfill(t.x, t.y, t.x+t.w, t.y, 5)
	end

	draw_boy()
end

function gen_field_texture(x1, y1, x2, y2, n)
	local texs = {}

	for i=1, n do
		add(texs, {
			x=rnd(x2-x1)+x1,
			w=rnd(3)+1,
			y=rnd(y2-y1)+y1
		})
	end

	return texs
end
