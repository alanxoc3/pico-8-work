-- alan morgan

-- call to start a transition.
function zeldo_transition(mark, music_when_done, sound_effect)
	if not trans_active then
		if mark != nil then
			marker = mark
		end

		trans_active = true
		trans_timer = 0
		trans_after_peak = false
		sleep = true

		trans_song = music_when_done

		if sound_effect != nil then
			music(-1)
			sfx(sound_effect)
		end
	end
end

