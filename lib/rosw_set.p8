-- this should be called in an init.
-- x and y are in tile coordinates. rooms are a block of 16 tiles
function rosw_set(x, y, w, h, spd)
	g_rosw_w, g_rosw_h = w, h
	g_rosw_spd = spd
	g_rosw_switching = false
	g_rosw_x_spd, g_rosw_y_spd = 0, 0
	g_x, g_y, g_rosw_x_nxt, g_rosw_y_nxt = x, y, x, y
end

