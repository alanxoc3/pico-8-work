g_acts_vec_lst = {}

function acts_vec_attach(a, ...)
	return acts_attach(g_acts_vec_lst, a, {"x", "y", "dx", "dy"}, {...}, {0, 0, 0, 0}, acts_act_attach)
end

function acts_vec_update()
	foreach(g_acts_vec_lst, function(a)
		a.x += a.dx
		a.y += a.dy
	end)
end
