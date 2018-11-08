-- this is in charge of the mouse and mouse collision i guess.
function update_mouse()
	local mouse_press = band(stat(34), 1) == 1
	local mx, my = stat(32), stat(33)



	left_button_col(mx, my, mouse_press, prev_particle)
	right_button_col(mx, my, mouse_press, next_particle)

	-- change color.
	if mouse_press then
		local col = col_from_pos(mx, my)
		if col != -1 then
			local tab = g_cols[col]
			g_col_1 = col
			g_col_2 = tab.col2
			g_col_3 = tab.col3
			g_bkg_col = tab.bkgd
		end
	end

	-- mouse control
	if mx != p_mx or my != p_my then
		g_x, g_y = mx, my
	end
	p_mx, p_my = mx, my

	for s in all(g_ps) do
		update_particles(s)
	end

	if g_pt == 0 then
		for s in all(g_ps) do
			if s.spawn then
				create_particles(s, g_x, g_y)
			end
		end
	end
	g_pt = (g_pt+1) % 10

	return mx, my
end
