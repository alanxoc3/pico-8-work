
function tile_col(a, func)
	if a.solid then
		a.x, a.dx = tile_collide_helper(a.x, a.y, a.dx, a.w, a.h, function(pos, per) return func(pos, per) end)
		a.y, a.dy = tile_collide_helper(a.y, a.x, a.dy, a.h, a.w, function(pos, per) return func(per, pos) end)
	end
end

