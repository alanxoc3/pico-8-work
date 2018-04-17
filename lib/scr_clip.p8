--- tokens: 43
-- see scr_mirrored
function scr_clip(x1, y1, x2, y2)
	clip(scr_x(x1), scr_y(y1), (x2-x1)*8, (x2-x1)*8)
end
