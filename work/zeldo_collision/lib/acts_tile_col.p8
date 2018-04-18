function acts_tile_col(a, func)
	if a.solid then
		a.x, a.dx = coll_tile_help(a.x, a.y, a.dx, a.w, a.h, function(pos, per) return func(pos, per) end)
		a.y, a.dy = coll_tile_help(a.y, a.x, a.dy, a.h, a.w, function(pos, per) return func(per, pos) end)
	end
end
