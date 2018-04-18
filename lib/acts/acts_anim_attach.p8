-- con_acts_anim()
function acts_anim_attach(a, ...)
	return acts_attach(g_acts_anim_lst, a, {"sinds", "anim_loc", "anim_off", "anim_len", "anim_spd"}, {}, {{...}, 1, 0, 0, 1}, acts_spr_attach)
end
