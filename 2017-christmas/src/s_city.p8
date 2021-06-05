--- tokens: 606
function update_city()
	update_pl(pl_input, town_collision)

	if not g_church_out_tbox and g_pl.y < 10.5 then
		tbox(":hmm. a church.:it's been a while.")
		g_church_out_tbox = true
	end

	spawn_particles(1, 0, 0, 10, 10)
	update_particles()
	game_update_view()
end

function draw_city()
	draw_town(g_y)
	draw_pl()
end

function init_city()
	g_church_out_tbox = false
	init_pl(8, 16*4 - 2, 0, 16*3, 2)
	game_load_view(0, 0, 16, 16*4)
	music(4)
end

function init_city_2()
	init_pl(8, 8, 0, 0, 3)
	game_load_view(0, 0, 16, 16*4)
end

function city_tbox()
	tbox(":well, it's officially christmas.:i wonder how my family has been doing.:...:why am i always alone?:...:everyone else is so happy this time of year.:...:not me though.:...:i can't stand it.:why do people even celebrate this holiday?")
end

function draw_church_out(_y)
	local inds={11,12,13,14,14,14,14}
	for i=0,8 do
		for j=0,6 do
			local ind = 58 + i*16 + j
			if j > 1 then ind -= 1 end
			scr_spr(ind, j+1, i)
			scr_spr(ind, 14-j, i, 1, 1, true)

			if j == 2 then
				scr_spr(ind, 3,  i, 1, 1, true)
				scr_spr(ind, 12, i)
			end
		end
	end
end

function draw_town_grnd(_h)
	scr_rectfill(0, 0, 16, _h, 13)

	local inds={11,12,13,14,14,14,14}
	for i=0, _h-1 do 

		-- different floors for the lamp.
		local lmp_flr = 43
		if i%3 == 0 then     lmp_flr = 11
		elseif i%3 == 1 then lmp_flr = 27 end
		inds[1] = lmp_flr
		inds[2] = lmp_flr+1

		for j=1,7 do
			scr_spr(inds[j], j-1,  i)
			scr_spr(inds[j], 16-j, i, 1, 1, true)
		end
	end
end

function draw_lamps(_y, _off, _h)
	for i=_off, _h*8, 8*3 do
		spr(15, 4,   i+3 - _y, 1, 2)
		spr(15, 116, i+3 - _y, 1, 2)
	end
end

function draw_town(y)
	local h = 16*4
	draw_town_grnd(h)
	draw_church_out(y*8)
	draw_lamps(y*8, 9*8, h)
end

function town_collision()
	local x, y, hs, vs

	-- bounds
	x, hs = update_in_box(g_pl.x, g_pl.hs, .5, 2, 14)
	y, vs = update_in_box(g_pl.y, g_pl.vs, .5, 6, 16*4)

	-- update_out_box(x, y, hs, vs, xrad, yrad, bx1, by1, bx2, by2)
	-- church sides
	x, y, hs, vs = update_out_box(x, y, hs, vs, .5, .5, 1 , 0, 5 , 9)
	x, y, hs, vs = update_out_box(x, y, hs, vs, .5, .5, 11, 0, 15, 9)

	-- next to church door
	x, y, hs, vs = update_out_box(x, y, hs, vs, .5, .5, 5, 0, 7, 8)
	x, y, hs, vs = update_out_box(x, y, hs, vs, .5, .5, 9, 0, 11, 8)

	if is_containing(x, y, .5, .5, 7, 6, 9, 8.25) then
		g_tl_next(8) -- the transition
		sfx(6)
		sfx(4, -1, 3) --wind
	end

	return x, y, hs, vs
end
