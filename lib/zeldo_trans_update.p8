--- tokens: 33
function zeldo_trans_update(time)
	local after_peak = false

	if trans_active then
		after_peak = (trans_timer >= flr(time / 2))
		trans_timer += 1
		if trans_timer >= time then trans_active = false end
	end

	return after_peak
end
