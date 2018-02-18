trans_active = false
trans_after_peak = false
trans_timer = 0
trans_song = -1

-- call to start a transition.
function transition(mark, music_when_done, sound_effect)
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

function trans_update(time)
	local after_peak = false

	if trans_active then
		after_peak = (trans_timer >= flr(time / 2))
		trans_timer += 1
		if trans_timer >= time then trans_active = false end
	end

	return after_peak
end

-- returns true if it is at least halfway done.
function trans_draw(time, func)
	if trans_active then
		func(time, trans_timer)
	end
end

-- a transition effect. returns true if it is at least halfway done.
function screen_swipe(length, timer)
	-- only want to go in a half circle.
	local pos = 128 * sin(timer / length / 2 + .5)

	if timer > length / 2 then
		rectfill(128-pos,-1,129,129,0)
	else
		rectfill(-1,-1,pos,129,0)
	end
end
