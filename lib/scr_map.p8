--- tokens: 37
function scr_map(cel_x, cel_y, sx, sy, cel_w, cel_h)
	map(cel_x, cel_y, (sx-g_x)*8, (sy-g_y)*8, cel_w, cel_h)
end
