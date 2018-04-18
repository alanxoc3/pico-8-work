function acts_set_pos(a)
	if a.is_outside then
		return
	end

	-- update the position then apply inertia.
	a.x += a.dx
	a.y += a.dy

	a.dx *= a.x_inertia
	a.dy *= a.y_inertia
end

