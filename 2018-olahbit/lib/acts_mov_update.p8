-- con_actors()
function acts_mov_update()
	local acts = filter_val(g_actors, "mov")
	acts_loop(acts, "move")

	foreach(acts, function(a)
		a.dx += a.ax a.dy += a.ay
		a.dx *= a.ix a.dy *= a.iy
	end)
end
