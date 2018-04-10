function scr_mirrored(ind, x, y, w, h)
	scr_spr(ind, x, y, w, h)
	scr_spr(ind, x+w, y, w, h, true)
end

function scr_clip(x1, y1, x2, y2)
	clip((x1-g_x)*8, (y1-g_y)*8, (x2-x1-g_x)*8, (y2-y1-g_y)*8)
end
