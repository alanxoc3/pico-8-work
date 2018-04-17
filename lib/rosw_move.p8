-- returns nil, or the room number switching to.
function rosw_move(dir)
	if not g_rosw_switching then
		if dir == 0 then
			g_rosw_x_nxt = max(0, g_x-16)
			g_rosw_x_spd = -g_rosw_spd
		elseif dir == 1 then
			g_rosw_x_nxt = min(g_rosw_w, g_x+16)
			g_rosw_x_spd = g_rosw_spd
		elseif dir == 2 then
			g_rosw_y_nxt = max(0, g_y-16)
			g_rosw_y_spd = -g_rosw_spd
		elseif dir == 3 then
			g_rosw_y_nxt = min(g_rosw_h, g_y+16)
			g_rosw_y_spd = g_rosw_spd
		end
		g_rosw_switching = true
		return g_rosw_x_nxt, g_rosw_y_nxt
	end
end
