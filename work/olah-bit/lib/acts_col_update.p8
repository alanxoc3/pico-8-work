-- con_actors()
function acts_col_update(solid_func)
	local acts = filter_val(g_actors, "col")
	-- set speed
	foreach(acts, function(a)
		a.dx = acts_move_check(a, acts, a.dx, 0)
		a.dy = acts_move_check(a, acts, 0, a.dy)
	end)

	-- tile col
	foreach(acts, function(a)
		if a.solid then
			a.x, a.dx = coll_tile_help(a.x, a.y, a.dx, a.w, a.h, 0, a.tile_hit, solid_func)
			a.y, a.dy = coll_tile_help(a.y, a.x, a.dy, a.h, a.w, 2, a.tile_hit, function(y, x) return solid_func(x, y) end)
		end
	end)
end
