--- tokens: 54
-- moves, with actor collisions
function move_actor_check(a, actors, dx, dy)
	local other_list = actor_collision(a, actors, dx, dy) 

	if #other_list != 0 then
		hit_actors(a,other_list)

		if a.touchable and has_touchable(other_list) then
			dx *= -a.bounce
			dy *= -a.bounce
		end
	end

	return dx + dy
end
