function acts_set_spd(a, actors)
	if a.is_outside then
		return
	end

	if a.move != nil then
		if a.stun <= 0 then
			a.move(a)
		else
			a.stun -= 1
		end

		a.dx = acts_move_check(a, actors, a.dx, 0)
		a.dy = acts_move_check(a, actors, 0, a.dy)
	end
end
