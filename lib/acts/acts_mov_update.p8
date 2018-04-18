-- con_acts_mov()
function acts_mov_update()
	foreach(g_acts_mov_lst, function(a)
		a.dx += a.ax a.dy += a.ay
		a.dx *= a.ix a.dy *= a.iy
	end)
end
