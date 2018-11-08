-- 144 tokens

-- a castle wall, takes in the length of it in barriers.
function draw_wall(x, y, w, h, len_in_bars, col)
	-- figure out barrier height
	local bar_dim = w / len_in_bars
	x, y = flr(x), flr(y)

	-- draw barriers
	for i = 1, len_in_bars, 2 do
		rectfill(x + (i-1)*bar_dim, y, x + i*bar_dim, y+bar_dim/2, col)
	end

	-- draw wall
	rectfill(x, y+bar_dim/2, x+w, y+h, col)
end

function draw_tower(x, y)
	draw_wall(x, y, 30, 8, 11, 8)
	draw_wall(x, y+8, 30, 9, 5, 8)
	rectfill(x+5, y+18, x+24, y+100, 8)
end

-- width is 128 [0, 127]
function draw_hell_scene(x, y)
	draw_tower(x/4 + 70, y + 30)
	draw_wall(x/2+30, y+70, 30,  50, 5,  1)
	draw_wall(x,      y+100, 128, 50, 12, 2)
end
