-- acts_vec_attach()
-- params are: w, h
function acts_mas_attach(a, ...)
	return acts_attach("mas", a, {"w", "h"}, {...}, {.4, .4}, acts_vec_attach)
end
