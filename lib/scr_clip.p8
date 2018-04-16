--- tokens: 43
-- see scr_mirrored
function scr_clip(x1, y1, x2, y2)
	clip((x1-g_x)*8, (y1-g_y)*8, (x2-x1-g_x)*8, (y2-y1-g_y)*8)
end
