g_acts_anim_timer = 0
function acts_update_sprites(actors)
	for a in all(actors) do
		if g_acts_anim_timer % a.anim_spd == 0 then
			a.anim_off = (a.anim_off + a.sw) % a.anim_len
		end
	end

	g_acts_anim_timer += 1
end
