--- tokens: 19
-- existential function for touchable items.
function has_touchable(actor_list)
	for a in all(actor_list) do
		if a.touchable then
			return true
		end
	end
	return false
end
