--- tokens: 43
-- see scr_mirrored
function scr_clip(x1, y1, x2, y2)
	clip(scr_off(x1, y1), scr_off(x2-x1, y2-y1))
end
