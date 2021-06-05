-- moves, with actor collisions
function acts_move_check(a, actors, dx, dy)
	local other_list, dir_list = acts_coll(a, actors, dx, dy) 

	if #other_list != 0 then
		acts_hit(a,other_list, dir_list)

		if a.touchable and acts_has_touchable(other_list, a.touch_group) then
			dx *= -a.bounce
			dy *= -a.bounce
		end
	end

	return dx + dy
end
