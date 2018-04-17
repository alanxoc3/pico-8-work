function rosw_update()
	if g_rosw_switching then
		g_x += g_rosw_x_spd
		g_y += g_rosw_y_spd

		if g_rosw_x_spd > 0 then
			g_x = min(g_x, g_rosw_x_nxt)
			g_rosw_switching = not (g_x == g_rosw_x_nxt)
		elseif g_rosw_x_spd < 0 then
			g_x = max(g_x, g_rosw_x_nxt)
			g_rosw_switching = not (g_x == g_rosw_x_nxt)
		end

		if g_rosw_y_spd > 0 then
			g_y = min(g_y, g_rosw_y_nxt)
			g_rosw_switching = not (g_y == g_rosw_y_nxt)
		elseif g_rosw_y_spd < 0 then
			g_y = max(g_y, g_rosw_y_nxt)
			g_rosw_switching = not (g_y == g_rosw_y_nxt)
		end

		if not g_rosw_switching then
			g_rosw_x_spd, g_rosw_y_spd = 0, 0
		end
	end
end

