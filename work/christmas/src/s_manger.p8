--- tokens: 258
function init_manger()
	init_pl(4, 14, 0, 0, 1)
	clear_fade()
	clear_particles()
end

function manger_collision()
	local x, y, hs, vs

	-- bounds
	x, hs = update_in_box(g_pl.x, g_pl.hs, .5, 0, 11.5)
	y, vs = update_in_box(g_pl.y, g_pl.vs, .5, 10.5, 15)

	-- stable collision
	-- update_out_box(x, y, hs, vs, xrad, yrad, bx1, by1, bx2, by2)
	x, y, hs, vs = update_out_box(x, y, hs, vs, .5, .5, 3, 10, 19, 12.75)

	return x, y, hs, vs
end

function draw_manger()
	rectfill(0,0,127,127,1) -- not cls, for the fade
	local grnd_y = 10
	scr_rectfill(0, 10, 16, 16, 3)

	scr_spr(29, 7, 1.5, 2, 2)
	draw_stable(3, 5)
	draw_shepherds(9, 13)
	draw_boy()
end

function draw_stable(x, y)
	for i=0, 4 do
		for j=0, 8 do
			scr_spr(mget(i, j), x+i, y+j)
		end
	end

	for i=0, 4 do
		for j=0, 8 do
			scr_spr(mget(i, j), x+(9-i), y+j, 1, 1, true)
		end
	end

	-- joseph, mary, and jesus.
	for i=0, 3 do
		for j=0, 1 do
			scr_spr(mget(i+5, j), x+3+i, y+6.5+j)
		end
	end
end

