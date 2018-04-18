g_acts_col_lst = {}

-- params are: static, solid, touchable, bounce, hit
function acts_col_attach(a, ...)
	return acts_attach(g_acts_col_lst, a, {"static", "solid", "touchable", "bounce", "hit", "tile_hit"}, {...}, {false, true, true, .1, nothing_func, nothing_func}, acts_mas_attach)
end

function acts_col_update(solid_func)
	-- set speed
	foreach(g_acts_col_lst, function(a)
		a.dx = acts_move_check(a, g_acts_col_lst, a.dx, 0)
		a.dy = acts_move_check(a, g_acts_col_lst, 0, a.dy)
	end)

	-- tile col
	foreach(g_acts_col_lst, function(a)
		if a.solid then
			a.x, a.dx = coll_tile_help(a.x, a.y, a.dx, a.w, a.h, 0, a.tile_hit, solid_func)
			a.y, a.dy = coll_tile_help(a.y, a.x, a.dy, a.h, a.w, 2, a.tile_hit, function(y, x) return solid_func(x, y) end)
		end
	end)
end
