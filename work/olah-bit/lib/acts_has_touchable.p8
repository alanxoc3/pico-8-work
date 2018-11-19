-- existential function for touchable items.
function acts_has_touchable(actor_list, touch_group)
	for a in all(actor_list) do
		if a.touchable and a.touch_group == touch_group then
			return true
		end
	end
	return false
end
