--- tokens: 58
function set_actor_speed(a, actors)
	if a.is_outside then
		return
	end

	if a.move != nil then
		if a.stun <= 0 then
			a.move(a)
		else
			a.stun -= 1
		end

		a.dx = move_actor_check(a, actors, a.dx, 0)
		a.dy = move_actor_check(a, actors, 0, a.dy)
	end
end

