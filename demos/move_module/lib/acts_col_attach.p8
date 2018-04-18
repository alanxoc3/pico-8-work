-- con_acts_col() acts_mas_attach() nothing_func()
-- params are: static, solid, touchable, bounce, hit
function acts_col_attach(a, ...)
	return acts_attach(g_acts_col_lst, a, {"static", "solid", "touchable", "bounce", "hit", "tile_hit"}, {...}, {false, true, true, .1, nothing_func, nothing_func}, acts_mas_attach)
end
