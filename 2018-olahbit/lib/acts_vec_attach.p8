-- acts_act_attach()
function acts_vec_attach(a, ...)
	return acts_attach("vec", a, {"x", "y", "dx", "dy"}, {...}, {0, 0, 0, 0}, acts_act_attach)
end
