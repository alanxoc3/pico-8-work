-- acts_spr_attach()
function acts_anim_attach(a, ...)
	return acts_attach("anim", a, {"sinds", "anim_loc", "anim_off", "anim_len", "anim_spd"}, {}, {{...}, 1, 0, 1, 1}, acts_spr_attach)
end
