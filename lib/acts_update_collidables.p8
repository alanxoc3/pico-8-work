-- acts_set_pos()
function acts_update_collidables(tile_func)
	-- set speed
	foreach(g_acts_col_lst, function(a)
		a.dx = acts_move_check(a, g_acts_col_lst, a.dx, 0)
		a.dy = acts_move_check(a, g_acts_col_lst, 0, a.dy)
	end)

	-- tile col
	foreach(g_acts_col_lst, function(a)
		if a.solid then
			a.x, a.dx = coll_tile_help(a.x, a.y, a.dx, a.w, a.h, function(pos, per) return func(pos, per) end)
			a.y, a.dy = coll_tile_help(a.y, a.x, a.dy, a.h, a.w, function(pos, per) return func(per, pos) end)
		end
	end)

	foreach(g_acts_col_lst, acts_set_pos)
end
