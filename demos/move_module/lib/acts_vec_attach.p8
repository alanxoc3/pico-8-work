-- con_acts_vec() acts_act_attach()
function acts_vec_attach(a, ...)
	return acts_attach(g_acts_vec_lst, a, {"x", "y", "dx", "dy"}, {...}, {0, 0, 0, 0}, acts_act_attach)
end
