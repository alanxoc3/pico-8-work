-- con_acts_mov()
-- params: dx, dy, ax, ay, move
function acts_mov_attach(a, ...)
	return acts_attach(g_acts_mov_lst, a, {"ix", "iy", "ax", "ay", "move"}, {...}, {.9, .9, 0, 0, nothing_func}, acts_vec_attach)
end
