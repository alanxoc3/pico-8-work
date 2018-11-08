function _init()
	g_mx, g_my = 64, 64
	g_col, g_bkgd_col = 2
end

function _update()
end

function _draw()
	cls()
	draw_colors()
	draw_cursor()

end

function _update60()
	update_mouse()
end
