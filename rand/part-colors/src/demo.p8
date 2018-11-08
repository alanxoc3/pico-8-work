-- particle demo
g_x, g_y = 64, 64
g_cps= 1

g_col_1=0
g_col_2=5
g_col_3=1
g_col_4=2
g_bkg_col=6

function _init()
	g_ps = { g_firework, g_rain, g_brimstone, g_smoke, g_lightning, g_void, g_steam }
	init_colors()

	-- enable mouse
	poke(0x5f2d, 1)
end

g_p_mx=0
g_p_my=0
g_pt=0
function _update60()
	assert(g_cps > 0)

	local mouse_press = band(stat(34), 1) == 1
	local mx, my = stat(32), stat(33)

	local next_particle = function()
		g_ps[g_cps].spawn = false
		g_cps = (g_cps) % #g_ps + 1
	end

	local prev_particle = function()
		g_ps[g_cps].spawn = false
		g_cps -= 1
		if g_cps == 0 then g_cps = #g_ps end
	end

	-- change particle and draw color.
	if btnp(4) then
		next_particle()
	else
		g_ps[g_cps].spawn = btn(5) or mouse_press
	end

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

	-- button control
	if g_cps != 6 then
		if btn(0) then g_x-=1.1 end
		if btn(1) then g_x+=1.1 end
	else
		if btn(0) then g_void_x-=1.1 end
		if btn(1) then g_void_x+=1.1 end
	end

	if btn(2) then g_y-=1.1 end
	if btn(3) then g_y+=1.1 end

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
end

function _draw()
	cls(g_bkg_col)

	rectfill(0, 0, g_void_x, 127, 0)

	local str = g_cols[g_col_1].name
	local x_pos = 64-#str*4/2
	print(str, x_pos+1, 112, g_col_2)
	print(str, x_pos, 111, g_col_1)

	for s in all(g_ps) do draw_particles(s) end
	draw_colors()
	draw_controls()
	draw_cursor()
end
