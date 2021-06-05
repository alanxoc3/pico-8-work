-- con_actors()
-- con_acts_anim()
function acts_anim_update()
	local acts = filter_val(g_actors, "anim")
	foreach(acts,
		function(a)
			if a.t % a.anim_spd == 0 then
				a.anim_off += 1
				a.anim_off %= a.anim_len
			end

			a.sind = a.sinds[a.anim_loc + a.anim_off] or 0xffff
		end)
end
