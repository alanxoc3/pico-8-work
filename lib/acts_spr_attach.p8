-- acts_act_attach() nothing_func()
-- params are: sind, sw, sh, xf, yf, pre_draw, post_draw
-- sind = -1 -- not visible
function acts_spr_attach(a, ...)
	return acts_attach("spr", a,
	{"sind", "sw", "sh", "xf", "yf", "pre_draw", "post_draw"},
	{...}, {0, 1, 1, false, false, nothing_func, nothing_func},
	acts_vec_attach)
end
