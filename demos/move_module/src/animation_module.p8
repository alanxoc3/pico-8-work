g_acts_anim_lst = {}

function acts_anim_attach(a, ...)
	return acts_attach(g_acts_anim_lst, a, {"sinds", "anim_loc", "anim_off", "anim_len", "anim_spd"}, {}, {{...}, 1, 0, 0, 1}, acts_spr_attach)
end

function acts_anim_update()
	foreach(g_acts_anim_lst,
		function(a)
			if a.t % a.anim_spd == 0 then
				a.anim_off += 1
				a.anim_off %= a.anim_len
			end

			a.sind = a.sinds[a.anim_loc + a.anim_off] or 0xffff
		end)
end
