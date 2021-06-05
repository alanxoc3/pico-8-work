--- tokens: 814
function init_church()
	init_pl(8, 29.5, 0, 16, 2)

	clear_fade()
	clear_particles()

	g_family = false
	g_sleep_x, g_sleep_y, g_sleep_vx, g_sleep_vy = 0, 0, 0, 0
	game_load_view(0, 0, 16, 16*2)
end

function draw_church()
	draw_interior()
	draw_pl()

	-- draw benches
	for i=0, 5 do
		draw_bench(3, 12 + i*3)
		draw_bench(10, 12 + i*3)
	end

	-- family.
	if g_family then
		scr_spr(64, 5, 5.5, 6, 3)
	end
end

function update_church()
	update_pl(pl_input, church_collision)
	game_update_view()
end

function draw_interior()
	-- floor
	scr_rectfill(2, 6, 14, 9, 6)
	draw_floor(1, 10, 7, 10)
	draw_rug(7, 9, 21)

	-- rug inconsistency
	scr_mirrored(197, 7,  9, 1, 1)
	scr_mirrored(203, 7, 10, 1, 2)
	scr_mirrored(237, 7, 12, 1, 1)

	-- lr windows/walls
	for i=0, 5 do
		scr_spr(168, 0,  i*4+6, 2, 4)
		scr_spr(168, 14, i*4+6, 2, 4, true)
	end

	-- draw top wall
	for i = 0, 7 do
		scr_spr(167, i, 0, 1, 6)
		scr_spr(167, i+8, 0, 1, 6, true)
	end

	-- draw bottom wall
	for i = 0, 4 do
		scr_spr(231, i+2, 30, 1, 2, false, true)
		scr_spr(231, i+9, 30, 1, 2, true, true)
	end

	-- doorway
	scr_mirrored(235, 7, 30, 1, 2)

	-- draw corners
	scr_spr(228, 0,  4, 2, 2)
	scr_spr(228, 14, 4, 2, 2, true)
	scr_spr(212, 0,  3, 1, 1)
	scr_spr(212, 15, 3, 1, 1, true)
	scr_spr(196, 2,  6, 1, 1)
	scr_spr(196, 13,  6, 1, 1, true)

	-- bottom corners
	scr_spr(232, 0,  30, 2, 2)
	scr_spr(232, 14, 30, 2, 2, true)

	-- draw stand
	for i=0, 4 do
		scr_spr(197, i+2, 9, 1, 2)
		scr_spr(197, i+9, 9, 1, 2, true)
	end
end

function church_collision()
	local x, y, hs, vs

	-- bounds
	x, hs = update_in_box(g_pl.x, g_pl.hs, .5, 2, 14)
	y, vs = update_in_box(g_pl.y, g_pl.vs, .5, 10, 16*2)

	-- update_out_box(x, y, hs, vs, xrad, yrad, bx1, by1, bx2, by2)
	-- bottom, near door.
	x, y, hs, vs = update_out_box(x, y, hs, vs, .5, .5, 0, 29.75, 7, 32)
	x, y, hs, vs = update_out_box(x, y, hs, vs, .5, .5, 9, 29.75, 16, 32)

	-- chair collision
	for i=0, 5 do
		x, y, hs, vs = update_out_box(x, y, hs, vs, .5, .5, 3,  i*3+12.25, 6,  i*3+13.5)
		x, y, hs, vs = update_out_box(x, y, hs, vs, .5, .5, 10, i*3+12.25, 13, i*3+13.5)
	end

	-- fix this!!!
	-- collision boundaries for door at the bottom.
	if is_containing(x, y, .5, .5, 7, 29.75, 9, 32) then
		g_tl_next()
		sfx(6)
	end

	-- for the cut scene
	if not g_family and is_containing(x, y, .5, .5, 0, 10, 16, 12.25) then
		g_tl_next(12)
	end

	return x, y, hs, vs
end

-- w and h are measured as tiles of 16x16
function draw_floor(x, y, w, h)
	scr_rectfill(x, y, x+w*2, y+h*2, 13)
	for i=0,h-1 do
		for j=(i+1)%2,w-1,2 do
			scr_mirrored(236, x+j*2, y+i*2, 1, 2)
		end
	end
end

function draw_rug(x, y, h)
	local mods = { 237, 205, 221, 237 }
	for i=0,h,1 do
		scr_mirrored(mods[i%4+1], x, y+i, 1, 1)
	end
end

function draw_bench(x, y)
	scr_spr(180, x, y, 2, 1)
	scr_spr(180, x+2, y, 1, 1, true)
end
