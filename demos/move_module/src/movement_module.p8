g_acts_mov_lst = {}

-- params: dx, dy, ax, ay, move
function acts_mov_attach(a, ...)
	return acts_attach(g_acts_mov_lst, a, {"ix", "iy", "ax", "ay", "move"}, {...}, {.9, .9, 0, 0, nothing_func}, acts_vec_attach)
end

function acts_mov_update()
	foreach(g_acts_mov_lst, function(a)
		a.dx += a.ax a.dy += a.ay
		a.dx *= a.ix a.dy *= a.iy
	end)
end
