g_acts_mas_lst = {}

-- params are: w, h
function acts_mas_attach(a, ...)
	return acts_attach(g_acts_mas_lst, a, {"w", "h"}, {...}, {.4, .4}, acts_vec_attach)
end
